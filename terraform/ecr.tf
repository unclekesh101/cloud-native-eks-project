resource "aws_ecr_repository" "this" {
  name = "eks-python-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "eks-python-app"
  }
}
