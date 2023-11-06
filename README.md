# The Ruby on Rails Web Application with Terraform & Jenkins
# Introduction:
    This documentation will guide through the deployment of a Ruby on Rails web application on AWS, leveraging Terraform for infrastructure as code. It is used for defining, managing, and provisioning infrastructure resources in a declarative manner. Terraform allows you to describe your infrastructure using code, specifying the desired state of your infrastructure in configuration files. Here we have to fork the repository, build docker images, and create AWS resources for a scalable and secure application. With a focus on best practices, and integrate RDS and S3, ensuring IAM role authentication and database security. This project showcases the synergy between modern web development and infrastructure automation, offering a comprehensive solution for deploying web applications. 

# Prerequisites
Before begin with the deployment of "The Ruby on Rails Web Application with Terraform Scripts," ensure that we have the following prerequisites:
 	 AWS Account.
 	 EC2 Ubuntu 22.04LTS Instance.
 	 Create new IAM User.
 	 Create IAM Role.
 	 Linux (Ubuntu) Package Manager
 	 Docker
 	 Jenkins
# What Will We Do
    To get started with this project, here's an overview of the essential steps will follow:
###  Login to AWS: 
    If you don't have an AWS account, you will begin by creating one and logging into the AWS Management Console.
### Create EC2 Instance: 
    You will create an EC2 instance that runs Ubuntu 22.04 LTS (or Linux) to serve as the environment for running Terraform scripts and deploying the Ruby on Rails web application. Ensure that this instance meets the following system requirements:
 	    Operating System: Ubuntu 22.04 LTS
 	    RAM: At least 1GB
 	    vCPU: 1
 	    Family: t2.micro
###  Create New IAM User: 
    Within the AWS Console, you will create a new IAM user specifically for Terraform. This user will have the necessary permissions to manage AWS resources as code.
###  Create IAM Role:
    Simultaneously, you will create an IAM role for authentication and to enhance security in the management of AWS resources.
###  Create EKS Cluster: 
    Create an Amazon EKS cluster to serve as the orchestration platform for deploying and managing your application containers.
###  Terraform Script: 
    You will use Terraform scripts to provision the infrastructure for the web application. These scripts will define the desired state of the infrastructure, enabling you to automate the provisioning process effectively.
## Terraform Script Execution
	Follow these steps to execute your Terraform scripts:
### Set-Up EC2 Instance
	1. Launch an EC2 instance running Ubuntu 22.04 LTS.
	2. Create an IAM user in AWS with programmatic access and AdministratorAccess permissions.
	3. Configure AWS CLI on the EC2 instance with the IAM user's credentials.
### Install Terraform
	1. Download the Terraform binary from the official website.


        1 Download Terraform stable release here.
         '(Install | Terraform | HashiCorp Developer)'
        2 Click download options in the top of the page
        3 Choose operating system ex. (Linux or Ubuntu )
        4 Select Package manager ex. (Linux or Ubuntu)
        5 Executing the following commands one by one for Amazon Linux

        '$ sudo yum install -y yum-utils shadow-utils'
   

        '$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.reo'
   
	2. Install Terraform on your EC2 instance using the package manager (apt).
       
        '$ sudo yum -y install terraform'
        
	3. Confirm the Terraform installation by running terraform --version.
        
        '$ terraform --version '
        
### Initialize Terraform
	1.Create a directory for your Terraform project.
	2.Navigate to the project directory.
	3.Copy and paste your Terraform scripts into the project directory.
	4.Initialize the Terraform project with terraform init.

       '$ terraform init'
       
### Validate Terraform Configuration
	1.Run terraform validate to check the syntax and validity of your Terraform configuration.
       
        '$ terraform validate'
        
### Plan Terraform Deployment
	1.Generate an execution plan with terraform plan.

        '$ terraform plan'
        
	2.Review the plan to ensure it aligns with your desired infrastructure changes.
### Apply Terraform Configuration
        1.Apply your Terraform configuration with terraform apply.
        
        '$ terraform apply'
        
        2.Confirm the changes when prompted.
## Jenkins Pipeline Execution Steps
        Follow these steps to create and execute a Jenkins pipeline for deploying infrastructure:
### Jenkins Configuration
	1.Set up Jenkins on your EC2 instance.
	2.Install the necessary plugins, including the AWS and Docker plugins.
### Create a Jenkins Pipeline
	1.Create a new Jenkins pipeline job.
        2.Configure the pipeline job to connect to your Git repository.
        3.Use the provided Jenkins pipeline script for building Docker images, pushing to AWS ECR, and deploying to AWS EKS.
        4.Define environment variables for AWS credentials, region, ECR repository name, and Dockerfile path.
### Execute the Jenkins Pipeline
	1.Trigger the Jenkins pipeline manually or set up a webhook for automatic execution.
	2.Monitor the Jenkins pipeline execution and view the build and deployment logs.
## Conclusion
        In this article, we explain all the steps to create an infrastructure using terraform and we explain how easy it is to create and destroy a service using terraform.
