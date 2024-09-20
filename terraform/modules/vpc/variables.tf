variable "name" {
  description = "Name prefix for resources"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}
variable "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}
variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
}
