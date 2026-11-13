variable "policy_id" {
  description = "New Relic alert policy ID that owns these conditions."
  type        = string
}

variable "conditions" {
  description = "Map of NRQL conditions to create. Disabled entries are filtered by the calling service module."

  type = map(object({
    name                      = string
    query                     = string
    enabled                   = bool
    critical_threshold        = number
    critical_operator         = string
    threshold_duration        = number
    threshold_occurrences     = string
    aggregation_window        = number
    aggregation_method        = string
    violation_time_limit_sec  = number
    runbook_url               = string
  }))
}
