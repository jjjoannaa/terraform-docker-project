
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

resource "docker_network" "app_network" {
  name = "validation-network"
}

data "docker_image" "web" {
  name = "validation-web:1.0"
}

resource "docker_image" "alpine" {
  name         = "alpine:latest"
  keep_locally = false
}

resource "docker_container" "web" {
  name  = "web"
  image = data.docker_image.web.id

  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_container" "test_client" {
  name    = "test-client"
  image   = docker_image.alpine.image_id
  command = ["tail", "-f", "/dev/null"]

  networks_advanced {
    name = docker_network.app_network.name
  }
}