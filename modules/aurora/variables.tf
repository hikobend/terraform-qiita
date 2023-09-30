variable "private_subnet_ids" {
  description = "The private subnet IDs to deploy the Aurora cluster to"
  type        = list(string)
}
