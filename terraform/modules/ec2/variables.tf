variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "ssh_key_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "sg_id" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "root_volume_size" {
  type = number
}
variable "root_volume_type" {
  type = string
}
variable "root_volume_delete_on_termination" {
  type = bool
}
variable "private_ip" {
  type = string
}
variable "network_interface_name" {
  type = string
}
variable "ec2_encrypted" {
  type = string
}
variable "kms_key" {
  type = string
}
