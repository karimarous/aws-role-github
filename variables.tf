variable "project_name" {
  type = string
  default = "example"
}

variable "oidc_provider_name" {
  type = string
  default = "token.actions.githubusercontent.com"
}

variable "oidc_audience" {
  type = string
  default = "sts.amazonaws.com"
}

variable "repo_path" {
  type = string
  default = "repo:organizationname/reponame"
}
