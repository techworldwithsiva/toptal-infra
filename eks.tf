# module "eks" {
#   source  = "./modules/terraform-aws-eks"

#   cluster_name    = "toptal-cluster"
#   cluster_version = "1.24"

#   cluster_endpoint_public_access  = true

#   cluster_addons = {
#     coredns = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#   }

#   vpc_id                   = local.vpc_id
#   subnet_ids               = local.private_subnets
#   control_plane_subnet_ids = local.private_subnets

#   eks_managed_node_groups = {
#     blue = {}
#     green = {
#       min_size     = 1
#       max_size     = 10
#       desired_size = 1

#       instance_types = ["t3.large"]
#       capacity_type  = "SPOT"
#     }
#   }

#   aws_auth_users = [
#     {
#       userarn  = "arn:aws:iam::752692907119:user/eks-admin"
#       username = "eks-admin"
#       groups   = ["system:masters"]
#     }
#   ]

#   tags = merge(local.tags, {
#         Name  = "toptal-cluster"
#     })

# }

/* resource "aws_autoscaling_policy" "example" {
  # ... other configuration ...
  depends_on
  for_each = toset(module.eks.eks_managed_node_groups_autoscaling_group_names)
  name = "dynamic-policy-${each.value}"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
  autoscaling_group_name = each.value
} */

/* module "my_scaling_policy" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "my-scaling-policy"
  resource_id = module.my_node_group.node_group_arn
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity = 2
  max_capacity = 10
  target_value = 50
} */