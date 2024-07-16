resource "aws_ecs_cluster" "cluster" {
  name = "github-actions-runner-cluster"
}

resource "aws_ecs_service" "orchestrator" {
  name = "orchestrator"
  desired_count = 1
  launch_type = "FARGATE"
  cluster = aws_ecs_cluster.cluster.arn
  network_configuration {
    subnets = var.subnets
    security_groups = [aws_security_group.orchestrator_sg.arn]
  }
}

resource "aws_security_group" "orchestrator_sg" {
  name = "gha-orchestrator-sg"
  vpc_id = var.vpc_id
  ingress{
    from_port = -1
    to_port = -1
    protocol = -1
    cidr_blocks = concat(var.ingress_cidrs, data.aws_vpc.vpc.cidr_block)
  }
  egress{
    from_port = -1
    to_port = -1
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}