# Creating a basic VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block   # CIDR block for our VPC (e.g., 10.0.0.0/16)
  enable_dns_support   = true                 # Enables DNS support in the VPC
  enable_dns_hostnames = true                 # Enables DNS hostnames for resources in the VPC

  tags = {
    Name = "${var.vpc_name}-vpc"              # Adds a tag that includes the VPC name
    Environment = "lesson-8-9"
  }
}

# Creating public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)   # Creating multiple subnets, the count is determined by the length of the public_subnets list
  vpc_id                  = aws_vpc.main.id              # Binding each subnet to the VPC created earlier
  cidr_block              = var.public_subnets[count.index] # CIDR block for the specific subnet from the public_subnets list
  availability_zone       = var.availability_zones[count.index] # Defining availability zones for each subnet
  map_public_ip_on_launch = true                         # Automatically assigns public IP addresses to instances in the subnet

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"  # Tag with subnet numbering
    # count.index — this is the index of the "count" loop, starting from 0.
    # ${count.index + 1} adds +1 to the index, to get a human-readable designation (1, 2, 3 instead of 0, 1, 2).
    Environment = "lesson-8-9"
  }
}

# Creating private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)   # Creating multiple private subnets, the count matches the length of the private_subnets list
  vpc_id            = aws_vpc.main.id               # Binding each private subnet to the VPC
  cidr_block        = var.private_subnets[count.index] # CIDR block for the specific subnet from the private_subnets list
  availability_zone = var.availability_zones[count.index] # Defining availability zones for each subnet

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"  # Tag for the subnet with numbering
    # ${count.index + 1} is used to start the subnet numbering from 1.
    Environment = "lesson-8-9"
  }
}

# Creating Internet Gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id   # Binding the Internet Gateway to the VPC for internet access

  tags = {
    Name = "${var.vpc_name}-igw"   # Tag for identifying the Internet Gateway
    Environment = "lesson-8-9"
  }
}

## Creating Elastic IP for NAT instance
#resource "aws_eip" "nat_eip" {
#  tags = {
#    Name = "${var.vpc_name}-nat-eip"
#  }
#}

## Creating NAT instance
#resource "aws_nat_gateway" "nat" {
#  allocation_id = aws_eip.nat_eip.id
#  subnet_id     = aws_subnet.public[0].id  # NAT Gateway must be in a public subnet
#  tags = {
#    Name = "${var.vpc_name}-nat-gw"
#  }
#
#  depends_on = [aws_internet_gateway.igw]
#}
