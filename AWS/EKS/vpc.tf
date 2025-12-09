provider "aws" {
  region     = "us-east-1"
  access_key = "ASIAZ7JE2WGYSV6CCSQY"
  secret_key = "x+x6fapJt36c0O6iDMCDAEiwugb7S6yabb0QjT42"
  token      = "IQoJb3JpZ2luX2VjEPX//////////wEaCXVzLXdlc3QtMiJHMEUCIQCaBsljh+U1mCa57mSTly5znYlOT/Ku6QfL4JF3DjqCcwIgR152hcnaSec8rJMMgZSyfEsThpurln7WZauM4YXjXx8qrAIIvv//////////ARABGgw2ODU2NjE0MDE1MjEiDHXDi8U9XFO3PTNdKSqAAgdtRBTppGu5Ps3HpWiiBTJrppTByZnzXyEBDkpPtIik4lcwo0a16bTI0HvWqsoHTPreq3H16/cSiR5f4WimBbUoQnEkz9pf7bEFaq/o7/vz4/t+is5/kbsnAemM/OV1pbfIUY7/84jHTp2VKtCUIc4fGc1n47WlEje//+ftFQJnbAGamy8XOzhZMtwtKzkwiGslKvpWuuf1QGYV32seNMXnlMX3aJIVqbwfsSFJqrvBiQ2kQ8qRT9sflqkvOnJPCJ45EmW9kzTIMQmuPbKrgrdM3xpFGhEMS+dhAiwJp2Evorg8Q5H1SJqRbicxNN2cJtwZqa8Fm5w60eUUR96l8/Ewvb3gyQY6nQEK3kQ6pLAKDe42YRMxV5i5PuZKMufUW97X0ccqnaQl1NT6q8119I2X5td5IQRR6bHSSJgUpvYmuxBA3XOFaHirEE28h84y+uFuisIgFvDq0hET+tz05VothlkqQ1d376Xe7xFkEZWHXUl9X22cpkIrKFKe3AsjPjbxzXK0KlcQ6sFWqx6BVlcKEk4ILK3tEB2jXl97QIUMkZW0Jmnl"
}

variable "cluster_name" {
  default = "cluster-1"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                        = "eks-vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "eks-igw"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "eks-public-subnet-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared" # Tags untuk jaringan milik EKS 
    "kubernetes.io/role/elb"                    = "1"      # Tempat public load balancer
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name                                        = "eks-private-subnet-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1" # Tempat internal load balancer
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "eks-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "eks-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "eks-private-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}





