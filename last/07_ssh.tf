resource "azurerm_ssh_public_key" "star_ssh" {      #기존에 ssh public key를 만들어서 등록해서 관리해준다
    name = "star_ssh"
    resource_group_name = azurerm_resource_group.star_rg.name
    location = azurerm_resource_group.star_rg.location
    public_key = file("../.ssh/jisoo-key.pub")
    
    depends_on = [ azurerm_bastion_host.star_bastion ]
}