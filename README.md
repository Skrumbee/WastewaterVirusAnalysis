## About This Project

The purpose of this project is to apply data science coursework to a real-world municipal project. The dataset comes from viral sequencing of wastewater in Columbia, Missouri, processed by a Mizzou lab led by Marc Johnson. Data processing was conducted in collaboration with David O’Connor at University of Wisconsin. The goal is to demonstrate an application that supports public health staff with insights on how they can benefit from statistically sound data models.

The objective of this analysis was twofold:

1. **Demonstrate model-building techniques** using real, relevant data as part of a data science curriculum project.
2. **Translate those models into operational insights** relevant to our organization — namely, how sequencing effort (`totalreads`), virus type, and seasonality relate to viral concentration detected in wastewater.

Three regression models were built to compare different approaches:

- A full model including sequencing effort, week number, and virus type
- A quadratic model examining nonlinear seasonal trends
- A practical model incorporating seasonality as a factor for operational use

The intent was not to produce a perfect or production-ready model, but rather to **demonstrate critical thinking and modeling workflow** — from exploratory analysis through to model selection based on interpretability, significance, and explanatory power. The strongest-performing model was chosen not just for its statistics, but for its **alignment with how this data might be used** internally — to inform sequencing strategy by season and virus type.

---

## A Warning On Heteroskedasticity

One known limitation in all three models is the presence of **heteroskedasticity**, evident in the residual plots which display a classic "fan shape." This means that the variance of prediction errors increases at higher fitted values, violating the constant variance assumption of OLS. While this would normally require correction (e.g., transformation, weighted regression, or robust standard errors), this analysis is **fit-for-purpose**:

- It can be used for **internal insight generation**, not scientific publication.
- Its primary goal is to **introduce data science thinking** to internal stakeholders.
- The model results are **directionally useful and interpretable**, even if not statistically pristine.

Future iterations could improve model robustness and apply corrective techniques, but at this stage, transparency about model limitations is sufficient for the intended operational use.

---

## Broader Context

This project also serves as a potential (internal) pair for a **public-facing dashboard**, making virus sequencing data more transparent to the community. It bridges academic work, internal operations, and public communication — and acts as a proof-of-concept for how data science can enhance predictive visibility for municipal public health staff within the city.

## Setup
In your R environment:
```
install.packages(c("RMySQL", "dplyr", "lubridate", "ggplot2"),
                  dependencies = TRUE)
```
The Data:
- A database named 'sensordata' with a table called 'sensordata' is expected
- Data is not provided in this repository. With permission from data owners, a sample .sql script may be added later
- MySQL was used to store the data, the same results can be achieved from a flat file
