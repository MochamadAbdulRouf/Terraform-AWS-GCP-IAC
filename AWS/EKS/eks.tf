# --- 1. MENGAMBIL DATA LABROLE (Sesuai request Anda) ---
data "aws_iam_role" "labrole" {
  name = "LabRole"
}

# --- 2. EKS CLUSTER ---
resource "aws_eks_cluster" "main" {
  name = var.cluster_name

  # PENTING: Menggunakan ARN dari LabRole yang sudah ada
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    # Menempatkan interface network cluster di semua subnet (Public & Private)
    subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)

    # Keamanan Cluster Endpoint
    endpoint_public_access  = true
    endpoint_private_access = true
  }

  # Catatan: menghapus 'depends_on' policy attachment 
  # karena LabRole sudah memiliki policy yang ditempel oleh AWS Academy.
}

# --- 3. NODE GROUP (Worker Nodes) ---
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"

  # PENTING: Node Group juga menggunakan LabRole yang sama
  node_role_arn = data.aws_iam_role.labrole.arn

  # Worker Nodes HANYA ditaruh di Private Subnet (Best Practice)
  subnet_ids = aws_subnet.private[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  # Catatan: menghapus 'depends_on' policy attachment di sini juga.
}