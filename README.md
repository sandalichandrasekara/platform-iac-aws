# AWS Platform Infrastructure

Terraform Infrastructure as Code to host a **legacy monolithic web application** on AWS
in a secure, reliable, and maintainable way.

The goal is not to modernize the app, but to build a solid AWS platform around it using a
**modular architecture** and DevOps best practices.

## Architecture

```
                        Internet
                           │
                  ┌────────▼────────┐   public subnets
                  │       ALB       │
                  └────────┬────────┘
                    ┌──────▼──────┐     private app subnets
                    │  EC2 (ASG)  │     Linux app servers
                    └──────┬──────┘
                    ┌──────▼──────┐     private data subnets
                    │  DocumentDB │     MongoDB-compatible database
                    └─────────────┘
```

**Cross-cutting:** NAT Gateway · SSM Session Manager (no SSH) · Secrets Manager ·
S3 remote state.

## Repository layout

```
platform-iac-aws/
├── bootstrap/        # S3 bucket for Terraform remote state (run once)
├── modules/          # reusable building blocks
│   ├── networking/   # VPC, subnets, IGW, NAT, route tables
│   ├── security/     # security groups, IAM roles
│   ├── compute/      # ALB, launch template, Auto Scaling Group
│   └── database/     # Amazon DocumentDB (MongoDB-compatible)
└── environments/     # per-environment composition (dev)
```

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.6
- AWS CLI configured with credentials (`aws configure`)

## Usage

```bash
# 1. Create the S3 state bucket once
cd bootstrap
terraform init && terraform apply

# 2. Deploy an environment
cd ../environments/dev
terraform init
terraform plan
terraform apply
```

## License

See [LICENSE](./LICENSE).
