resource "google_compute_instance" "vm_instance" {
  count    =  1
  project = "${var.project}"
  name = "${var.name}"
  
  machine_type = "${var.machine_type}"
  allow_stopping_for_update = true

  tags = ["${concat(list("allow-ssh"), var.target_tags)}"]
  labels = "${var.instance_labels}"

  network_interface {
    network = "${google_compute_network.vpc_network.self_link}"
    access_config {
      // Ephemeral IP
    }
  }

  can_ip_forward = "${var.can_ip_forward}"

  service_account {
    email  = "${var.service_account_email}"
    scopes = ["${var.service_account_scopes}"]
  }

  scheduling {
    preemptible       = "${var.preemptible}"
    automatic_restart = "${var.automatic_restart}"
  }

  lifecycle {
    create_before_destroy = true
  }

  boot_disk {
    initialize_params {
      #image = "debian-cloud/debian-9"
      image = "${var.image_name}"
    }
  }
  metadata {
   sshKeys = "serg:${file("~/.ssh/id_rsa.pub")}"
  }

}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
  project = "${var.project}"
}

resource "google_compute_firewall" "default" {
 name    = "flask-app-firewall"
 network = "${google_compute_network.vpc_network.self_link}"
 project = "${var.project}"

 allow {
  protocol = "tcp"
  ports = ["1-65535"]
 }
 allow {
  protocol = "udp"
  ports = ["1-65535"]
 }
 allow {
  protocol = "icmp"
 }
 
 source_ranges = ["0.0.0.0/0"]
 
}