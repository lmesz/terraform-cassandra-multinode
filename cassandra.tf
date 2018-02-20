resource "aws_instance" "cassandra_0" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.ssh_key_name}"
  private_ip = "10.2.5.170"
  subnet_id = "${aws_subnet.cassandra.id}"
  vpc_security_group_ids = ["${module.cassandra_security_group.security_group_id}", "${aws_security_group.cassandra_net.id}", "${aws_security_group.cassandra_ssh.id}"]
  depends_on = ["aws_internet_gateway.cassandra"]

  tags {
    Name = "${var.user_name}_cassandra_0"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/backup.bash"
    destination = "/home/ubuntu/backup.bash"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }
}


resource "aws_instance" "cassandra_1" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.ssh_key_name}"
  private_ip = "10.2.5.171"
  subnet_id = "${aws_subnet.cassandra.id}"
  vpc_security_group_ids = ["${module.cassandra_security_group.security_group_id}", "${aws_security_group.cassandra_net.id}", "${aws_security_group.cassandra_ssh.id}"]
  depends_on = ["aws_internet_gateway.cassandra", "aws_instance.cassandra_0"]

  tags {
    Name = "${var.user_name}_cassandra_1"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }
}


resource "aws_instance" "cassandra_2" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.ssh_key_name}"
  private_ip = "10.2.5.172"
  subnet_id = "${aws_subnet.cassandra.id}"
  vpc_security_group_ids = ["${module.cassandra_security_group.security_group_id}", "${aws_security_group.cassandra_net.id}", "${aws_security_group.cassandra_ssh.id}"]
  depends_on = ["aws_internet_gateway.cassandra", "aws_instance.cassandra_1"]

  tags {
    Name = "${var.user_name}_cassandra_2"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }
}

resource "aws_instance" "cassandra_3" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.ssh_key_name}"
  private_ip = "10.3.5.170"
  subnet_id = "${aws_subnet.cassandra1.id}"
  vpc_security_group_ids = ["${module.cassandra1_security_group.security_group_id}", "${aws_security_group.cassandra1_net.id}", "${aws_security_group.cassandra1_ssh.id}"]
  depends_on = ["aws_internet_gateway.cassandra1"]

  tags {
    Name = "${var.user_name}_cassandra_3"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/backup.bash"
    destination = "/home/ubuntu/backup.bash"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }
}


resource "aws_instance" "cassandra_4" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.ssh_key_name}"
  private_ip = "10.3.5.171"
  subnet_id = "${aws_subnet.cassandra1.id}"
  vpc_security_group_ids = ["${module.cassandra1_security_group.security_group_id}", "${aws_security_group.cassandra1_net.id}", "${aws_security_group.cassandra1_ssh.id}"]
  depends_on = ["aws_internet_gateway.cassandra1", "aws_instance.cassandra_3"]

  tags {
    Name = "${var.user_name}_cassandra_4"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }
}


resource "aws_instance" "cassandra_5" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.ssh_key_name}"
  private_ip = "10.3.5.172"
  subnet_id = "${aws_subnet.cassandra1.id}"
  vpc_security_group_ids = ["${module.cassandra1_security_group.security_group_id}", "${aws_security_group.cassandra1_net.id}", "${aws_security_group.cassandra1_ssh.id}"]
  depends_on = ["aws_internet_gateway.cassandra1", "aws_instance.cassandra_4"]

  tags {
    Name = "${var.user_name}_cassandra_5"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup_cassandra.sh"
    destination = "/tmp/provisioning/setup_cassandra.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file(var.ssh_key_path)}"
    }
  }
}

resource "aws_ebs_volume" "cassandra_0" {
  availability_zone = "${var.az}"
  size = 500
  type = "gp2"

  tags {
    Name = "${var.user_name}_cassandra_0"
  }
}

resource "aws_ebs_volume" "cassandra_1" {
  availability_zone = "${var.az}"
  size = 500
  type = "gp2"

  tags {
    Name = "${var.user_name}_cassandra_1"
  }
}

resource "aws_ebs_volume" "cassandra_2" {
  availability_zone = "${var.az}"
  size = 500
  type = "gp2"

  tags {
    Name = "${var.user_name}_cassandra_2"
  }
}

resource "aws_ebs_volume" "cassandra_3" {
  availability_zone = "${var.az}"
  size = 500
  type = "gp2"

  tags {
    Name = "${var.user_name}_cassandra_3"
  }
}

resource "aws_ebs_volume" "cassandra_4" {
  availability_zone = "${var.az}"
  size = 500
  type = "gp2"

  tags {
    Name = "${var.user_name}_cassandra_4"
  }
}

resource "aws_ebs_volume" "cassandra_5" {
  availability_zone = "${var.az}"
  size = 500
  type = "gp2"

  tags {
    Name = "${var.user_name}_cassandra_5"
  }
}

resource "aws_volume_attachment" "cassandra_0_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.cassandra_0.id}"
  instance_id = "${aws_instance.cassandra_0.id}"
}

resource "aws_volume_attachment" "cassandra_1_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.cassandra_1.id}"
  instance_id = "${aws_instance.cassandra_1.id}"
}

resource "aws_volume_attachment" "cassandra_2_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.cassandra_2.id}"
  instance_id = "${aws_instance.cassandra_2.id}"
}

resource "aws_volume_attachment" "cassandra_3_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.cassandra_3.id}"
  instance_id = "${aws_instance.cassandra_3.id}"
}

resource "aws_volume_attachment" "cassandra_4_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.cassandra_4.id}"
  instance_id = "${aws_instance.cassandra_4.id}"
}

resource "aws_volume_attachment" "cassandra_5_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = "${aws_ebs_volume.cassandra_5.id}"
  instance_id = "${aws_instance.cassandra_5.id}"
}
