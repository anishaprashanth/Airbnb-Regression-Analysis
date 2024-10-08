 # Code for plots and variables
 plot(distance_city, price, xlab = "distance", ylab = "price", ylim=c(0,3500))
 boxplot(price~peak,ylim = c(0,4000), horizontal = TRUE)
 plot(accommodates + bedrooms + bathrooms, price, ylim = c(0,3000), xlab = "capacity")
 hist(host_identity_verified+host_is_superhost+review_scores_communication, xlab = "quality of host")

 # Code for correlation plot
 library(tidyverse)
 library(car)
 library(Ecdat)
 library(corrplot)
 library(RColorBrewer)
 Air <- read_csv('CleandedAirbnb.csv')
 A <- lm(distance_city~number_of_reviews,Air)
 M <-cor(Air)
 corrplot(M, type="upper", order="hclust",
 col=cols)

 # Stepwise plot
 full.lm <- lm(price ~ . , data=input)
 min.lm <- lm(price ~ 1, data=input)
 step_forward = step(min.lm, list(upper=full.lm), direction='forward')

 # VIF
 vif(modelAirbnbR1)
 mean(vif(modelAirbnbR1))

 # Numerical Corr
 library(car)
 cor(input)
 modelAirbnbR2=lm(price~accommodates+bathrooms+distance_city+review_scores_rating+host_identity_verified)
 summary(modelAirbnbR1)

# Residuals
 plot(full_model, resid(modelAirbnbR3), main="y",pch = 16, col = "blue", ylab = bquote(paste("e")))
 abline(0,0, col = "red", lwd=3)
 par(mfrow = c(2,2), mai=c(0.4,0.4,0.4,0.4), out.width = "50%")
 plot(full_model, resid(modelAirbnb1), main="sqrt(y)", pch = 16, col = "blue", ylab = bquote(paste("e")))
 abline(0,0, col = "red", lwd=3)
 plot(full_model, resid(modelAirbnb2), main="yˆ0.25", pch = 16, col = "blue", ylab = bquote(paste("e")))
 abline(0,0, col = "red", lwd=3)
 plot(full_model, resid(modelAirbnb3), main = "ln(y)", pch = 16, col = "blue", ylab = bquote(paste("e")))
 abline(0,0, col = "red", lwd=3)

# NPPS
 par(mfrow = c(2,2), mai=c(0.4,0.4,0.4,0.4), out.width = "50%")
 qqnorm(resid(modelAirbnbR1), pch = 16, main = bquote(y)) #npp 0
 qqline(resid(modelAirbnbR1), col = "red", lwd = 2)
 qqnorm(resid(modelAirbnb1), pch = 16, main = bquote(sqrt(y))) #npp 1
 qqline(resid(modelAirbnb1), col = "red", lwd = 2)
 qqnorm(resid(modelAirbnb2), pch = 16, main = bquote(yˆ(1/4))) #npp 2
 qqline(resid(modelAirbnb2), col = "red", lwd = 2)
 qqnorm(resid(modelAirbnb3), pch = 16, main = bquote(ln(y))) #npp 3
 qqline(resid(modelAirbnb3), col = "red", lwd = 2)

 # transformations
 modelAirbnb1 = lm(sqrt(price) ~full_model, data = input)
 modelAirbnb2 = lm(priceˆ(.25) ~full_model, data = input)
 modelAirbnb3 = lm(log(price) ~full_model, data = input)

# Influential points
 CooksD=cooks.distance(modelAirbnbR3)
 F05=qf(.5,k+1,n-k-1)
 CooksD[CooksD>F05]
