## ----setup , include=FALSE---------------------------------------------------------------
require(knitr)
knitr::opts_chunk$set(echo = TRUE)
r <- getOption("repos")
r["CRAN"] <- "https://ftp.osuosl.org/pub/cran/"
options(repos = r)


## ---- include = FALSE--------------------------------------------------------------------
#function to install and load required packages
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

#load or install these packages:
packages <- c("ggplot2","lattice", "tidyverse", "effects")

#run function to install packages
ipak(packages)


## ----------------------------------------------------------------------------------------
wolfused <-read.csv(here::here("Data","wolfused.csv"), header = TRUE)
wolfavail <-read.csv(here::here("Data","wolfavail.csv"), header = TRUE)
wolfkde <- rbind(wolfused, wolfavail)
str(wolfkde)
table(wolfkde$used, wolfkde$pack)
table(wolfkde$used, wolfkde$deer_w2)

## next we will create a new variable called usedFactor and graphically compare USED and AVAIL locations for prey
wolfkde$usedFactor <- factor(wolfkde$used, labels=c('0','1'))
str(wolfkde)


## ----------------------------------------------------------------------------------------
par(mfrow = c(2,3))
boxplot(deer_w2~usedFactor, data=wolfkde, main = "Deer", xlab="usedFactor", ylab="deer")
boxplot(elk_w2~usedFactor, main = "Elk", ylab="elk_w2", xlab="usedFactor", data=wolfkde)
boxplot(moose_w2~usedFactor, main = "Moose", ylab="moose_w2", xlab="usedFactor", data=wolfkde)
boxplot(goat_w2~usedFactor, main = "Goat", ylab="goat_w2", xlab="usedFactor", data=wolfkde)
boxplot(sheep_w2~usedFactor, main = "Sheep", ylab="sheep_w2", xlab="usedFactor", data=wolfkde)


## ----------------------------------------------------------------------------------------
par(mfrow = c(1,3))
boxplot(Elevation2~usedFactor, data=wolfkde, main = "Elevation", xlab="usedFactor", ylab="deer")
boxplot(DistFromHumanAccess2~usedFactor, data=wolfkde, main = "Dist. Human Access", ylab="elk_w2", xlab="usedFactor")
boxplot(DistFromHighHumanAccess2~usedFactor, data=wolfkde, main = "Dist. High Human Access", ylab="elk_w2", xlab="usedFactor")


## ----------------------------------------------------------------------------------------
## subset for Bow Valley Pack
bvkde<- subset(wolfkde, subset=pack =="Bow Valley")
par(mfrow = c(2,3))
boxplot(deer_w2~usedFactor, data=bvkde, main = "Deer", xlab="usedFactor", ylab="deer")
boxplot(elk_w2~usedFactor, data=bvkde, main = "Elk", ylab="elk_w2", xlab="usedFactor")
boxplot(moose_w2~usedFactor, data=bvkde, main = "Moose", ylab="moose_w2", xlab="usedFactor")
boxplot(goat_w2~usedFactor, data=bvkde, main = "Goat", ylab="goat_w2", xlab="usedFactor")
boxplot(sheep_w2~usedFactor, data=bvkde, main = "Sheep", ylab="sheep_w2", xlab="usedFactor")


## ----------------------------------------------------------------------------------------
par(mfrow = c(1,3))
boxplot(Elevation2~usedFactor, data=bvkde, main = "Elevation", xlab="usedFactor", ylab="deer")
boxplot(DistFromHumanAccess2~usedFactor, data=bvkde, main = "Dist. Human Access", ylab="elk_w2", xlab="usedFactor")
boxplot(DistFromHighHumanAccess2~usedFactor, data=bvkde, main = "Dist. High Human Access", ylab="elk_w2", xlab="usedFactor")


## ----------------------------------------------------------------------------------------
## subset for Red Deer Wolf
rdkde <- subset(wolfkde, subset=pack=="Red Deer")
table(rdkde$used, rdkde$pack)
par(mfrow = c(2,3))
boxplot(deer_w2~usedFactor, data=rdkde, main = "Deer", xlab="usedFactor", ylab="deer")
boxplot(elk_w2~usedFactor, data=rdkde, main = "Elk", ylab="elk_w2", xlab="usedFactor")
boxplot(moose_w2~usedFactor, data=rdkde, main = "Moose", ylab="moose_w2", xlab="usedFactor")
boxplot(goat_w2~usedFactor, data=rdkde, main = "Goat", ylab="goat_w2", xlab="usedFactor")
boxplot(sheep_w2~usedFactor, data=rdkde, main = "Sheep", ylab="sheep_w2", xlab="usedFactor")


## ----------------------------------------------------------------------------------------
par(mfrow = c(1,3))
boxplot(Elevation2~usedFactor, data=rdkde, main = "Elevation", xlab="usedFactor", ylab="deer")
boxplot(DistFromHumanAccess2~usedFactor, data=rdkde, main = "Dist. Human Access ", ylab="elk_w2", xlab="usedFactor")
boxplot(DistFromHighHumanAccess2~usedFactor, data=rdkde, main = "Dist. High Human Access", ylab="elk_w2", xlab="usedFactor")


## ----------------------------------------------------------------------------------------
## Can make more complex box plots
par(mfrow = c(1,1))
boxplot(Elevation2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
boxplot(DistFromHumanAccess2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Human Access Used-Avail")
boxplot(deer_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
boxplot(moose_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
boxplot(elk_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
boxplot(goat_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
boxplot(sheep_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")

## using lattice package
bwplot(sheep_w2+ goat_w2 + elk_w2+moose_w2+ deer_w2~as.factor(usedFactor)|pack, data = wolfkde, layout = c(2,5), pch = "|", outer = TRUE)



## ----------------------------------------------------------------------------------------
aggregate(wolfkde[1:9], by=list(wolfkde$pack, wolfkde$usedFactor), FUN=mean, na.rm=TRUE)

wolf_df <- as_tibble(wolfkde)
wolf_df %>% group_by(pack, used) %>% summarise(mean(Elevation2))
wolf_df %>% group_by(pack, used) %>% summarise(dha = mean(DistFromHumanAccess2))


## ----------------------------------------------------------------------------------------
wolfkde2 <- na.omit(wolfkde)
wolf_df <- as_tibble(wolfkde2)
wolf_df %>% group_by(pack, used) %>% summarise(dha = mean(DistFromHumanAccess2))
wolf_df %>% group_by(pack, used) %>% summarise(dhha =mean(DistFromHighHumanAccess2))

wolf_df %>% group_by(pack, used) %>% summarise(moose = mean(moose_w2))
wolf_df %>% group_by(pack, used) %>% summarise(elk = mean(elk_w2))
wolf_df %>% group_by(pack, used) %>% summarise(sheep = mean(sheep_w2))
wolf_df %>% group_by(pack, used) %>% summarise(deer = mean(deer_w2))
wolf_df %>% group_by(pack, used) %>% summarise(goat = mean(goat_w2))



## ----------------------------------------------------------------------------------------
## First lets flip fair coins 100 times
rbinom(100, 1, 0.5)
trial = rbinom(100, 1, 0.5)
sum(trial)

## What about say, a survival probability of 0.9.
surv1 <- rbinom(100, 1, 0.9)
sum(surv1)


## ----------------------------------------------------------------------------------------
plogis(0)
## note that if p = 0, then the probability of an outcome is 0.5, heads or tails - i.e., a fair coin. 
plogis(1)
plogis(-5)
plogis(-100)
plogis(5)
plogis(100)


## ----------------------------------------------------------------------------------------
x = c(-50:50) ## just creating a uniform vector from -50 to 50. 
y = rbinom(length(x), 1, plogis(0+0.07*x) )
## unpack this line by ?rbinom
## and ? plogis

plot( y ~ x)
abline(lm((y~x)))


## ----------------------------------------------------------------------------------------
wrong = lm(y~x)
summary(wrong)
coef(wrong)


## ----------------------------------------------------------------------------------------
res = glm( y~x, family=binomial(link="logit"))
summary(res)
yLogit=predict(res)

plot( yLogit ~ x )
yhat=predict(res, type="response")
plot( y ~ x)
lines(yhat~x)


## ----------------------------------------------------------------------------------------
elev <- glm(used ~ Elevation2, family=binomial(logit), data=wolfkde)
summary(elev)
## exploring univarite logistic regression
## how to obtain 95% confidence intervals? Where are they in the output?
## CI's using profile log-likelihood's
confint(elev)
## CI's using standard errors
confint.default(elev)


## ----------------------------------------------------------------------------------------
exp(coefficients(elev))
## how to obtain 95% CI's on odds ratio's
exp(cbind(OR=coef(elev), confint(elev)))


## ----------------------------------------------------------------------------------------
wolfkde$elev100 <- wolfkde$Elevation2 / 100
elev100 <- glm(used ~ elev100, family=binomial(logit), data=wolfkde)
summary(elev100)
exp(coef(elev100))


## ----------------------------------------------------------------------------------------
elevBnp = 0:3000 ## creates a new vector elevBnp with ranges from 0 - 3000 in it.
elevPred = predict(elev, newdata=data.frame(Elevation2=elevBnp), type = "response") ## uses the predict function to predict Y values given the model object elev
hist(elevPred)
plot(elevBnp, elevPred, type="l", ylim = c(0,1.0), ylab= "Pr(Used)")


## ----------------------------------------------------------------------------------------
plot(wolfkde$Elevation2, wolfkde$used)
lines(elevBnp, elevPred, type="l", ylab= "Pr(Used)")


## ----------------------------------------------------------------------------------------
## next human use
distHuman <- glm(used ~ DistFromHumanAccess2, family=binomial(logit), data=wolfkde)
summary(distHuman)
hist(wolfkde$DistFromHumanAccess2)
disthumanBnp = 0:7000
disthumanPred = predict(distHuman, newdata=data.frame(DistFromHumanAccess2=disthumanBnp), type="response")
hist(disthumanPred)
plot(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")
plot(wolfkde$DistFromHumanAccess2, wolfkde$used)
lines(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")


## ----------------------------------------------------------------------------------------
## next human use
distHHuman <- glm(used ~ DistFromHighHumanAccess2, family=binomial(logit), data=wolfkde)
summary(distHHuman)
hist(wolfkde$DistFromHighHumanAccess2)
disthumanBnp = 0:10000
disthumanPred = predict(distHHuman, newdata=data.frame(DistFromHighHumanAccess2=disthumanBnp), type="response")
hist(disthumanPred)
plot(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")
plot(wolfkde$DistFromHumanAccess2, wolfkde$used)
lines(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")


## ----------------------------------------------------------------------------------------
# now lets do all at once for ungulate HSI models
sheep <- glm(used ~ sheep_w2, family=binomial(logit), data=wolfkde)
summary(sheep)
habvalues = 0:7
deer <- glm(used ~ deer_w2, family=binomial(logit), data=wolfkde)
summary(deer)
elk <- glm(used ~ elk_w2, family=binomial(logit), data=wolfkde)
summary(elk)
moose <- glm(used ~ moose_w2, family=binomial(logit), data=wolfkde)
summary(moose)
goat <- glm(used ~ goat_w2, family=binomial(logit), data=wolfkde)
summary(goat)


## ----------------------------------------------------------------------------------------
habvalues = 0:7 ## making a vector of hsi values
sheeppred = predict(sheep, newdata = data.frame(sheep_w2 = habvalues), type = "response")
goatpred = predict(goat, newdata = data.frame(goat_w2 = habvalues), type = "response")
moosepred = predict(moose, newdata = data.frame(moose_w2 = habvalues), type = "response")
elkpred = predict(elk, newdata = data.frame(elk_w2 = habvalues), type = "response")
deerpred = predict(deer, newdata = data.frame(deer_w2 = habvalues), type = "response")
sheeppred = predict(sheep, newdata = data.frame(sheep_w2 = habvalues), type = "response")


## ----------------------------------------------------------------------------------------
## back to elevation
elev <- glm(used ~ Elevation2, family=binomial(logit), data=wolfkde)
summary(elev)
wolfkde$fitted.Elev <- fitted(elev)
head(wolfkde)
hist(wolfkde$fitted.Elev)
plot(wolfkde$fitted.Elev, wolfkde$Elevation2)


## ----------------------------------------------------------------------------------------
# ggplot 2 explore basic histogram functio
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_histogram()
# lets explore faceting
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_histogram(binwidth=0.05, fill="gray70", colour="black") + facet_grid(used ~ .)
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_histogram(binwidth=0.05, fill="gray70", colour="black") + facet_grid(used ~ ., scales = "free")
ggplot(wolfkde, aes(x=fitted.Elev, fill=usedFactor)) + geom_histogram(binwidth=0.05, position="identity", alpha=0.7) + xlab("Predicted Probability of Wolf Use") + theme(axis.title.x=element_text(size=16))
# lets redo this graph using faceting by pack
ggplot(wolfkde, aes(x = fitted.Elev, y=after_stat(density), fill=usedFactor)) + geom_histogram(binwidth=0.05, position="identity", alpha=0.7) + xlab("Predicted Probability of Wolf Use") + theme(axis.title.x=element_text(size=16)) + facet_grid(pack ~ ., scales="free")


## ----------------------------------------------------------------------------------------
# Now lets explore fitting functions to the distributions
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_density()
ggplot(wolfkde, aes(x=fitted.Elev), fill=usedFactor) + geom_density(alpha=0.5) + xlim(0,1)+xlab("Predicted Probability of Wolf Use") + theme(axis.title.x=element_text(size=16)) 
# kernel lines
ggplot(wolfkde, aes(x=fitted.Elev, y=..density.., fill=usedFactor)) + geom_histogram(binwidth=0.05) + geom_density(alpha = 0.5) + facet_grid(pack ~ .)



## ----------------------------------------------------------------------------------------
# Exploring Predictions as a function of covariates
# this fits a univariate glm as a function of elevation and predicts
ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"))


## ----------------------------------------------------------------------------------------
ggplot(wolfkde, aes(x=DistFromHumanAccess2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"))
ggplot(wolfkde, aes(x=elk_w2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"))


## ----------------------------------------------------------------------------------------
ggplot(wolfkde, aes(x=elk_w2, y=used)) + geom_point() +geom_jitter(aes(colour = used), width=0.25, height = 0.05) + stat_smooth(method="glm", method.args = list(family="binomial"))


## ----------------------------------------------------------------------------------------
## lets redo elevation jittered by used
ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point() +geom_jitter(aes(colour = used), width=0.25, height = 0.05)+ stat_smooth(method="glm", method.args = list(family="binomial"))


## ----------------------------------------------------------------------------------------
ggplot(wolfkde, aes(x=Elevation2, y=used, colour=pack)) + geom_point() + geom_jitter(width=0.25, height = 0.05) +stat_smooth(method="glm", method.args = list(family="binomial"), level=0.90)


## ----------------------------------------------------------------------------------------
ggplot(wolfkde, aes(x=moose_w2, y=used, colour=pack)) + stat_smooth(method="glm", method.args = list(family="binomial"))

ggplot(wolfkde, aes(x=sheep_w2, y=used, colour=pack)) + stat_smooth(method="glm", method.args = list(family="binomial"))


## ----------------------------------------------------------------------------------------
# versus faceting by wolf pack
ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"), level=0.90) + facet_grid(pack~.)


## ----------------------------------------------------------------------------------------
# this function plots predictions from the previously fitted best model
ggplot(wolfkde, aes(x=Elevation2, y=fitted.Elev)) + geom_point() + stat_smooth(method=lm) + ylim(0, 0.8)


## ----------------------------------------------------------------------------------------
plot(effects::effect("Elevation2", elev), grid=TRUE, rescale.axis = FALSE, ylab = "Probability(Used)") 


## ----------------------------------------------------------------------------------------
plot(effects::effect("deer_w2", deer), grid=TRUE, rescale.axis = FALSE, ylab = "Probability(Used)")


## ----------------------------------------------------------------------------------------
#Printing PDFs from R
pdf("Output/wolf_elev.pdf", width=4, height=4)
print(ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point(colour="gray") + stat_smooth(method="glm", method.args = list(family="binomial")) + xlab("Elevation (m)") + ylab("Predicted Probability of Wolf Use"))
dev.off()
# then go and look in the active directory for wolf_elev.pdf
#or
ggsave("Output/elev_wolf2.pdf", width=4, height=4)
#


## ----------------------------------------------------------------------------------------
figPrey<-ggplot(wolfkde, aes(x=elk_w2, y=used)) + geom_smooth(data = wolfkde, aes(x=elk_w2, y=used, col="Elk"),method="glm", method.args = list(family="binomial")) + geom_smooth(data = wolfkde, aes(x=deer_w2, y=used, col="Deer"),method="glm", method.args = list(family="binomial"))+ geom_smooth(data = wolfkde, aes(x=moose_w2, y=used, col="Moose"),method="glm", method.args = list(family="binomial"))+ geom_smooth(data = wolfkde, aes(x=sheep_w2, y=used, col="Sheep"),method="glm", method.args = list(family="binomial"))+ geom_smooth(data = wolfkde, aes(x=goat_w2, y=used, col="Goat"),method="glm", method.args = list(family="binomial")) + xlab("Relative prey habitat suitability") + ylab("Relative probability of wolf use") + theme(axis.title.y=element_text(size=12), axis.text.y=element_text(size=12)) + theme(axis.title.x=element_text(size=12), axis.text.x=element_text(size=12))+ labs(fill="Prey Species")

figPrey
  
## lets save this
pdf("Output/figPrey.pdf", width=6, height=6)
figPrey
dev.off()

