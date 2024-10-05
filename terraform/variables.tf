variable "subnets" {
  type        = list(string)
  description = "a list of subnets to deploy the orchestrator to"
}

variable "vpc_id" {
  type        = string
  description = "the vpc where the service resides"
}

variable "ingress_cidrs" {
  type        = set(string)
  description = "a list of extra cidrs that will be added to security group ingress"
  default     = []
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "the region the vpc resides in"
}

variable "environment_variables" {
  type = object({
    GITHUB_PERSONAL_TOKEN = string,
    GITHUB_REPOSITORY = optional(string),
    GITHUB_ORG = string,
    DESTINATION = string,
    RUNNER_GROUP = string,
    RUNNER_LABELS = set(string)
  })
}
