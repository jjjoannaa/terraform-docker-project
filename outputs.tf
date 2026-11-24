output "network_name" {
  description = "Custom Docker network"
  value       = docker_network.app_network.name
}

output "web_container" {
  description = "Nginx web server"
  value       = docker_container.web.name
}

output "test_container" {
  description = "Alpine test client"
  value       = docker_container.test_client.name
}

output "internal_url" {
  description = "Internal web server URL"
  value       = "http://${docker_container.web.name}"
}