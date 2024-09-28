variable "profile" {
  type        = string
  description = "User profile"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "public_key" {
  type        = string
  description = "Path to the Public ssh key"
}

variable "environment" {
  type = map(string)
  default = {
    "development" = "development-environment"
    "testing"     = "testing-environment"
    "production"  = "production-environment"
  }
}

variable "tag_name" {
  type = map(string)
  default = {
    "development" = "development"
    "testing"     = "testing"
    "production"  = "production"
  }

}

variable "count_instance" {
  type        = number
  description = "Number of instances"
}
