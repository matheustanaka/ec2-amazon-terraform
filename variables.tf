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
