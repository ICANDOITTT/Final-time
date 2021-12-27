resource "azurerm_virtual_machine_extension" "star_vmex_web01" {
    name = "star-vmex-web01"
    virtual_machine_id = azurerm_linux_virtual_machine.star_vm_web01.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("install2.sh", {pub_ip="${azurerm_public_ip.star_elbip.ip_address}"}))}"

    }
    SETTINGS

    depends_on = [ azurerm_linux_virtual_machine.star_vm_web04 ]
} 


resource "azurerm_virtual_machine_extension" "star_vmex_web02" {
    name = "star-vmex-web02"
    virtual_machine_id = azurerm_linux_virtual_machine.star_vm_web02.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("install3.sh", {pub_ip="${azurerm_public_ip.star_elbip.ip_address}"}))}"
    }
    SETTINGS

    depends_on = [ azurerm_virtual_machine_extension.star_vmex_web01 ]
}

resource "azurerm_virtual_machine_extension" "star_vmex_web03" {
    name = "star-vmex-web03"
    virtual_machine_id = azurerm_linux_virtual_machine.star_vm_web03.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("install3.sh", {pub_ip="${azurerm_public_ip.star_elbip.ip_address}"}))}"     
    }
    SETTINGS

    depends_on = [ azurerm_virtual_machine_extension.star_vmex_web02 ]
}

resource "azurerm_virtual_machine_extension" "star_vmex_web04" {
    name = "star-vmex-web04"
    virtual_machine_id = azurerm_linux_virtual_machine.star_vm_web04.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${base64encode(templatefile("install3.sh", {pub_ip="${azurerm_public_ip.star_elbip.ip_address}"}))}"     
    }
    SETTINGS

    depends_on = [ azurerm_virtual_machine_extension.star_vmex_web03 ]
}



