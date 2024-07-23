# vm.tf

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface#example-usage
resource "azurerm_network_interface" "vm_network_interface" {
  name                = local.vm_network_interface_name
  location            = local.location
  resource_group_name = local.resource_group_name


  ip_configuration {
    name                          = "vm_ip_configrationinternal"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group#example-usage

resource "azurerm_network_security_group" "vm_security_group" {
  name                = local.vm_security_group
  location            = local.location
  resource_group_name = local.resource_group_name
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule#example-usage
resource "azurerm_network_security_rule" "rdp" {
  name                        = "RDP"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm_security_group.name
}

resource "azurerm_network_security_rule" "http" {
  name                        = "HTTP"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = local.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm_security_group.name
}

resource "azurerm_network_interface_security_group_association" "security_group_association" {
  network_interface_id      = azurerm_network_interface.vm_network_interface.id
  network_security_group_id = azurerm_network_security_group.vm_security_group.id
}