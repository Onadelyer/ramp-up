variable "ami" {
  description = "The ID of the AMI to use for the instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start (e.g., t2.micro)."
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for the instance."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in."
  type        = string
}

variable "sg_id" {
  description = "The ID of the security group to associate with the instance."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the instance."
  type        = map(string)
}
