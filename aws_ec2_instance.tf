provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-east-1"
}
resource "aws_instance" "web" {
  ami = "ami-03ed2b90d746768d7"
  instance_type = "t2.micro"
  key_name   = "Mayuresh_US_East01"
}
