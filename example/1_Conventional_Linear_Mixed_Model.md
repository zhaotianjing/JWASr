1. Bayesian Linear Mixed Models (conventional)
================
Tianjing Zhao
August 26, 2018

### Step 1: Load Package

``` r
library("JWASr")
```
Please make sure you've already set up.


### Step 2: Read data

``` r
phenotypes = phenotypes  #build-in data
phenotypes
```

    ##     ID    y1   y2    y3  x1 x2 x3 dam
    ## 1   a1 -0.06 3.58 -1.18 0.9  2  m   0
    ## 2   a2 -0.60 4.90  0.88 0.3  1  f   0
    ## 3   a3 -2.07 3.19  0.73 0.7  2  f   0
    ## 4   a4 -2.63 6.97 -0.83 0.6  1  m  a2
    ## 5   a5  2.31 3.50 -1.52 0.4  2  m  a2
    ## 6   a6  0.93 4.87 -0.01 5.0  2  f  a3
    ## 7   a7 -0.69 3.10 -1.47 0.5  2  f  a3
    ## 8   a8 -4.69 7.31 -1.09 0.3  2  m  a6
    ## 9   a9 -2.81 7.18  0.76 0.4  2  m  a6
    ## 10 a10  1.92 1.78 -0.88 0.2  1  m  a7
You can import your own data by [read.table()](https://www.rdocumentation.org/packages/utils/versions/3.5.1/topics/read.table).

Univariate Linear Mixed Model (conventional)
----

### Step 3: Build Model Equations

``` r
model_equation1 = "y1 = intercept + x1*x3 + x2 + x3"
R = 1.0

model1 = build_model(model_equation1, R)
```

### Step 4: Set Factors or Covariate

``` r
set_covariate(model1, "x1")
```

### Step 5: Set Random or Fixed Effects

``` r
G1 = 1.0
set_random(model1, "x2",G1)
```

### Step 6: Run Bayesian Analysis

``` r
outputMCMCsamples(model1, "x3")
out = runMCMC(model1, phenotypes, chain_length=5000, output_samples_frequency=100)
out
```

    ## $`Posterior mean of residual variance`
    ## [1] 5.480242
    ##
    ## $`Posterior mean of location parameters`
    ##   Trait    Effect     Level    Estimate
    ## 1     1 intercept intercept   -60.94357
    ## 2     1     x1*x3    x1 * m -0.02613005
    ## 3     1     x1*x3    x1 * f   0.4772402
    ## 4     1        x2         2  -0.1875421
    ## 5     1        x2         1   0.1704768
    ## 6     1        x3         m    60.04687
    ## 7     1        x3         f    59.67192
  
Multivariate Linear Mixed Model (conventional)
---
### Step 3: Build Model Equations
``` r
model_equation2 ="y1 = intercept + x1 + x3
                  y2 = intercept + x1 + x2 + x3
                  y3 = intercept + x1 + x1*x3 + x2"
R = diag(3)

model2 = build_model(model_equation2,R)
```


### Step 4: Set Factors or Covariate

``` r
set_covariate(model2, "x1")
```


### Step 5: Set Random or Fixed Effects

``` r
G1 = diag(2)
set_random(model2, "x2", G1)
```


### Step 6: Run Bayesian Analysis

``` r
outputMCMCsamples(model2, "x1")
```


``` r
out2 = runMCMC(model2, phenotypes, chain_length=5000, output_samples_frequency=100)
out2
```

    ## $`Posterior mean of residual variance`
    ##            [,1]       [,2]       [,3]
    ## [1,]  4.4927093 -3.0977890 -0.5987682
    ## [2,] -3.0977890  3.4710408  0.5944115
    ## [3,] -0.5987682  0.5944115  1.0333277
    ## 
    ## $`Posterior mean of location parameters`
    ##    Trait    Effect     Level   Estimate
    ## 1      1 intercept intercept  -6.927895
    ## 2      1        x1        x1  0.3599465
    ## 3      1        x3         m    5.73187
    ## 4      1        x3         f   5.802203
    ## 5      2 intercept intercept   7.077444
    ## 6      2        x1        x1  0.3167174
    ## 7      2        x2         2 -0.1327011
    ## 8      2        x2         1  0.2475499
    ## 9      2        x3         m  -2.127094
    ## 10     2        x3         f  -3.608548
    ## 11     3 intercept intercept -0.1340349
    ## 12     3        x1        x1  -7.934409
    ## 13     3     x1*x3    x1 * m   6.921875
    ## 14     3     x1*x3    x1 * f   8.014301
    ## 15     3        x2         2 -0.1757257
    ## 16     3        x2         1  0.1214085





