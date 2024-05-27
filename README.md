<!-- action-docs-header source="action.yml" -->
## Action AWS Webiste
<!-- action-docs-header source="action.yml" -->

<!-- action-docs-description source="action.yml" -->
## Description

Provision all the resource required to host a website in AWS
<!-- action-docs-description source="action.yml" --> 

<!-- action-docs-inputs source="action.yml" -->
## Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `domain` | <p>Full domain of the website</p> | `true` | `""` |
| `content-path` | <p>folder to publish as root of the website</p> | `false` | `""` |
| `action` | <p>Desire outcome: apply, plan or destroy</p> | `false` | `plan` |
<!-- action-docs-inputs source="action.yml" -->

<!-- action-docs-outputs source="action.yml" -->

<!-- action-docs-outputs source="action.yml" -->

<!-- action-docs-runs source="action.yml" -->
## Runs

This action is a `composite` action.
<!-- action-docs-runs source="action.yml" -->