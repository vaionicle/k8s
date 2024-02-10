variable "azure" {
  description = "Login to Azure using the Service Principal Account"

  type = object({
    subscription_id = string
    client_id       = string
    client_secret   = string
    tenant_id       = string
  })

  default = {
    subscription_id = ""
    client_id       = ""
    client_secret   = ""
    tenant_id       = ""
  }
}