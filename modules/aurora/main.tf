resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.env}-aurora-subnet-group"
  }
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.env}-aurora-parameter-group"
  family = "aurora-mysql8.0"

  parameter {
    name  = "general_log"
    value = "1"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "0"
  }

  parameter {
    name         = "log_output"
    value        = "FILE"
    apply_method = "pending-reboot"
  }
}
