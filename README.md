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
| `name` | <p>Unique identifier for this website on the infra instance</p> | `false` | `empty` |
| `domain` | <p>Full domain of the website</p> | `false` | `""` |
| `alternate-domains` | <p>Comma-separated list of alternate domains (e.g., www.example.com)</p> | `false` | `""` |
| `content-path` | <p>folder to publish as root of the website</p> | `false` | `""` |
| `spa` | <p>Enable SPA (Single Page Application) routing support</p> | `false` | `false` |
| `action` | <p>Desire outcome: apply, plan or destroy</p> | `false` | `apply` |
<!-- action-docs-inputs source="action.yml" -->

<!-- action-docs-outputs source="action.yml" -->

<!-- action-docs-outputs source="action.yml" -->
## Output Environment Variables
| name | description |
| --- | --- |
| `ACTIONS_AWS_WEBSITE_BUCKET` | <p>Website S3 bucket name</p> |
| `ACTIONS_AWS_DOMAIN` | <p>The value from `inputs.domain`</p> |
| `ACTIONS_AWS_DISTRIBUTION_ID` | <p>CloudFront distribution ID</p> |
| `ACTIONS_AWS_DISTRIBUTION_DOMAIN_NAME` | <p>CloudFront distribution domain name</p> |

## Sample Usage

### Basic Usage

```yml
permissions: 
  id-token: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@v4
      - uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-region: us-east-1
          role-to-assume: ${{ secrets.ROLE_ARN }}
          role-session-name: ${{ github.actor }}
      - uses: realsensesolutions/actions-aws-backend-setup@main
        with: 
          instance: demo
      - uses: realsensesolutions/actions-aws-website@main
        with: 
          name: my-website
          domain: example.com
          content-path: public
```

### With Alternate Domains (e.g., www subdomain)

Use `alternate-domains` to add additional domains that point to the same website. This is useful for supporting both `example.com` and `www.example.com`.

```yml
- uses: realsensesolutions/actions-aws-website@main
  with: 
    name: my-website
    domain: example.com
    alternate-domains: www.example.com
    content-path: public
```

You can also specify multiple alternate domains (comma-separated):

```yml
- uses: realsensesolutions/actions-aws-website@main
  with: 
    name: my-website
    domain: example.com
    alternate-domains: www.example.com, app.example.com
    content-path: public
```

When using `alternate-domains`, the action will:
- Create an ACM certificate with Subject Alternative Names for all domains
- Add all domains as CloudFront alternate domain names (aliases)
- Create Route53 A records for each alternate domain pointing to CloudFront

### With SPA Routing

For Single Page Applications (React, Vue, Angular, etc.), enable SPA routing to handle client-side routing:

```yml
- uses: realsensesolutions/actions-aws-website@main
  with: 
    name: my-spa
    domain: app.example.com
    content-path: dist
    spa: true
```

