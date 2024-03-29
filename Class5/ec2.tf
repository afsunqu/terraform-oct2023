resource "aws_instance" "web" {
  ami           = "ami-09694bfab577e90b0"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"
  key_name = aws_key_pair.deployer.key_name

  connection {
    host = element(aws_instance.web[*].public_ip, 0)
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
  }
  provisioner "file" {
    source = "./main.tf"
    destination = "./hello.tf"
  }
  
}

resource "aws_key_pair" "deployer" {
  key_name   = "kaizen2"
  public_key = file("~/.ssh/id_rsa.pub")

  }
