output "parameters" {
    value = tolist([ for obj in local.parameter_store_keys : "${obj.microservice_name}-${obj.parameter}" ])
}

output "parameters_map" {
  value = tomap({for obj in aws_ssm_parameter.parameter_map: obj.name => obj  })
}