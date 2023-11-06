provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "CustomVPC"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_instance" "Demo_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet1.id
  key_name      = var.key_name

  tags = {
    Name = "Demo_Instance"
  }
} 

resource "aws_s3_bucket" "Demo_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"  

  tags = {
    Name = "Demo-Bucket"
  }
}


resource "aws_iam_role" "eks_s3_access_role" {
  name = "EKS_S3_Access_Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "S3_Access_Policy"
  description = "Allows access to a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_s3_policy_attachment" {
  role       = aws_iam_role.eks_s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_eks_cluster" "demo_eks_cluster" {
  name     = var.eks_cluster_name
  role_arn =  aws_iam_role.eks_s3_access_role.arn 

  vpc_config {
    subnet_ids = [var.aws_subnet]

  }
  
  depends_on = [aws_s3_bucket.Demo_bucket]
}

resource "aws_db_subnet_group" "example_db_subnet_group" {
  name       = "demo-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Demo_DB_SubnetGroup"
  }
}


resource "aws_db_instance" "Demo_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = var.db_instance_class
  nchar_character_set_name = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres12"
  db_subnet_group_name = aws_db_subnet_group.example_db_subnet_group.name

  vpc_security_group_ids = ["sg-12345678"] 

  tags = {
    Name = "Demo_DB"
  }
}

