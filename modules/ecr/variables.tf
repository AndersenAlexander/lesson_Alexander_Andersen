variable "repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "scan_on_push" {
  description = "Enable scanning of images on push"
  type        = bool
  default     = true
}

variable "image_tag_mutability" {
  type        = string
  description = "IMMUTABLE blocks modification of existing tags; MUTABLE allows overwriting."
  default     = "MUTABLE"
}

variable "force_delete" {
  type        = bool
  description = "If true, deletion of the repository will automatically delete all images within."
  default     = true
}

variable "repository_policy" {
  type        = string
  description = "JSON policy for the repository."
  default     = null
}
