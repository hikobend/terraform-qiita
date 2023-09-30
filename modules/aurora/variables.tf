variable "private_subnet_ids" {
  description = "The private subnet IDs to deploy the Aurora cluster to"
  type        = list(string)
}

variable "env" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
}
