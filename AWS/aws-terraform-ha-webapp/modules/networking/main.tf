resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true 
    enable_dns_support   = true 
    
    tags = {
      Name = "${var.project_name}-vpc"
    }
}

# Membuat 2 Public Subnet di 2 Availability Zone berbeda (High Availability)
resource "aws_subnet" "public" {
    count                   = length(var.public_cidrs)
    vpc_id                  = aws_vpc.main.id 
    cidr_block              = var.public_cidrs[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = true # Agar server bisa download update/nginx

    tags = {
      Name = "${var.project_name}-public-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}-igw"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "${var.project_name}-public-rt"
    }
}

resource "aws_route_table_association" "public_assoc" {
    count          = length(var.public_cidrs)
    subnet_id      = aws_subnet.public[count.index].id 
    route_table_id = aws_route_table.public_rt.id 
}