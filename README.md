
# JWASr

### Installation

1. Install [Julia](https://julialang.org/downloads/).
2. Install [R](https://www.r-project.org) and [RStudio](https://www.rstudio.com/products/rstudio/download/) (IDE).
3. Install prerequisite R package `JuliaCall` and `devtools` in R.

    ```bash
    install.packages("JuliaCall")
    install.packages("devtools")
    ```

    If the error massage `Installation failed: Command failed (50)` is shown, please install the latest version of devtools as `devtools::install_github("hadley/devtools")`.

4. Install R package `JWASr` in R

    ```bash
    devtools::install_github("zhaotianjing/JWASr")
    ```
### Set up
Please set up **every time** you start a new session of R. The set up time is about 10 second.
* Mac or Linux users
    ```bash
    JWASr::jwasr_setup()
    ```

 * Windows users
    ```bash
    # please change to your local path of libjulia.dll
    path_libjulia = "C:/Users/ztjsw/AppData/Local/Julia-0.7.0/bin/libjulia.dll"
    JWASr::jwasr_setup_win(path_libjulia)
    ```
    If R session aborted, please click "Start New Session" and set up again.

### Workflow
#### Step 1: Load Package
``` r
library("JWASr")
```
Please make sure you've already set up.


#### Step 2: Read data
``` r
phenotypes = phenotypes #build-in data

ped_path = "D:\\JWASr\\data\\pedigree.txt" #please change to your local path
get_pedigree(ped_path, separator = ',', header = T)  #build "pedigree" in Julia
```

#### Step 3: Build Model Equations
``` r
model_equation ="y1 = intercept + x1 + x3 + ID + dam
                  y2 = intercept + x1 + x2 + x3 + ID
                  y3 = intercept + x1 + x1*x3 + x2 + ID"
R = diag(3)
model = build_model(model_equation, R)
```

#### Step 4: Set Factors or Covariate

``` r
set_covariate("x1")
```


#### Step 5: Set Random or Fixed Effects

``` r
G1 = diag(2)
set_random("x2",G1)
```


``` r
G2 = diag(4)
set_random("ID dam", G2, pedigree = TRUE)
```


#### Step 6: Use Genomic Information

``` r
G3 = diag(3)
geno_path = "D:/JWASr/data/genotypes.txt"  #change to your local path

add_genotypes(geno_path, G3)  #separator=',' is default
```

#### Step 7: Run Bayesian Analysis

``` r
outputMCMCsamples("x2")
```

### For developers
After updating the code locally, please run `devtools::document()` in the package folder.
