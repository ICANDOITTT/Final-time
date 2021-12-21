resource "azurerm_virtual_machine_extension" "star_vmex_was" {
    name = "star-vmex-was"
    virtual_machine_id = azurerm_linux_virtual_machine.star_vm_was.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${filebase64("install1.sh")}"
    }
    SETTINGS
}