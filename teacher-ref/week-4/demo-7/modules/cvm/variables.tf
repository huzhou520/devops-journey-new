variable "secret_id" {
  default = "Your Access ID"
}

variable "secret_key" {
  default = "Your Access Key"
}

variable "region" {
  default = "ap-hongkong"
}

variable "password" {
  default = "password123"
}

variable "cvm_name" {
  type        = string
  default     = ""
  description = "Name of CVM Instance."
}
