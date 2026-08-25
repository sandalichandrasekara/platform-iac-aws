locals {
  name_prefix = "${var.project}-${var.environment}"
}

# 1. Networking: VPC, subnets, NAT, routing.
module "networking" {
  source      = "../../modules/networking"
  name_prefix = local.name_prefix
}

# 2. Security: tiered security groups + EC2 SSM role.
module "security" {
  source      = "../../modules/security"
  name_prefix = local.name_prefix
  vpc_id      = module.networking.vpc_id
}

# 3. Database: DocumentDB in the private data subnets.
# Module defaults are prod-safe; dev overrides them for cheap, fast teardown.
module "database" {
  source              = "../../modules/database"
  name_prefix         = local.name_prefix
  subnet_ids          = module.networking.data_subnet_ids
  security_group_ids  = [module.security.data_sg_id]
  skip_final_snapshot = true  # dev is disposable
  deletion_protection = false # allow `terraform destroy` in dev
}

# 4. Compute: ALB + Auto Scaling Group in the app subnets.
module "compute" {
  source                = "../../modules/compute"
  name_prefix           = local.name_prefix
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  app_subnet_ids        = module.networking.app_subnet_ids
  alb_sg_id             = module.security.alb_sg_id
  app_sg_id             = module.security.app_sg_id
  instance_profile_name = module.security.instance_profile_name
}

# 5. Monitoring: SNS + CloudWatch alarms.
module "monitoring" {
  source                  = "../../modules/monitoring"
  name_prefix             = local.name_prefix
  asg_name                = module.compute.asg_name
  alb_arn_suffix          = module.compute.alb_arn_suffix
  target_group_arn_suffix = module.compute.target_group_arn_suffix
  alarm_email             = var.alarm_email
}

# 6. Backup: daily AWS Backup of the database.
module "backup" {
  source        = "../../modules/backup"
  name_prefix   = local.name_prefix
  resource_arns = [module.database.cluster_arn]
}
