resource "newrelic_nrql_alert_condition" "this" {
  for_each = {
    for condition_key, condition in var.conditions : condition_key => condition
    if condition.enabled
  }

  policy_id                    = var.policy_id
  name                         = each.value.name
  type                         = "static"
  enabled                      = true
  description                  = "Managed by Terraform/Terragrunt. Condition key: ${each.key}."
  runbook_url                  = each.value.runbook_url
  violation_time_limit_seconds = each.value.violation_time_limit_sec
  aggregation_window           = each.value.aggregation_window
  aggregation_method            = each.value.aggregation_method

  nrql {
    query = each.value.query
  }

  critical {
    operator              = each.value.critical_operator
    threshold             = each.value.critical_threshold
    threshold_duration    = each.value.threshold_duration
    threshold_occurrences = each.value.threshold_occurrences
  }
}
