2. Linear Additive Genetic Model
================
Tianjing Zhao
August 27, 2018

### Step 1: Load Package

``` r
library("JWASr")
```
Please make sure you've already set up.

### Step 2: Read data

``` r
phenotypes = phenotypes #build-in data
```
You can import your own data by [read.table()](https://www.rdocumentation.org/packages/utils/versions/3.5.1/topics/read.table).
``` r
ped_path = "D:\\JWASr\\data\\pedigree.txt"  #please change to your local path
get_pedigree(ped_path, separator=',', header=TRUE) 
```
Univariate Linear Additive Genetic Model
---
### Step 3: Build Model Equations

``` r
model_equation1 = "y1 = intercept + x1*x3 + x2 + x3 + ID + dam";
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
set_random(model1, "x2", G1) 
```

``` r
G2 = diag(2)
set_random_ped(model1, "ID dam", pedigree, G2)
```


### Step 6: Run Bayesian Analysis

``` r
outputMCMCsamples(model1, "x2")
```

``` r
out = runMCMC(model1, phenotypes, chain_length = 5000, output_samples_frequency = 100)
out
```

    ## $`Posterior mean of polygenic effects covariance matrix`
    ##           [,1]      [,2]
    ## [1,] 3.3931469 0.3802194
    ## [2,] 0.3802194 1.6247857
    ## 
    ## $`Posterior mean of residual variance`
    ## [1] 1.778849
    ## 
    ## $`Posterior mean of location parameters`
    ##    Trait    Effect     Level     Estimate
    ## 1      1 intercept intercept    -30.19578
    ## 2      1     x1*x3    x1 * m   -0.9102935
    ## 3      1     x1*x3    x1 * f    0.6452522
    ## 4      1        x2         2  -0.01478697
    ## 5      1        x2         1 -0.001557767
    ## 6      1        x3         m     30.17486
    ## 7      1        x3         f     29.10591
    ## 8      1        ID        a2    0.1050424
    ## 9      1        ID        a1    0.3625167
    ## 10     1        ID        a3   -0.9619355
    ## 11     1        ID        a7    0.1805772
    ## 12     1        ID        a4    -1.284158
    ## 13     1        ID        a6   -0.9379141
    ## 14     1        ID        a9    -1.322888
    ## 15     1        ID        a5     1.525415
    ## 16     1        ID       a10     1.284201
    ## 17     1        ID       a12  -0.05131535
    ## 18     1        ID       a11  -0.05213253
    ## 19     1        ID        a8    -2.323727
    ## 20     1       dam        a2   0.07629914
    ## 21     1       dam        a1    -0.205709
    ## 22     1       dam        a3   -0.2856228
    ## 23     1       dam        a7   0.07904597
    ## 24     1       dam        a4   -0.2002867
    ## 25     1       dam        a6   -0.8363825
    ## 26     1       dam        a9    -0.466576
    ## 27     1       dam        a5   0.02053787
    ## 28     1       dam       a10   0.00751982
    ## 29     1       dam       a12    -0.206505
    ## 30     1       dam       a11   -0.2423756
    ## 31     1       dam        a8   -0.6223393

Multivariate Linear Additive Genetic Model
---
### Step 3: Build Model Equations
``` r
model_equation2 ="y1 = intercept + x1 + x3 + ID + dam
                  y2 = intercept + x1 + x2 + x3 + ID
                  y3 = intercept + x1 + x1*x3 + x2 + ID"
R = diag(3)

model2 = build_model(model_equation2, R)
```



### Step 4: Set Factors or Covariate


``` r
set_covariate(model2, "x1")
```


### Step 5: Set Random or Fixed Effects

``` r
G1 = diag(2)
set_random(model2,"x2",G1)
```


``` r
G2 = diag(4)
set_random_ped(model2, "ID dam", pedigree, G2)
```


### Step 6: Run Bayesian Analysis

``` r
outputMCMCsamples(model2, "x2")
```


``` r
out = runMCMC(data = phenotypes, chain_length = 5000, output_samples_frequency = 100, outputEBV = TRUE)   
```

We can select specified result, for example, "EBV\_y2"

``` r
out$EBV_y2
```

    ##       [,1]  [,2]      
    ##  [1,] "a2"  0.6062295 
    ##  [2,] "a1"  -0.6944214
    ##  [3,] "a7"  -0.7921685
    ##  [4,] "a12" -0.2416416
    ##  [5,] "a5"  -0.9816584
    ##  [6,] "a3"  -0.2682168
    ##  [7,] "a4"  1.160835  
    ##  [8,] "a6"  0.2334113 
    ##  [9,] "a10" -1.8595   
    ## [10,] "a11" -0.2383322
    ## [11,] "a8"  1.38478   
    ## [12,] "a9"  1.332655

Or "out[1]"

All results

``` r
out
```

    ## $EBV_y2
    ##       [,1]  [,2]      
    ##  [1,] "a2"  0.6062295 
    ##  [2,] "a1"  -0.6944214
    ##  [3,] "a7"  -0.7921685
    ##  [4,] "a12" -0.2416416
    ##  [5,] "a5"  -0.9816584
    ##  [6,] "a3"  -0.2682168
    ##  [7,] "a4"  1.160835  
    ##  [8,] "a6"  0.2334113 
    ##  [9,] "a10" -1.8595   
    ## [10,] "a11" -0.2383322
    ## [11,] "a8"  1.38478   
    ## [12,] "a9"  1.332655  
    ## 
    ## $`Posterior mean of polygenic effects covariance matrix`
    ##             [,1]       [,2]        [,3]        [,4]
    ## [1,]  2.53764988 -1.5032986 -0.27064753  0.07234178
    ## [2,] -1.50329859  2.1127901  0.33853987 -0.10457687
    ## [3,] -0.27064753  0.3385399  0.94876189 -0.08366245
    ## [4,]  0.07234178 -0.1045769 -0.08366245  0.98494329
    ## 
    ## $EBV_y1
    ##       [,1]  [,2]      
    ##  [1,] "a2"  0.7280166 
    ##  [2,] "a1"  0.6580267 
    ##  [3,] "a7"  0.6361615 
    ##  [4,] "a12" 0.5752607 
    ##  [5,] "a5"  2.156187  
    ##  [6,] "a3"  -0.4688096
    ##  [7,] "a4"  -0.7570163
    ##  [8,] "a6"  -0.7570586
    ##  [9,] "a10" 2.285231  
    ## [10,] "a11" 0.5526151 
    ## [11,] "a8"  -1.741143 
    ## [12,] "a9"  -1.054158 
    ## 
    ## $EBV_y3
    ##       [,1]  [,2]       
    ##  [1,] "a2"  0.2215576  
    ##  [2,] "a1"  -0.5713717 
    ##  [3,] "a7"  -0.612759  
    ##  [4,] "a12" -0.158376  
    ##  [5,] "a5"  -0.6377978 
    ##  [6,] "a3"  0.2545787  
    ##  [7,] "a4"  -0.1576888 
    ##  [8,] "a6"  0.004126426
    ##  [9,] "a10" -0.7603757 
    ## [10,] "a11" -0.1414264 
    ## [11,] "a8"  -0.2574019 
    ## [12,] "a9"  0.419824   
    ## 
    ## $`Posterior mean of residual variance`
    ##             [,1]        [,2]        [,3]
    ## [1,]  1.70004726 -0.83074652 -0.04949942
    ## [2,] -0.83074652  1.41029386  0.06950121
    ## [3,] -0.04949942  0.06950121  0.82406161
    ## 
    ## $`Posterior mean of location parameters`
    ##    Trait    Effect     Level     Estimate
    ## 1      1 intercept intercept     27.99374
    ## 2      1        x1        x1     0.573256
    ## 3      1        x3         m    -29.47289
    ## 4      1        x3         f    -29.44521
    ## 5      1        ID        a2    0.3947647
    ## 6      1        ID        a1    0.5881265
    ## 7      1        ID        a3   -0.5372246
    ## 8      1        ID        a7    0.3867613
    ## 9      1        ID        a4   -0.8821649
    ## 10     1        ID        a6   -0.5565861
    ## 11     1        ID        a9    -1.022439
    ## 12     1        ID        a5     1.866521
    ## 13     1        ID       a10     1.962364
    ## 14     1        ID       a12    0.4371826
    ## 15     1        ID       a11    0.4250572
    ## 16     1        ID        a8    -1.744681
    ## 17     1       dam        a2    0.3332519
    ## 18     1       dam        a1   0.06990018
    ## 19     1       dam        a3   0.06841504
    ## 20     1       dam        a7    0.2494001
    ## 21     1       dam        a4    0.1251486
    ## 22     1       dam        a6   -0.2004725
    ## 23     1       dam        a9  -0.03171866
    ## 24     1       dam        a5    0.2896667
    ## 25     1       dam       a10    0.3228672
    ## 26     1       dam       a12    0.1380781
    ## 27     1       dam       a11    0.1275579
    ## 28     1       dam        a8  0.003538235
    ## 29     2 intercept intercept    -4.003138
    ## 30     2        x1        x1    0.1493666
    ## 31     2        x2         2 -0.002360669
    ## 32     2        x2         1   0.03438047
    ## 33     2        x3         m     8.915057
    ## 34     2        x3         f     7.779748
    ## 35     2        ID        a2    0.6062295
    ## 36     2        ID        a1   -0.6944214
    ## 37     2        ID        a3   -0.2682168
    ## 38     2        ID        a7   -0.7921685
    ## 39     2        ID        a4     1.160835
    ## 40     2        ID        a6    0.2334113
    ## 41     2        ID        a9     1.332655
    ## 42     2        ID        a5   -0.9816584
    ## 43     2        ID       a10      -1.8595
    ## 44     2        ID       a12   -0.2416416
    ## 45     2        ID       a11   -0.2383322
    ## 46     2        ID        a8      1.38478
    ## 47     3 intercept intercept  -0.05089487
    ## 48     3        x1        x1  -0.02038974
    ## 49     3     x1*x3    x1 * m    -0.749217
    ## 50     3     x1*x3    x1 * f    0.0405443
    ## 51     3        x2         2  -0.07135401
    ## 52     3        x2         1    0.1694405
    ## 53     3        ID        a2    0.2215576
    ## 54     3        ID        a1   -0.5713717
    ## 55     3        ID        a3    0.2545787
    ## 56     3        ID        a7    -0.612759
    ## 57     3        ID        a4   -0.1576888
    ## 58     3        ID        a6  0.004126426
    ## 59     3        ID        a9     0.419824
    ## 60     3        ID        a5   -0.6377978
    ## 61     3        ID       a10   -0.7603757
    ## 62     3        ID       a12    -0.158376
    ## 63     3        ID       a11   -0.1414264
    ## 64     3        ID        a8   -0.2574019






