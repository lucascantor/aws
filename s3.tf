# ------------------------------------------------------------------------------------------
# Terraform backend state bucket resources retained during account sunset

resource "aws_s3_bucket" "terraform_backend" {
  bucket = "cantor-terraform"
}

resource "aws_s3_bucket_versioning" "terraform_backend_versioning" {
  bucket = aws_s3_bucket.terraform_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}
