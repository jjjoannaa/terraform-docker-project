variable "docker_host" {
  description = "Docker daemon socket address"
  type        = string
  default     = "unix:///var/run/docker.sock"
}