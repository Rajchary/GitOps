


data "github_repository" "repo" {
  full_name = var.repo_name
}

resource "github_repository_environment" "aws_environment" {
  repository  = data.github_repository.repo.name
  environment = "AWS"
}

resource "github_actions_environment_secret" "inventory" {
  repository  = data.github_repository.repo.name
  environment = github_repository_environment.aws_environment.environment
  secret_name = "inventory"
  plaintext_value = base64encode(templatefile(
    "${path.module}/templates/inventory.tpl",
    {
      home_app     = module.compute.home_app_ip,
      products_app = module.compute.products_app_ip,
    }
  ))
}

locals {
  ipv4_address = concat(module.compute.home_app_ip, module.compute.products_app_ip)
}

data "sshclient_host" "host" {
  count                    = var.instance_count * 2
  hostname                 = local.ipv4_address[count.index]
  username                 = "keyscan"
  insecure_ignore_host_key = true # we use this to scan and obtain the key
}

data "sshclient_keyscan" "keyscan" {
  count     = length(data.sshclient_host.host)
  host_json = data.sshclient_host.host[count.index].json
}

resource "github_actions_environment_secret" "known_hosts" {
  repository  = data.github_repository.repo.name
  environment = github_repository_environment.aws_environment.environment
  secret_name = "known_hosts"
  plaintext_value = templatefile(
    "${path.module}/templates/known_hosts.tpl",
    {
      hostname = data.sshclient_host.host.*.hostname,
      keyscan  = data.sshclient_keyscan.keyscan,
    }
  )
}