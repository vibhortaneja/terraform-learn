resource "aws_kms_key" "wordpress" {
  description             = "KMS Key used to encrypt Wordpress related resources"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  is_enabled              = true
  policy                  = data.aws_iam_policy_document.kms.json
  tags = {
    Name = "KMS-key Wordpress"
  }
}

resource "aws_kms_alias" "wordpress" {
  name          = "alias/wordpress"
  target_key_id = aws_kms_key.wordpress.id
}
