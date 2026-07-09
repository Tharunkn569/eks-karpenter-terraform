variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "tags" {
  description = "Common tags applied to GitHub OIDC resources"
  type        = map(string)
  default     = {}
}