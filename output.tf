// A variable for extracting the external ip of the instance

//output "ip" {
 //value = "${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
//}

//output "ip_external" {
	//value = "${network_interface.*.access_config.*.nat_ip}"
//}

//output "ip_external" {
//	value = "${google_compute_network.vpc_network.self_link.*.access_config.*.nat_ip}"
//}

//output "ip_internal" {
	//value = "${network_interface.*.network_ip}"
//}

//output "addresses" {
  //value = "${join(",", google_compute_address.instances.*.address)}"
//}

output "project" {
	value = "${google_compute_instance.vm_instance.*.project}"
}

output "ip" {
	value = "${google_compute_network.vpc_network.*.self_link}"
}