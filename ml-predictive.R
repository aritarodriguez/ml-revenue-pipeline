# CARGA DE LIBRERÍAS ---------------------------------------------------
library(readxl)
library(dplyr)
library(ggplot2)
library(caret)
library(corrplot)
library(rpart)
library(randomForest)

data <- read_excel("C:/Users/User/Desktop/Certificado Data Science/Excel data sets/intro_ml_predictive_big.xlsx")
str(data)

# EXPLORACIÓN DE DATOS ---------------------------------------------------
summary(data)

# Gráfico de ventas por categoría

ggplot(data, aes(x = category, y = sales_next_month)) +
  geom_boxplot(fill = "#69b3a2") +
  labs(title = "Distribución de ventas por categoría", x = "Categoría", y = "Ventas")

# Correlaciones numéricas
numeric_vars <- data %>% select(price_usd, ad_spend_usd, customer_rating, in_stock_days, promo_count, sales_next_month)
corrplot(cor(numeric_vars), method = "color", addCoef.col = "black")

# TRANSFORMACIÓN DE CATEGÓRICAS ------------------------------------------
data$category <- as.factor(data$category)
data$product_id <- as.factor(data$product_id)


# SPLIT TRAIN / TEST -----------------------------------------------------
set.seed(123)
splitIndex <- createDataPartition(data$sales_next_month, p = 0.8, list = FALSE)
train <- data[splitIndex, ]
test <- data[-splitIndex, ]

# MODELO 1: REGRESIÓN LINEAL MÚLTIPLE ------------------------------------
model_lm <- lm(sales_next_month ~ price_usd + ad_spend_usd + customer_rating +
                 in_stock_days + promo_count, data = train)
summary(model_lm)
pred_lm <- predict(model_lm, newdata = test)
postResample(pred_lm, test$sales_next_month)

# MODELO 2: ÁRBOL DE DECISIÓN --------------------------------------------

model_tree <- rpart(sales_next_month ~ price_usd + ad_spend_usd + customer_rating +
                      in_stock_days + promo_count, data = train)

plot(model_tree); text(model_tree)
pred_tree <- predict(model_tree, newdata = test)
postResample(pred_tree, test$sales_next_month)

# MODELO 3: RANDOM FOREST ------------------------------------------------
model_rf <- randomForest(sales_next_month ~ price_usd + ad_spend_usd + customer_rating +
                           in_stock_days + promo_count, data = train, ntree = 100, importance = TRUE)
pred_rf <- predict(model_rf, newdata = test)
postResample(pred_rf, test$sales_next_month)

varImpPlot(model_rf)
