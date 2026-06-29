resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = merge(var.tags, {
    Name = var.vpc_name
  })

}

# -----------------------------
# PUBLIC SUBNETS
# -----------------------------
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-${count.index}"
  })
}

# -----------------------------
# PRIVATE SUBNETS
# -----------------------------
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_subnet_cidrs[count.index]

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-${count.index}"
  })
}

# -----------------------------
# INTERNET GATEWAY
# -----------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
}