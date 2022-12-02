resource "docker_image" "mysql_latest" {
  name = "mysql:8"
}

resource "docker_container" "mysql" {
  name = "mysql"
  image = "${docker_image.mysql_latest.image_id}"
  env = [
    "MYSQL_ROOT_PASSWORD=abcD_1234"
  ]
  ports {
    internal = 3308
    external = 3308
  }
  depends_on = [
    docker_image.mysql_latest
  ]
}

output "ip" { value = "MYSQL_IP=${docker_container.mysql.ip_address}" }
