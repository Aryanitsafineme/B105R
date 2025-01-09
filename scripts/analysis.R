# Load Required Libraries
library(tidyverse)  # For data manipulation and visualization
library(caret)      # For machine learning workflows
library(ROSE)       # For handling imbalanced datasets
library(corrplot)   # For correlation matrix visualization
library(pROC)       # For ROC curve analysis

# Load the Dataset
# Ensure the correct file path to the dataset provided
file_path <- "data/creditcard.csv"
data <- read.csv(file_path)

# Initial Exploration
# Check the structure and summary of the dataset
str(data)
summary(data)

# Check for missing values
colSums(is.na(data))

# Visualize class distribution
class_distribution <- data %>% 
  group_by(Class) %>% 
  summarise(count = n())

ggplot(class_distribution, aes(x = as.factor(Class), y = count, fill = as.factor(Class))) +
  geom_bar(stat = "identity") +
  labs(title = "Class Distribution", x = "Class (0 = Non-Fraud, 1 = Fraud)", y = "Count") +
  theme_minimal()

# Handle Class Imbalance using ROSE
balanced_data <- ovun.sample(Class ~ ., data = data, method = "over", N = nrow(data))$data

# Check new class distribution
balanced_distribution <- balanced_data %>% 
  group_by(Class) %>% 
  summarise(count = n())

ggplot(balanced_distribution, aes(x = as.factor(Class), y = count, fill = as.factor(Class))) +
  geom_bar(stat = "identity") +
  labs(title = "Balanced Class Distribution", x = "Class (0 = Non-Fraud, 1 = Fraud)", y = "Count") +
  theme_minimal()

# Save the balanced dataset for future use
write.csv(balanced_data, "balanced_creditcard.csv", row.names = FALSE)

# Exploratory Data Analysis (EDA)
# Correlation matrix
numeric_features <- balanced_data %>% select(-Class)
corr_matrix <- cor(numeric_features)

corrplot(corr_matrix, method = "circle", type = "upper", tl.col = "black", tl.srt = 45,
         title = "Correlation Matrix", mar = c(0, 0, 1, 0))

# Visualize key variables
# Scatterplot for V1 vs V2
ggplot(balanced_data, aes(x = V1, y = V2, color = as.factor(Class))) +
  geom_point(alpha = 0.5) +
  labs(title = "Scatter Plot of V1 vs V2", x = "V1", y = "V2", color = "Class") +
  theme_minimal()

# Statistical Testing
# T-test for V1
t_test_result <- t.test(V1 ~ Class, data = balanced_data)
print(t_test_result)

# Model Development
# Split data into training and testing sets
set.seed(123)
train_index <- createDataPartition(balanced_data$Class, p = 0.8, list = FALSE)
train_data <- balanced_data[train_index, ]
test_data <- balanced_data[-train_index, ]

# Logistic Regression Model
log_model <- glm(Class ~ ., data = train_data, family = binomial)
summary(log_model)

# Model Evaluation
# Predict on test data
predictions <- predict(log_model, test_data, type = "response")
predicted_classes <- ifelse(predictions > 0.5, 1, 0)
conf_matrix <- table(Predicted = predicted_classes, Actual = test_data$Class)
print(conf_matrix)

# Calculate accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
cat("Accuracy:", accuracy, "\n")

# ROC Curve
roc_curve <- roc(test_data$Class, predictions)
plot(roc_curve, main = "ROC Curve")
cat("AUC:", auc(roc_curve), "\n")

# Save model performance metrics
cat("Model Accuracy:", accuracy, "\nAUC:", auc(roc_curve), file = "model_performance.txt")

