module "cloudwatch_alarms" {
  source = "../../modules/cloudwatch-metric-alarm"

  for_each = {
    # =====================================================
    # DynamoDB
    # =====================================================
    "dynamodb_read_throttle_events" = {
      alarm_name          = "DynamoDB-Vault-ReadThrottleEvents"
      alarm_description   = "DynamoDB for Vault read throttle events"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = 1
      threshold           = 1
      period              = 300
      unit                = "Count"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/DynamoDB"
      metric_name = "ReadThrottleEvents"
      statistic   = "Sum"
      
      dimensions  = {
        TableName = "vault-backend-production"
      }
    }
    "dynamodb_write_throttle_events" = {
      alarm_name          = "DynamoDB-Vault-WriteThrottleEvents"
      alarm_description   = "DynamoDB for Vault write throttle events"
      comparison_operator = "GreaterThanOrEqualToThreshold"
      evaluation_periods  = 1
      threshold           = 1
      period              = 300
      unit                = "Count"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/DynamoDB"
      metric_name = "WriteThrottleEvents"
      statistic   = "Sum"
      dimensions  = {
        TableName = "vault-backend-production"
      }
    }
    # =====================================================
    # RDS
    # =====================================================
    "rds_writer_cpu_utilization" = {
      alarm_name          = "RDS-Writer-CPUUtilization"
      alarm_description   = "RDS Writer CPU utilization"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 85
      period              = 300
      unit                = "Percent"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "CPUUtilization"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "WRITER"
      }
    }
    "rds_writer_cpu_credit_balance" = {
      alarm_name          = "RDS-Writer-CPUCreditBalance"
      alarm_description   = "RDS Writer CPU credit balance"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 1
      threshold           = 100
      period              = 300
      unit                = "Count"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "CPUCreditBalance"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "WRITER"
      }
    }
    "rds_writer_freeable_memory" = {
      alarm_name          = "RDS-Writer-FreeableMemory"
      alarm_description   = "RDS Writer freeable memory"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 1
      threshold           = 314572800  # 300M
      period              = 300
      unit                = "Bytes"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "FreeableMemory"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "WRITER"
      }
    }
    "rds_reader_cpu_utilization" = {
      alarm_name          = "RDS-Reader-CPUUtilization"
      alarm_description   = "RDS Reader CPU utilization"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 85
      period              = 300
      unit                = "Percent"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "CPUUtilization"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "READER"
      }
    }
    "rds_reader_cpu_credit_balance" = {
      alarm_name          = "RDS-Reader-CPUCreditBalance"
      alarm_description   = "RDS Reader CPU credit balance"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 1
      threshold           = 100
      period              = 300
      unit                = "Count"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "CPUCreditBalance"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "READER"
      }
    }
    "rds_reader_freeable_memory" = {
      alarm_name          = "RDS-Reader-FreeableMemory"
      alarm_description   = "RDS Reader freeable memory"
      comparison_operator = "LessThanThreshold"
      evaluation_periods  = 1
      threshold           = 314572800  # 300M
      period              = 300
      unit                = "Bytes"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "FreeableMemory"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "READER"
      }
    }
    "rds_reader_replica_lag" = {
      alarm_name          = "RDS-Reader-ReplicaLag"
      alarm_description   = "RDS Reader replica lag"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 20000
      period              = 300
      unit                = "Milliseconds"
      treat_missing_data  = "missing"

      namespace   = "AWS/RDS"
      metric_name = "AuroraReplicaLag"
      statistic   = "Average"
      dimensions  = {
        DBClusterIdentifier = "production-pg-cluster"
        Role                = "READER"
      }
    }
  }

  alarm_name          = each.value["alarm_name"]
  alarm_description   = each.value["alarm_description"]
  comparison_operator = each.value["comparison_operator"]
  evaluation_periods  = each.value["evaluation_periods"]
  threshold           = each.value["threshold"]
  period              = each.value["period"]
  unit                = each.value["unit"]
  treat_missing_data  = each.value["treat_missing_data"]

  namespace   = each.value["namespace"]
  metric_name = each.value["metric_name"]
  statistic   = each.value["statistic"]
  dimensions  = each.value["dimensions"]
}


module "cloudwatch_alarms_alb" {
  source = "../../modules/cloudwatch-metric-alarm"

  for_each = {
    "alb_vault_target_5XX" = {
      alarm_name          = "ALB-Vault-Target5XX"
      alarm_description   = "ALB Vault ingress high target 5XX count"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 200
      period              = 300
      unit                = "Count"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/ApplicationELB"
      metric_name = "HTTPCode_Target_5XX_Count"
      statistic   = "Sum"
      dimensions  = {
        LoadBalancer = "app/k8s-apps-cbd04fbad4/1f6e6813cea05c91"
      }
    }
    "alb_vault_5XX" = {
      alarm_name          = "ALB-Vault-5XX"
      alarm_description   = "ALB Vault ingress high 5XX count"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 200
      period              = 300
      unit                = "Count"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/ApplicationELB"
      metric_name = "HTTPCode_ELB_5XX_Count"
      statistic   = "Sum"
      dimensions  = {
        LoadBalancer = "app/k8s-apps-cbd04fbad4/1f6e6813cea05c91"
      }
    }
    "alb_vault_average_target_response_time" = {
      alarm_name          = "ALB-Vault-AverageTargetResponseTime"
      alarm_description   = "ALB Vault ingress high average target response time"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 5
      period              = 300
      unit                = "Seconds"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/ApplicationELB"
      metric_name = "TargetResponseTime"
      statistic   = "Average"
      dimensions  = {
        LoadBalancer = "app/k8s-apps-cbd04fbad4/1f6e6813cea05c91"
      }
    }
    "alb_apps_target_5XX" = {
      alarm_name          = "ALB-Microservices-Target5XX"
      alarm_description   = "ALB for microservices ingress high target 5XX count"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 200
      period              = 300
      unit                = "Count"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/ApplicationELB"
      metric_name = "HTTPCode_Target_5XX_Count"
      statistic   = "Sum"
      dimensions  = {
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "alb_apps_5XX" = {
      alarm_name          = "ALB-Microservices-5XX"
      alarm_description   = "ALB for microservices inress high 5XX count"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 200
      period              = 300
      unit                = "Count"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/ApplicationELB"
      metric_name = "HTTPCode_ELB_5XX_Count"
      statistic   = "Sum"
      dimensions  = {
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "alb_apps_average_target_response_time" = {
      alarm_name          = "ALB-Microservices-AverageTargetResponseTime"
      alarm_description   = "ALB for microservices ingress high average target response time"
      comparison_operator = "GreaterThanThreshold"
      evaluation_periods  = 1
      threshold           = 5
      period              = 300
      unit                = "Seconds"
      treat_missing_data  = "notBreaching"

      namespace   = "AWS/ApplicationELB"
      metric_name = "TargetResponseTime"
      statistic   = "Average"
      dimensions  = {
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
  }

  alarm_name          = each.value["alarm_name"]
  alarm_description   = each.value["alarm_description"]
  comparison_operator = each.value["comparison_operator"]
  evaluation_periods  = each.value["evaluation_periods"]
  threshold           = each.value["threshold"]
  period              = each.value["period"]
  unit                = each.value["unit"]
  treat_missing_data  = each.value["treat_missing_data"]

  namespace   = each.value["namespace"]
  metric_name = each.value["metric_name"]
  statistic   = each.value["statistic"]
  dimensions  = each.value["dimensions"]
}


module "cloudwatch_alarms_alb_healthyhosts" {
  source = "../../modules/cloudwatch-metric-alarm"

  for_each = {
    # internal
    "vault" = {
      service_name = "Vault"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-vault-vault-d32b35777d/2fd3ee4cf5bbafa2"
        LoadBalancer = "app/k8s-apps-cbd04fbad4/1f6e6813cea05c91"
      }
    }
    # external
    "adhoc" = {
      service_name = "Adhoc"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-adhoc-b9d47bf3a0/d424cb54df21280b"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "booking" = {
      service_name = "Booking"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-booking-712ba765a0/a465d9dfede551fd"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "canteen" = {
      service_name = "Canteen"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-canteen-08860fcab2/c2b1388c32cb9c29"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "conferencemeal" = {
      service_name = "Conferencemeal"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-conferen-01e890877d/662b15b07b4af2a4"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "entities" = {
      service_name = "Entities"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-entities-751c8eb87c/64f8b51e63be7107"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "filehander" = {
      service_name = "Filehandler"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-filehand-83b4f3ccb5/413515885d7f7c69"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "insight" = {
      service_name = "Insight"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-insight-c3a8d91a16/326ec7dd4d617464"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "invoice" = {
      service_name = "Invoice"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-invoice-d395c3e333/8ca20c1879e60039"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "izyportal" = {
      service_name = "Izyportal"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-izyporta-1a3608c502/c8ca27867039084d"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "kiosk" = {
      service_name = "Kiosk"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-kiosk-fa14c54256/e03a58935bb61f24"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "microsoftintegration" = {
      service_name = "Microsoftintegration"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-microsof-f1ae2f085c/e7410481c3c4ed1d"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "news" = {
      service_name = "News"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-news-7a08f8a698/d5cbe1f1d431a3ef"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "notification" = {
      service_name = "Notification"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-notifica-7305ec9b37/45f62ce260d9940a"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "payment" = {
      service_name = "Payment"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-payment-418cd6e7a8/7c90ef4f496c9d6a"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "publicapi" = {
      service_name = "Publicapi"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-publicap-9a584a30f8/a5da88b70986146e"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "reports" = {
      service_name = "Reports"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-reports-edf63ccdef/09e79525cf24ee85"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "scheduler" = {
      service_name = "Scheduler"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-schedule-1eda1a65eb/61b60df28bacb218"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "tickets" = {
      service_name = "Tickets"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-tickets-bce8d2fdc7/f9b599cafd0895a5"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
    "usermanagement" = {
      service_name = "Usermanagement"
      dimensions  = {
        TargetGroup  = "targetgroup/k8s-apps-usermana-46627f3057/8ca2ea688d428f4d"
        LoadBalancer = "app/k8s-appsproduction-824e1f1fdc/3ad74d56402d6adb"
      }
    }
  }

  alarm_name          = join("",["ALB-Service-", each.value["service_name"], "-HealthyHostCount"])    
  alarm_description   = join("",["ALB ", each.value["service_name"], " microservice healthy hosts"]) 
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  threshold           = 1
  period              = 300
  unit                = "Count"

  namespace   = "AWS/ApplicationELB"
  metric_name = "HealthyHostCount"
  statistic   = "Average"
  dimensions  = each.value["dimensions"]
}