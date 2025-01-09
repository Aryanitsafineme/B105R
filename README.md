B105R
This repository contains the implementation and analysis for the Credit Card Fraud Detection Project, which aims to build a statistical model to identify fraudulent credit card transactions. The project follows a systematic approach from data preprocessing and exploration to model development and evaluation.

Credit card fraud detection is a crucial task in financial systems to prevent financial losses and enhance security. According to a report by the Nilson Report, global card fraud losses reached $28.65 billion in 2019 and are projected to exceed $35 billion by 2025. Real-world examples include data breaches like the 2019 Capital One hack, which exposed sensitive customer information, highlighting the importance of robust fraud detection mechanisms in safeguarding both institutions and consumers. This project employs the "Credit Card Fraud Detection" dataset to develop a logistic regression model for identifying fraudulent transactions. Logistic regression was chosen for its simplicity, interpretability, and efficiency in binary classification tasks. Additionally, it provides insight into feature importance, enabling the identification of key predictors of fraud, which aligns well with the project's goal of understanding transaction patterns and detecting anomalies. The dataset exhibits a severe class imbalance, which is addressed during preprocessing.

The dataset used in this project is publicly available on Kaggle and consists of:
Features: 30 anonymized numerical variables (V1, V2, etc.) and a transaction amount.
Target Variable: Class (0 = Non-Fraud, 1 = Fraud)
Records: 284,807 transactions with 492 marked as fraudulent.
Link to dataset: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud?resource=download

Software

R version 4.0 or higher

RStudio (optional, for development environment)

R Packages

The following R libraries are required:
tidyverse
caret
ROSE
corrplot
pROC

Key Results
Accuracy: 94.7%
ROC-AUC: 0.97


To see the code, and all the files and dataset, download the files from dropbox, couldnt be uploaded here due to the file size limit of 100mb.
Content guide:
Scripts: Rstudio script
Data: raw dataset for the creditcard fraud
please do download it to see the whole R project.
The data visualization and the graphs are already here on github. 
https://www.dropbox.com/scl/fo/99sv851do7osm8lhyzfdi/ANiS4Z1NDQ93h7TMsvOLtTQ?rlkey=xyrrd3svgqkdkvm6gl2h60vpy&st=anc9z691&dl=0


References
Nilson Report. (2019). Global Card Fraud Losses. Available at: https://nilsonreport.com/
ULB Machine Learning Group. (2013). Credit Card Fraud Detection Dataset. Available at: https://www.kaggle.com/mlg-ulb/creditcardfraud
Capital One. (2019). Capital One Data Breach. Available at: https://www.capitalone.com/
