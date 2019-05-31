# resource "google_sql_database_instance" "kumaya-db-instance" {
#   name = "kumaya-db-instance"
#   database_version = "${var.database_instance_version}"
#   region = "${var.region}"

#   settings {
#     tier = "db-f1-micro"
#   }

# }