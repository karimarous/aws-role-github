# aws-role-github

# 1. Introduction
In modern cloud infrastructure, managing access securely and efficiently is crucial. In this case, we're going to talk about AWS cloud provider. AWS Identity and Access Management (IAM) Roles provide a powerful way to control and delegate access to AWS resources without needing to expose sensitive credentials. This repository showcases how to create and manage AWS IAM Roles in real-world scenarios, specifically focusing on practical use cases, such as integrating with GitHub Actions self-hosted runners.

The goal of this repository is to demonstrate best practices for creating IAM Roles, assigning appropriate permissions, and configuring trust policies to ensure secure and scalable access to AWS resources. Whether you are setting up CI/CD pipelines, automating workflows, or managing infrastructure, this guide will walk you through the entire process, making it easier to implement roles effectively.

By following the examples in this repository, you will learn how to:
- Create an AWS Identity Provider with Github
- Create an IAM role tailored for your specific needs
- Assign least-privileged permissions to ensure security
- Integrate IAM roles seamlessly with GitHub Actions for automated workflows

This guide is designed for cloud engineers, DevOps practitioners, or anyone looking to improve their understanding of AWS IAM roles in real-world applications.

# 2. Pre-Requisites
List all the tools, accounts, or permissions needed to follow along with this example:
- AWS Account
- IAM Permissions to create roles and assign policies
- IAM Permissions to create identity providers
- GitHub Repository

# 3. Understanding AWS Identity Provider
AWS Identity Provider enables you to authenticate users from an external identity system, like GitHub, Microsoft Active Directory, Google, or other OpenID Connect (OIDC) providers, and grant them temporary access to AWS resources. This allows seamless integration of your existing identity management systems with AWS, without needing to create and manage IAM users for every external entity.
# 4. Step by step guide
In order to create the role using AWS best practices, you can follow both methods provided below 
## 4.1 Manually
### 4.1.1 Create an AWS Identity provider
#### 4.1.1.1 Navigate to IAM
#### 4.1.1.2 Choose Identity providers and click on Add provider
1. Select OpenID 
2. Put this provider URL: https://token.actions.githubusercontent.com
3. Put this Audience: sts.amazonaws.com
4. Click Add provider

### 4.1.2 Create an IAM policy
1. Navigate to IAM
2. Choose Policies and click on Create policy
3. Create a policy depending on your needs. Add the services that you want to use and the required access for each one, ensuring the use of the principle of least privilege

### 4.1.3 Create an IAM role
#### 4.1.3.1. Navigate to IAM
#### 4.1.3.2 Choose Roles and click on Create role
1. Select Web Identity
2. Click on Choose a provider and select token.actions.githubusercontent.com
3. Click on Audience section and fill it with sts.amazonaws.com
4. Click on Github organization section and fill it with the name of your organization
5. Click on Github repository and the name of the repository that's going to use this rôle and click Next 
6. Choose to policy created in the section [Create IAM Policy](#412-create-an-iam-policy) and click next
#### 4.1.3.3. Put the role name

## 4.2 Using Terraform
In this section, I will show you how to create the same component using Terraform

### 4.2.1 Create an AWS Identity provider
In only this section, we're going to create AWS Identity provider manually. Why? Because, we can use the same components to create multiples role rather than creating AWS Identity provider per environment

Follow the same steps provided in the section [Create AWS Identity Provider](#411-create-an-aws-identity-provider) 

Note: 
If you want to provision the AWS Identity provider using Terraform follow this link:
[iam-github-oidc-provider](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest/submodules/iam-github-oidc-provider)



### 4.2.2 Provision the AWS IAM role
In only this section, we're going to provision the AWS IAM role using Terraform. In order to ensure the simplicity of the project, I'm not going to use any CI/CD tools like Github Actions or configure Terraform backend and workspaces

Don't worry, I will cover it in another repo ;)

1. Clone the project on your local machine
2. Configure the code depending on your needs
This project contains a policy that used just for the purpose of this project you need to modify it depending on your needs
Just go to policies.tf file and modify the policy of the block that start with 
```
data "aws_iam_policy_document" "role_policy" {
```

Note:
Don't forget to save your file

3. Provision the AWS role
```
terraform init
terraform apply -auto-approve
```

# 5 Use the role in Github actions runners
I covered this section in another repo
[aws-terraform-frontend](https://github.com/opsforall/aws-terraform-frontend)
