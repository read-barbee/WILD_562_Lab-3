WILD 562 - Lab 3: Habitat Selection & Logistic Regression
================
Mark Hebblewhite
1/25/2021

# Introduction to the Logistic Regression Model for Used-Available Data

The general introduction to the biological rationale of the ecological
system and wolf telemetry data was given in the Lab 2 introduction. In
Lab 3, we extend the analysis of habitat use by wolves in two wolf packs
from 2001-2005 in Banff National Park to analysis of habitat selection
using univariate logistic model to estimate a resource selection
function (RSF) as a function of the availability of resources.

Boyce and McDonald (1999) and Manly et al. (2002) defined a resource
selection function (RSF) as any function that is proportional to the
probability of use of a resource unit to covariates that allow
biologists to gain insight into the underlying factors affecting the
probability of use. Thus, H.S.I. models, expert opinion models, models
based solely on use, occupancy models, and selection models are all
potentially classified as RSF models is their function relates to the
probability of use. The basic form of a resource selection function
model is to relate the covariates that predict used locations against
covariates that predict un-used or available locations. As we shall see
in future weeks, there is a CRITICAL distinction in interpretation of
the RSF dependent on which design is employed; the use-availability or
the used-unused. For now, however, we will simply consider the best way
to compare used locations against available locations.

We will use logistic regression, a type of generalized linear model and
member of the family of binomial models using the logit link function
that relate the linear predictor vector of covariates to the probability
function via the logistic function. This is a very useful model where we
have binomial categorical outcomes such as used (which is set to =1) or
available/un-used (which is set to =0). The basic equation is:

$$logit(y) = \frac{exp^(\beta_0+\beta_1*X_1+\beta_n*X_n) + e}{1 + exp(\beta_0+\beta_1*X_11+\beta_n*X_n) + e}$$

where y is the probability of a 1 (in true logistic regression),
$\beta_0$ is the baseline probability, or intercept, $\beta_1$ and
$\beta_n$ are the coefficients of covariates $X_1....X_n$, respectively.
In this way, the exponentiated portion of the numerator and denominator
are the familiar form of ANY linear model

$$ y = \beta_0+\beta_1*X_1+\beta_n*X_n + e $$ Except here, y, is linear
in the logit scale which ranges from - infinity to + infinity, which is
problematic of course because the response, 0 or 1, cannot range between
positive and negative infinity. This is the purpose of the logit link
function which takes a linear term in the brackets and constrains it to
be between 0 and 1. Mathematically, the function of this is to
mathematically bound the response variable, Y, here Logit(P) between 0
and 1. If we exponentiate a small number, and then divide it by 1+ a
small number, we get a number close to 0. Conversely, if the numerator
evaluates as a large number, then 1+ a large number approaches 1. The
\[exp/(1+exp)\] link function simply bounds the response to be a
continuous function between 0 and 1.

Equation 2 is called the *Linear Predictor*. Here, *y*, is linear in the
logit scale which ranges from - infinity to + infinity. This is
problematic of course because the response, 0 or 1, cannot range between
positive and negative infinity. This is the purpose of the logit link
function used in Equation 1 which is simplified here:

$$P = logit(y) = \frac{exp^{()}}{1 + exp^{()}}$$ Equation 3 which takes
a linear term in the brackets and constrains it to be between 0 and 1.
Mathematically, the function of this is to mathematically bound the
response variable, Y, here Logit(Y) - a probability - between 0 and 1.
We call this equation 3 the Logit Link Function.

Consider the mathematics of this Logit Link Function. If we consider
some really small terms in the linear predictor, then exponentiate them
($\exp(-5)$ = 0.0067), and then divide it by 1+ a small number (0.0067),
we get a number close to 0. Conversely, if the numerator evaluates as a
large number, say + 5, then ($\exp(5)$ = 148) then 1+ a large number,
148 approaches 1. The \[exp/(1+exp)\] link function simply bounds the
response to be a continuous function between 0 and 1, a probability.

Finally, technically, *y* in Equation 2 is now the log-odds, that is, P
/ (1 - P), which we have algebraically solved using the log rule
following:

$$ln\frac{(P)}{(1-P)} = \beta_0+\beta_1X_1+\beta_nX_n + \epsilon$$
Equation 4 Note here that in Equation 4, the Y variable is technically
called the log-odds, that is, the log of the odds ratio between the
probability of an event occuring, and the probability of an event not
occuring. This can range from - infinity to + infinity. Log-odds is not
necessarily easy to think about. Consider a ‘fair’ coin where p = 0.5.
Thus, the log odds here is log (0.5/0.5) = log (1) = 0. Thus, in a fair
coin, there is no greater or lower log-odds of either outcome.

The final algebraic set of transformations are to consider the odds
ratio formulation:

$$\frac{(P)}{(1-P)} = exp^{(\beta_0+\beta_1X_1+\beta_nX_n)} + \epsilon$$
Equation 5

And again, like last week from Likelihood, recognize that because of the
log-product rule, we can break out the coefficients separately such as:

$$\frac{(P)}{(1-P)} = exp^{(\beta_0)} + exp^{\beta_1X_1} +exp^{\beta_nX_n} + \epsilon$$
Equation 6 Here, then, in Equation 5 and 6 the formulations are
considered the odds ratio of Y occuring, given a per-unit change in each
X variable. Read more on Odds-ratio’s in Hosmer and Lemeshow. But go
back to our ‘fair’ coin of p =0.5. Thus, here, we have the odds ratio of
0.5/0.5 = 1. That is, an odds ratio of 1 is a fair bet, equally likely
to obtain a heads (1) or a tail (0). This is the formulation that is
common sense to people who gamble (though why we do that I’m unclear).

Consider an outcome that is 0.67 chance of heads, and 0.33 chance of
tails. here, the odds-ratio = 0.67/0.33 = 2, and the log-odds is log(2)
= 0.69. Thus, the probability of obtaining a heads here, 1, is twice
that of getting a tails. The log-odds says there is a 69% higher chance
of getting a heads than a tail. We will learn why the log-odds is not
symmetric shortly.

We will explore the logistic model below with simulated and empirical
data building on our wolf habitat use and selection case study after
getting started.

**SIDEBAR** *In this first, gentle, introduction to Resource Selection
Functions (RSF) we are glossing over a few VERY important points about
RSF models and the distinction between relative probabilities in
used-availability designs (RSF) and the true probability obtained in
Resource Selection Probability Functions (RSPF). *

## Lab 3 Objectives

1.  Merge the wolf used and wolf availability datasets from last weeks
    lab based on the Kernel Density Estimated home range for both wolf
    packs.

2.  Conduct graphical and numerical data exploration of the differences
    between USED and AVAILABLE locations for each wolf pack for the \~ 8
    ecologial covariates we developed in Lab 2.

3.  Learn about logistic regression through simulation.

4.  Fit Univariate logistic regression to wolf used-available data.

5.  Learn how to interpret Logistic regression coefficients.

6.  Making graphical predictions of the results of logistic regression
    models for our univariate covariates.

### Preliminaries: getting started, loading packages, setting working directory

Today we will use the following pacakges
`packages <- c("ggplot2","lattice", "tidyverse", "effects")` - note I
supress output in the next set of ipak functions.

# Objective 1 - Merging the wolf availabiltiy sample from the KDE’s from Lab 2.

Note last week we merged the wolf USED data, but did not merge the USED
data with the AVAILABILITY data. Here is the code to merge the
availabiltiy data. Note I did this for you, skip to 1.0 below.

    rdavail <- as.data.frame(cov.availRD)
    rdavail$pack <- c("Red Deer")

    #repeat for Bow Valley pack
    bvavail <- as.data.frame(cov.availBV)
    bvavail$pack <- c("Bow Valley")

    ## merge the two availability samples together
    wolfavail <- rbind(rdavail, bvavail)

    ## and for next week, lets add a new column for a 1=used 0 = avail
    wolfavail$used <- 0

    write.table(wolfused, file = "wolfused.csv", row.names=FALSE, na="", col.names=TRUE, sep=",")
    write.table(wolfavail, file = "wolfavail.csv", row.names=FALSE, na="", col.names=TRUE, sep=",")

# Objective 2 - Exploring Merged Wolf USED and AVAIL datasets

First read them back into active memory.

``` r
wolfused <-read.csv(here::here("Data","wolfused.csv"), header = TRUE)
wolfavail <-read.csv(here::here("Data","wolfavail.csv"), header = TRUE)
wolfkde <- rbind(wolfused, wolfavail)
str(wolfkde)
```

    ## 'data.frame':    2396 obs. of  11 variables:
    ##  $ deer_w2                 : int  1 1 3 3 3 3 3 3 3 3 ...
    ##  $ moose_w2                : int  1 1 3 3 3 3 3 3 3 3 ...
    ##  $ elk_w2                  : int  1 1 3 3 3 3 3 3 4 4 ...
    ##  $ sheep_w2                : int  1 1 4 4 4 4 4 4 6 6 ...
    ##  $ goat_w2                 : int  1 4 4 4 4 4 4 4 5 5 ...
    ##  $ wolf_w2                 : int  1 1 3 3 3 3 3 3 4 4 ...
    ##  $ Elevation2              : num  1494 1778 2035 2035 2035 ...
    ##  $ DistFromHumanAccess2    : num  189.5 622.6 30.8 30.8 30.8 ...
    ##  $ DistFromHighHumanAccess2: num  0 724 217 217 217 ...
    ##  $ pack                    : chr  "Bow Valley" "Red Deer" "Red Deer" "Red Deer" ...
    ##  $ used                    : int  1 1 1 1 1 1 1 1 1 1 ...

``` r
table(wolfkde$used, wolfkde$pack)
```

    ##    
    ##     Bow Valley Red Deer
    ##   0       1000     1000
    ##   1        316       80

``` r
table(wolfkde$used, wolfkde$deer_w2)
```

    ##    
    ##       0   1   3   4   5   6   7
    ##   0   1 516 343 684 168  25  14
    ##   1   0   2  35 149 121  85   4

``` r
## next we will create a new variable called usedFactor and graphically compare USED and AVAIL locations for prey
wolfkde$usedFactor <- factor(wolfkde$used, labels=c('0','1'))
str(wolfkde)
```

    ## 'data.frame':    2396 obs. of  12 variables:
    ##  $ deer_w2                 : int  1 1 3 3 3 3 3 3 3 3 ...
    ##  $ moose_w2                : int  1 1 3 3 3 3 3 3 3 3 ...
    ##  $ elk_w2                  : int  1 1 3 3 3 3 3 3 4 4 ...
    ##  $ sheep_w2                : int  1 1 4 4 4 4 4 4 6 6 ...
    ##  $ goat_w2                 : int  1 4 4 4 4 4 4 4 5 5 ...
    ##  $ wolf_w2                 : int  1 1 3 3 3 3 3 3 4 4 ...
    ##  $ Elevation2              : num  1494 1778 2035 2035 2035 ...
    ##  $ DistFromHumanAccess2    : num  189.5 622.6 30.8 30.8 30.8 ...
    ##  $ DistFromHighHumanAccess2: num  0 724 217 217 217 ...
    ##  $ pack                    : chr  "Bow Valley" "Red Deer" "Red Deer" "Red Deer" ...
    ##  $ used                    : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ usedFactor              : Factor w/ 2 levels "0","1": 2 2 2 2 2 2 2 2 2 2 ...

## Graphical Data Exploration for all Wolves

We will use the base boxplot graphing function in the R base package to
explore differences between the usedFactor (1, 0) binary response
variable for allt he different covariates of habitat suitability index
variables.

``` r
par(mfrow = c(2,3))
boxplot(deer_w2~usedFactor, data=wolfkde, main = "Deer", xlab="usedFactor", ylab="deer")
boxplot(elk_w2~usedFactor, main = "Elk", ylab="elk_w2", xlab="usedFactor", data=wolfkde)
boxplot(moose_w2~usedFactor, main = "Moose", ylab="moose_w2", xlab="usedFactor", data=wolfkde)
boxplot(goat_w2~usedFactor, main = "Goat", ylab="goat_w2", xlab="usedFactor", data=wolfkde)
boxplot(sheep_w2~usedFactor, main = "Sheep", ylab="sheep_w2", xlab="usedFactor", data=wolfkde)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- --> Class
discussion: how do we interpret the comparison of used and available for
ungulate prey for wolves in Banff?

Now lets do for Elevation and Distance from Human Access2

``` r
par(mfrow = c(1,3))
boxplot(Elevation2~usedFactor, data=wolfkde, main = "Elevation", xlab="usedFactor", ylab="deer")
boxplot(DistFromHumanAccess2~usedFactor, data=wolfkde, main = "Dist. Human Access", ylab="elk_w2", xlab="usedFactor")
boxplot(DistFromHighHumanAccess2~usedFactor, data=wolfkde, main = "Dist. High Human Access", ylab="elk_w2", xlab="usedFactor")
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- --> Class
discussion: similarly, what do we think? Do wolves like humans? Do
wolves like elevation?

## Splitting by Wolf Packs

Note that the above analyses are for both packs combined, but your
analyses last week confirmed that the red deer wolf pack, for example,
dwells at higher elevations than the bow valley pack. We should probably
consider the wolf packs separately.

``` r
## subset for Bow Valley Pack
bvkde<- subset(wolfkde, subset=pack =="Bow Valley")
par(mfrow = c(2,3))
boxplot(deer_w2~usedFactor, data=bvkde, main = "Deer", xlab="usedFactor", ylab="deer")
boxplot(elk_w2~usedFactor, data=bvkde, main = "Elk", ylab="elk_w2", xlab="usedFactor")
boxplot(moose_w2~usedFactor, data=bvkde, main = "Moose", ylab="moose_w2", xlab="usedFactor")
boxplot(goat_w2~usedFactor, data=bvkde, main = "Goat", ylab="goat_w2", xlab="usedFactor")
boxplot(sheep_w2~usedFactor, data=bvkde, main = "Sheep", ylab="sheep_w2", xlab="usedFactor")
```

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Now lets do for Elevation and Distance from Human Access2

``` r
par(mfrow = c(1,3))
boxplot(Elevation2~usedFactor, data=bvkde, main = "Elevation", xlab="usedFactor", ylab="deer")
boxplot(DistFromHumanAccess2~usedFactor, data=bvkde, main = "Dist. Human Access", ylab="elk_w2", xlab="usedFactor")
boxplot(DistFromHighHumanAccess2~usedFactor, data=bvkde, main = "Dist. High Human Access", ylab="elk_w2", xlab="usedFactor")
```

![](README_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Class discussion: how does the Bow Valley pack compare to all wolves in
BNP?

``` r
## subset for Red Deer Wolf
rdkde <- subset(wolfkde, subset=pack=="Red Deer")
table(rdkde$used, rdkde$pack)
```

    ##    
    ##     Red Deer
    ##   0     1000
    ##   1       80

``` r
par(mfrow = c(2,3))
boxplot(deer_w2~usedFactor, data=rdkde, main = "Deer", xlab="usedFactor", ylab="deer")
boxplot(elk_w2~usedFactor, data=rdkde, main = "Elk", ylab="elk_w2", xlab="usedFactor")
boxplot(moose_w2~usedFactor, data=rdkde, main = "Moose", ylab="moose_w2", xlab="usedFactor")
boxplot(goat_w2~usedFactor, data=rdkde, main = "Goat", ylab="goat_w2", xlab="usedFactor")
boxplot(sheep_w2~usedFactor, data=rdkde, main = "Sheep", ylab="sheep_w2", xlab="usedFactor")
```

![](README_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

Now lets do for Elevation and Distance from Human Access2

``` r
par(mfrow = c(1,3))
boxplot(Elevation2~usedFactor, data=rdkde, main = "Elevation", xlab="usedFactor", ylab="deer")
boxplot(DistFromHumanAccess2~usedFactor, data=rdkde, main = "Dist. Human Access ", ylab="elk_w2", xlab="usedFactor")
boxplot(DistFromHighHumanAccess2~usedFactor, data=rdkde, main = "Dist. High Human Access", ylab="elk_w2", xlab="usedFactor")
```

![](README_files/figure-gfm/unnamed-chunk-8-1.png)<!-- --> Class
discussion: and what about the red deer pack?

It would be nice if there was a way to graph both by pack and used?

``` r
## Can make more complex box plots
par(mfrow = c(1,1))
boxplot(Elevation2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

``` r
boxplot(DistFromHumanAccess2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Human Access Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-2.png)<!-- -->

``` r
boxplot(deer_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-3.png)<!-- -->

``` r
boxplot(moose_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-4.png)<!-- -->

``` r
boxplot(elk_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-5.png)<!-- -->

``` r
boxplot(goat_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-6.png)<!-- -->

``` r
boxplot(sheep_w2~used+pack, data = wolfkde, main = "Bow Valley vs. Red Deer Elevation Used-Avail")
```

![](README_files/figure-gfm/unnamed-chunk-9-7.png)<!-- -->

``` r
## using lattice package
bwplot(sheep_w2+ goat_w2 + elk_w2+moose_w2+ deer_w2~as.factor(usedFactor)|pack, data = wolfkde, layout = c(2,5), pch = "|", outer = TRUE)
```

![](README_files/figure-gfm/unnamed-chunk-9-8.png)<!-- -->

## Numerical Summary Statistics

``` r
aggregate(wolfkde[1:9], by=list(wolfkde$pack, wolfkde$usedFactor), FUN=mean, na.rm=TRUE)
```

    ##      Group.1 Group.2  deer_w2 moose_w2   elk_w2 sheep_w2  goat_w2  wolf_w2
    ## 1 Bow Valley       0 3.423000 3.576000 3.282000 2.859000 3.011000 3.641000
    ## 2   Red Deer       0 2.591212 2.758988 2.782956 2.620506 3.263648 2.874834
    ## 3 Bow Valley       1 4.901899 4.129747 4.680380 2.338608 1.534810 4.879747
    ## 4   Red Deer       1 3.712500 4.125000 4.087500 3.175000 2.575000 4.175000
    ##   Elevation2 DistFromHumanAccess2 DistFromHighHumanAccess2
    ## 1   1908.777             998.8968                1059.6538
    ## 2   2179.910            1331.6502                4651.1266
    ## 3   1451.127             256.9808                 207.4447
    ## 4   1864.125             492.9217                4539.9155

``` r
wolf_df <- as_tibble(wolfkde)
wolf_df %>% group_by(pack, used) %>% summarise(mean(Elevation2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used `mean(Elevation2)`
    ##   <chr>      <int>              <dbl>
    ## 1 Bow Valley     0              1909.
    ## 2 Bow Valley     1              1451.
    ## 3 Red Deer       0              2180.
    ## 4 Red Deer       1              1864.

``` r
wolf_df %>% group_by(pack, used) %>% summarise(dha = mean(DistFromHumanAccess2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used   dha
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0   NA 
    ## 2 Bow Valley     1  257.
    ## 3 Red Deer       0 1332.
    ## 4 Red Deer       1  493.

Why are there missing data for Bow Valley Available Locations? Missing
data… lets remove it

``` r
wolfkde2 <- na.omit(wolfkde)
wolf_df <- as_tibble(wolfkde2)
wolf_df %>% group_by(pack, used) %>% summarise(dha = mean(DistFromHumanAccess2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used   dha
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0  999.
    ## 2 Bow Valley     1  257.
    ## 3 Red Deer       0 1530.
    ## 4 Red Deer       1  493.

``` r
wolf_df %>% group_by(pack, used) %>% summarise(dhha =mean(DistFromHighHumanAccess2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used  dhha
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0 1060.
    ## 2 Bow Valley     1  207.
    ## 3 Red Deer       0 5041.
    ## 4 Red Deer       1 4540.

``` r
wolf_df %>% group_by(pack, used) %>% summarise(moose = mean(moose_w2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used moose
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0  3.59
    ## 2 Bow Valley     1  4.13
    ## 3 Red Deer       0  2.76
    ## 4 Red Deer       1  4.12

``` r
wolf_df %>% group_by(pack, used) %>% summarise(elk = mean(elk_w2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used   elk
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0  3.30
    ## 2 Bow Valley     1  4.68
    ## 3 Red Deer       0  2.78
    ## 4 Red Deer       1  4.09

``` r
wolf_df %>% group_by(pack, used) %>% summarise(sheep = mean(sheep_w2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used sheep
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0  2.84
    ## 2 Bow Valley     1  2.34
    ## 3 Red Deer       0  2.62
    ## 4 Red Deer       1  3.18

``` r
wolf_df %>% group_by(pack, used) %>% summarise(deer = mean(deer_w2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used  deer
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0  3.43
    ## 2 Bow Valley     1  4.90
    ## 3 Red Deer       0  2.59
    ## 4 Red Deer       1  3.71

``` r
wolf_df %>% group_by(pack, used) %>% summarise(goat = mean(goat_w2))
```

    ## `summarise()` has grouped output by 'pack'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 4 × 3
    ## # Groups:   pack [2]
    ##   pack        used  goat
    ##   <chr>      <int> <dbl>
    ## 1 Bow Valley     0  2.98
    ## 2 Bow Valley     1  1.53
    ## 3 Red Deer       0  3.26
    ## 4 Red Deer       1  2.58

# Objective 3 - Learning about Logisitic Regresson through Simulating

Now, we are going to conduct univariate logistic regression following
advice from (Hosmer and Lemeshow 2000) who advocate such an approach for
understanding the effect of each covariate on the probability of use.
There are at least three different ways to conduct a logistic regression
in most stats packages, including R, but following from lab 1 and 2, we
are going to use GLM- GENERALIZED LINEAR MODEL to increase familiarity
with this format.

First we will simulate a binomial random variable using the plogis
function learn more about ?plogis() and ? rbinom()

``` r
## First lets flip fair coins 100 times
rbinom(100, 1, 0.5)
```

    ##   [1] 1 1 0 1 0 0 0 1 0 0 1 0 0 0 1 0 0 1 1 1 1 0 1 0 1 0 1 0 0 0 0 1 0 1 1 1 1
    ##  [38] 1 0 0 0 0 0 0 1 1 0 1 1 1 0 0 0 1 1 0 1 1 1 1 1 0 0 1 0 0 0 1 1 1 0 1 0 0
    ##  [75] 1 0 1 1 1 1 1 0 1 1 0 1 1 0 0 1 1 0 0 0 1 0 1 1 0 0

``` r
trial = rbinom(100, 1, 0.5)
sum(trial)
```

    ## [1] 53

``` r
## What about say, a survival probability of 0.9.
surv1 <- rbinom(100, 1, 0.9)
sum(surv1)
```

    ## [1] 87

So 92 animals survived, say. (it will depend on your simulation).

`plogis()` plogis is the distribution function for converting a value
from the logistic scale to a real probability

``` r
plogis(0)
```

    ## [1] 0.5

``` r
## note that if p = 0, then the probability of an outcome is 0.5, heads or tails - i.e., a fair coin. 
plogis(1)
```

    ## [1] 0.7310586

``` r
plogis(-5)
```

    ## [1] 0.006692851

``` r
plogis(-100)
```

    ## [1] 3.720076e-44

``` r
plogis(5)
```

    ## [1] 0.9933071

``` r
plogis(100)
```

    ## [1] 1

Note that no matter what real number we put in plogis, the resultant
probability is always bound between 0 and 1.

Next we will simulate 101 numbers from -50 to 50, and then imagine we
are conducting a single binomial trial at each value from -50 to 50. The
probability, say, selecting a discrete habitat value increases with each
value of x according to the Logistic beta coefficient of 0.07

``` r
x = c(-50:50) ## just creating a uniform vector from -50 to 50. 
y = rbinom(length(x), 1, plogis(0+0.07*x) )
## unpack this line by ?rbinom
## and ? plogis

plot( y ~ x)
abline(lm((y~x)))
```

![](README_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

Lets fit a linear model, assuming a gaussian distributed Y variable

``` r
wrong = lm(y~x)
summary(wrong)
```

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.97979 -0.22312 -0.00344  0.22120  1.01334 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.495050   0.036399   13.60  < 2e-16 ***
    ## x           0.011823   0.001248    9.47 1.57e-15 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.3658 on 99 degrees of freedom
    ## Multiple R-squared:  0.4753, Adjusted R-squared:   0.47 
    ## F-statistic: 89.68 on 1 and 99 DF,  p-value: 1.568e-15

``` r
coef(wrong)
```

    ## (Intercept)           x 
    ##  0.49504950  0.01182295

Note these coefficients bear little resemblance ot the coefficients
embedded in the plogis() function above.
`rbinom(length(x), 1, plogis(0+0.07*x) )`

What have we learned by incorrectly analyzing binary (1, 0) data by
forcing a linear model (linear regression) through the origin? There has
to be a better way…. Logistic Regression!

``` r
res = glm( y~x, family=binomial(link="logit"))
summary(res)
```

    ## 
    ## Call:
    ## glm(formula = y ~ x, family = binomial(link = "logit"))
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.4663  -0.5689  -0.2172   0.5699   2.5523  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -0.03878    0.27855  -0.139    0.889    
    ## x            0.07393    0.01358   5.444 5.22e-08 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 140.006  on 100  degrees of freedom
    ## Residual deviance:  81.651  on  99  degrees of freedom
    ## AIC: 85.651
    ## 
    ## Number of Fisher Scoring iterations: 5

``` r
yLogit=predict(res)

plot( yLogit ~ x )
```

![](README_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

``` r
yhat=predict(res, type="response")
plot( y ~ x)
lines(yhat~x)
```

![](README_files/figure-gfm/unnamed-chunk-16-2.png)<!-- --> These plots
show that the slope of the logistic function is linear in the logit
transformation (plot yLogit \~ x), and non-linear in real probability.
The logit link function
$$logit(y) = \frac{exp^(\beta_0+\beta_1*X_1+\beta_n*X_n) + e}{1 + exp(\beta_0+\beta_1*X_11+\beta_n*X_n) + e}$$
handily keeps the real probability bounded between 0 and 1 always.

*Excercise* Try negative coefficients, and/or, try a different
‘intercept’ value, the 0 in the plogis() command above.

# Objective 4 - Univariate Logistic Regression with glm

Next we will explore logistic regression using univariate logistic
regression for the variables in our wolf used-available model. Learn
about glm using: `?glm`

``` r
elev <- glm(used ~ Elevation2, family=binomial(logit), data=wolfkde)
summary(elev)
```

    ## 
    ## Call:
    ## glm(formula = used ~ Elevation2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##      Min        1Q    Median        3Q       Max  
    ## -1.35906  -0.48164  -0.15906  -0.04368   3.11245  
    ## 
    ## Coefficients:
    ##               Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  9.3484168  0.5609435   16.67   <2e-16 ***
    ## Elevation2  -0.0063747  0.0003517  -18.12   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2148.3  on 2395  degrees of freedom
    ## Residual deviance: 1403.4  on 2394  degrees of freedom
    ## AIC: 1407.4
    ## 
    ## Number of Fisher Scoring iterations: 7

``` r
## exploring univarite logistic regression
## how to obtain 95% confidence intervals? Where are they in the output?
## CI's using profile log-likelihood's
confint(elev)
```

    ## Waiting for profiling to be done...

    ##                    2.5 %       97.5 %
    ## (Intercept)  8.280656592 10.480954212
    ## Elevation2  -0.007088088 -0.005708514

``` r
## CI's using standard errors
confint.default(elev)
```

    ##                    2.5 %       97.5 %
    ## (Intercept)  8.248987780 10.447845747
    ## Elevation2  -0.007064005 -0.005685359

## Odds Ratio Interpretation

Recall Equation 5 (and 6) above:
$$\frac{(P)}{(1-P)} = exp^{(\beta_0+\beta_1X_1+\beta_nX_n)} + \epsilon$$

In Equation 5 (and 6) the formulations are considered the odds ratio of
Y occuring, given a per-unit change in each X variable. Read more on
Odds-ratio’s in Hosmer and Lemeshow. But go back to our ‘fair’ coin of p
=0.5. Thus, here, we have the odds ratio of 0.5/0.5 = 1. That is, an
odds ratio of 1 is a fair bet, equally likely to obtain a heads (1) or a
tail (0). This is the formulation that is common sense to people who
gamble (though why people gamble I’m unclear).

Consider an outcome that is 0.67 chance of heads, and 0.33 chance of
tails. here, the odds-ratio = 0.67/0.33 = 2, and the log-odds is log(2)
= 0.69. Thus, the probability of obtaining a heads here, 1, is twice
that of getting a tails. The log-odds says there is a 69% higher chance
of getting a heads than a tail. We will learn the log-odds is not
symmetric shortly.

To estimate the Odds ratio from a logistic regression model, therefore,
based on Equation 5, we simply exponentiate the beta coefficients.

``` r
exp(coefficients(elev))
```

    ##  (Intercept)   Elevation2 
    ## 1.148063e+04 9.936456e-01

``` r
## how to obtain 95% CI's on odds ratio's
exp(cbind(OR=coef(elev), confint(elev)))
```

    ## Waiting for profiling to be done...

    ##                       OR       2.5 %       97.5 %
    ## (Intercept) 1.148063e+04 3946.784959 3.563039e+04
    ## Elevation2  9.936456e-01    0.992937 9.943077e-01

Thus, for every increase in elevation by 1 meter, the odds of wolf use
decrease by 0.9936, a really small amount. Note this is not really
compelling. Next we will consider rescaling to make a more compelling
example.

## Rescaling beta coefficients and odds ratio’s

Lets rescale to be the odds in a per 100 meter change of elevation.

``` r
wolfkde$elev100 <- wolfkde$Elevation2 / 100
elev100 <- glm(used ~ elev100, family=binomial(logit), data=wolfkde)
summary(elev100)
```

    ## 
    ## Call:
    ## glm(formula = used ~ elev100, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##      Min        1Q    Median        3Q       Max  
    ## -1.35906  -0.48164  -0.15906  -0.04368   3.11245  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  9.34842    0.56094   16.67   <2e-16 ***
    ## elev100     -0.63747    0.03517  -18.12   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2148.3  on 2395  degrees of freedom
    ## Residual deviance: 1403.4  on 2394  degrees of freedom
    ## AIC: 1407.4
    ## 
    ## Number of Fisher Scoring iterations: 7

``` r
exp(coef(elev100))
```

    ##  (Intercept)      elev100 
    ## 1.148063e+04 5.286291e-01

We would conclude that for every increase in 100 meters of elevation,
the odds of wolf use decreases by 0.528. Therefore the interpretation of
the odds ratio is scale dependent.

## Plotting Predictions

Next, lets continue by extracting predictions from our Elevation model.
First, we create a new vector of elevations from 0 to 3000m , the
approximate range of elevations in BNP where wolves were observed or
could have been (avail).

``` r
elevBnp = 0:3000 ## creates a new vector elevBnp with ranges from 0 - 3000 in it.
elevPred = predict(elev, newdata=data.frame(Elevation2=elevBnp), type = "response") ## uses the predict function to predict Y values given the model object elev
hist(elevPred)
```

![](README_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
plot(elevBnp, elevPred, type="l", ylim = c(0,1.0), ylab= "Pr(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-20-2.png)<!-- -->

But were there elevations from 0 - 1300m in Banff?

``` r
plot(wolfkde$Elevation2, wolfkde$used)
lines(elevBnp, elevPred, type="l", ylab= "Pr(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-21-1.png)<!-- --> How do
wolves respond to elevation? Can we make predictions about wolf use of
elevations \< 1000 m based on our data in Banff? What would that be
called?

# Objective 5 - Interpreting Coefficients in Logistic Models

What this example shows us is that there is a pure logistic model behind
the response of wolves to elevation is only ‘capturing’ a range of the
entire logistic function. This is because of the logit link and the
challenge of interpreting the intercept and slope expressed in the
linear scale in true probabilities.

Note that just like OLS regression, the intercept and slope determine
the shape of the logistic regression response in real probabilities. But
it is more complicated because of the relationship between the
coefficients in the linear part of the logit (e.g., Eq. 4) and their
relationship to the real probabilities. This is why many, many
statistical textbooks always tell students that the best way to
interpret probabilities from any logistic regression is to plot them.
This is especially true in logistic regression models with more than one
covariate, interactions, and more complex models such as mixed-effects
models. Certainly, we can easily understand that a negative $\beta_1$
implies that the probability of the outcome, here, use, declines with
increasing X. But we cannot necessarily understand or solve something
like the Y intercept when X = 0, or, vice versa, what X will be when Y =
0 like we can with OLS regression.

To illustrate the effects of varying the $\beta_0$ and $\beta_1$ on the
shape of the logistic regression predictions, I show here in Fig. 3.1
the effects of varying first the intercept, $\beta_0$, from -5 to 5
where $\beta_1$ was fixed at 0.05 (Fig. 9.1.a). This shows that like the
OLS regression, here, $\beta_0$ governs where Y crosses the X=0 line.
Unlike OLS, however, the slopes are not parallel because of the fixed
$\beta_1$ =0.05 because of the logit link function. Second, I fixed
$\beta_0$ = 0 varied the coefficient, $\beta_1$ , from -0.10 to +0.10.

![Figure 3.1. Effects of varying first a) the intercept, b0 , from -5 to
5 where b1 was fixed at 0.05, and b) the coefficient, b1 , where b0 = 0
on the predicted probability of 1 or 0 from the same logistic regression
equation.](Figures/logisticregression1.png)

A second complication is that the shape of the predicted probabilities
can take on a linear, exponential, curvilinear, or the full range of the
logistic regression response depending on the range of the X values.
Consider the wolf elevation response above. That is, there is *always a
perfect logistic regression function predicted by any logit link
function*, it just may be that the range of values observed in any
particular dataset (i.e., range of X values) capture only a portion of
the logistic link function as illustrated in Figure X.

![Figure 3.2. Effects of the range of X data sampled and the predictions
from the logistic regression model showing in the first box a largely
exponential function, the second box, a largely linear response, and in
the last box, a curvilinear relationship. The logistic regression model
is very flexible in accommodating linear and many non-linear responses
that are linear in the logit (Eq. 4), but non-linear in the transformed
real probabilities.](Figures/logisticregression2.png)

With this in mind, lets proceed through the rest of the univariate
logistic regression models.

``` r
## next human use
distHuman <- glm(used ~ DistFromHumanAccess2, family=binomial(logit), data=wolfkde)
summary(distHuman)
```

    ## 
    ## Call:
    ## glm(formula = used ~ DistFromHumanAccess2, family = binomial(logit), 
    ##     data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.0369  -0.7202  -0.3400  -0.0518   3.1764  
    ## 
    ## Coefficients:
    ##                        Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)          -0.3397520  0.0839162  -4.049 5.15e-05 ***
    ## DistFromHumanAccess2 -0.0022319  0.0001695 -13.164  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2133.0  on 2353  degrees of freedom
    ## Residual deviance: 1746.4  on 2352  degrees of freedom
    ##   (42 observations deleted due to missingness)
    ## AIC: 1750.4
    ## 
    ## Number of Fisher Scoring iterations: 7

``` r
hist(wolfkde$DistFromHumanAccess2)
```

![](README_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

``` r
disthumanBnp = 0:7000
disthumanPred = predict(distHuman, newdata=data.frame(DistFromHumanAccess2=disthumanBnp), type="response")
hist(disthumanPred)
```

![](README_files/figure-gfm/unnamed-chunk-22-2.png)<!-- -->

``` r
plot(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-22-3.png)<!-- -->

``` r
plot(wolfkde$DistFromHumanAccess2, wolfkde$used)
lines(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-22-4.png)<!-- --> Similarly,
how do wolves respond to high human activity?

``` r
## next human use
distHHuman <- glm(used ~ DistFromHighHumanAccess2, family=binomial(logit), data=wolfkde)
summary(distHHuman)
```

    ## 
    ## Call:
    ## glm(formula = used ~ DistFromHighHumanAccess2, family = binomial(logit), 
    ##     data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.7630  -0.7040  -0.5839  -0.2270   2.9724  
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)              -1.086e+00  6.894e-02 -15.746   <2e-16 ***
    ## DistFromHighHumanAccess2 -2.938e-04  3.362e-05  -8.738   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2133.0  on 2353  degrees of freedom
    ## Residual deviance: 1999.5  on 2352  degrees of freedom
    ##   (42 observations deleted due to missingness)
    ## AIC: 2003.5
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
hist(wolfkde$DistFromHighHumanAccess2)
```

![](README_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

``` r
disthumanBnp = 0:10000
disthumanPred = predict(distHHuman, newdata=data.frame(DistFromHighHumanAccess2=disthumanBnp), type="response")
hist(disthumanPred)
```

![](README_files/figure-gfm/unnamed-chunk-23-2.png)<!-- -->

``` r
plot(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-23-3.png)<!-- -->

``` r
plot(wolfkde$DistFromHumanAccess2, wolfkde$used)
lines(disthumanBnp, disthumanPred, type="l", ylab= "Pr(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-23-4.png)<!-- -->

Next for the ungulate H.S.I. models

``` r
# now lets do all at once for ungulate HSI models
sheep <- glm(used ~ sheep_w2, family=binomial(logit), data=wolfkde)
summary(sheep)
```

    ## 
    ## Call:
    ## glm(formula = used ~ sheep_w2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.7130  -0.6840  -0.6286  -0.5770   2.0179  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.23989    0.10441 -11.875  < 2e-16 ***
    ## sheep_w2    -0.09375    0.03461  -2.709  0.00675 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2052.8  on 2146  degrees of freedom
    ## Residual deviance: 2045.3  on 2145  degrees of freedom
    ##   (249 observations deleted due to missingness)
    ## AIC: 2049.3
    ## 
    ## Number of Fisher Scoring iterations: 4

``` r
habvalues = 0:7
deer <- glm(used ~ deer_w2, family=binomial(logit), data=wolfkde)
summary(deer)
```

    ## 
    ## Call:
    ## glm(formula = used ~ deer_w2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.9327  -0.6497  -0.3977  -0.1417   3.0351  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -5.64527    0.28920  -19.52   <2e-16 ***
    ## deer_w2      1.04929    0.06525   16.08   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2052.8  on 2146  degrees of freedom
    ## Residual deviance: 1618.4  on 2145  degrees of freedom
    ##   (249 observations deleted due to missingness)
    ## AIC: 1622.4
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
elk <- glm(used ~ elk_w2, family=binomial(logit), data=wolfkde)
summary(elk)
```

    ## 
    ## Call:
    ## glm(formula = used ~ elk_w2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.0049  -0.6737  -0.4078  -0.1414   3.0367  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -5.67843    0.28893  -19.65   <2e-16 ***
    ## elk_w2       1.07776    0.06688   16.12   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2052.8  on 2146  degrees of freedom
    ## Residual deviance: 1629.3  on 2145  degrees of freedom
    ##   (249 observations deleted due to missingness)
    ## AIC: 1633.3
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
moose <- glm(used ~ moose_w2, family=binomial(logit), data=wolfkde)
summary(moose)
```

    ## 
    ## Call:
    ## glm(formula = used ~ moose_w2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.1682  -0.6774  -0.5533  -0.3627   2.3470  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  -3.1329     0.1837  -17.06   <2e-16 ***
    ## moose_w2      0.4445     0.0438   10.15   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2052.8  on 2146  degrees of freedom
    ## Residual deviance: 1931.3  on 2145  degrees of freedom
    ##   (249 observations deleted due to missingness)
    ## AIC: 1935.3
    ## 
    ## Number of Fisher Scoring iterations: 5

``` r
goat <- glm(used ~ goat_w2, family=binomial(logit), data=wolfkde)
summary(goat)
```

    ## 
    ## Call:
    ## glm(formula = used ~ goat_w2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.1630  -0.9178  -0.4000  -0.2971   2.9451  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -0.03402    0.10381  -0.328    0.743    
    ## goat_w2     -0.61282    0.04423 -13.856   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2052.8  on 2146  degrees of freedom
    ## Residual deviance: 1805.8  on 2145  degrees of freedom
    ##   (249 observations deleted due to missingness)
    ## AIC: 1809.8
    ## 
    ## Number of Fisher Scoring iterations: 5

And similarly, lets examine the predicted probabilities

``` r
habvalues = 0:7 ## making a vector of hsi values
sheeppred = predict(sheep, newdata = data.frame(sheep_w2 = habvalues), type = "response")
goatpred = predict(goat, newdata = data.frame(goat_w2 = habvalues), type = "response")
moosepred = predict(moose, newdata = data.frame(moose_w2 = habvalues), type = "response")
elkpred = predict(elk, newdata = data.frame(elk_w2 = habvalues), type = "response")
deerpred = predict(deer, newdata = data.frame(deer_w2 = habvalues), type = "response")
sheeppred = predict(sheep, newdata = data.frame(sheep_w2 = habvalues), type = "response")
```

Now lets go back to our elevation object and save predictions from the
Elevation model in the wolfkde dataframe. We can use this to plot
predicted values for most situations as well.

``` r
## back to elevation
elev <- glm(used ~ Elevation2, family=binomial(logit), data=wolfkde)
summary(elev)
```

    ## 
    ## Call:
    ## glm(formula = used ~ Elevation2, family = binomial(logit), data = wolfkde)
    ## 
    ## Deviance Residuals: 
    ##      Min        1Q    Median        3Q       Max  
    ## -1.35906  -0.48164  -0.15906  -0.04368   3.11245  
    ## 
    ## Coefficients:
    ##               Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)  9.3484168  0.5609435   16.67   <2e-16 ***
    ## Elevation2  -0.0063747  0.0003517  -18.12   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 2148.3  on 2395  degrees of freedom
    ## Residual deviance: 1403.4  on 2394  degrees of freedom
    ## AIC: 1407.4
    ## 
    ## Number of Fisher Scoring iterations: 7

``` r
wolfkde$fitted.Elev <- fitted(elev)
head(wolfkde)
```

    ##   deer_w2 moose_w2 elk_w2 sheep_w2 goat_w2 wolf_w2 Elevation2
    ## 1       1        1      1        1       1       1   1494.000
    ## 2       1        1      1        1       4       1   1778.360
    ## 3       3        3      3        4       4       3   2035.073
    ## 4       3        3      3        4       4       3   2035.073
    ## 5       3        3      3        4       4       3   2035.073
    ## 6       3        3      3        4       4       3   2132.627
    ##   DistFromHumanAccess2 DistFromHighHumanAccess2       pack used usedFactor
    ## 1             189.4874                   0.0000 Bow Valley    1          1
    ## 2             622.6257                 723.7941   Red Deer    1          1
    ## 3              30.8216                 217.0442   Red Deer    1          1
    ## 4              30.8216                 217.0442   Red Deer    1          1
    ## 5              30.8216                 217.0442   Red Deer    1          1
    ## 6             201.2580                7770.2141   Red Deer    1          1
    ##    elev100 fitted.Elev
    ## 1 14.94000  0.45627248
    ## 2 17.78360  0.12046198
    ## 3 20.35073  0.02596928
    ## 4 20.35073  0.02596928
    ## 5 20.35073  0.02596928
    ## 6 21.32627  0.01411363

``` r
hist(wolfkde$fitted.Elev)
```

![](README_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

``` r
plot(wolfkde$fitted.Elev, wolfkde$Elevation2)
```

![](README_files/figure-gfm/unnamed-chunk-26-2.png)<!-- -->

# Objective 6 - Improving Graphical Predictions using ggplot2

First lets explore the distribution of predicted values from the
elevation model.

``` r
# ggplot 2 explore basic histogram functio
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_histogram()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](README_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

``` r
# lets explore faceting
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_histogram(binwidth=0.05, fill="gray70", colour="black") + facet_grid(used ~ .)
```

![](README_files/figure-gfm/unnamed-chunk-27-2.png)<!-- -->

``` r
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_histogram(binwidth=0.05, fill="gray70", colour="black") + facet_grid(used ~ ., scales = "free")
```

![](README_files/figure-gfm/unnamed-chunk-27-3.png)<!-- -->

``` r
ggplot(wolfkde, aes(x=fitted.Elev, fill=usedFactor)) + geom_histogram(binwidth=0.05, position="identity", alpha=0.7) + xlab("Predicted Probability of Wolf Use") + theme(axis.title.x=element_text(size=16))
```

![](README_files/figure-gfm/unnamed-chunk-27-4.png)<!-- -->

``` r
# lets redo this graph using faceting by pack
ggplot(wolfkde, aes(x = fitted.Elev, y=after_stat(density), fill=usedFactor)) + geom_histogram(binwidth=0.05, position="identity", alpha=0.7) + xlab("Predicted Probability of Wolf Use") + theme(axis.title.x=element_text(size=16)) + facet_grid(pack ~ ., scales="free")
```

![](README_files/figure-gfm/unnamed-chunk-27-5.png)<!-- --> This gives
us a firm sense that things differ by pack, not only the \# of
locations, but also the relatively lower predicted probability of use
for the Red deer wolf pack compared to the Bow Valley wolf pack. Why is
this? Remind ourselves of the structure of our model - it is a simple
GLM of used \~ elevation, with no differences or accounting for
differences between wolf packs. You can imagine an excercise would be to
estimate the pack-specific univariate beta-coefficients between wolf
packs for the same suite of covariates. What ecological questions would
this address?

``` r
# Now lets explore fitting functions to the distributions
ggplot(wolfkde, aes(x=fitted.Elev)) + geom_density()
```

![](README_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

``` r
ggplot(wolfkde, aes(x=fitted.Elev), fill=usedFactor) + geom_density(alpha=0.5) + xlim(0,1)+xlab("Predicted Probability of Wolf Use") + theme(axis.title.x=element_text(size=16)) 
```

![](README_files/figure-gfm/unnamed-chunk-28-2.png)<!-- -->

``` r
# kernel lines
ggplot(wolfkde, aes(x=fitted.Elev, y=..density.., fill=usedFactor)) + geom_histogram(binwidth=0.05) + geom_density(alpha = 0.5) + facet_grid(pack ~ .)
```

    ## Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
    ## ℹ Please use `after_stat(density)` instead.

![](README_files/figure-gfm/unnamed-chunk-28-3.png)<!-- -->

## Plotting Logistic Regresson with ggplot2

ggplot2 has a great handy function called + stat_smooth for plotting
logistic regression. stat_smooth() can be specified to fit a univariate
glm with a binomial logistic regression model beween y\~x, and add this
plot - with its 95% CI - to a gpplot.

``` r
# Exploring Predictions as a function of covariates
# this fits a univariate glm as a function of elevation and predicts
ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](README_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

## Distance from human access

``` r
ggplot(wolfkde, aes(x=DistFromHumanAccess2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 42 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 42 rows containing missing values (`geom_point()`).

![](README_files/figure-gfm/unnamed-chunk-30-1.png)<!-- -->

``` r
ggplot(wolfkde, aes(x=elk_w2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 249 rows containing missing values (`geom_point()`).

![](README_files/figure-gfm/unnamed-chunk-30-2.png)<!-- -->

But whats up with the dots? - lets jitter and see

``` r
ggplot(wolfkde, aes(x=elk_w2, y=used)) + geom_point() +geom_jitter(aes(colour = used), width=0.25, height = 0.05) + stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## Warning: Removed 249 rows containing missing values (`geom_point()`).
    ## Removed 249 rows containing missing values (`geom_point()`).

![](README_files/figure-gfm/unnamed-chunk-31-1.png)<!-- -->

What the jittering shows is the nice, clear separation between 0’s and
1’s. MOST 1’s are \> 4 H.S.I. ranking scores, and similarly, most 0’s
are \< 5 HSI score.

``` r
## lets redo elevation jittered by used
ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point() +geom_jitter(aes(colour = used), width=0.25, height = 0.05)+ stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](README_files/figure-gfm/unnamed-chunk-32-1.png)<!-- -->

## Splitting by wolf pack

Next we will split by wolf packs, and change the confidence interval to
99th. However, note that this fits two separate logistic regression
models to each wolf packs Y \~ Elevation. I often use this to explore
whether or not there are differences between groups or factors before
proceeding to fit statistical models split by factors. Lets take a look:

``` r
ggplot(wolfkde, aes(x=Elevation2, y=used, colour=pack)) + geom_point() + geom_jitter(width=0.25, height = 0.05) +stat_smooth(method="glm", method.args = list(family="binomial"), level=0.90)
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](README_files/figure-gfm/unnamed-chunk-33-1.png)<!-- --> This is the
first analysis that shows us the two wolf packs respond very differently
to elevation. I wonder if they respond differently to Moose, or Sheep,
say?

``` r
ggplot(wolfkde, aes(x=moose_w2, y=used, colour=pack)) + stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

![](README_files/figure-gfm/unnamed-chunk-34-1.png)<!-- -->

``` r
ggplot(wolfkde, aes(x=sheep_w2, y=used, colour=pack)) + stat_smooth(method="glm", method.args = list(family="binomial"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

![](README_files/figure-gfm/unnamed-chunk-34-2.png)<!-- --> This
provides ample evidence that perhaps we should not be pooling over both
wolf packs and paves the way for your homework this week. You can also
facet by pack, and put each pack in its own panel.

``` r
# versus faceting by wolf pack
ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point() + stat_smooth(method="glm", method.args = list(family="binomial"), level=0.90) + facet_grid(pack~.)
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](README_files/figure-gfm/unnamed-chunk-35-1.png)<!-- --> And finally,
this last plot again illustrates the futility of fitting a linear model
(lm) to binary data compared against the predictions from the elev
model.

``` r
# this function plots predictions from the previously fitted best model
ggplot(wolfkde, aes(x=Elevation2, y=fitted.Elev)) + geom_point() + stat_smooth(method=lm) + ylim(0, 0.8)
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 38 rows containing missing values (`geom_smooth()`).

![](README_files/figure-gfm/unnamed-chunk-36-1.png)<!-- -->

Lastly, I will illustrate our first use of the effects package which is
especially nice later for quickly visualizing interactions. `?effect`.
Learn more here <https://www.jstatsoft.org/article/view/v008i15>

``` r
plot(effects::effect("Elevation2", elev), grid=TRUE, rescale.axis = FALSE, ylab = "Probability(Used)") 
```

![](README_files/figure-gfm/unnamed-chunk-37-1.png)<!-- -->

Lets explore the effects() function more with other variables.

``` r
plot(effects::effect("deer_w2", deer), grid=TRUE, rescale.axis = FALSE, ylab = "Probability(Used)")
```

![](README_files/figure-gfm/unnamed-chunk-38-1.png)<!-- -->

## Saving Graphics

It is a HUGE time saver to use R to make publication quality figures see
here:
<https://www.r-bloggers.com/creating-publication-quality-graphics-using-r/>
and <https://www.r-bloggers.com/high-resolution-figures-in-r/>

``` r
#Printing PDFs from R
pdf("Output/wolf_elev.pdf", width=4, height=4)
print(ggplot(wolfkde, aes(x=Elevation2, y=used)) + geom_point(colour="gray") + stat_smooth(method="glm", method.args = list(family="binomial")) + xlab("Elevation (m)") + ylab("Predicted Probability of Wolf Use"))
```

    ## `geom_smooth()` using formula = 'y ~ x'

``` r
dev.off()
```

    ## png 
    ##   2

``` r
# then go and look in the active directory for wolf_elev.pdf
#or
ggsave("Output/elev_wolf2.pdf", width=4, height=4)
```

    ## `geom_smooth()` using formula = 'y ~ x'

``` r
#
```

Now - how to make a figure of all 5 prey species predictions \## code
figured out from Latham et al. (2013) in Ecography

Latham, A. D. M., M. C. Lathan, K. H. Knopff, M. Hebblewhite, and S.
Boutin. 2013. Wolves, deer and beaver: implications of prey enrichment
and seasonal prey swtiching for woodland caribou declines. . Ecography
36:001 - 015. ![Figure 3.3. Relative probability of wolf resource
selection in (a) winter (October–March) and (b) summer (April–September)
in the West and East Sides of the Athabasca River caribou ranges,
northeastern Alberta, Canada,
2006–2008.](Figures/Latham%20et%20al_ECOGRAPHY_E0035%202.jpg)

``` r
figPrey<-ggplot(wolfkde, aes(x=elk_w2, y=used)) + geom_smooth(data = wolfkde, aes(x=elk_w2, y=used, col="Elk"),method="glm", method.args = list(family="binomial")) + geom_smooth(data = wolfkde, aes(x=deer_w2, y=used, col="Deer"),method="glm", method.args = list(family="binomial"))+ geom_smooth(data = wolfkde, aes(x=moose_w2, y=used, col="Moose"),method="glm", method.args = list(family="binomial"))+ geom_smooth(data = wolfkde, aes(x=sheep_w2, y=used, col="Sheep"),method="glm", method.args = list(family="binomial"))+ geom_smooth(data = wolfkde, aes(x=goat_w2, y=used, col="Goat"),method="glm", method.args = list(family="binomial")) + xlab("Relative prey habitat suitability") + ylab("Relative probability of wolf use") + theme(axis.title.y=element_text(size=12), axis.text.y=element_text(size=12)) + theme(axis.title.x=element_text(size=12), axis.text.x=element_text(size=12))+ labs(fill="Prey Species")

figPrey
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

![](README_files/figure-gfm/unnamed-chunk-40-1.png)<!-- -->

``` r
## lets save this
pdf("Output/figPrey.pdf", width=6, height=6)
figPrey
```

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

    ## `geom_smooth()` using formula = 'y ~ x'

    ## Warning: Removed 249 rows containing non-finite values (`stat_smooth()`).

``` r
dev.off()
```

    ## png 
    ##   2

Now, remember that the figure is saved in your working directory.

# Literature Cited

Boyce, M. S. and L. L. McDonald. 1999. Relating populations to habitats
using resource selection functions. Trends in ecology and evolution
14:268-272.

Hosmer, D. W. and S. Lemeshow, editors. 2000. Applied Logistic
Regression. John Wiley and Sons, New York.

Manly, B. F. J., L. L. McDonald, D. L. Thomas, T. L. McDonald, and W. P.
Erickson, editors. 2002. Resource selection by animals: statistical
analysis and design for field studies. Second Edition. Kluwer, Boston,
USA.

# Homework 3: LAB 3 Practice Excercises

I encourage you to work through these questions for practice excercises.
Some questions merely summarize what we did in Lab (Q1). Q2 asks you to
fit univariate logistic regression models by the 2 packs, and summarize
results to understand if there are differences (or similarities) between
wolf packs for selection for the 8 univariate covariates. Q3 is a
typical compare 2 forms of sampling availability question, comparing
availability sampled with KDE or MCPs.

1.  Summarize the patterns of univariate selection you have examined for
    ALL covariates pooled across wolf packs and then separated by wolf
    packs (new). Answer the following question.

<!-- -->

1.  What are the most important variables (strongest) in their
    univariate effect on wolf resource selection? What are the effects?
2.  How do the patterns of selection observed this week relate to the
    analysis of USE from lab 2?
3.  How do the effects of covariates differ between wolf packs?

<!-- -->

2)  Split the wolfkde dataset by the 2 wolf packs, and refit univariate
    logistic regression models to each of the covariates. Summarize
    these in a table showing Pack as columns (3 columns total with the
    pooled model we fit in lab as well), and then the 8 covariates as
    rows so you can easily compare coefficients between 3 sets of models
    we compared. Which coefficients show that wolves have different
    selectivity for covariates?

3)  Repeat (on your own) the steps required to merge the USED wolf data
    with the AVAILABLE wolf pack data from the 95% MCP Home ranges we
    developed in LAB 2. Note – this may mean you need to quickly re-run
    Lab 2 to save the MCP home ranges, and sample 1000 random
    availability points within these MCP’s. With the merged USED/AVAIL
    dataset for 95% MCP home ranges, repeat the analyses in this lab –
    what are the main differences (if any) between the MCP and Kernel
    home range estimates of Availability??
