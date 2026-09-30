location            = "Australia East"
resource_group_name = "ishuara-week08-rg"

acr_name = "ishuaraweek08acr9381"

storage_account_name = "ishuaraw08sa9381"

aks_cluster_name = "ishuara-week08-aks"
aks_dns_prefix   = "ishuara-w08-9381"

aks_node_count   = 3
aks_node_vm_size = "Standard_D2s_v3"

environment = "development"

tags = {
  Project     = "KoalaTech Course Platform"
  ManagedBy   = "Terraform"
  Practical   = "Week08-8.1P"
  Environment = "Development"
}