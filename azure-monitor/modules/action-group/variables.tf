variable "action_group_name" {
  type        = string
  description = "The name of the Action Group"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Action Group instance"
}

variable "action_group_short_name" {
  type        = string
  description = "The short name of the action group. This will be used in SMS messages"
}

variable "email_receiver_name" {
  type        = string
  description = "The name of the email receiver"
}

variable "email_address" {
  type        = string
  description = "The email address of this receiver"
}

variable "sms_receiver_name" {
  type        = string
  description = "The name of the SMS receiver"
}

variable "phone_number" {
  type        = string
  description = "The phone number of the SMS receiver"
}