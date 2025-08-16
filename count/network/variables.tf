variable "availability_zones" {
    description = "List of availability zones"
    type = list(string)
    default = ["us-west-2a", "us-west-2b"]
}

variable "public_subnet_cidrs" {
    description = "CIDR blocks for public subnets"
    type = list(string)
    default = ["10.0.1.0/24", "10.0.4.0/24"]
  
}

variable "private_subnet_cidrs" {
    description = "CIDR blocks for private subnets"
    type = list(string)
    default = ["10.0.3.0/24", "10.0.4.0/24"]


}

