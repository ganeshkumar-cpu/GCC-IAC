# Assuming you have an Auto Scaling group resource named `aws_autoscaling_group.this`

# Output for the Auto Scaling Group Name
output "asg_name" {
  value = aws_autoscaling_group.this.name
}

# Output for the Auto Scaling Group ID
output "asg_id" {
  value = aws_autoscaling_group.this.id
}

# Output for the Launch Template ID
output "launch_template_id" {
  value = aws_launch_template.this.id
}

# Query the EC2 instances using the Auto Scaling Group tag
data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [aws_autoscaling_group.this.name]
  }
}

# Output the instance IDs of instances in the Auto Scaling group
output "asg_instances" {
  value = data.aws_instances.asg_instances.ids
}
