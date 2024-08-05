variable "subnets" {
  type        = list(string)
  description = "a list of subnets to deploy the orchestrator to"
}

variable "vpc_id" {
  type        = string
  description = "the vpc where the service resides"
}

variable "ingress_cidrs" {
  type        = list(string)
  description = "a list of extra cidrs that will be added to security group ingress"
  default     = []
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "the region the vpc resides in"
}