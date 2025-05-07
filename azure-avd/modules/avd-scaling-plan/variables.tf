variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the host pool"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "scaling_plan_name" {
  type        = string
  description = "The name which should be used for this Virtual Desktop Scaling Plan"
}

variable "schedule_name" {
  type        = string
  description = "The name which should be used for this Scaling Plan schedule"
}

variable "days_of_week" {
  type        = list(string)
  description = "A list of Days of the Week on which this schedule will be used"
}

variable "ramp_up_start_time" {
  type        = string
  description = "The time at which Ramp-Up scaling will begin"
}

variable "ramp_up_minimum_hosts_percent" {
  type        = number
  description = "Specifies the minimum percentage of session host virtual machines to start during ramp-up for peak hours"
}

variable "ramp_up_load_balancing_algorithm" {
  type        = string
  description = "The load Balancing Algorithm to use during the Ramp-Up period"

  validation {
    condition     = contains(["DepthFirst", "BreadthFirst"], var.ramp_up_load_balancing_algorithm)
    error_message = "Allowed values are 'DepthFirst' or 'BreadthFirst'"
  }
}

variable "peak_load_balancing_algorithm" {
  type        = string
  description = "The load Balancing Algorithm to use during Peak Hours"

  validation {
    condition     = contains(["DepthFirst", "BreadthFirst"], var.peak_load_balancing_algorithm)
    error_message = "Allowed values are 'DepthFirst' or 'BreadthFirst'"
  }
}

variable "off_peak_load_balancing_algorithm" {
  type        = string
  description = "The load Balancing Algorithm to use during Off-Peak Hours"

  validation {
    condition     = contains(["DepthFirst", "BreadthFirst"], var.off_peak_load_balancing_algorithm)
    error_message = "Allowed values are 'DepthFirst' or 'BreadthFirst'"
  }
}

variable "ramp_down_load_balancing_algorithm" {
  type        = string
  description = "The load Balancing Algorithm to use during the Ramp-Down period"

  validation {
    condition     = contains(["DepthFirst", "BreadthFirst"], var.ramp_down_load_balancing_algorithm)
    error_message = "Allowed values are 'DepthFirst' or 'BreadthFirst'"
  }
}

variable "ramp_up_capacity_threshold_percent" {
  type        = number
  description = "Value of percentage of used host pool capacity that will be considered to evaluate whether to turn on/off virtual machines during the ramp-up and peak hours"
}

variable "peak_start_time" {
  type        = string
  description = "The time at which Peak scaling will begin"
}


variable "ramp_down_start_time" {
  type        = string
  description = "The time at which Ramp-Down scaling will begin"
}

variable "ramp_down_minimum_hosts_percent" {
  type        = number
  description = "The minimum percentage of session host virtual machines that you would like to get to for ramp-down and off-peak hours"
}

variable "ramp_down_force_logoff_users" {
  type        = bool
  description = "Specifies whether users will be forced to log-off session hosts once the ramp down wait time value has been exceeded"
}

variable "ramp_down_wait_time_minutes" {
  type        = number
  description = "The number of minutes to wait during Ramp-Down period before forcing any currently signed in users to logoff"
}

variable "ramp_down_capacity_threshold_percent" {
  type        = number
  description = "Value of percentage of used host pool capacity that will be considered to evaluate whether to turn on/off virtual machines during the ramp-down and off-peak hours"
}



variable "ramp_down_stop_hosts_when" {
  type        = string
  description = "Controls Session Host shutdown behaviour during Ramp-Down period"

  validation {
    condition     = contains(["ZeroSessions", "ZeroActiveSessions"], var.ramp_down_stop_hosts_when)
    error_message = "Allowed values are 'ZeroSessions' or 'ZeroActiveSessions'"
  }
}

variable "off_peak_start_time" {
  type        = string
  description = "The time at which Off-Peak scaling will begin"
}

/*variable "host_pool_id" {
  type        = string
  description = "The ID of the HostPool to assign the Scaling Plan to"
}

variable "scaling_plan_enabled" {
  type        = bool
  description = "Specifies if the scaling plan is enabled or disabled for the HostPool"
}*/

variable "host_pool_id" {
  description = "A mapping of HostPool IDs to associate with the Scaling Plan"
  type = map(object({
    host_pool_id         = string
    scaling_plan_enabled = bool
  }))
}
