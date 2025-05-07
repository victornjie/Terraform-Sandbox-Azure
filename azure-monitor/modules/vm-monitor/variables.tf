variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Action Group instance"
}

variable "target_resource_location" {
  type        = string
  description = "The location of the target resource"
}

variable "monitor_alert_scope" {
  type        = list(string)
  description = "A set of strings of resource IDs at which the metric criteria should be applied"
}

variable "email_address" {
  type        = string
  description = "The email address of this receiver"
}

variable "phone_number" {
  type        = string
  description = "The phone number of the SMS receiver"
}

variable "vm_metric_alert" {
  description = "List of metric alert rules to add to the Azure Monitor Metric Alert"
  type = map(object({
    description = string,
    metric_name = string,
    aggregation = string,
    operator    = string,
    threshold   = number
  }))

  /*default = {
    "memory-metricalert" = {
      description = "Action will be triggered when available memory is less than or equal to 20 percent"
      metric_name = "Available Memory Percentage"
      aggregation = "Average"
      operator    = "LessThanOrEqual"
      threshold   = 20
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
  }*/
}
