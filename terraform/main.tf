module "vpc" {
  source = "./modules/vpc"

  name                        = "ramp-up"
  vpc_cidr                    = "192.168.0.0/16"
  azs                         = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets_cidr_blocks  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private_subnets_cidr_blocks = []
  tags                        = {}
}

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "ramp-up_sample_sg"
  }

  ingress_with_cird_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allow HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "ec2" {
  source = "./modules/ec2"

  ami           = "ami-0ebfd941bbafe70c6"
  sg_id         = module.security_groups.sg_id
  subnet_id     = module.vpc.public_subnet_ids[0]
  instance_type = "t2.micro"
  ssh_key_name  = "ramp-up"

  tags = {
    Name = "swg-sample-ec2"
  }
}

module "lambda" {
  source = "./modules/lambda"

  function_name              = "increment_sample_value"
  handler                    = "main.handler"
  runtime                    = "python3.8"
  lambda_role_arn            = "arn:aws:iam::905418362898:role/Lambda-dynamodb"
  invoking_service_name      = "APIGateway"
  invoking_service_principal = "apigateway.amazonaws.com"
  code_bucket_name           = "lambda-deployment-bucket455"
  code_object_key            = "lambda.zip"
  package_path               = "./lambda_source"
}

module "api_gateway" {
  source = "./modules/api_gateway"

  name         = "sample-api-gateway"
  lambda_arn   = module.lambda.lambda_invoke_arn
  lambda_alias = module.lambda.lambda_alias_name
  lambda_name  = module.lambda.lambda_function_name
}
