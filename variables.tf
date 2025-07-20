variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = "rohsiv-repo-new" # Optional: you can remove default if you want to pass it in tfvars
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "rohsiv-cluster-new" # Optional
}
