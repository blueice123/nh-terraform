# module "alb" {
#   source  = "../../00.Modules/alb"
#   # version = "~> 8.0"

#   name = "nh-jenkins"

#   load_balancer_type = "application"

#   vpc_id             = data.terraform_remote_state.nh-net-account-vpc.outputs.
#   subnets            = ["subnet-b4fbd3dd", "subnet-d263009f"]
#   security_groups    = ["sg-0bd2270ec78755584"]

#   # access_logs = {
#   #   bucket = data.terraform_remote_state.logs.outputs.s3_alb_access_arn
#   # }

#     target_groups = [
#     {
#       name_prefix      = "nh-jenkins-tg"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       targets = {
#         # my_target = {
#         #   target_id = "i-0123456789abcdefg"
#         #   port = 80
#         # }
#         jenkins = {
#           target_id = "i-a1b2c3d4e5f6g7h8i"
#           port = 8080
#         }
#       }
#     }
#   ]

#   http_tcp_listeners = [
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#     }
#   ]

#   # https_listeners = [
#   #   {
#   #     port               = 443
#   #     protocol           = "HTTPS"
#   #     certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
#   #     target_group_index = 0
#   #   }
#   # ]

#   # http_tcp_listeners = [
#   #   {
#   #     port        = 80
#   #     protocol    = "HTTP"
#   #     action_type = "redirect"
#   #     redirect = {
#   #       port        = "443"
#   #       protocol    = "HTTPS"
#   #       status_code = "HTTP_301"
#   #     }
#   #   }
#   # ]

#   tags = {
#     Environment = "shared"
#   }
# }