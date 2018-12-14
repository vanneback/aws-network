variable project {
  description = "project name"
  default = "emils-network"
}

variable region {
  default = "us-east-2"
}

variable AZ{
  description = "availability zone"
  default = "us-east-2a"
}

variable vpc_cidr {
  default = "10.0.0.0/16"
}

variable amis {
  description = "Default AMIs to use for nodes depending on the region"
  type = "map"
  default = {
    ap-northeast-1 = "ami-0567c164"
    ap-southeast-1 = "ami-a1288ec2"
    cn-north-1 = "ami-d9f226b4"
    eu-central-1 = "ami-8504fdea"
    eu-west-1 = "ami-0d77397e"
    sa-east-1 = "ami-e93da085"
    us-east-1 = "ami-40d28157"
    us-east-2 = "ami-0f65671a86f061fcd"
    us-west-1 = "ami-6e165d0e"
    us-west-2 = "ami-a9d276c9"
  }
}

variable instance_type {
  default = "t2.micro"
}
