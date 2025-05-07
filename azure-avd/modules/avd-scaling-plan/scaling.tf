resource "azurerm_virtual_desktop_scaling_plan" "scaling_plan" {
  name                = var.scaling_plan_name
  location            = var.location
  resource_group_name = var.rg_name
  time_zone           = "Eastern Standard Time"
  schedule {
    name                                 = var.schedule_name
    days_of_week                         = var.days_of_week
    ramp_up_start_time                   = var.ramp_up_start_time
    ramp_up_load_balancing_algorithm     = var.ramp_up_load_balancing_algorithm
    ramp_up_minimum_hosts_percent        = var.ramp_up_minimum_hosts_percent
    ramp_up_capacity_threshold_percent   = var.ramp_up_capacity_threshold_percent
    peak_start_time                      = var.peak_start_time
    peak_load_balancing_algorithm        = var.peak_load_balancing_algorithm
    ramp_down_start_time                 = var.ramp_down_start_time
    ramp_down_load_balancing_algorithm   = var.ramp_down_load_balancing_algorithm
    ramp_down_minimum_hosts_percent      = var.ramp_down_minimum_hosts_percent
    ramp_down_force_logoff_users         = var.ramp_down_force_logoff_users
    ramp_down_wait_time_minutes          = var.ramp_down_wait_time_minutes
    ramp_down_notification_message       = "You will be logged off in ${var.ramp_down_wait_time_minutes} minutes, as the AVD pool ramps down the number of active machines. Please find a stopping point to save your work and then sign-off this session and start a new one."
    ramp_down_capacity_threshold_percent = var.ramp_down_capacity_threshold_percent
    ramp_down_stop_hosts_when            = var.ramp_down_stop_hosts_when
    off_peak_start_time                  = var.off_peak_start_time
    off_peak_load_balancing_algorithm    = var.off_peak_load_balancing_algorithm
  }

  for_each = var.host_pool_id
  host_pool {
    hostpool_id          = each.value.host_pool_id
    scaling_plan_enabled = each.value.scaling_plan_enabled
  }
}