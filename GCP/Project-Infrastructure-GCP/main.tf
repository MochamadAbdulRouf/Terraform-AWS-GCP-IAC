module "modules" {
    source = "./modules/instances"
    region      = var.region 
    zone        = var.zone 
    project_id  = var.project_id
}

