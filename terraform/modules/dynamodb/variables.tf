variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "The billing mode for the DynamoDB table (PAY_PER_REQUEST or PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "The primary key for the DynamoDB table"
  type        = string
}

variable "hash_key_type" {
  description = "The data type for the hash key (S for string, N for number, B for binary)"
  type        = string
  default     = "S"
}

variable "additional_attributes" {
  description = "Additional attributes for the DynamoDB table"
  type        = list(object({
    name = string
    type = string
  }))
  default = []
}