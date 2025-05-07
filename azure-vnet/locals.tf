locals {
  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }

  app_subnets_eus2 = {
    "app1" = {
      subnet_name = "snet-app1-eus2"
      subnet_cidr = ["10.10.1.0/24"]
    },
    "app2" = {
      subnet_name = "snet-app2-eus2"
      subnet_cidr = ["10.10.2.0/24"]
    }
  }

  nsg_inbound_rule = {
    "web" = {
      name                         = "allow_web_traffic"
      priority                     = 1000
      access                       = "Allow"
      protocol                     = "Tcp"
      destination_port_ranges      = ["80", "443"]
      source_address_prefixes      = ["192.168.1.100", "172.16.80.10"]
      destination_address_prefixes = ["10.10.0.0/16"]
    },
    "ssh" = {
      name                         = "deny_ssh_traffic"
      priority                     = 1100
      access                       = "Deny"
      protocol                     = "Tcp"
      destination_port_ranges      = ["22"]
      source_address_prefixes      = ["20.0.0.0/18"]
      destination_address_prefixes = ["10.10.0.0/16"]
    }
  }
}
