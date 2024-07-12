variable "REGISTRY" {
  default = ""
  #Ensure you have a slash on this!!!
}

group "all" {
    targets = ["orchestrator", "ephemeral"]
}

target "orchestrator" {
    dockerfile = "../Dockerfile"
    context= "./orchestrator"
    tags= ["${REGISTRY}orchestrator"]
}

target "ephemeral" {
    dockerfile = "../Dockerfile"
    context= "./ephemeral"
    tags= ["${REGISTRY}ephemeral"]
}

target "test" {
    dockerfile = "../Dockerfile"
    context= "./test"
}