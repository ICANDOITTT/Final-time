resource "azurerm_linux_virtual_machine" "star_vm_web01" {    #web부분 작업 시작!
    name = "star-vm-web01"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    network_interface_ids = [azurerm_network_interface.star_web_nwif01.id]
    size = "Standard_DS1_v2"
    admin_username = "web"
    //admin_password = "gkwltnsmscjswo1!"
    //disable_password_authentication = false

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

    depends_on = [ azurerm_network_interface_backend_address_pool_association.star_elb_backass04 ]
}

resource "azurerm_linux_virtual_machine" "star_vm_web02" {    #web부분 작업 시작!
    name = "star-vm-web02"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    network_interface_ids = [azurerm_network_interface.star_web_nwif02.id]
    size = "Standard_DS1_v2"
    admin_username = "web"
    //admin_password = "gkwltnsmscjswo1!"
    //disable_password_authentication = false

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

    depends_on = [ azurerm_linux_virtual_machine.star_vm_web01 ]
}

resource "azurerm_linux_virtual_machine" "star_vm_web03" {    #web부분 작업 시작!
    name = "star-vm-web03"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    network_interface_ids = [azurerm_network_interface.star_web_nwif03.id]
    size = "Standard_DS1_v2"
    admin_username = "web"
    //admin_password = "gkwltnsmscjswo1!"
    //disable_password_authentication = false

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

    depends_on = [ azurerm_linux_virtual_machine.star_vm_web02 ]
}

resource "azurerm_linux_virtual_machine" "star_vm_web04" {    #web부분 작업 시작!
    name = "star-vm-web04"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    network_interface_ids = [azurerm_network_interface.star_web_nwif04.id]
    size = "Standard_DS1_v2"
    admin_username = "web"
    //admin_password = "gkwltnsmscjswo1!"
    //disable_password_authentication = false

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
    
    depends_on = [ azurerm_linux_virtual_machine.star_vm_web03 ]
}