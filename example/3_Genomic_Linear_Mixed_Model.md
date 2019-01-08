3.\_Genomic\_Linear\_Mixed\_Model
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
JWASr_path = find.package("JWASr")                            #find the local path of JWASr
JWASr_data_path = paste(JWASr_path,"/extdata/",sep= "")       #path for data
ped_path = paste(JWASr_data_path,"pedigree.txt",sep = "")     #path for pedigree.txt
geno_path = paste(JWASr_data_path,"genotypes.txt",sep = "")    #path for genotypes.txt
```
You can also use your local data path to define `ped_path` and `geno_path`.
``` r
pedigree = get_pedigree(ped_path, separator=',', header=TRUE) 
```



Univariate Linear Mixed Model (Genomic data)
---

### Step 3: Build Model Equations

``` r
model_equation1 = "y1 = intercept + x1*x3 + x2 + x3 + ID + dam";
R = 1.0

model1 = build_model(model_equation1,R) 
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


### Step 6: Use Genomic Information

``` r
G3 = 1.0
add_genotypes(model1, geno_path, G3, separator=',', header = TRUE)  
```

### Step 7: Run Bayesian Analysis

``` r
outputMCMCsamples(model1, "x2")
```

``` r
out = runMCMC(model1, phenotypes, methods = "BayesC", estimatePi = TRUE, 
                     chain_length = 5000, output_samples_frequency = 100) 
out
```

    ## $`Posterior mean of polygenic effects covariance matrix`
    ##           [,1]      [,2]
    ## [1,] 2.2515918 0.3201589
    ## [2,] 0.3201589 1.7288127
    ## 
    ## $`Posterior mean of marker effects`
    ##      [,1] [,2]      
    ## [1,] "m1" -0.3528505
    ## [2,] "m2" -0.2837558
    ## [3,] "m3" 0.7387871 
    ## [4,] "m4" 0.3174194 
    ## [5,] "m5" 0.3249077 
    ## 
    ## $`Posterior mean of residual variance`
    ## [1] 1.272377
    ## 
    ## $`Posterior mean of marker effects variance`
    ## [1] 0.9280905
    ## 
    ## $`Posterior mean of location parameters`
    ##    Trait    Effect     Level    Estimate
    ## 1      1 intercept intercept    11.22084
    ## 2      1     x1*x3    x1 * m    2.056661
    ## 3      1     x1*x3    x1 * f   0.9054161
    ## 4      1        x2         2   0.2748953
    ## 5      1        x2         1  -0.2128133
    ## 6      1        x3         m   -13.91094
    ## 7      1        x3         f   -13.89881
    ## 8      1        ID        a2   0.2053027
    ## 9      1        ID        a1   0.2089958
    ## 10     1        ID        a3   -0.235355
    ## 11     1        ID        a7  0.04042069
    ## 12     1        ID        a4  -0.3907794
    ## 13     1        ID        a6  -0.1865815
    ## 14     1        ID        a9  -0.2896912
    ## 15     1        ID        a5   0.8834916
    ## 16     1        ID       a10   0.4266387
    ## 17     1        ID       a12  0.07726209
    ## 18     1        ID       a11  0.04771032
    ## 19     1        ID        a8  -0.6744953
    ## 20     1       dam        a2   0.6520092
    ## 21     1       dam        a1  -0.1223837
    ## 22     1       dam        a3  -0.1084323
    ## 23     1       dam        a7 -0.08451849
    ## 24     1       dam        a4   0.2548246
    ## 25     1       dam        a6  -0.4173132
    ## 26     1       dam        a9  0.01880938
    ## 27     1       dam        a5   0.3874218
    ## 28     1       dam       a10   0.1851588
    ## 29     1       dam       a12   0.1197191
    ## 30     1       dam       a11    0.113721
    ## 31     1       dam        a8 -0.03800705
    ## 
    ## $`Posterior mean of Pi`
    ## [1] 0.3757778

Multivariate Linear Mixed Model (Genomic data)
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
set_random(model2, "x2", G1)
```


``` r
G2 = diag(4)
set_random_ped(model2, "ID dam", pedigree, G2)
```


### Step 6: Use Genomic Information

``` r
G3 = diag(3)
add_genotypes(model2, geno_path, G3, separator = ',', header = TRUE)  
```

### Step 7: Run Bayesian Analysis

``` r
outputMCMCsamples(model2, "x2")
```


``` r
out2 = runMCMC(model2, phenotypes, methods = "BayesC", estimatePi = TRUE, chain_length = 5000, output_samples_frequency = 100)
```

We can select specified result, for example, "Posterior mean of Pi".

``` r
 out2$`Posterior mean of Pi`
```

    ## $`[1.0, 1.0, 0.0]`
    ## [1] 0.1414603
    ## 
    ## $`[0.0, 0.0, 0.0]`
    ## [1] 0.1157675
    ## 
    ## $`[1.0, 0.0, 0.0]`
    ## [1] 0.1405228
    ## 
    ## $`[0.0, 1.0, 1.0]`
    ## [1] 0.1104829
    ## 
    ## $`[1.0, 0.0, 1.0]`
    ## [1] 0.1323508
    ## 
    ## $`[0.0, 0.0, 1.0]`
    ## [1] 0.1092856
    ## 
    ## $`[1.0, 1.0, 1.0]`
    ## [1] 0.1338292
    ## 
    ## $`[0.0, 1.0, 0.0]`
    ## [1] 0.1163008

All results

``` r
out2
```

    ## $`Posterior mean of polygenic effects covariance matrix`
    ##             [,1]         [,2]         [,3]        [,4]
    ## [1,]  1.11046525 -0.301740327 -0.068583319  0.02358558
    ## [2,] -0.30174033  1.060070354 -0.004732375 -0.01842695
    ## [3,] -0.06858332 -0.004732375  0.847376902 -0.03139959
    ## [4,]  0.02358558 -0.018426951 -0.031399592  0.89325743
    ## 
    ## $`Model frequency`
    ## Julia Object of type Array{Array{Float64,1},1}.
    ## Array{Float64,1}[[0.6026, 0.5614, 0.8218, 0.567, 0.588], [0.553, 0.4942, 0.5564, 0.5032, 0.4946], [0.4414, 0.487, 0.487, 0.445, 0.4712]]
    ## $`Posterior mean of marker effects`
    ## $`Posterior mean of marker effects`[[1]]
    ##      [,1] [,2]      
    ## [1,] "m1" -0.348707 
    ## [2,] "m2" -0.2568689
    ## [3,] "m3" 0.9459965 
    ## [4,] "m4" 0.2666736 
    ## [5,] "m5" 0.2858568 
    ## 
    ## $`Posterior mean of marker effects`[[2]]
    ##      [,1] [,2]       
    ## [1,] "m1" 0.3013397  
    ## [2,] "m2" 0.1372816  
    ## [3,] "m3" -0.3487142 
    ## [4,] "m4" -0.1126686 
    ## [5,] "m5" -0.07387788
    ## 
    ## $`Posterior mean of marker effects`[[3]]
    ##      [,1] [,2]       
    ## [1,] "m1" 0.01560571 
    ## [2,] "m2" -0.1257267 
    ## [3,] "m3" -0.1909362 
    ## [4,] "m4" -0.04438518
    ## [5,] "m5" 0.01595111 
    ## 
    ## 
    ## $`Posterior mean of marker effects covariance matrix`
    ##             [,1]        [,2]        [,3]
    ## [1,]  0.78742143 -0.08543852 -0.04644018
    ## [2,] -0.08543852  0.59608915 -0.01831761
    ## [3,] -0.04644018 -0.01831761  0.48020575
    ## 
    ## $`Posterior mean of residual variance`
    ##             [,1]        [,2]        [,3]
    ## [1,]  1.17370351 -0.41981751 -0.02838261
    ## [2,] -0.41981751  1.15984119 -0.08667158
    ## [3,] -0.02838261 -0.08667158  0.79706916
    ## 
    ## $`Posterior mean of marker effects variance`
    ##             [,1]        [,2]        [,3]
    ## [1,]  0.78742143 -0.08543852 -0.04644018
    ## [2,] -0.08543852  0.59608915 -0.01831761
    ## [3,] -0.04644018 -0.01831761  0.48020575
    ## 
    ## $`Posterior mean of location parameters`
    ##    Trait    Effect     Level     Estimate
    ## 1      1 intercept intercept     32.21929
    ## 2      1        x1        x1    0.9131961
    ## 3      1        x3         m    -34.01638
    ## 4      1        x3         f    -34.52477
    ## 5      1        ID        a2  -0.05716014
    ## 6      1        ID        a1    0.1868688
    ## 7      1        ID        a3   -0.1949345
    ## 8      1        ID        a7   0.02883038
    ## 9      1        ID        a4   -0.4025737
    ## 10     1        ID        a6   -0.1724982
    ## 11     1        ID        a9   -0.2828338
    ## 12     1        ID        a5    0.5386816
    ## 13     1        ID       a10    0.2722372
    ## 14     1        ID       a12  -0.02503967
    ## 15     1        ID       a11  0.006221662
    ## 16     1        ID        a8   -0.7136537
    ## 17     1       dam        a2    0.4407947
    ## 18     1       dam        a1   -0.1395491
    ## 19     1       dam        a3   -0.1564929
    ## 20     1       dam        a7   -0.1141477
    ## 21     1       dam        a4    0.1523033
    ## 22     1       dam        a6   -0.3848841
    ## 23     1       dam        a9  -0.05133943
    ## 24     1       dam        a5    0.1656039
    ## 25     1       dam       a10   0.05150225
    ## 26     1       dam       a12 -0.001888326
    ## 27     1       dam       a11   0.03107539
    ## 28     1       dam        a8   -0.1094652
    ## 29     2 intercept intercept    -16.22043
    ## 30     2        x1        x1    0.1656188
    ## 31     2        x2         2   -0.1952748
    ## 32     2        x2         1     0.326396
    ## 33     2        x3         m     21.33518
    ## 34     2        x3         f     19.79537
    ## 35     2        ID        a2    0.2806208
    ## 36     2        ID        a1   -0.3204084
    ## 37     2        ID        a3    0.0278819
    ## 38     2        ID        a7   0.01188378
    ## 39     2        ID        a4    0.4665653
    ## 40     2        ID        a6    0.1094586
    ## 41     2        ID        a9    0.2222683
    ## 42     2        ID        a5   -0.2349071
    ## 43     2        ID       a10   -0.1280968
    ## 44     2        ID       a12   0.04255067
    ## 45     2        ID       a11   0.01549121
    ## 46     2        ID        a8    0.7771148
    ## 47     3 intercept intercept   -0.5473773
    ## 48     3        x1        x1     -9.20709
    ## 49     3     x1*x3    x1 * m     9.027483
    ## 50     3     x1*x3    x1 * f     9.320441
    ## 51     3        x2         2  -0.07216963
    ## 52     3        x2         1   0.01347271
    ## 53     3        ID        a2   -0.1511818
    ## 54     3        ID        a1   -0.3940017
    ## 55     3        ID        a3    0.3949147
    ## 56     3        ID        a7   -0.2806019
    ## 57     3        ID        a4   -0.2590409
    ## 58     3        ID        a6   -0.1215465
    ## 59     3        ID        a9   -0.2386465
    ## 60     3        ID        a5   -0.4399348
    ## 61     3        ID       a10   -0.3477279
    ## 62     3        ID       a12   -0.3080151
    ## 63     3        ID       a11   -0.2786712
    ## 64     3        ID        a8   -0.2663514
    ## 
    ## $`Posterior mean of Pi`
    ## $`Posterior mean of Pi`$`[1.0, 1.0, 0.0]`
    ## [1] 0.1414603
    ## 
    ## $`Posterior mean of Pi`$`[0.0, 0.0, 0.0]`
    ## [1] 0.1157675
    ## 
    ## $`Posterior mean of Pi`$`[1.0, 0.0, 0.0]`
    ## [1] 0.1405228
    ## 
    ## $`Posterior mean of Pi`$`[0.0, 1.0, 1.0]`
    ## [1] 0.1104829
    ## 
    ## $`Posterior mean of Pi`$`[1.0, 0.0, 1.0]`
    ## [1] 0.1323508
    ## 
    ## $`Posterior mean of Pi`$`[0.0, 0.0, 1.0]`
    ## [1] 0.1092856
    ## 
    ## $`Posterior mean of Pi`$`[1.0, 1.0, 1.0]`
    ## [1] 0.1338292
    ## 
    ## $`Posterior mean of Pi`$`[0.0, 1.0, 0.0]`
    ## [1] 0.1163008
