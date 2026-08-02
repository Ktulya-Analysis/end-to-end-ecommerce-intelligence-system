# 📊 E-Commerce Intelligence Platform

An end-to-end **Business Intelligence and Analytics Platform** built on the **Olist Brazilian E-Commerce Dataset (100K+ orders)** to transform raw marketplace data into executive-ready business insights through SQL analytics, exploratory data analysis, dimensional modeling, and interactive Power BI dashboards.

The project follows a real-world analytics architecture by implementing a layered PostgreSQL data warehouse (**Raw → Staging → Analytics**), designing business-oriented analytical marts, and developing interactive dashboards for **Executive, Customer, Product, Seller, Delivery, and Revenue Analytics**.

By integrating data engineering, business intelligence, and analytics, the platform enables stakeholders to monitor marketplace performance, evaluate operational efficiency, understand customer and seller behavior, measure revenue performance, and support data-driven strategic decision-making.


# 🔄 End-to-End Project Workflow

The project follows a real-world analytics workflow that mirrors the architecture commonly adopted in modern Business Intelligence teams. Raw marketplace data is progressively transformed into validated analytical datasets before being consumed by executive dashboards and business reports.

```text
                    Olist Brazilian E-Commerce Dataset
                                   │
                                   ▼
                    Exploratory Data Analysis (Python)
                                   │
                                   ▼
                 Data Validation, Cleaning & Transformation
                                   │
                                   ▼
                    PostgreSQL Data Warehouse (Raw Layer)
                                   │
                                   ▼
                         Staging Data Model
                                   │
                                   ▼
                     Analytics Data Warehouse Layer
                                   │
                                   ▼
             Business-Oriented Analytics Marts (Star Schema)
                                   │
                                   ▼
                      Business KPIs & SQL Analytics
                                   │
                                   ▼
                 Interactive Power BI Executive Dashboard
                                   │
                                   ▼
           Business Insights & Strategic Recommendations
```

The workflow separates data ingestion, transformation, analytics modeling, and visualization into independent layers, creating a scalable architecture that supports reliable business reporting and future analytical enhancements.

---
# 🛠️ Tech Stack

| Category | Technologies |
|----------|--------------|
| **Programming Language** | Python |
| **Data Analysis** | Pandas, NumPy |
| **Database** | PostgreSQL |
| **Query Language** | SQL |
| **Business Intelligence** | Power BI |
| **Version Control** | Git, GitHub |
| **Dataset** | Olist E-Commerce Dataset |
| **Architecture** | Layered Data Warehouse (Raw → Staging → Analytics) |
| **Data Modeling** | Fact & Dimension Modeling, Analytics Marts |
| **Analytics** | Exploratory Data Analysis (EDA), Business KPI Development |

# 🎯 Business Problem

E-commerce marketplaces generate vast amounts of transactional data across customers, products, sellers, payments, deliveries, and customer reviews. While this data captures every stage of the customer journey, it is typically distributed across multiple operational tables, making it difficult for business teams to obtain a unified view of marketplace performance.

Without a centralized analytics platform, decision-makers face challenges in monitoring executive KPIs, evaluating seller performance, understanding customer purchasing behavior, identifying high-performing product categories, tracking delivery efficiency, and measuring overall revenue performance. As a result, strategic decisions often rely on fragmented reports rather than integrated business intelligence.

This project addresses these challenges by designing and implementing an end-to-end **E-Commerce Intelligence Platform** that transforms raw marketplace data into business-ready analytical models, interactive dashboards, and actionable insights. By combining SQL-based data warehousing, exploratory data analysis, dimensional modeling, and Power BI reporting, the platform enables stakeholders to monitor business performance, identify operational opportunities, and support data-driven decision-making through a centralized analytics solution.

# 🎯 Business Objectives

The primary objective of this project is to design and implement a scalable business intelligence platform that converts raw e-commerce transaction data into actionable insights for executive and operational decision-making.

The platform focuses on the following business objectives:

- Develop an end-to-end analytics pipeline to transform raw marketplace data into business-ready analytical models.
- Build a centralized PostgreSQL data warehouse using layered data modeling (Raw → Staging → Analytics) to ensure reliable and scalable reporting.
- Monitor executive business performance through key performance indicators including revenue, orders, customers, freight cost, and average order value.
- Analyze customer, product, seller, delivery, and revenue performance through dedicated analytics modules to uncover operational trends and business opportunities.
- Evaluate marketplace performance by identifying high-performing products, sellers, customer segments, and delivery patterns using descriptive analytics.
- Design interactive Power BI dashboards that enable executives and business users to explore insights through drill-through navigation, dynamic filtering, and cross-visual analysis.
- Translate analytical findings into actionable business recommendations that support revenue optimization, operational efficiency, customer experience improvement, and strategic decision-making.


# 📈 Dashboard Preview

The platform includes a **6-page interactive Power BI dashboard** designed to provide executive and operational visibility across key areas of marketplace performance. Each analytics module focuses on a distinct business domain while supporting cross-filtering, drill-through navigation, and KPI-driven decision-making.

## 📊 Dashboard Overview



---

## 📊 Executive Analytics

Executive overview of marketplace performance with high-level business KPIs, revenue trends, product performance, and regional sales distribution.

![Executive Analytics](images/ExecutiveOverview.png)

---

## 👥 Customer Analytics

Customer behavior analysis including customer distribution, repeat customer metrics, customer lifetime analysis, and geographic customer insights.

![Customer Analytics](images/CustomerAnalytics.png)

---

## 📦 Product Analytics

Evaluation of product category performance through revenue contribution, order volume, product distribution, and product content quality.

![Product Analytics](images/productAnalytics.png)

---

## 🏪 Seller Analytics

Marketplace seller performance including seller revenue, seller distribution, seller segmentation, and seller performance comparison.

![Seller Analytics](images/SellerAnalytics.png)

---

## 🚚 Delivery Analytics

Logistics performance analysis covering shipping speed distribution, delivery duration, delivery delays, and operational delivery metrics.

![Delivery Analytics](images/DeliveryAnalytics.png)

---

## 💰 Revenue Analytics

Financial performance monitoring through revenue trends, quarterly contribution, average order value, freight cost analysis, and revenue comparison.

![Revenue Analytics](images/RevenueAnalytics.png)
---

# 📊 Executive Business KPIs

The dashboard consolidates business performance into executive-level Key Performance Indicators (KPIs) that provide a comprehensive overview of marketplace health.

| KPI | Business Purpose |
|------|------------------|
| **Total Revenue** | Measure total marketplace revenue generated from completed orders. |
| **Total Orders** | Track overall order volume across the marketplace. |
| **Total Customers** | Monitor marketplace customer base. |
| **Average Order Value (AOV)** | Evaluate average customer spending per order. |
| **Total Freight Cost** | Measure logistics expenditure associated with deliveries. |
| **Repeat Customers** | Assess customer retention and repeat purchasing behavior. |
| **Average Customer Lifetime** | Understand customer engagement duration. |
| **Total Products** | Monitor marketplace catalog size. |
| **Total Sellers** | Track active marketplace sellers. |
| **Average Delivery Days** | Evaluate overall delivery efficiency. |
| **Average Delivery Delay** | Monitor delivery performance against expected timelines. |
| **Late Delivery Rate** | Measure the proportion of delayed deliveries across the marketplace. |


# 📒 Exploratory Data Analysis

Exploratory Data Analysis (EDA) was performed using **Python, Pandas, and NumPy** to understand the characteristics of the Olist Brazilian E-Commerce dataset before designing the analytics pipeline. The objective was to validate data quality, understand business entities, identify potential analytical opportunities, and support the design of business-oriented data models.

The EDA process included:

- Data understanding and business domain exploration.
- Data quality assessment and missing value analysis.
- Duplicate record validation.
- Distribution analysis of customers, sellers, products, and orders.
- Revenue and order pattern analysis.
- Customer purchasing behavior analysis.
- Product category exploration.
- Delivery performance exploration.
- Business KPI identification for dashboard development.
- Analytical observations used to support SQL modeling and Power BI dashboard design.

📓 **EDA Notebook**

➡️ `notebooks/Ecommerce_EDA.ipynb`

---

# 🗄️ SQL Analytics Pipeline

The project implements a layered SQL analytics architecture that transforms raw transactional data into validated, business-ready analytical datasets. Each layer has a clearly defined responsibility, ensuring scalability, maintainability, and reliable business reporting.

The SQL pipeline consists of the following stages:

### Raw Data Layer
- Raw dataset ingestion
- Source table creation
- Initial data validation

### Staging Layer
- Data cleaning
- Standardization
- Data quality validation
- Relationship validation

### Analytics Layer
- Fact table development
- Dimension table development
- Business-oriented analytics marts
- KPI generation
- Business aggregation queries

### Reporting Layer
- Power BI data model
- Interactive dashboards
- Executive KPIs
- Business reporting

The layered architecture separates data ingestion, transformation, analytics, and reporting, closely following enterprise Business Intelligence development practices.

# 🧱 Data Warehouse Architecture

The project follows a layered PostgreSQL data warehouse architecture that separates data ingestion, transformation, analytics modeling, and reporting into independent components. This design improves data quality, simplifies maintenance, and provides a scalable foundation for business intelligence reporting.

```text
                           Olist Dataset
                                 │
                                 ▼
                          Raw Data Layer
                                 │
                                 ▼
                         Staging Data Layer
                                 │
                                 ▼
                      Analytics Data Warehouse
                                 │
                 ┌───────────────┼────────────────┐
                 │               │                │
                 ▼               ▼                ▼
          Fact Tables     Dimension Tables   Analytics Marts
                 │               │                │
                 └───────────────┼────────────────┘
                                 │
                                 ▼
                         Power BI Semantic Model
                                 │
                                 ▼
                    Executive Business Dashboards
```

### Architecture Components

| Layer | Purpose |
|--------|---------|
| **Raw Layer** | Stores imported source data without business transformations. |
| **Staging Layer** | Cleans, validates, standardizes, and prepares data for analytics. |
| **Analytics Layer** | Builds fact tables, dimension tables, and business-oriented analytical marts. |
| **Semantic Layer** | Provides optimized datasets for Power BI reporting and KPI analysis. |
| **Visualization Layer** | Presents executive dashboards and interactive business reports. |

This architecture follows modern Business Intelligence design principles by separating operational data processing from analytical reporting, improving scalability, maintainability, and reporting performance.

---

# 📊 Analytics Marts

To support domain-specific business analysis, the project organizes analytical datasets into dedicated business marts. Each mart is designed around a specific functional area, enabling focused reporting while maintaining a consistent enterprise data model.

| Analytics Mart | Business Purpose |
|----------------|------------------|
| **Sales Mart** | Revenue analysis, order performance, average order value, and freight cost monitoring. |
| **Customer Mart** | Customer distribution, repeat purchasing behavior, customer lifetime analysis, and geographic customer insights. |
| **Product Mart** | Product category performance, order volume, product distribution, and product content quality analysis. |
| **Seller Mart** | Seller performance, seller segmentation, marketplace contribution, and geographic seller analysis. |
| **Delivery Mart** | Delivery duration, shipping speed analysis, delivery delays, and logistics performance monitoring. |

### Supporting Data Model

The analytics marts are supported by a dimensional data model consisting of:

- Fact Sales
- Customer Dimension
- Product Dimension
- Seller Dimension
- Date Dimension

This business-oriented data model enables efficient aggregation, simplified reporting, and scalable dashboard development while supporting multiple analytical perspectives across the marketplace.


# 💡 Key Business Insights

The integrated analytics platform uncovered several business patterns across customers, products, sellers, revenue, and delivery operations that can support strategic decision-making.

### Executive Performance
- Marketplace revenue is concentrated within a limited number of product categories, highlighting opportunities for category-specific growth strategies.
- Revenue and order volume exhibit noticeable monthly and quarterly variations, indicating seasonal purchasing behavior.

### Customer Analytics
- The marketplace is primarily driven by one-time purchasers, while repeat customers represent a comparatively smaller share of the customer base.
- Customer purchasing activity varies across geographic regions, providing opportunities for targeted regional marketing initiatives.

### Product Analytics
- A small number of product categories contribute a significant proportion of marketplace revenue and order volume.
- Product content quality (images and descriptions) differs across categories, suggesting opportunities to improve catalog completeness and customer experience.

### Seller Analytics
- Seller contribution is uneven across the marketplace, with a relatively small group of sellers generating a large share of total revenue.
- Seller distribution varies geographically, highlighting regional marketplace concentration.

### Delivery Analytics
- Delivery performance differs across shipping speed categories.
- Monitoring delivery duration and late delivery rates can help identify operational inefficiencies within the logistics process.

### Revenue Analytics
- Revenue growth, freight costs, and average order value exhibit different temporal patterns, enabling continuous monitoring of marketplace profitability and operational performance.


# 🚀 Business Recommendations

Based on the analytical findings, the following business strategies are recommended:

- Prioritize investment in high-performing product categories while identifying growth opportunities within underperforming categories.
- Strengthen customer retention initiatives to increase repeat purchasing behavior and improve long-term customer value.
- Improve product catalog quality by encouraging sellers to provide richer product descriptions and higher-quality product images.
- Develop seller performance programs that reward high-performing sellers while supporting lower-performing sellers through marketplace enablement initiatives.
- Continuously monitor delivery performance and late delivery rates to improve customer satisfaction and logistics efficiency.
- Track executive KPIs through interactive Power BI dashboards to support faster and more informed business decision-making.
- Leverage the analytics platform as a centralized decision-support system for monitoring marketplace performance and identifying future business opportunities.

# 📂 Repository Structure

```text
ecommerce-intelligence-system/
│
├── dashboard/
│
├── data/
│   └── raw/
│
├── docs/
│   ├── data_model.md
│   └── metric_definitions.md
│
├── images/
│   ├── dashboard_overview.png
│   ├── executive_analytics.png
│   ├── customer_analytics.png
│   ├── product_analytics.png
│   ├── seller_analytics.png
│   ├── delivery_analytics.png
│   └── revenue_analytics.png
│
├── notebooks/
│   └── Ecommerce_EDA.ipynb
│
├── sql/
│   ├── 01_staging/
│   ├── 02_validation/
│   ├── 03_intermediate/
│   ├── 04_analytics/
│   ├── 05_marts/
│   ├── 06_metrics/
│   ├── 07_quality/
│   └── 08_dashboard/
│
├── src/
│
├── tests/
│
├── .gitignore
├── README.md
└── requirements.txt
```

# 📁 Project Files

| File | Description |
|------|-------------|
| 📓 **EDA Notebook** | Exploratory Data Analysis, data understanding, missing value analysis, and business insights. |
| 🗄️ **SQL Scripts** | Database creation, data validation, staging layer, analytics marts, KPI generation, and business queries. |
| 📊 **Power BI Dashboard** | Interactive multi-page business intelligence dashboard with executive and operational analytics. |
| 📑 **Presentation** | Business presentation summarizing project objectives, architecture, analytics, insights, and recommendations. |
| 📚 **Documentation** | Data model, architecture, data dictionary, and project documentation. |

---

# 🔮 Future Improvements

The current implementation establishes a scalable analytics foundation that can be extended with additional Business Intelligence capabilities.

Potential future enhancements include:

- Deploy dashboards using **Power BI Service** for enterprise reporting.
- Implement Row-Level Security (RLS) to support role-based dashboard access.
- Expand the analytics model with additional business marts and KPIs.
- Automate data ingestion and refresh workflows for continuous reporting.
- Integrate predictive analytics models to support demand forecasting and marketplace optimization.

---

# 🎯 Business Impact

This project demonstrates how modern Business Intelligence and analytics can transform raw marketplace data into actionable business insights by:

- Establishing a scalable end-to-end analytics platform using PostgreSQL, SQL, Python, and Power BI.
- Providing executives with centralized KPI monitoring across revenue, customers, products, sellers, and delivery operations.
- Supporting data-driven decision-making through interactive dashboards and business-oriented analytics marts.
- Improving business visibility by consolidating operational data into a unified analytical model.
- Enabling continuous monitoring of marketplace performance, customer behavior, operational efficiency, and revenue trends.
- Demonstrating enterprise-style data warehousing, analytics engineering, and dashboard development practices applicable to real-world business environments.

---

# 👨‍💻 Author

**Kanishka Tulya**

**Data Analytics | Business Intelligence | SQL | PostgreSQL | Python | Power BI**

If you found this project interesting or useful, consider giving the repository a ⭐.
