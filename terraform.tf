terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = ">= 2.23.1"
    }
  }
}

provider "docker" {
  # host = "npipe:////.//pipe//docker_engine" # Comenta esta linea si eres usuario MacOS o Linux
}
