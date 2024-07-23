locals {
  resource_group_name = "tcl-rg"
  location            = "East US"

  vnet_name           = "tcl-vnet"
  public_subnet_name  = "public"
  private_subnet_name = "private"

  vm_network_interface_name = "tcl-nic"
  vm_security_group         = "tcl-sg"

  vm_name           = "tcl-vm"
  vm_admin_username = "adminuser"
  vm_admin_password = "P@$$w0rd1234!"
}