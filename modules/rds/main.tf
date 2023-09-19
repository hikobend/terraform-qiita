resource "aws_db_parameter_group" "this" {
  name   = "${var.env}-parameter-group"
  family = "mysql8.0.32"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
