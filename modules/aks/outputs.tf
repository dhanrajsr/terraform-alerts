output "alert_policy_id" {
  description = "ID of the AKS alert policy."
  value       = newrelic_alert_policy.aks.id
}

output "condition_ids" {
  description = "Map of condition keys to New Relic condition IDs."
  value       = module.nrql_conditions.condition_ids
}

output "effective_condition_names" {
  description = "Names of the AKS conditions configured by this unit."
  value       = { for key, condition in local.effective_conditions : key => condition.name }
}
