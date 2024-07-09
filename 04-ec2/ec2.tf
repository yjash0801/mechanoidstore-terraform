module "mongodb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-mongodb"
  ami = data.aws_ami.centos.id
  instance_type          = var.t3-micro
  #key_name               = "user1"
  #monitoring             = true
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_id 

  tags = merge(

    var.common_tags,
    {
        Component = "mongodb"
    },
    {
        Name = "${local.ec2_name}-mongodb"
    }
  )
}