# Mendefinisikan mengambil Child Module dari folder lokal
module "gcs-static-website-bucket" {
  source = "./modules/gcs-static-website-bucket"

  # Memberikan nilai untuk variabel yang tidak memiliki nilai di Child Module
  # Jika Variabel yang memiliki nilai default di Child Module tidak perlu diberikan nilai di sini
  # Nilai dari Variable (var.name dan var.project_id) ini bisa diambil dari Variable di Root Module (variables.tf)
  # Location diberikan nilai langsung di sini
  name       = var.name
  project_id = var.project_id
  location   = "us-east1"

  # Memberikan nilai untuk lifecycle_rules di Child Module
  # Aturanya disini adalah hapus objek apapun yang sudah usianya 365 hari
  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age        = 365
      with_state = "ANY"
    }
  }]
}


# Ingat apa itu key dan value
# Key adalah nama dari variable
# Value adalah nilai dari variable