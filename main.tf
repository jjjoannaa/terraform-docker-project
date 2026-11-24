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

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

resource "docker_image" "alpine" {
  name         = "alpine:latest"
  keep_locally = false
}

resource "docker_container" "web" {
  name  = "web"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    host_path      = abspath("${path.module}/index.html")
    container_path = "/usr/share/nginx/html/index.html"
    read_only      = true
  }
}

resource "docker_container" "test_client" {
  name  = "test-client"
  image = docker_image.alpine.image_id

  command = ["tail", "-f", "/dev/null"]

  networks_advanced {
    name = docker_network.app_network.name
  }
}