output "condition_ids" {
  description = "Map of condition keys to New Relic NRQL alert condition IDs."
  value       = { for key, condition in newrelic_nrql_alert_condition.this : key => condition.id }
}
