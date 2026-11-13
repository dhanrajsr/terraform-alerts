locals {
  # These queries are examples. Validate event and attribute names in your
  # New Relic account before using them in production.
  default_conditions = {
    pod_not_ready = {
      name      = "${upper(var.environment)} - AKS Pod Not Ready"
      query     = "SELECT count(*) FROM K8sPodSample WHERE clusterName = '${var.cluster_name}' AND status = 'Pending'"
      threshold = 0
    }

    node_not_ready = {
      name      = "${upper(var.environment)} - AKS Node Not Ready"
      query     = "SELECT count(*) FROM K8sNodeSample WHERE clusterName = '${var.cluster_name}' AND status != 'Ready'"
      threshold = 0
    }

    high_cpu = {
      name      = "${upper(var.environment)} - AKS Container CPU Cores High"
      query     = "SELECT average(cpuUsedCores) FROM K8sContainerSample WHERE clusterName = '${var.cluster_name}'"
      threshold = 2.0
    }
  }

  effective_conditions = {
    for condition_key, defaults in local.default_conditions : condition_key => {
      name                      = defaults.name
      query                     = lookup(var.nrql_overrides, condition_key, defaults.query)
      enabled                   = !contains(var.disabled_conditions, condition_key)
      critical_threshold       = lookup(var.threshold_overrides, condition_key, defaults.threshold)
      critical_operator        = "above"
      threshold_duration       = 300
      threshold_occurrences    = "AT_LEAST_ONCE"
      aggregation_window       = 60
      aggregation_method       = "event_flow"
      violation_time_limit_sec = 3600
      runbook_url               = var.runbook_url
    }
  }

  unknown_nrql_override_keys = setsubtract(
    toset(keys(var.nrql_overrides)),
    toset(keys(local.default_conditions))
  )

  unknown_threshold_override_keys = setsubtract(
    toset(keys(var.threshold_overrides)),
    toset(keys(local.default_conditions))
  )

  unknown_disabled_condition_keys = setsubtract(
    var.disabled_conditions,
    toset(keys(local.default_conditions))
  )
}
