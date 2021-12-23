resource "azurerm_linux_virtual_machine" "star_vm_was" {    #이미지를 만들기위한 was 작업시작!!
    name = "star-vm-was"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    network_interface_ids = [azurerm_network_interface.star_was_nwif.id]
    size = "Standard_DS1_v2"
    admin_username = "was"
    //admin_password = "gkwltnsmscjswo1!"
    //disable_password_authentication = false


    admin_ssh_key {
      username = "was"
      public_key = azurerm_ssh_public_key.star_ssh.public_key
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_disk {
      name = "star-was-osdisk"
      caching = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
    }

    depends_on = [azurerm_network_interface.star_was_nwif]
}