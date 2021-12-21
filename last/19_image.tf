resource "azurerm_image" "star_image" {
    name = "star-image"
    location = azurerm_resource_group.star_rg.location
    resource_group_name = azurerm_resource_group.star_rg.name
    source_virtual_machine_id = azurerm_linux_virtual_machine.star_vm_was.id

    depends_on = [azurerm_lb_rule.star_ilb_inbound]
}