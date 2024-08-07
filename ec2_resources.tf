# Create an EC2 Auto Scaling Group - app
resource "aws_autoscaling_group" "three-tier-app-asg" {
  name                 = "three-tier-app-asg"
  launch_configuration = aws_launch_configuration.three-tier-app-lconfig.id
  vpc_zone_identifier  = [aws_subnet.three-tier-pvt-sub-1.id, aws_subnet.three-tier-pvt-sub-2.id]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}

# Create a launch configuration for the EC2 instances
resource "aws_launch_configuration" "three-tier-app-lconfig" {
  name_prefix     = "three-tier-app-lconfig"
  image_id        = "ami-0b3a4110c36b9a5f0"
  instance_type   = "t2.micro"
  key_name        = "three-tier-app-asg-kp"
  security_groups = [aws_security_group.three-tier-ec2-asg-sg-app.id]
  user_data       = <<-EOF
                                #!/bin/bash

                                sudo yum install mysql -y

                                EOF

  associate_public_ip_address = false
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}