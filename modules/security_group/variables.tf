variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
  default = "vpc-xxxxxxxx" # replace if not passed from root
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { from_port = 5432, to_port = 5432, protocol = "tcp", cidr_blocks = ["121.241.210.182/32"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 5432, to_port = 5432, protocol = "tcp", cidr_blocks = ["203.147.89.184/30"] },
    { from_port = 4532, to_port = 4532, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = -1, to_port = -1, protocol = "icmp", cidr_blocks = ["3.7.0.137/32"] }
  ]
}
