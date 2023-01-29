locals {
  tag_environment = lookup(var.common_tags, "environment", "")

  parameter_store_keys = flatten([
    for microservice_name, parameters in var.parameter_store_keys : [
      for parameter in parameters: {
        microservice_name = microservice_name
        parameter = parameter
      }
    ]
  ])
}
