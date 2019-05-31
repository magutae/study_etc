// eip 1개
resource "aws_eip" "kumaya-eip" {
    vpc = true
    
    tags {
        Name = "kumaya-eip"
    }
}

// vpc 1개
resource "aws_vpc" "kumaya-vpc" {
    cidr_block = "10.0.0.0/16"
    
    tags {
        Name = "kumaya-vpc"
    }
}

// subnet 2개
resource "aws_subnet" "kumaya-public-subnet-a" {
    vpc_id            = "${aws_vpc.kumaya-vpc.id}"
    cidr_block        = "10.0.0.0/24"
    availability_zone = "ap-northeast-2a"

    tags {
        Name = "kumaya-public-subnet-a"
    }
}
resource "aws_subnet" "kumaya-private-subnet-a" {
    vpc_id            = "${aws_vpc.kumaya-vpc.id}"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"

    tags {
        Name = "kumaya-private-subnet-a"
    }
}

// 라우팅 테이블 2개
resource "aws_route_table" "kumaya-public-rtb" {
    vpc_id = "${aws_vpc.kumaya-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.kumaya-igw.id}"
    }

    tags {
        Name = "kumaya-public-rtb"
    }
}

resource "aws_route_table" "kumaya-private-rtb" {
    vpc_id = "${aws_vpc.kumaya-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.kumaya-nat.id}"
    }

    tags {
        Name = "kumaya-private-rtb"
    }
}

resource "aws_main_route_table_association" "kumaya-rtb-asso" {
  vpc_id         = "${aws_vpc.kumaya-vpc.id}"
  route_table_id = "${aws_route_table.kumaya-public-rtb.id}"
}

// 인터넷 게이트웨이 1개
resource "aws_internet_gateway" "kumaya-igw" {
    vpc_id = "${aws_vpc.kumaya-vpc.id}"

    tags {
        Name = "kumaya-igw"
    }
}

// NAT 게이트웨이 1개
resource "aws_nat_gateway" "kumaya-nat" {
    allocation_id = "${aws_eip.kumaya-eip.id}"
    subnet_id     = "${aws_subnet.kumaya-public-subnet-a.id}"

    tags {
        Name = "kumaya-nat"
    }
}

// ACL 3개
// 디폴트 1개, public 1개, private 1개
resource "aws_default_network_acl" "kumaya-default-acl" {
    default_network_acl_id = "${aws_vpc.kumaya-vpc.default_network_acl_id}"

    tags {
        Name = "kumaya-default-acl"
    }
}

// Security Group 1개
// EC2 생성후 설정 추가 필요
resource "aws_default_security_group" "kumaya-default-sg" {
    vpc_id = "${aws_vpc.kumaya-vpc.id}"
    
    tags {
        Name = "kumaya-default-sg"
    }
}

// DHCP 옵션 세트 1개
resource "aws_default_vpc_dhcp_options" "kumaya-default-dhcp" {
  tags = {
    Name = "kumaya-default-dhcp"
  }
}

