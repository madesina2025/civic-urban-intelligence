# Urban Intelligence (CivicPulse) – City Service Analytics Pipeline

**Urban Cities Live**  
**Intelligence and Reporting**

---
# Table of Contents

1. [Project Overview](#1-project-overview)  
2. [Problem Statement](#2-problem-statement)  
3. [Solution Summary](#3-solution-summary)  
4. [High-Level Architecture](#4-high-level-architecture)  
5. [Architecture Diagram](#5-architecture-diagram)  
6. [Data Pipeline Logic](#6-data-pipeline-logic)  
7. [Project Structure](#7-project-structure)  
8. [Prerequisites](#8-prerequisites)  
9. [How to Run Locally](#9-how-to-run-locally)  
10. [Access Services](#10-access-services)  
11. [Outputs](#11-outputs)  
12. [Roadmap & Enhancements](#12-roadmap--enhancements)
  
---

## 1. Project Overview

Urban Intelligence (CivicPulse) is an end-to-end cloud data pipeline built to deliver reliable, transparent, and explainable city-service performance metrics.

The platform ingests public NYC 311 non-emergency service request data and transforms it into near real-time operational intelligence for city agencies, field operations, dispatch teams, and executive leadership.

This project is designed to help stakeholders monitor city-service performance using trusted and analytics-ready datasets built through a modern cloud architecture.

### End-to-End Flow

```text
NYC 311 API → Apache Airflow → Azure Blob Storage → Azure Data Factory → Azure PostgreSQL → Power BI
```

Strong data-quality checks, lineage tracking, and clearly defined KPIs ensure that insights are accurate, auditable, and trusted.

The final Power BI dashboards provide timely visibility into service trends and operational performance, supporting fair and data-driven decision-making with a resident-first focus.

## 2. Problem Statement

City agencies face increasing demand for **live, explainable, and trustworthy insights** into non-emergency service delivery.

However, public service operations often face several data challenges:

- **Fragmented and delayed reporting** from raw 311 datasets
- **Limited visibility** into service backlog, SLA compliance, and service equity
- **Data latency during peak periods** such as storms, holidays, and major incidents
- **Lack of automated monitoring, validation, and data lineage**
- **Reduced confidence in operational reporting** due to inconsistent or delayed data

Without a robust analytics pipeline, operational decisions become **slower, riskier, and harder to justify**.

CivicPulse addresses these issues by creating a **scalable, transparent, and cloud-native data platform** that transforms raw public data into **trusted operational intelligence**.

## 3. Solution Summary

CivicPulse delivers a modern **end-to-end analytics solution** for city-service reporting.

### Core Solution Capabilities

- **Scalable near real-time ingestion** from the NYC 311 API
- **Automated orchestration, retries, and SLA monitoring** using Apache Airflow
- **Raw and clean landing zones** in Azure Blob Storage
- **Managed data movement and transformation** using Azure Data Factory
- **Curated analytics-ready tables** in Azure PostgreSQL
- **Self-service Power BI dashboards** for operational and leadership reporting
- **Infrastructure provisioning and environment consistency** using Terraform

### Business Value

The solution prioritises:

- **Data trust**
- **Transparency**
- **Operational usability**
- **Reproducibility**
- **Faster decision-making**
- **Explainable KPI reporting**

CivicPulse helps convert **raw resident requests into actionable insights** across:

- Request volumes
- Backlogs
- SLA performance
- Resolution times
- Geographic service distribution

## 4. High-Level Architecture

The pipeline follows a modern **API → Lake → Warehouse → Analytics** architecture pattern.

### Core Components

| Component | Purpose |
|----------|---------|
| NYC 311 API | Source system for non-emergency service request data |
| Apache Airflow | Workflow orchestration, retries, scheduling, SLA monitoring |
| Azure Blob Storage | Raw and clean landing zone for pipeline data |
| Azure Data Factory | Managed ETL and movement into curated layers |
| Azure PostgreSQL | Analytics-ready database for structured reporting |
| Power BI | Dashboarding and operational insight consumption |
| Terraform | Infrastructure as Code for Azure resource provisioning |

### Architecture Flow

```text
API → Airflow → Azure Blob Storage → Azure Data Factory → Azure PostgreSQL → Power BI

```
### Technology Stack

- **Python** – API integration, schema handling, validation, and transformations  
- **Apache Airflow** – orchestration backbone for scheduling, retries, and alerts  
- **Azure Blob Storage** – cloud landing zone for raw and clean files  
- **Azure Data Factory** – managed orchestration for transformation and database loading  
- **Azure PostgreSQL** – curated storage for typed staging and analytics marts  
- **Power BI** – operational dashboards and KPI reporting  
- **Terraform** – Azure infrastructure provisioning using code

## 5. Architecture Diagram

![CivicPulse Architecture Diagram](docs/images/architecture.png)

## 6. Data Pipeline Logic

The CivicPulse pipeline is designed as a **staged data workflow** that supports reliability, traceability, and analytics readiness.

---

### Step 1: Extract Data from NYC 311 API

Python scripts connect to the **NYC 311 public API** and extract service request records.

Typical extraction responsibilities include:

- API connection handling  
- Pagination  
- Error handling  
- Schema capture  
- Raw response retrieval  

---

### Step 2: Load Raw Data to Azure Blob Storage

The extracted raw data is stored in the **raw landing zone in Azure Blob Storage**.

**Purpose of raw storage:**

- Preserve original source records  
- Support auditability and reprocessing  
- Maintain lineage from source to reporting layer  

**Example raw path**

```text
storage/blob/raw2/

```
### Step 3: Transform and Standardise Data

The raw dataset is **cleaned and standardised** before loading into downstream services.

Typical transformation activities include:

- Column standardisation  
- Data type casting  
- Null handling  
- Filtering invalid records  
- Date formatting  
- Basic business rule enforcement  

The clean dataset is then stored in the **clean landing zone**.

```text
storage/blob/clean2/

```
### Step 4: Load Curated Data with Azure Data Factory

Azure Data Factory moves **clean data from Blob Storage into Azure PostgreSQL**.

This stage typically includes:

- Data mapping  
- Incremental or batch loading  
- Structured table loading  
- Curated layer preparation  
- Error logging and monitoring  

---

### Step 5: Serve Analytics Through Azure PostgreSQL

Azure PostgreSQL stores the **curated analytics-ready datasets** used by Power BI.

### Step 6: Visualise Operational Insights in Power BI

Power BI connects to **Azure PostgreSQL** and presents dashboards for operational and leadership consumption.

Example insight areas include:

- Service volumes by borough  
- Complaint type trends  
- Open vs closed request status  
- SLA compliance performance  
- Resolution time analysis  
- Backlog ageing  
- Daily and weekly trend analysis

## 7. Project Structure

```text
urban-intelligence/
├── README.md
├── .gitignore
├── .env
├── requirements.txt
│
├── api/
│   ├── api_connect.py
│   ├── auth.py
│   ├── extract.py
│   ├── load_to_data_lake.py
│   ├── transform_data.py
│   └── load_clean_data_to_data_lake.py
│
├── airflow/
│   ├── dags/
│   │   └── civicpulse_dag.py
│   └── airflow_config.md
│
├── storage/
│   └── blob/
│       ├── raw2/
│       └── clean2/
│
├── adf/
│   ├── pipelines/
│   ├── datasets/
│   └── linked_services/
│
├── database/
│   └── postgres/
│       ├── schema.sql
│       ├── staging.sql
│       └── marts.sql
│
├── powerbi/
│   ├── dashboards/
│   ├── model.md
│   └── measures.md
│
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
│
└── docs/
    ├── architecture.md
    ├── data_lineage.md
    ├── runbook.md
    └── images/
        └── architecture.png

```

### Structure Explanation

- **api/** – contains Python scripts for extraction, transformation, and loading  
- **airflow/** – contains DAGs for orchestration  
- **storage/** – represents Blob landing zones  
- **adf/** – stores Azure Data Factory assets  
- **database/** – stores SQL scripts for PostgreSQL schema and curated models  
- **powerbi/** – contains reporting logic and dashboard documentation  
- **terraform/** – contains Infrastructure as Code definitions  
- **docs/** – stores project documentation and architecture assets

## 8. Prerequisites

Before running this project locally, make sure the following tools and services are available.

### Required Tools

- Python **3.10 or above**
- **Git**
- **Docker Desktop**
- **Terraform**
- **Azure CLI**
- **Power BI Desktop**
- **Apache Airflow environment** (local or Docker-based)

### Required Cloud Resources

- **Azure Subscription**
- **Azure Storage Account**
- **Azure Data Factory**
- **Azure Database for PostgreSQL**
- **Power BI environment**

### Recommended Skills

- Basic **Python scripting**
- **SQL**
- **Azure fundamentals**
- **Power BI reporting**
- **Terraform basics**

### Required Accounts:

- **Azure Subscription**
- **GitHub**


## 9. How to Run Locally

### Clone the Repository

```bash
git clone https://github.com/madesina2025/urban-intelligence.git
cd urban-intelligence

### Create Python Environment

```bash
python -m venv venv
source venv/bin/activate

### Install Dependencies

```bash
pip install -r requirements.txt

### Configure Environment Variables

- Create a .env file in the project root and add the following variables:

```bash
API_URL=
AZURE_STORAGE_CONNECTION_STRING=
POSTGRES_HOST=
POSTGRES_DB=
POSTGRES_USER=
POSTGRES_PASSWORD=

'''

### Provision Azure Infrastructure

- Navigate to the Terraform directory:

```bash
cd terraform


=======
```

- Initialize terraform

```bash
terraform init

```
- Preview infrastructure changes:

```bash
terraform plan


=======
```

- Apply the infrastructure:

```bash
terraform apply
```

- This will provision:

- Resource Group

- Blob Storage

- Azure Data Factory

- Azure PostgreSQL

### Run Data Ingestion

```bash
python api/api_connect.py
python api/extract.py
python api/load_to_data_lake.py

```
- Run Data Transformation

```bash
python api/transform_data.py
python api/load_clean_data_to_data_lake.py

```
Trigger Airflow DAG

```bash
civicpulse_dag

```
- **Airflow orchestrates the pipeline execution**.
