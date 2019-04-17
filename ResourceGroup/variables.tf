variable "name" {
  default = "infra-test"

  description = "Resource Name"
}

variable "location" {
  default = "westus2"

  description = "Resource Location"
}

variable "tags" {
  type        = "map"
  description = "Resource Tags"
}