resource "aws_ecs_cluster" "cluster" {
  name = "github-actions-runner-cluster"
}

resource "aws_ecs_service" "orchestrator" {
  name            = "orchestrator"
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.cluster.arn
  task_definition = aws_ecs_task_definition.task_def.arn

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.orchestrator_sg.arn]
    assign_public_ip = false
  }
}

resource "aws_security_group" "orchestrator_sg" {
  name   = "gha-orchestrator-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = -1
    cidr_blocks = concat(var.ingress_cidrs, data.aws_vpc.vpc.cidr_block)
  }
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "task_def" {
  family             = "github-actions-runner"
  network_mode       = "awsvpc"
  cpu                = 1024
  memory             = 512
  task_role_arn      = aws_iam_role.task.arn
  execution_role_arn = aws_iam_role.execution.arn
  container_definitions = jsonencode([
    {
      name = "orchestrator"

      image                    = "${aws_ecr_repository.ecr.repository_url}:orhcestrator"
      requires_compatibilities = ["FARGATE"]
      essential                = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_iam_role" "execution" {
  name               = "gha-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json

}

resource "aws_iam_role_policy" "task_execution" {
  name   = "gha-task-execution"
  role   = aws_iam_role.execution.id
  policy = data.aws_iam_policy_document.task_execution_permissions.json
}

resource "aws_iam_role" "task" {
  name               = "gha-task-role"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy" "log_agent" {
  name   = "gha-log-permissions"
  role   = aws_iam_role.task.id
  policy = data.aws_iam_policy_document.task_permissions.json
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "gha-runner"
  retention_in_days = 60
}