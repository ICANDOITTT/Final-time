resource "azurerm_linux_virtual_machine" "star_vm_web" {    #web부분 작업 시작!
    name = "star-vm-web"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    network_interface_ids = [azurerm_network_interface.star_web_nwif.id]
    size = "Standard_DS1_v2"
    admin_username = "web"

    admin_ssh_key {
      username = "web"
      public_key = azurerm_ssh_public_key.star_ssh.public_key
    }

    source_image_reference {
      publisher = "OpenLogic"
      offer = "CentOS"
      sku   = "7.5"
      version = "latest"
    }

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
    }

    depends_on = [ azurerm_network_interface.star_web_nwif ]
}