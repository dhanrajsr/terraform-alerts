variable "environment" {
  description = "Environment name used for alert policy metadata/naming."
  type        = string
}

variable "cluster_name" {
  description = "Kubernetes cluster name used by the default NRQL queries."
  type        = string
}

variable "policy_name" {
  description = "Name of the service-owned New Relic alert policy."
  type        = string
}

variable "nrql_overrides" {
  description = "Optional NRQL query overrides keyed by condition key."
  type        = map(string)
  default     = {}
}

variable "threshold_overrides" {
  description = "Optional critical-threshold overrides keyed by condition key."
  type        = map(number)
  default     = {}
}

variable "disabled_conditions" {
  description = "Condition keys that should not be managed as enabled alert conditions."
  type        = set(string)
  default     = []
}

variable "runbook_url" {
  description = "Optional common runbook URL attached to all AKS conditions."
  type        = string
  default     = null
  nullable    = true
}
