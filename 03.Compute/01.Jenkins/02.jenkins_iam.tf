resource "aws_iam_instance_profile" "jenkins" {
    name  = "jenkins"
    role = aws_iam_role.jenkins.id
}

resource "aws_iam_role" "jenkins" {
    name = format("%s-%s-jenkins", var.project_code, terraform.workspace)

    assume_role_policy = <<EOF
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                "Sid": "",
                "Effect": "Allow",
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
                }
            ]
        }
        EOF
}

resource "aws_iam_role_policy" "jenkins" {
    name = format("%s-%s-jenkins", var.project_code, terraform.workspace)
    role = aws_iam_role.jenkins.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
                    "Action": [
                        "sts:GetFederationToken",
                        "sts:AssumeRole",
                        "iam:PassRole"
                    ],
                    "Resource": "*",
                    "Effect": "Allow"
                }
            ]
        }
    EOF
}

