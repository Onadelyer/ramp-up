resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  dynamic "attribute" {
    for_each = var.additional_attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.additional_attributes
    content {
      name            = "${global_secondary_index.value["name"]}Index"
      hash_key        = global_secondary_index.value["name"]
      projection_type = "ALL"
    }
  }
}
