variable "s3_bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
  default     = "memos-aamir-s3"
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository to create"
  type        = string
  default     = "memos-ecr"
}

variable "image_tag_immutability" {
  description = "Whether to enable image tag immutability for the ECR repository"
  type        = bool
  default     = true
}

variable "github_repo" {
  description = "The GitHub repository in the format 'owner/repo'"
  type        = string
  default     = "AamirKT/eks-memos"
}