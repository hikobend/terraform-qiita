resource "aws_db_subnet_group" "this" {
  name       = "${var.company_name}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.company_name}-aurora-subnet-group"
  }
}
