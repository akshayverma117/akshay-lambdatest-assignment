data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = "akshay-lambdatest"
    key    = "terraform/vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}

module "webserver" {
  source                      = "../../modules/ec2_module"
  instance_count              = local.variables[terraform.workspace].ec2.webserver.count
  name                        = join("-", [var.platform, "webserver", local.environment])
  ami                         = "ami-0c1a7f89451184c8b"
  key_name                    = var.ec2_jump_pem_path
  instance_type               = local.variables[terraform.workspace].ec2.webserver.type
  associate_public_ip_address = false
  cpu_credits                 = "unlimited"
  subnet_id                   = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  vpc_security_group_ids      = [module.webserver_security_group.this_security_group_id]
  iam_instance_profile        = "${aws_iam_instance_profile.webserver_iam_profile.name}"
  user_data                   = "${data.template_file.webserver_userdata_script_template.rendered}"
  tags = {  
    "Environment"             = local.environment
    "Application"             = "webserver"
    "Name"                    = "${var.platform}-webserver-${local.environment}"
  }
}


data "template_file" "webserver_userdata_script_template" {
  template = "${file("../../templates/install-apache.sh.tpl")}"
  vars = {
    aws_ec2_region            = "${var.aws_region}"
    project_platform          = "${var.platform}"
    project_environment       = "${local.environment}"
  }
}



module "webserver_security_group" {
  source  = "../../modules/sg_module"
  name        = "${var.platform}-webserver-${local.environment}"
  description = "Security Group for Web Server"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = {
    "Environment"  = local.environment
    "Application"  = "webserver"
    "Name"         = "${var.platform}-webserver-${local.environment}-sg"
  }

  ingress_cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Ingress for SSH only from the terraform workstation"
      cidr_blocks = "${chomp(data.http.myip.body)}/32"
    }
  ]
  egress_rules        = ["all-all"]
}


resource "aws_iam_policy" "webserver_iam_policy" {
  name        = "webserver_node_iam_policy_${local.environment}"
  description = "IAM Policy for webserver nodes"
  policy      = "${file("../../templates/webserver_iam_policy.json")}"
  tags = {
    "Environment"  = local.environment
    "Application"  = "webserver"
    "Name"         = "${var.platform}-webserver-${local.environment}-IAMPolicy"
  }
}

resource "aws_iam_role" "webserver_iam_role" {
  name = "webserver_node_iam_role_${local.environment}"
  assume_role_policy = "${file("../../templates/webserver_assumerole.json")}"
  tags = {
    "Environment"  = local.environment
    "Application"  = "webserver"
    "Name"         = "${var.platform}-webserver-${local.environment}-IAMRole"
  }
}

resource "aws_iam_role_policy_attachment" "webserver_iam_role_attach" {
  role       = "${aws_iam_role.webserver_iam_role.name}"
  policy_arn = "${aws_iam_policy.webserver_iam_policy.arn}"
}

resource "aws_iam_instance_profile" "webserver_iam_profile" {
  name = "webserver_profile_${local.environment}"
  role = "${aws_iam_role.webserver_iam_role.name}"
}
