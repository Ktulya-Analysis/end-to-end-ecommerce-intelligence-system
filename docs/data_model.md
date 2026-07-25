# 📘 Data Model

## Overview

The **E-Commerce Intelligence Platform** adopts a dimensional data modeling approach to transform raw marketplace transactions into business-ready analytical datasets. The model is designed to support scalable reporting, executive dashboards, and business intelligence by organizing operational data into reusable fact tables, dimension tables, and subject-oriented analytics marts.

The warehouse follows a **Star Schema** design, enabling efficient aggregation, simplified querying, and consistent KPI generation across multiple business domains.

---

#  Modeling Approach

The analytical warehouse follows a dimensional modeling methodology where:

- A centralized **Fact Table** stores measurable business events.
- Supporting **Dimension Tables** provide descriptive business context.
- Subject-oriented **Analytics Marts** expose pre-aggregated business metrics optimized for Power BI reporting.

This design reduces query complexity while improving dashboard performance and maintaining consistent business definitions across analytical modules.

---

# Star Schema Overview

```text
                           +------------------------+
                           | analytics_dim_customers|
                           +------------------------+
                                       |
                                       |
                                       |
+------------------------+             |             +-----------------------+
| analytics_dim_products |-------------|-------------| analytics_dim_sellers |
+------------------------+             |             +-----------------------+
                                       |
                                       |
                           +------------------------+
                           | analytics_fact_sales   |
                           +------------------------+
                                       |
                                       |
                           +------------------------+
                           | analytics_dim_date     |
                           +------------------------+

                                        │
                                        ▼

                  +---------------------------------------------+
                  |            Analytics Marts                  |
                  +---------------------------------------------+
                  | analytics_sales_mart                        |
                  | analytics_customer_mart                     |
                  | analytics_product_mart                      |
                  | analytics_seller_mart                       |
                  | analytics_delivery_mart                     |
                  +---------------------------------------------+

                                        │
                                        ▼

                          Power BI Semantic Model & Dashboards
```

---

#  Fact Table

## analytics_fact_sales

### Purpose

Stores transactional sales records that act as the central business fact for analytical reporting.

### Grain

Each record represents a single marketplace sales transaction at the order-item level.

### Primary Business Keys

- Order ID
- Customer ID
- Product ID
- Seller ID
- Purchase Date

### Business Measures

The fact table stores quantitative measures used throughout the analytical platform, including:

- Revenue
- Freight Cost
- Item Value
- Delivery Days
- Delivery Delay

The fact table serves as the primary source for revenue analysis, customer analytics, seller performance, product analytics, and delivery reporting.

---

# Dimension Tables

Dimension tables provide descriptive attributes that enrich analytical reporting and enable slicing business metrics across multiple perspectives.

---

## analytics_dim_customers

### Purpose

Stores customer descriptive information used for customer segmentation and geographical analysis.

### Business Attributes

- Customer ID
- Customer City
- Customer State

---

## analytics_dim_products

### Purpose

Stores descriptive product information for product analytics and catalog reporting.

### Business Attributes

- Product ID
- Product Category
- Product Weight
- Product Length
- Product Height
- Product Width
- Product Name Quality
- Description Quality
- Image Quality

---

## analytics_dim_sellers

### Purpose

Stores seller descriptive information used in marketplace performance analysis.

### Business Attributes

- Seller ID
- Seller City
- Seller State

---

## analytics_dim_date

### Purpose

Provides standardized calendar attributes for time-based reporting.

### Business Attributes

- Purchase Date
- Month
- Quarter
- Year
- Year-Month

---

#  Analytics Marts

The warehouse exposes dedicated analytics marts to simplify reporting and improve dashboard performance. Each mart is designed around a specific business domain.

---

## analytics_sales_mart

### Business Focus

- Revenue Analysis
- Order Performance
- Average Order Value
- Freight Analysis
- Quarterly Revenue Trends

---

## analytics_customer_mart

### Business Focus

- Customer Distribution
- Repeat Customer Analysis
- Customer Lifetime Metrics
- Geographic Customer Analysis

---

## analytics_product_mart

### Business Focus

- Product Category Performance
- Product Revenue
- Order Volume
- Product Distribution
- Product Content Quality

---

## analytics_seller_mart

### Business Focus

- Seller Performance
- Seller Revenue
- Seller Segmentation
- Geographic Seller Distribution

---

## analytics_delivery_mart

### Business Focus

- Shipping Speed Analysis
- Delivery Duration
- Delivery Delay Analysis
- Delivery Performance Monitoring

---

#  Relationships

The analytical warehouse is organized around the **analytics_fact_sales** table.

| Parent Table | Child Table | Relationship |
|--------------|-------------|--------------|
| analytics_dim_customers | analytics_fact_sales | One-to-Many |
| analytics_dim_products | analytics_fact_sales | One-to-Many |
| analytics_dim_sellers | analytics_fact_sales | One-to-Many |
| analytics_dim_date | analytics_fact_sales | One-to-Many |

The analytics marts are generated from the dimensional warehouse and provide subject-oriented datasets optimized for business reporting.

---

#  Design Principles

The data model follows modern Business Intelligence and Analytics Engineering best practices.

### Design Principles

- Dimensional Data Modeling
- Star Schema Architecture
- Layered Data Warehouse Design
- Subject-Oriented Analytics Marts
- Reusable Business Dimensions
- Centralized Business Metrics
- Simplified Analytical Queries
- Optimized Power BI Reporting
- Consistent Business Definitions
- Separation of Transactional and Analytical Data

---

#  Power BI Consumption Model

Power BI connects directly to the **Analytics Layer** of the warehouse through business-oriented analytics marts rather than raw operational tables.

This approach provides several advantages:

- Consistent KPI calculations across dashboards.
- Faster report performance through pre-aggregated datasets.
- Simplified dashboard development with reduced DAX complexity.
- Reusable analytical models across multiple business domains.
- Scalable architecture for future dashboard enhancements.

The resulting semantic model supports the project's six analytical modules:

- Executive Analytics
- Customer Analytics
- Product Analytics
- Seller Analytics
- Delivery Analytics
- Revenue Analytics