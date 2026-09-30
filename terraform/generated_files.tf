locals {
  generated_manifest_names = toset([
    "07-application-secret.yaml",
    "08-user-service.yaml",
    "09-student-service.yaml",
    "10-lecturer-service.yaml",
    "11-course-service.yaml",
    "12-enrollment-service.yaml",
    "13-frontend.yaml"
  ])

  generated_file_names = setunion(
    local.generated_manifest_names,
    toset([
      "student-service.env",
      "lecturer-service.env"
    ])
  )

  generated_file_paths = merge(
    {
      for filename in local.generated_manifest_names :
      filename => abspath("${path.module}/../kubernetes/${filename}")
    },
    {
      "student-service.env" = abspath(
        "${path.module}/../student-service/.env"
      )

      "lecturer-service.env" = abspath(
        "${path.module}/../lecturer-service/.env"
      )
    }
  )

  generated_file_contents = merge(
    {
      for filename in local.generated_manifest_names :
      filename => templatefile(
        "${path.module}/templates/kubernetes/${filename}.tftpl",
        {
          acr_login_server = azurerm_container_registry.acr.login_server

          storage_connection_string = (
            azurerm_storage_account.storage_account.primary_connection_string
          )
        }
      )
    },
    {
      "student-service.env" = format(
        "AZURE_STORAGE_CONNECTION_STRING=%s\n",
        azurerm_storage_account.storage_account.primary_connection_string
      )

      "lecturer-service.env" = format(
        "AZURE_STORAGE_CONNECTION_STRING=%s\n",
        azurerm_storage_account.storage_account.primary_connection_string
      )
    }
  )
}

resource "local_sensitive_file" "generated_file" {
  for_each = local.generated_file_names

  filename             = local.generated_file_paths[each.key]
  content              = local.generated_file_contents[each.key]
  file_permission      = "0600"
  directory_permission = "0700"
}