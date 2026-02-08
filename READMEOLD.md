# Urban Intelligence (CivicPulse) – City Service Analytics Pipeline

## Project Overview
Urban Intelligence (CivicPulse) is an end-to-end cloud data pipeline built to deliver reliable, transparent, and explainable city-service performance metrics.

The platform ingests data from public APIs and processes it through an automated workflow:

**API → Airflow → Azure Blob Storage → Azure Data Factory → Azure PostgreSQL → Power BI**

Strong data-quality checks, lineage tracking, and clearly defined KPIs ensure that insights are accurate, auditable, and easy to trust. The final Power BI dashboards provide decision-makers with timely visibility into service trends and operational performance, supporting fair and data-driven decisions with a resident-first focus.

---

## Architecture Overview
The pipeline is orchestrated with **Apache Airflow** for API ingestion, staging raw data in **Azure Blob Storage** and transforming it via **Azure Data Factory** into **Azure PostgreSQL** for analytics consumption in **Power BI**.

**Terraform** is used as **Infrastructure as Code (IaC)** to provision, version, and manage all Azure resources, ensuring consistent, repeatable, and auditable deployments across environments.

---

## Architecture Diagram
> Add your diagram image to the repo (e.g., `docs/images/architecture.png`) and reference it here.

![Architecture Diagram](docs/images/architecture.png)

---

## Repository Structure
This structure mirrors the architecture flow:

**API → Airflow → Azure Blob → Azure Data Factory → Azure PostgreSQL → Power BI**  
with **Terraform (IaC)** wrapping and provisioning the Azure infrastructure.

```text
urban-intelligence/
├── README.md
├── .gitignore
├── .env
├── requirements.txt
│
├── api/
│   ├── api_connect.py                     # API ingestion logic
│   ├── auth.py                            # Authentication & token handling
│   ├── extract.py                         # Raw data extraction
│   ├── load_to_data_lake.py               # Load raw data to Blob (raw2)
│   ├── transform_data.py                  # Data cleaning/standardization
│   └── load_clean_data_to_data_lake.py    # Load clean data to Blob (clean2)
│
├── airflow/
│   ├── dags/
│   │   └── civicpulse_dag.py              # Pipeline orchestration
│   └── airflow_config.md
│
├── storage/
│   └── blob/
│       ├── raw2/                          # Raw landed data
│       └── clean2/                        # Cleaned/intermediate data
│
├── adf/
│   ├── pipelines/                         # Azure Data Factory pipelines
│   ├── datasets/
│   └── linked_services/
│
├── database/
│   ├── postgres/                          # SQL schema, tables, curated layer
│
├── powerbi/
│   ├── model.md                           # Data model & relationships
│   ├── measures.md                        # DAX measures
│   └── dashboards/                        # PBIX / deployment notes
│
├── terraform/
│   ├── main.tf                            # Resource provisioning
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
│
└── docs/
    ├── architecture.md
    ├── data_lineage.md
    └── runbook.md

Tech Stack

Orchestration: Apache Airflow

Storage / Landing Zone: Azure Blob Storage

ETL / Integration: Azure Data Factory (ADF)

Analytics Database: Azure PostgreSQL

Visualization: Power BI

Infrastructure as Code: Terraform

Language: Python

Step-by-Step Implementation
1) Prerequisites

Python 3.10+ (recommended)

Azure Subscription (Storage Account, ADF, PostgreSQL)

Terraform installed

Airflow environment (Docker or local)

2) Clone the Repository
git clone https://github.com/madesina2025/urban-intelligence.git
cd urban-intelligence

3) Configure Environment Variables

Create a .env file locally 

fields to include:

API base URL + credentials (if required)

Azure Storage connection string or SAS

PostgreSQL host, DB, user, password

Any ADF pipeline identifiers (optional)


4) Provision Azure Infrastructure with Terraform (IaC)

Terraform provisions and manages Azure resources such as:

Resource Group

Storage Account + Containers

Azure Data Factory

Azure PostgreSQL

cd terraform
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"


5) Run API Ingestion + Data Lake Landing (Python)

python -m venv venv
source venv/bin/activate
pip install -r requirements.txt


Run ingestion and landing:
python src/api_connect.py
python src/extract.py
python src/load_to_data_lake.py

Transform + load clean data:
python src/transform_data.py
python src/load_clean_data_to_data_lake.py

This writes:

Raw files → storage/blob/raw2/

Clean files → storage/blob/clean2/

7) Transform & Load with Azure Data Factory (ADF)

ADF consumes the staged data in Blob Storage and performs ETL into Azure PostgreSQL.

In adf/, store exported ADF assets:

pipelines

datasets

linked services

8) Serve Analytics via Azure PostgreSQL

Curated datasets and KPI-ready tables live in PostgreSQL.

Store SQL assets in:

database/postgres/



