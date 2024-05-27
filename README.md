<!-- action-docs-header source="action.yml" -->
## Action AWS Webiste
<!-- action-docs-header source="action.yml" -->
![Demo Status](https://github.com/alonch/actions-aws-website/actions/workflows/on-push.yml/badge.svg)
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
## Output Environment Variables
| name | description |
| --- | --- |
| `ACTIONS_AWS_WEBSITE_BUCKET` | <p>Website S3 bucket</p> |
| `ACTIONS_AWS_DOMAIN` | <p> This is the value in `inputs.domain` </p> |

## Sample Usage
```yml
permissions: 
  id-token: write
jobs:
  apply:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@v4
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-region: us-east-1
          role-to-assume: ${{ secrets.ROLE_ARN }}
          role-session-name: ${{ github.actor }}
      - uses: alonch/actions-aws-backend-setup@main
        with: 
          instance: demo
      - uses: alonch/actions-aws-website@main
        with: 
          domain: ${{ env.DOMAIN }}
          content-path: public
          action: apply
```

