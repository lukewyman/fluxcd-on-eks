module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.36"

  cluster_name = "istio-tasks"
  cluster_version = var.cluster_version  

  cluster_endpoint_public_access = true 

  enable_cluster_creator_admin_permissions = true 
  enable_irsa = true

  eks_managed_node_groups = {
    initial = {
      instance_types = var.instance_types
      capacity_type = "SPOT"
      min_size = var.cluster_min_size  
      max_size = var.cluster_max_size  
      desired_size = var.cluster_desired_size 
      ec2_ssh_key = var.ec2_ssh_key   
    }
  }

  vpc_id = var.vpc_id 
  subnet_ids = var.subnet_ids

  tags = {
    Environment = "test"
    Terraform = "true"
  }
}


# IAM Policy and Role for AWS Load Balancer Controller 

resource "aws_iam_policy" "lbc_iam_policy" {
  name = "${var.app_name}-AWSLoadBalancerControllerIAMPolicy"
  path = "/"
  description = "AWS Load Balancer Controller IAM Policy"
  policy = data.http.lbc_iam_policy.response_body
}

resource "aws_iam_role" "lbc_iam_role" {
  name = "${var.app_name}-lbc-iam-role"

  assume_role_policy = data.aws_iam_policy_document.lbc_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lbc_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.lbc_iam_policy.arn 
  role = aws_iam_role.lbc_iam_role.name
}