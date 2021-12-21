resource "azurerm_linux_virtual_machine_scale_set" "star_vmss" {     #마지막으로 만든 이미지로 vmss만들어보쟈잉~
    name = "star-vmss"
    resource_group_name = azurerm_resource_group.star_rg.name
    location = azurerm_resource_group.star_rg.location
    sku = "Standard_DS1_v2"
    instances = 2
    disable_password_authentication = true
    computer_name_prefix = "vmss"
    admin_username = "was-vmss"
    upgrade_mode = "Automatic"

    platform_fault_domain_count = 1

        admin_ssh_key {
            username = "was-vmss"
            public_key = azurerm_ssh_public_key.star_ssh.public_key
        }

    source_image_id = azurerm_image.star_image.id
    overprovision = false

    os_disk {
      storage_account_type = "Standard_LRS"
      caching = "ReadWrite"
    }

    health_probe_id = azurerm_lb_probe.star_ilbprobe.id

    network_interface {
      name = "image-was-nwif"
      primary = true
      network_security_group_id = azurerm_network_security_group.star_nsg3.id

      ip_configuration {
        name = "subnet03-was"
        primary = true
        subnet_id = azurerm_subnet.star_sub3.id
        load_balancer_backend_address_pool_ids = [ azurerm_lb_backend_address_pool.star_ilb_backend.id ]
      }
    }


  extension {
    name = "MSILinuxExtension"
    publisher ="Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"
     auto_upgrade_minor_version = true


      settings = <<SETTINGS
    {
        "script": "${filebase64("install3.sh")}"
    }
    SETTINGS
  }

  depends_on = [azurerm_image.star_image]
}

resource "azurerm_monitor_autoscale_setting" "star_auto" {
  name = "star-auto"
  resource_group_name = azurerm_resource_group.star_rg.name
  location = azurerm_resource_group.star_rg.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.star_vmss.id

  profile { 
    name = "autoprofile"

    capacity {
      default = 2
      minimum = 2
      maximum = 6
    }

    rule {
      metric_trigger {
        metric_name = "percentage cpu"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.star_vmss.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "GreaterThan"
        threshold = 60
      }

    scale_action {
      direction = "Increase"
      type = "ChangeCount"
      value = "2"
      cooldown = "PT1M"
    }
  }

  rule {
    metric_trigger {
      metric_name = "percentage cpu"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.star_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT5M"
      time_aggregation = "Average"
      operator = "LessThan"
      threshold = 40
    }

    scale_action {
      direction = "Decrease"
      type = "ChangeCount"
      value = "2"
      cooldown = "PT1M"
    }
  }
}
}