resource docker_image "jenkins_docker_latest" {
  name = "jbd"
  build {
    path = "./jenkins-docker"
    tag  = [
      "jbd:latest"
      ]
  }
}

# resource docker_volume "jenkins_volume" {
#   name = "jenkins_home"
# }

resource "docker_container" "jenkins" {
  name = "jenkins"
  image = "${docker_image.jenkins_docker_latest.image_id}"
  privileged = true
  env = [
    "JENKINS_HOME=/var/jenkins_home",
  ]
  ports {
    internal = 8089
    external = 8089
  }
  volumes {
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only = false
  }
  volumes {
    volume_name = "jenkins_home"
    host_path = ""/home/jenkins_home"
    container_path = "/var/jenkins_home"
    read_only = false
  }
  provisioner "local-exec" {
    command = "docker exec -d -u root jenkins chown jenkins:jenkins /var/run/docker.sock"
  }
}

output "jenkins_ip" { value = "JENKINS_IP=${docker_container.jenkins.ip_address}" }