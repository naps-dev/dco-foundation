# 2. GitHub Pipeline Design: Prioritize Shared Patterns

Date: 2022-11-25

## Status

Accepted

## Context

**Question: should we resuse workflows / actions or do what's fastest for now?**

GitHub pipelines achieve reuse two ways:

1. Sharing whole workflows
1. Sharing actions

We need to find the right balance between creating reusable pipeline components and expediently achieving goals of naps-dev. Engineering a perfect solution that shares whole workflows is an attractive but labor-intensive option for naps-dev. Alternatively, leaving each developer to customize a unique pipeline solution for every project they helm results in a disjointed set of projects and significant cognitive load as the naps-dev systems grow.

### Background on GitHub Actions

GitHub pipelines provide basic templating capabilities. Projects may have one or more [workflows](https://docs.github.com/en/actions/using-workflows/about-workflows). A workflow is an automated test with one or more jobs and each job has one or more steps. Events trigger workflows, and jobs are assigned to execute on a dedicated or shared runner.

* Project
  * Workflow
    * Job
      * Step

Steps are either references to a developer-provided bash script (inline or an external `*.sh` file) or a **call to an action**.

[Actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions) are reusable pipeline components in GitHub. Developers can create and maintain [composite actions](https://docs.github.com/en/actions/creating-actions/creating-a-composite-action) (actions comprised of multiple steps) and make them available to other projects.

Workflows are [also reusable](https://docs.github.com/en/actions/using-workflows/reusing-workflows). Caller workflows can call many reusable workflows sequentially but you cannot nest multiple workflows hierarchically; a called workflow may not also call another reusable workflow.

A project's workflow can reference a composite action or workflow from it's own subdirectories or from a public project on GitHub. Further, GitHub allows developers to [publish their composite actions](https://docs.github.com/en/actions/creating-actions/publishing-actions-in-github-marketplace) in the GitHub Marketplace. 

### DCO Pipeline Needs

We are concerned with four fundamental pipelines at naps-dev:

1. Manage the foundational package
1. Manage VM-based applications
1. Manage container-based applications
1. Manage the DCO package

While the four pipelines are unique, they share some important steps.

1. Manage the foundational package
    1. Zarf package create - *install Zarf, registry login(s), create package, save to S3*
    1. Test Zarf package - *create k3d cluster, retrieve package from S3, deploy zarf package, basic health/ingress checks, destroy k3d cluster*
1. Manage VM-based applications
    1. Create qcow VM - *retrieve source VM from S3, convert VM, configure VM, save to S3*
    1. Create VM OCI image - *login to ECR, retrieve source qcow VM from S3, build container, push container to ECR*
    1. Zarf package create - *install Zarf, registry login(s), create package, save to S3*
    1. Test Zarf package - *create k3d cluster, retrieve packages from S3, deploy zarf packages, basic health/ingress checks, destroy k3d cluster*
1. Manage container-based applications
    1. (if the container doesn't exist) Create the OCI image - *login to ECR, retrieve source executable from S3, build container, push container to ECR*
    1. Zarf package create - *install Zarf, registry login(s), create package, save to S3*
    1. Test Zarf Package - *create k3d cluster, retrieve packages from S3, deploy zarf packages, basic health/ingress checks, destroy k3d cluster*
1. Manage the DCO package
    1. Zarf package create - *install Zarf, registry login(s), create package, save to S3*
    1. Test Zarf Package - *create k3d cluster, retrieve packages from S3, deploy zarf packages, basic health/ingress checks, destroy k3d cluster*

## Decision

**Answer: Do not reuse yet, but organize pipelines in the same way so that we can implement smart reuse later** 

We will not engineer a perfect system of reusable workflows today. Projects will follow simple guidelines ensuring pipelines adhere to a common pattern and are positioned to be iteratively improved into a more mature system of reusable components.

### Pipeline Pattern

Projects will have these top-level directories:
* `.github/actions`
* `.github/workflows`

A typical workflow will consist of two or more jobs with distinctly useful, single-purpose steps. Following the description above, the *Manage VM-based applications* workflow should consist of four jobs 1) create qcow VM, 2) create VM UCI image, 3) zarf package create, 4) test zarf package. Further, steps within the *zarf package create* job are 1) install Zarf, 2) registry login(s), 3) create package, 4) save package to S3.

Adhering to this structure allows developers to easily transition between projects' pipelines and ensures the projects can be improved with action or workflow reuse as naps-dev matures.

## Consequences

Ensuring the team is following a pre-defined pipeline structure without engineering reuse today means we have to keep one-another accountable through careful code reviews. Inefficiencies we discover in the pattern outlined above may require re-design that results in significant changes across may projects.
