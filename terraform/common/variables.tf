variable "subnets" {
  type = list(string)
  description = "a list of subnets to deploy the orchestrator to"
}

variable "vpc_id" {
  type = string
  description = "the vpc where the service resides"
}

variable "ingress_cidrs" {
  type = list(string)
  description = "a list of extra cidrs that will be added to security group ingress"
}