provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

module "cassandra_security_group" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_cassandra"
  security_group_name = "${var.security_group_name}-cassandra"
  vpc_id = "${aws_vpc.cassandra.id}"
  source_cidr_block = ["10.2.5.0/24"]
}

module "cassandra1_security_group" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_cassandra"
  security_group_name = "${var.security_group_name}-cassandra1"
  vpc_id = "${aws_vpc.cassandra1.id}"
  source_cidr_block = ["10.3.5.0/24"]
}

resource "aws_vpc" "cassandra" {
  cidr_block = "10.2.5.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy     = "default"
  tags { Name = "cassandra" }
}

resource "aws_vpc" "cassandra1" {
  cidr_block = "10.3.5.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy     = "default"
  tags { Name = "cassandra1" }
}

resource "aws_subnet" "cassandra" {
  vpc_id = "${aws_vpc.cassandra.id}"
  cidr_block = "10.2.5.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.az}"
  
  tags {
    Name = "${var.user_name}_cassandra"
  }
}

resource "aws_subnet" "cassandra1" {
  vpc_id = "${aws_vpc.cassandra1.id}"
  cidr_block = "10.3.5.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.az}"
  tags {
    Name = "${var.user_name}_cassandra1"
  }
}

resource "aws_internet_gateway" "cassandra" {
  vpc_id = "${aws_vpc.cassandra.id}"
  tags {
    Name = "${var.user_name}_cassandra"
  }
}
resource "aws_internet_gateway" "cassandra1" {
  vpc_id = "${aws_vpc.cassandra1.id}"
  tags {
    Name = "${var.user_name}_cassandra1"
  }
}

resource "aws_route_table" "cassandra" {
  vpc_id = "${aws_vpc.cassandra.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.cassandra.id}"
  }
}

resource "aws_route_table" "cassandra1" {
  vpc_id = "${aws_vpc.cassandra1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.cassandra1.id}"
  }
}


resource "aws_network_acl" "cassandra" {
  vpc_id = "${aws_vpc.cassandra.id}"
  subnet_ids = ["${aws_subnet.cassandra.id}"]
  egress{
    protocol = "all"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "all"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags {
    Name = "${var.user_name}"
  }
}

resource "aws_network_acl" "cassandra1" {
  vpc_id = "${aws_vpc.cassandra1.id}"
  subnet_ids = ["${aws_subnet.cassandra1.id}"]
  egress{
    protocol = "all"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "all"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags {
    Name = "${var.user_name}"
  }
}

resource "aws_route_table_association" "cassandra" {
  subnet_id = "${aws_subnet.cassandra.id}"
  route_table_id = "${aws_route_table.cassandra.id}"
}

resource "aws_route_table_association" "cassandra1" {
  subnet_id = "${aws_subnet.cassandra1.id}"
  route_table_id = "${aws_route_table.cassandra1.id}"
}

resource "aws_security_group" "cassandra_net" {
  name = "allow_internet_access"
  description = "Allow outbound internet communication."
  vpc_id = "${aws_vpc.cassandra.id}"

  tags {
    Name = "cluster_internet"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "cassandra1_net" {
  name = "allow_internet_access"
  description = "Allow outbound internet communication."
  vpc_id = "${aws_vpc.cassandra1.id}"

  tags {
    Name = "cluster_internet"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "cassandra_ssh" {
  name = "allow_all_ssh_access"
  description = "ALlow ssh access from any ip"
  vpc_id = "${aws_vpc.cassandra.id}"
  tags {
    Name = "cluster_ssh"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "cassandra1_ssh" {
  name = "allow_all_ssh_access"
  description = "ALlow ssh access from any ip"
  vpc_id = "${aws_vpc.cassandra1.id}"
  tags {
    Name = "cluster_ssh"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
