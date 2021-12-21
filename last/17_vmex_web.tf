resource "azurerm_virtual_machine_extension" "star_vmex_web" {
    name = "star-vmex-web"
    virtual_machine_id = azurerm_linux_virtual_machine.star_vm_web.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${filebase64("install2.sh")}"
    }
    SETTINGS

    depends_on = [ azurerm_linux_virtual_machine.star_vm_web ]
}