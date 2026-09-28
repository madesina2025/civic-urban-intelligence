# Urban Intelligence (CivicPulse) – City Service Analytics Pipeline

**Urban Cities Live Intelligence and Reporting**

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Problem Statement](#problem-statement)  
3. [Solution Summary](#solution-summary)  
4. [High-Level Architecture](#high-level-architecture)  
5. [Architecture Diagram](#architecture-diagram)  
6. [Data Pipeline Logic](#data-pipeline-logic)  
7. [Project Structure](#project-structure)  
8. [Prerequisites](#prerequisites)  
9. [How to Run Locally](#how-to-run-locally)  
10. [Access Services](#access-services)  
11. [Outputs](#outputs)  
12. [Roadmap & Enhancements](#roadmap--enhancements)

---

## Project Overview

**Urban Intelligence (CivicPulse)** is an end-to-end cloud data pipeline built to deliver reliable, transparent, and explainable city-service performance metrics.

The platform ingests public **NYC 311 non-emergency service request data** and transforms it into near real-time operational intelligence for city agencies, field operations, and leadership.

**End-to-end flow:**

API → Airflow → Azure Blob Storage → Azure Data Factory → Azure PostgreSQL → Power BI

Strong data-quality checks, lineage, and clearly defined KPIs ensure that insights are accurate, auditable, and trusted.  
The final Power BI dashboards provide timely visibility into service trends and operational performance, supporting fair and data-driven decision-making with a resident-first focus.

---

## Problem Statement

City agencies face increasing demand for **live, explainable, and trustworthy insights** into non-emergency service delivery.

Key challenges include:

- Fragmented and delayed reporting from raw 311 datasets  
- Limited visibility into backlog, SLA compliance, and service equity  
- Data latency during peak events (storms, holidays, major incidents)  
- Lack of automated monitoring, validation, and lineage  

Without a robust analytics pipeline, operational decisions become slower, riskier, and harder to justify.

---

## Solution Summary

CivicPulse addresses these challenges by delivering:

- Scalable, near real-time ingestion from the NYC 311 API  
- Automated orchestration, retries, and SLAs using Apache Airflow  
- Cloud-native landing and transformation on Azure  
- Typed, curated analytics tables in Azure PostgreSQL  
- Self-service Power BI dashboards for operations and leadership  

The solution prioritises **data trust, transparency, and operational usability**.

---

## High-Level Architecture

The pipeline follows a modern **API → Lake → Warehouse → Analytics** pattern.

- **Apache Airflow** orchestrates ingestion, retries, and monitoring  
- **Azure Blob Storage** serves as the raw and clean landing zone  
- **Azure Data Factory (ADF)** handles managed transformations  
- **Azure PostgreSQL** stores curated analytics-ready datasets  
- **Power BI** provides operational dashboards and KPIs  
- **Terraform (IaC)** provisions and manages Azure infrastructure  

---

## Architecture Diagram

docs/images/architecture.png




