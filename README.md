## Cloud-Native CI/CD on AWS EKS — STAR Storytelling (Why This Exists)

This project was built to **solve a real business problem**: slow, manual, and error‑prone application deployments.

Instead of deploying apps by hand and clicking around the AWS console, this system **automates everything** — from infrastructure creation to application rollout — using modern cloud‑native practices.

> **In one sentence:** A Git push automatically builds, ships, and deploys an application securely to AWS EKS.

## S — Situation (The Problem)

Many teams struggle with:

* Manual deployments that are slow and risky

* Inconsistent environments ("works on my machine")

* Infrastructure created by hand, hard to reproduce or destroy

* Long‑lived AWS credentials checked into CI/CD tools

* Difficulty scaling applications reliably for real users

**Business impact:**

* Slower feature delivery

* Higher chance of outages

* Security risks

* Wasted engineering time

**Analogy (simple):**

> Rebuilding the same house every day without instructions — something always breaks.


## R — Result (Impact & Outcomes)

## Engineering Results

* Fully automated deployments — no manual steps

* Zero‑downtime rolling updates

* Infrastructure can be created or destroyed on demand

* Secure cloud access without stored credentials

## Business Value

* Deployment time reduced from manual steps to minutes

* Human error significantly reduced

* Security posture improved (OIDC, IAM, IRSA)

* Cost control enabled by clean teardown of resources

**Plain English:**

> Faster releases, fewer mistakes, safer systems.

## T — Task (What I Needed to Do)

My responsibility was to:

* Design a **production‑style CI/CD pipeline**

* Automate infrastructure creation and teardown

* Secure AWS access without static credentials

* Deploy a containerized application that is:

  * Highly available

  * Internet‑accessible

  * Easy to update

The goal was not just to "make it work" — but to make it **repeatable, secure, and scalable**

## A — Action (What I Built & Why)

## Infrastructure (Terraform)

* Provisioned VPC, subnets, EKS cluster, node groups, and ECR using **Terraform**

* Enabled full infrastructure reproducibility and version control

## Application Packaging (Docker + ECR)

* Containerized a Python application with Docker

* Stored images in Amazon ECR for reliable, versioned delivery

## CI/CD (GitHub Actions)

* Built a pipeline triggered on `main` branch pushes

* Automatically:

  1. Builds Docker image

  2. Pushes image to ECR

  3. Connects to EKS

  4. Deploys Kubernetes manifests

## Security (OIDC + IAM)

* Used **GitHub Actions OIDC** instead of AWS access keys

* Implemented least‑privilege IAM roles

* Used **IRSA** for AWS Load Balancer Controller

## Kubernetes & Networking

* Deployed workloads to EKS with rolling updates
* Exposed the app using AWS Load Balancer Controller
* Automatically provisioned an internet‑facing ALB

**Analogy:**

> Terraform is the blueprint, GitHub Actions is the robot, Kubernetes is the factory, AWS is the land.

---



---

## Architecture Overview

**Flow:**

1. Developer pushes code to GitHub

2. GitHub Actions builds Docker image

3. Image pushed to Amazon ECR

4. GitHub Actions deploys to EKS

5. AWS Load Balancer Controller provisions ALB

6. Users access the app via public ALB URL

**Core Services:**

* Amazon EKS

* EC2 Managed Node Groups

* Amazon ECR

* AWS ALB

* IAM + OIDC

## Repository Structure

app/
  Dockerfile
  app.py
  requirements.txt

k8s/
  deployment.yaml
  service.yaml
  ingress.yaml

terraform/
  networking/
  eks/
  iam/
  addons/
  ecr.tf
  cloudwatch.tf

.github/workflows/
  deploy.yml

## Debug Stories (What I Learned). Each issue was debugged using logs, events, and AWS/K8s primitives.

### 1) Pods stuck in `Pending`

**Cause:** Node group capacity exhausted

**Fix:**

* Scaled managed node group

* Verified scheduling events

Lesson:

> Kubernetes can’t place pods if there are no chairs.

### 2) GitHub Actions could not access cluster

**Cause:** IAM role not mapped in `aws-auth`

**Fix:**

* Added GitHubActionsEKSRole to `system:masters`

Lesson:

> AWS auth ≠ Kubernetes auth

### 3) ALB not provisioning

**Cause:** Missing IRSA permissions

**Fix:**

* Correct IAM policy + trust relationship

Lesson:

> Controllers need AWS permissions too.

## Live Demo

The application is exposed via an auto‑generated ALB URL:

http://k8s-xxxx.us-east-1.elb.amazonaws.com

## Why This Project Matters

This project demonstrates:

* Real AWS EKS usage (not local clusters)

* Infrastructure as Code

* Secure CI/CD without secrets

* Kubernetes debugging skills

* Cloud‑native system design thinking

## Next Improvements

* HTTPS with ACM

* HPA (Horizontal Pod Autoscaler)

* Blue/Green or Canary deploys

* Terraform remote state (S3 + DynamoDB)

* Cloud watch

Alb controller and app run image: alb controller_app_run.jpg

The architecture diagram image: architecture.png

## About Me

This project reflects how I **think, debug, and build** — not just what tools i know.

 LinkedIn: https://www.linkedin.com/in/unclekesh/ Email: olalekankeshinro22@gmail.com




