variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "172.20.0.0/20"
}

# CIDR vals
variable "public_web_cidr" {
  type        = list(string)
  description = "subnet values for public web subnet"
  default     = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
}

variable "private_app_cidr" {
  type        = list(string)
  description = "subnet values for public web subnet"
  default     = ["172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]
}

variable "private_db_cidr" {
  type        = list(string)
  description = "subnet values for public web subnet"
  default     = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
}

variable "availability_zones" {
  type = list(string)
  description = "availabilty zones"
  default = [ "us-east-1a", "us-east-1b" , "us-east-1c" ]
}
