# alerts Terraform modules

Reusable Terraform modules for New Relic alert resources.

## Module layout

- `modules/aks`: owns the AKS alert policy and AKS default NRQL query/condition definitions.
- `modules/common/nrql_conditions`: reusable implementation of `newrelic_nrql_alert_condition` resources.

## Release

The Terragrunt repository references this module by immutable Git tag. After review and validation:

```bash
git tag v0.1.0
git push origin v0.1.0
```

## Provider authentication

The New Relic provider reads credentials from `NEW_RELIC_API_KEY`, `NEW_RELIC_ACCOUNT_ID` and `NEW_RELIC_REGION`. Do not store credentials in this repository.

## Notes

The NRQL queries are examples and must be checked against the event types and attributes available in your New Relic account. The module uses a service-specific policy; do not use it unchanged if your policy is shared across environments.
