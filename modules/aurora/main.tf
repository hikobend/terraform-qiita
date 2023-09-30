resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.env}-aurora-subnet-group"
  }
}
