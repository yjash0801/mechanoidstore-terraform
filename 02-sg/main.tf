module "mongodb" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for mongodb"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "mongodb"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "redis" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for redis"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "redis"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "mysql" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for mysql"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "mysql"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "rabbitmq" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for rabbitmq"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "rabbitmq"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "catalogue" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for catalogue"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "catalogue"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "user" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for user"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "user"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "cart" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for cart"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "cart"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "shipping" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for shipping"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "shipping"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "payment" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for payment"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "payment"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "web" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for web"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    sg_name = "web"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

module "vpn" {
    source = "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    description = "SG for VPN"
    vpc_id = data.aws_vpc.default.id
    sg_name = "vpn"
    #ingress_rule = var.mongodb_sg_ingress_rules
}

#openvpn sg
resource "aws_security_group_rule" "vpn_yourip" {
    security_group_id = module.vpn.sg_id
    type              = "ingress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["0.0.0.0/0"] #ideally your ip address, and static only
}

#mongodb accept connections from catalogue instance
resource "aws_security_group_rule" "mongodb_catalogue" {
    source_security_group_id = module.catalogue.sg_id
    type              = "ingress"
    from_port         = 27017
    to_port           = 27017
    protocol          = "tcp"
    security_group_id = module.mongodb.sg_id
}

#mongodb accept connections from user instance
resource "aws_security_group_rule" "mongodb_user" {
    source_security_group_id = module.user.sg_id
    type              = "ingress"
    from_port         = 27017
    to_port           = 27017
    protocol          = "tcp"
    security_group_id = module.mongodb.sg_id
}

#mongodb accept connections from vpn instance
resource "aws_security_group_rule" "mongodb_vpn" {
    source_security_group_id = module.vpn.sg_id
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    security_group_id = module.mongodb.sg_id
}

#redis accept connections from cart instance
resource "aws_security_group_rule" "redis_cart" {
    source_security_group_id = module.cart.sg_id
    type = "ingress"
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_group_id = module.redis.sg_id
}

#redis accept connections from user instance
resource "aws_security_group_rule" "redis_user" {
    source_security_group_id = module.user.sg_id
    type = "ingress"
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_group_id = module.redis.sg_id
}