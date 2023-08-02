# resource "aws_security_group" "jenkins" {
#     ingress {
#         from_port   = 8080
#         to_port     = 8080
#         protocol    = "TCP"
#         cidr_blocks = [var.vpc_cidr]
#         description = "For HTTP Traffic"
#     }
#     egress {
#         from_port   = 80
#         to_port     = 80
#         protocol    = "TCP"
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "For HTTP Traffic Outbound"
#     }
#     egress {
#         from_port   = 443
#         to_port     = 443
#         protocol    = "TCP"
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "For HTTPS Traffic Outbound"
#     }

#     vpc_id      = aws_vpc.vpc_main.id
#     name        = format("%s-%s-jenkins-sg", var.project_code, terraform.workspace)
#     description = format("%s-%s-jenkins-sg", var.project_code, terraform.workspace)
    
#     tags = {
#         Name = format("%s-%s-jenkins-sg", var.project_code, terraform.workspace)
#     }
# }