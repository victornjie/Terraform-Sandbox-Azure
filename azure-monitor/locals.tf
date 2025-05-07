locals {
  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }


  # A mapping of values to assign to the resource
  monitor_alert_scope = ["/subscriptions/97f16178-50de-44aa-baa1-ed27b0e733cb"]
  email_address       = "test@test.com"
  phone_number        = "123456789"

  rg_monitor_name = "rg-azure-monitor-eus2-001"
  location        = "eastus2"

  vm_metric_alert = {
    "memory-metricalert" = {
      description = "Action will be triggered when available memory is less than or equal to 20 percent"
      metric_name = "Available Memory Percentage"
      aggregation = "Average"
      operator    = "LessThanOrEqual"
      threshold   = 95
    },

    "cpu-metricalert" = {
      description = "Action will be triggered when CPU usage is greater than or equal to 80 percent"
      metric_name = "Percentage CPU"
      aggregation = "Average"
      operator    = "GreaterThanOrEqual"
      threshold   = 80
    },

    "iops-metricalert" = {
      description = "Action will be triggered when IOPS consumed on OS disk is greater than or equal to 80 percent"
      metric_name = "OS Disk IOPS Consumed Percentage"
      aggregation = "Average"
      operator    = "GreaterThanOrEqual"
      threshold   = 80
    }
  }

}
