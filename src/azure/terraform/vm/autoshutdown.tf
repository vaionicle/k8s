
resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown_at_12" {
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  location           = var.resource_group_location
  enabled            = true

  daily_recurrence_time = "0010"
  timezone              = "GTB Standard Time"

  notification_settings {
    enabled = true
    email   = var.notification_email
  }
}