# terraform will create dummy keys in order policy to read it
resource "aws_ssm_parameter" "path_access" {
  name  = "${var.key_path_access}"
  type  = "SecureString"
  value = "dummy"
}

resource "aws_ssm_parameter" "path_secret" {
  name  = "${var.key_path_secret}"
  type  = "SecureString"
  value = "dummy"
}
