# resource "aws_iam_role" "ecs_task_execution" {
#   name = "${local.name}-ECSTaskExecution"

#   assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
#   tags = merge(local.tags, {
#     Name = "${local.name}-ECSTaskExecution"
#   })
# }

# resource "aws_iam_role" "ecs_task" {
#   name = "${local.name}-ECSTask"

#   assume_role_policy = data.aws_iam_policy_document.ecs_trust.json
#   tags = merge(local.tags, {
#     Name = "${local.name}-ECSTask"
#   })
# }

# resource "aws_iam_policy" "toptal_ecs_task_execution" {
#   name        = "${local.name}-ecs-task-execution"
#   description = "Policy that allows Stitcher ECS task to perform action"

#   policy = data.aws_iam_policy_document.rds_secret.json
#   tags = merge(local.tags, {
#     Name = "${local.name}-ecs-task-execution"
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
#   role       = aws_iam_role.ecs_task_execution.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment_rds_secret" {
#   role       = aws_iam_role.ecs_task_execution.name
#   policy_arn = aws_iam_policy.toptal_ecs_task_execution.arn
# }

# resource "aws_cloudwatch_log_group" "ecs-api" {
#   name = "/ecs/toptal/api"

#   tags = merge(local.tags, {
#     Name = local.name
#   })
# }

# resource "aws_cloudwatch_log_group" "ecs-web" {
#   name = "/ecs/toptal/web"

#   tags = merge(local.tags, {
#     Name = local.name
#   })
# }

