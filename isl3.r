# the p-value is the probability that random chance generated
# (1) the data
# (2) something else that is equal [to (1) the data]
# (3) or rarer [data, i.e., less probable data]
# - StatQuest with Josh Starmer; [enumeration & additions in sq.brackets by me]
#
# if p-value < 0.05 then
#   there is at least 95% confidence that
#     the occurrence of the data isn't by random chance
#   if the occurrence of the data is against some hypothesis Hₒ then
#     the occurrence of the data is sufficient evidence to REJECT Hₒ
# if p-value >= 0.05 then
#   there is at most 95% confidence that
#     the occurrence of the data can be explained by random chance
#   if the occurrence of the data is against some hypothesis Hₒ then
#     the occurrence of the data is INSUFFICIENT evidence to reject Hₒ, or
#                                                         "we FAIL TO REJECT Hₒ"

# (1) find LOWEST training MSE and test MSE
# MSE - average distance of prediction from actual

# (2) find LOWEST RSS
# RSS - residual sum of squares
# sum of distances of prediction from actual
# basically MSE * n
# derivations:
#   MSE ← RSS → RSE
#             → R²
#             → F-statistic

################################################################################

# 3 Linear Regression, p.59

adv <- read.csv("Advertising.csv")

# 3.1 Simple Linear Regression, p.61

fit <- lm(sales ~ TV, data = adv) # equation 3.1/3.2 in p.61
##                                        ꞈ
hat_beta_0 <- coef(fit)["(Intercept)"]  # β₀ in p.62
hat_beta_0
##                                        ꞈ
hat_beta_1 <- coef(fit)["TV"]           # β₁ in p.62
hat_beta_1

plot(residuals(fit))
mean(residuals(fit)) # this is practically zero

confint(fit, level = 0.95) # confidence intervals in p.67

################################################################################

# CONFIDENCE INTERVAL VERIFICATION: ADVERTISING

adv <- read.csv("Advertising.csv")

fit <- lm(sales ~ TV, data = adv)
fit_summary <- summary(fit)
fit_summary

std_err1 <- fit_summary$coefficients["(Intercept)", "Std. Error"]
std_err1

tval0 <- fit_summary$coefficients["(Intercept)", "t value"]
tval0

confint(fit)

lower <- confint(fit)["(Intercept)", "2.5 %"] # lower c.i. of intercept
upper <- confint(fit)["(Intercept)", "97.5 %"] # upper c.i. of intercept

#                                                      ꞈ       ꞈ    ꞈ       ꞈ
dist4 <- upper - lower # assuming 4 standard errors = [β₀-2·SE(β₀), β₀+2·SE(β₀)]
std_err2 <- dist4 / 4
std_err2 # should be equal to std_err1

conf_factor <- (dist4 / std_err1) / 2
conf_factor # should be 2

################################################################################

# CONFIDENCE INTERVAL VERIFICATION: MASS::BOSTON

library(MASS)
fit <- lm(medv ~ lstat, data = Boston)

fit_summary <- summary(fit)
fit_summary

std_err1 <- fit_summary$coefficients["(Intercept)", "Std. Error"]
std_err1

tval0 <- fit_summary$coefficients["(Intercept)", "t value"]
tval0

confint(fit)

lower <- confint(fit)["(Intercept)", "2.5 %"] # lower c.i. of intercept
upper <- confint(fit)["(Intercept)", "97.5 %"] # upper c.i. of intercept

#                                                      ꞈ       ꞈ    ꞈ       ꞈ
dist4 <- upper - lower # assuming 4 standard errors = [β₀-2·SE(β₀), β₀+2·SE(β₀)]
std_err2 <- dist4 / 4
std_err2 # should be equal to std_err1

conf_factor <- (dist4 / std_err1) / 2
conf_factor # should be 2

################################################################################

fit <- lm(sales ~ TV, data = adv)
fit_summary <- summary(fit)
coef(fit_summary) # table 3.1 in p.68

# (3) find LOWEST RSE
# RSE - Residual Standard Error
# derived from RSS as numerator, ↓RSS ≈ ↓RSE
# // considered a measure of the lack of ﬁt of the model //
# // measured in the units of Y,
#   it is not always clear what constitutes a good RSE //
# measure of fitness, lower value is more fit

fit_summary$sigma # RSE in p.69
fit_summary$r.squared # R² in p.69
fit_summary$fstatistic["value"] # F-statistic in p.69

# // the mean value of sales over all markets is approximately 14,000 units //
#   in p. 81
mean(adv$sales)
# 14.0225    (in thousand units)

# // so the percentage error is 3,260/14,000 = 23% //
#   in p. 81
fit_summary$sigma / mean(adv$sales)
# 0.2323877    (in *100%)

# (4) find HIGHEST R²
# R² -  (upper bound 1)
# // always takes on a value between 0 and 1,
#   and is independent of the scale of Y //
# // measures the proportion of variability in Y
#   that can be explained using X //
# measure of fitness, higher value is more fit

# % of variability in Y is explained by variabilty in Xᵢ
fit_summary$r.squared

################################################################################

# 3.2 Multiple Linear Regression, p.71

adv <- read.csv("Advertising.csv")

fit <- lm(sales ~ TV, data = adv)
fit_summary <- summary(fit)
fit_summary$coefficients

fit <- lm(sales ~ radio, data = adv)
fit_summary <- summary(fit)
fit_summary$coefficients # ratio section, table 3.3 in p.74

fit <- lm(sales ~ newspaper, data = adv)
fit_summary <- summary(fit)
fit_summary$coefficients # newspaper section, table 3.3 in p.74

fit <- lm(sales ~ TV + radio + newspaper, data = adv) # eqn 3.20/3.21 in p.72
fit_summary <- summary(fit)

# (5) find predictors with NEAR-ZERO coefficient ("estimate")
# (6) find predictors with >0.05 p-value,
#       check if removable (compare correlations (see 7))
# do these when additive(?)

fit_summary$coefficients # table 3.4 in p.74
# note that p-value for newspaper is 0.86 (>0.05)

# (7) find predictors with HIGH correlation
# see if they can be removed, check p-values in (5)/(6)

# the call below assumes a linear (at most first-degree term) correlation
fit_corr <- cor(adv[, c("TV", "radio", "newspaper", "sales")])
str(fit_corr)
# table in 3.5 in p.75

fit_summary$sigma # RSE in p.76, lower compared to {sales ~ TV}
fit_summary$r.squared # R^2 in p.76, hihgher compared to {sales ~ TV}

# (8) find HIGHEST F-statistic
# F-statistic - signifies relationship between predictors and response
# if Hₒ is TRUE (predictors ↛  response) then F-statistic is NEAR ONE
# if Hₐ is TRUE (predictors →  response) then F-statistic is GREATER THAN ONE
fit_summary$fstatistic["value"] # F-statistic in p.76

# (9) find HIGHEST F-statistic where p-value < alpha (?)
# p-value for F-statistic
pf( fit_summary$fstatistic["value"],
    fit_summary$fstatistic["numdf"],
    fit_summary$fstatistic["dendf"],
    lower.tail = FALSE)

# WHY F-statistic when p-values are already given in (5)/(6):
#   When p (num of preds) is large but not (p > n), there will be p-values that
#     are less than alpha without any true association between
#     preds and response

# (10) DO NOT USE F-statistic when p > n

# (11) DO NOT USE multiple linear regression model
#   using least squares when p > n

# (12) find HIGHEST (?) Adjusted R²
fit_summary$adj.r.squared

# (13) remove potential pred where improvement to R² is LOW

fit <- lm(sales ~ TV + radio + newspaper, data = adv)
fit_summary <- summary(fit)
rsq3 <- fit_summary$r.squared # R² for all preds in p.79

fit <- lm(sales ~ TV + radio, data = adv)
fit_summary <- summary(fit)
rsq2 <- fit_summary$r.squared # R² for TV + radio in p.79

rsq3 - rsq2 # little improvement from rsq2 to rsq3

fit <- lm(sales ~ TV, data = adv)
fit_summary <- summary(fit)
rsq1 <- fit_summary$r.squared # R² for TV only in p.80

rsq2 - rsq1 # significant improvement from rsq1 to rsq2

# "improvement" here is used loosely

################################################################################

# GRAPHING 3D: FIGURE 3.5, p.81

fit <- lm(sales ~ TV + radio, data = adv)

library(rgl)

open3d()
plot3d(adv$TV, adv$radio, adv$sales, type = "s", col = "red", size = 1)

coefs <- coef(fit)
aa <- coefs["TV"]
bb <- coefs["radio"]
cc <- -1                    # doesn't work with 0 or 1   ┐(￣ヘ￣)┌
dd <- coefs["(Intercept)"]
planes3d(aa, bb, cc, dd, alpha = 0.5)

# the image in the window CAN BE ROTATED

################################################################################

# Confidence and prediction intervals, p.82

fit <- lm(sales ~ TV + radio, data = adv)
summary(fit)

newdata <- data.frame(TV = 100, radio = 20) # the data is in thousands

predict(fit, newdata, interval = "confidence") # matches [10,985, 11,528]

predict(fit, newdata, interval = "prediction") # matches [7,930, 14,580]

################################################################################

# 3.3 Other Considerations in the Regression Model
# 3.3.1 Qualitative Predictors

credit <- read.csv("Credit.csv")
str(credit)

# figure 3.6 in p.83
pairs(
    ~ Balance + Age + Cards + Education + Income + Limit + Rating,
    data = credit)

fit <- lm(Balance ~ Gender, data = credit)
fit_summary <- summary(fit)
fit$coefficients # gender[Male] might be used instead

# fulfillment of eqn 3.26 in p.84
gender_female <- ifelse(credit$Gender == "Female", 1, 0)
fit <- lm(Balance ~ gender_female, data = credit)
fit_summary <- summary(fit)
fit$coefficients # matches values in table 3.7 in p.84

fit <- lm(Balance ~ Ethnicity, data = credit)
fit_summary <- summary(fit)
fit$coefficients # matches values in table 3.8 in p.86

# p-value for the F-test in p.86
pf( fit_summary$fstatistic["value"],
    fit_summary$fstatistic["numdf"],
    fit_summary$fstatistic["dendf"],
    lower.tail = FALSE)

# 3.3.2 Extensions of the Linear Model

# (14) variable selection: INCLUDE components of interaction terms even if
#     p-values for these are not significant
# this is the "hierarchical principle"
# seems automatic when "*"" in "response ~ pred1 * pred2" is used

fit <- lm(sales ~ TV * radio, data = adv) # eqn 3.31 in p. 87
fit_summary <- summary(fit)
fit$coefficients # table 3.9 in p.88

fit2 <- lm(sales ~ TV : radio, data = adv)
fit2_summary <- summary(fit2) #

fit_summary$r.squared - fit2_summary$r.squared # fit > fit2
# without the interaction terms, R² is worse

fit <- lm(Balance ~ Income * Student, data = credit) # eqn 3.35 in p.90
fit_summary <- summary(fit)

################################################################################

# Non-linear Relationships

auto <- read.csv("Auto.csv", na.strings = "?")
auto <- na.omit(auto)
str(auto)

attach(auto)

plot(horsepower, mpg, col = "gray70") # scatterplot in figure 3.8 in p.91

fit1 <- lm(mpg ~ horsepower)
linear <- function(x) {                      # I don't know how to make a
    (fit1$coefficients["horsepower"]) * x +  #   function out of an lm object
    fit1$coefficients["(Intercept)"]
}
# "Linear" in figure 3.8 in p.91
curve(linear, add = TRUE, lwd = 2, col = "orange")

fit2 <- lm(mpg ~ horsepower + I(horsepower ^ 2))
fit2_summary <- summary(fit2) # matches table 3.10 in p.92
degree2 <- function(x) {
    (fit2$coefficients["I(horsepower^2)"]) * (x ^ 2) +
    (fit2$coefficients["horsepower"]) * x +
    fit2$coefficients["(Intercept)"]
}
# "Degree 2" in figure 3.8 in p.91
curve(degree2, add = TRUE, lwd = 2, col = "skyblue")

fit2p <- lm(mpg ~ poly(horsepower, 2)) # this seemed to have a different result
fit2p_summary <- summary(fit2p) # does NOT match table 3.10 in p.92
# we won't use fit2p in place of fit2

#fit5 <- lm(mpg ~ horsepower + I(horsepower ^ 2) + I(horsepower ^ 3)
#                    + I(horsepower ^ 4) + I(horsepower ^ 5))
fit5 <- lm(mpg ~ poly(horsepower, 5, raw = TRUE)) # "raw = TRUE" is needed
fit5_summary <- summary(fit5)
degree5 <- function(x) {
    y <- 0.0
    for (degree in 1:5) {
        y <- y + fit5$coefficients[degree + 1] * (x ^ degree)
                               # [1] is intercept
    }
    y <- y + fit5$coefficients[1]
    y <- unname(y)
    y
}
# "Degree 5" in figure 3.8 in p.91
curve(degree5, add = TRUE, lwd = 2, col = "seagreen")

detach(auto)

################################################################################

# 3.3.3 Potential Problems

# 1. Non-linearity of the Data

# (15) Check for linearity:
#     residual plot trend is flatter for non linear if model is nonlinear
# // If the residual plot indicates that there are non-linear associations in
#       the data, then a simple approach is to use non-linear transformations
#       of the predictors, such as logX, √X, andX2, in the regression model //

auto <- read.csv("Auto.csv", na.strings = "?")
auto <- na.omit(auto)

par(mfrow = c(1, 2))

# residual plot for linear fit in figure 3.9 in p.93
fit1 <- lm(mpg ~ horsepower, data = auto)
plot(fit1$fitted.values, fit1$residuals, main = "Residual plot for linear fit")
redline <- smooth.spline(fit1$fitted.values, fit1$residuals, spar = 0.95)
lines(redline, col = "red", lwd = 2) # close enough

# residual plot for quadratic fit in figure 3.9 in p.93
fit2 <- lm(mpg ~ poly(horsepower, 5, raw = TRUE), data = auto)
plot(fit2$fitted.values, fit2$residuals, main = "Residual plot for quad fit")
redline <- smooth.spline(fit2$fitted.values, fit2$residuals, spar = 0.95)
lines(redline, col = "red", lwd = 2) # close enough

# 2. Correlation of Error Terms

# (16) Remove error term correlation:
# Checking:
#   For time series data:
#       plot residual over time, see if there is "tracking"
#               - adjacent points have similar values
#   For non- time series data:
#       ???                       ლ(ಠ_ಠ ლ)

# NO DATA, NO CODE    for figure 3.10

# 3. Non-constant Variance of Error Terms

# (17) Remove heteroscedasticity
# Heteroscedasticity - non constance variance of error term
#   Plot residuals vs fitted values
#       "funnel" pattern = heteroscedasticity
# To remove, use concave functions on Y such as log(Y) or sqrt(Y)

# NO DATA, NO CODE    for figure 3.11

# TODO finish isl3.11.r

# 4. Outliers

# (18) Remove outliers
# Outliers - unusual value for response (Y)
# Checking: (this is currently an eyeball method)
#   Plot residuals vs fitted values,    or
#   Plot studentized residuals vs fitted values (see code below for sample)
# Removing the outlier may result in better RSE (but worse R²)

fit1 <- lm(mpg ~ horsepower, data = auto)
residuals_stdz <- rstudent(fit1)
points(fit1$fitted.values, residuals_stdz)

# 5. High leverage points
# - unusual value for predictor (X)

# see plot(hatvalues(fit)) in p.113

# TODO this needs another pass

# 6. Collinearity

# multicollinearity - collinearity across >2 predictors
#   this might not be obvious in correlation matrix, use VIF instead

# see vif(fit) in p.114

# TODO this needs another pass

################################################################################

# ISLR Lab

library(MASS)
library(ISLR)

"fix(Boston)"
names(Boston)

# SIMPLE LR #

fit <- lm(medv ~ lstat, data = Boston) # linear model, predict medv with lstat
fit
class(fit) # fit is an 'lm' object
summary(fit)
names(fit)
coef(fit)
confint(fit)
predict(fit, data.frame(lstat = c(5, 10, 15)), interval = "confidence")
predict(fit, data.frame(lstat = c(5, 10, 15)), interval = "prediction")

attach(Boston)
plot(lstat, medv)
# abline(a,b) to plot a line with intercept a and slope b
abline(fit) # can accept an 'lm' object
abline(fit, lwd = 3) # lwd = line width
abline(fit, lwd = 3, col = "red")
plot(lstat, medv, col = "red")
plot(lstat, medv, pch = 20) # pch = plot character, see this param in ?points
plot(lstat, medv, pch = "+")
plot(1:25, 1:25, pch = 1:25)

par(mfrow = c(2, 2))
plot(fit)

plot(predict(fit), residuals(fit))
plot(predict(fit), rstudent(fit))
plot(hatvalues(fit))
which.max(hatvalues(fit))

# MULTIPLE LR #

fit <- lm(medv ∼ lstat + age, data = Boston) # predict medv with lstat and age
summary(fit)

fit <- lm(medv ∼ ., data = Boston) # predict medv with all variables except medv
summary(fit)

car::vif(fit) # variance inflation factors

fit1 <- lm(medv ∼ . - age, data = Boston) # medv = all except age
# fit1 = update(fit, ~ . - age) is an alternative

fit <- lm(medv ∼ lstat * age) # the same as medv ~ lstat + age + lstat:age
# lstat:age is the interaction term
summary(fit)

# NONLINEAR (?) #

fit2 <- lm(medv ∼ lstat + I(lstat ^ 2)) # I() function to make "AsIs"
summary(fit2)

fit <- lm(medv ∼ lstat)
anova(fit, fit2)

par(mfrow = c(2, 2))
plot(fit)
plot(fit2)

fit5 <- lm(medv ∼ poly(lstat, 5)) # fifth-order polynomial fit
summary(fit5)

summary(lm(medv∼log(rm), data = Boston)) # log transformation

# QUALITATIVE PREDICTORS #

"fix(Carseats)"
names(Carseats)

fit <- lm(Sales ∼ . + Income:Advertising + Price:Age, data = Carseats)
summary(fit)

contrasts(Carseats$ShelveLoc) # coding R uses for dummy variables

# WRITING FUNCTIONS #

myvar <- function() {
    "last value is return value"
}

myvar()

###############################################################################

# ISLR exercises, applied

# 8.a.
auto <- read.csv("Auto.csv", na.strings = "?")
auto <- na.omit(auto)

fit <- lm(mpg ~ horsepower, data = auto)
summary(fit)
## Residuals:
##      Min       1Q   Median       3Q      Max
## -13.5710  -3.2592  -0.3435   2.7630  16.9240
##
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept) 39.935861   0.717499   55.66   <2e-16 ***
## horsepower  -0.157845   0.006446  -24.49   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 4.906 on 390 degrees of freedom
## Multiple R-squared:  0.6059,    Adjusted R-squared:  0.6049
## F-statistic: 599.7 on 1 and 390 DF,  p-value: < 2.2e-16

# i. Is there a relationship between the predictor and the response?
# YES

# ii. How strong is the relationship between the predictor and the response?
# strong enough, as indicated by a very low p-value

# iii. Is the relationship between the predictor and the response positive or
#   negative?
# NEGATVE

# iv. What is the predicted mpg associated with a horsepower of 98?
#  What are the associated 95% conﬁdence and prediction intervals?
newdata <- data.frame("horsepower" = 98)
predict(fit, newdata)
## 24.46708
predict(fit, newdata, interval = "confidence")
##        fit      lwr      upr
## 1 24.46708 23.97308 24.96108
predict(fit, newdata, interval = "prediction")
##        fit     lwr      upr
## 1 24.46708 14.8094 34.12476

# 8.b.
plot(auto$horsepower, auto$mpg)
abline(fit)

# 8.c.
par(mfrow = c(2, 2))
plot(fit)
# ???        ╮(￣ω￣;)╭

# 9.a
auto <- read.csv("Auto.csv", na.strings = "?")
auto <- na.omit(auto)
pairs(auto)

# 9.b
cormat <- cor(auto[, names(auto) != "name"])
fix(cormat)

# 9.c
fit <- lm(mpg ~ . - name, data = auto)
summary(fit)
# i. Is there a relationship between the predictors and the response?
# YES, given the significant p-value of the F-statistic

# ii. Which predictors appear to have a statistically signiﬁcant relationship 
#   to the response?
# displacement, weight, year and origin

# iii. What does the coeﬃcient for the year variable suggest? 
# every year, MPG increases by 0.75

# 9.d
par(mfrow = c(2, 2))
plot(fit)
# Do the residual plots suggest any unusually large outliers
# YES
# Does the leverage plot identify any observations with unusually high 
#   leverage?
# YES

# 9.e
fit1 <- lm(mpg ~ cylinders * displacement * horsepower * weight * acceleration *
            year * origin, data = auto)
fit1_summary <- summary(fit1)
# if all quantitative data is included, no term is significant,
#   even F-statistic p-value is significant

fit2 <- lm(mpg ~ cylinders * displacement, data = auto)
fit2_summary <- summary(fit2)

fit3 <- lm(mpg ~ cylinders : displacement, data = auto) # note the ":"
fit3_summary <- summary(fit3)

fit4 <- lm(mpg ~ cylinders * displacement * acceleration, data = auto)
fit4_summary <- summary(fit4)

fit5 <- lm(mpg ~ cylinders : displacement : acceleration, data = auto)
fit5_summary <- summary(fit5) # best F-statistic (out of fit1-fit5)

# cylinders:displacement:acceleration

# 9.f

fit6 <- lm(log(mpg) ~ cylinders * displacement, data = auto)
fit6_summary <- summary(fit6)

fit7 <- lm(log(mpg) ~ cylinders : displacement, data = auto)
fit7_summary <- summary(fit7) # best F-statistic (out of fit1-fit11)

fit8 <- lm(sqrt(mpg) ~ cylinders * displacement, data = auto)
fit8_summary <- summary(fit8)

fit9 <- lm(sqrt(mpg) ~ cylinders : displacement, data = auto)
fit9_summary <- summary(fit9)

fit10 <- lm(sqrt(mpg) ~ cylinders * displacement * acceleration, data = auto)
fit10_summary <- summary(fit10)

fit11 <- lm(sqrt(mpg) ~ cylinders : displacement : acceleration, data = auto)
fit11_summary <- summary(fit11)

# 10

carseats <- ISLR::Carseats
str(carseats)

# 10.a

fit1 <- lm(Sales ~ Price + Urban + US, data = carseats)
fit1_summary <- summary(fit1)
## Residuals:
##     Min      1Q  Median      3Q     Max
## -6.9206 -1.6220 -0.0564  1.5786  7.0581
##
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept) 13.043469   0.651012  20.036  < 2e-16 ***
## Price       -0.054459   0.005242 -10.389  < 2e-16 ***
## UrbanYes    -0.021916   0.271650  -0.081    0.936
## USYes        1.200573   0.259042   4.635 4.86e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 2.472 on 396 degrees of freedom
## Multiple R-squared:  0.2393,    Adjusted R-squared:  0.2335
## F-statistic: 41.52 on 3 and 396 DF,  p-value: < 2.2e-16

# 10.b
# ???

# 10.c
# Sales = 13.043469 + (-0.054459)*Price + 
#           (-0.021916)*UrbanYes + (1.200573)*USYes

# 10.d
# UrbanYes

# 10.e
fit2 <- lm(Sales ~ Price + US, data = carseats)
fit2_summary <- summary(fit2) # improved fit
## Residuals:
##     Min      1Q  Median      3Q     Max
## -6.9269 -1.6286 -0.0574  1.5766  7.0515
##
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept) 13.03079    0.63098  20.652  < 2e-16 ***
## Price       -0.05448    0.00523 -10.416  < 2e-16 ***
## USYes        1.19964    0.25846   4.641 4.71e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 2.469 on 397 degrees of freedom
## Multiple R-squared:  0.2393,    Adjusted R-squared:  0.2354
## F-statistic: 62.43 on 2 and 397 DF,  p-value: < 2.2e-16

# 10.f
# ???

# 10.g
confint(fit2)

# 10.h
par(mfrow = c(2, 2))
plot(fit2)
# there seems to be no outliers, based on residual plot
# there seems to be high leverage points, based on residuals vs leverage plot
plot(carseats$US, carseats$Price)
# there are outliers on the predictors based on box plot
# ???

# 11
set.seed(1)
x <- rnorm(100)
y <- 2 * x + rnorm(100)

# 11.a
fit1 <- lm(y ~ x + 0)
fit1_summary <- summary(fit1)
coef(fit1) # coefficient estimate βˆ
fit1_summary$coefficients["x", "Std. Error"] # the standard error
fit1_summary$coefficients["x", "t value"] # the t-statistic 
fit1_summary$coefficients["x", "Pr(>|t|)"] # p-value

# 11.b
fit2 <- lm(x ~ y + 0)
fit2_summary <- summary(fit2)
coef(fit2) # coefficient estimate βˆ
fit2_summary$coefficients["y", "Std. Error"] # the standard error
fit2_summary$coefficients["y", "t value"] # the t-statistic 
fit2_summary$coefficients["y", "Pr(>|t|)"] # p-value
# ???

# 11.c
# coefs and stderr are different, but t-stat and p-value are same

# 11.d
# ???

# 11.e
# ???

# 11.f
# ???
d <- fit1_summary$coefficients["x", "t value"] - 
        fit2_summary$coefficients["y", "t value"]
d # -7.105427e-15    a very small number near zero

