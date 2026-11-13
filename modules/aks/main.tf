resource "newrelic_alert_policy" "aks" {
  name = var.policy_name

  # Run input-key preconditions before creating the policy.
  depends_on = [terraform_data.validate_condition_keys]
}

module "nrql_conditions" {
  source = "../common/nrql_conditions"

  policy_id   = newrelic_alert_policy.aks.id
  conditions  = local.effective_conditions
}

resource "terraform_data" "validate_condition_keys" {
  input = "${var.environment}/${var.cluster_name}"

  lifecycle {
    precondition {
      condition     = length(local.unknown_nrql_override_keys) == 0
      error_message = "Unknown NRQL override keys: ${join(", ", tolist(local.unknown_nrql_override_keys))}. Add the condition to default_conditions first."
    }

    precondition {
      condition     = length(local.unknown_threshold_override_keys) == 0
      error_message = "Unknown threshold override keys: ${join(", ", tolist(local.unknown_threshold_override_keys))}. Add the condition to default_conditions first."
    }

    precondition {
      condition     = length(local.unknown_disabled_condition_keys) == 0
      error_message = "Unknown disabled condition keys: ${join(", ", tolist(local.unknown_disabled_condition_keys))}. Add the condition to default_conditions first."
    }
  }
}
