




# JWASr

### Installation

1. Install [Julia](https://julialang.org/downloads/).
2. Install [R](https://www.r-project.org) and [RStudio](https://www.rstudio.com/products/rstudio/download/) (IDE).
3. Install prerequisite R package `JuliaCall` and `devtools` in R.

    ```r
    install.packages("JuliaCall")
    install.packages("devtools")
    ```

    If the error massage `Installation failed: Command failed (50)` is shown, please install the latest version of devtools as `devtools::install_github("hadley/devtools")`.

4. Install R package `JWASr` in R

    ```r
    devtools::install_github("zhaotianjing/JWASr")
    ```

5. Install required `Julia` packages (`JWAS` and `CSV`) if needed

    ```r
    JuliaCall::julia_install_package_if_needed("JWAS")
    JuliaCall::julia_install_package_if_needed("CSV")
    ```

### Set up
Please set up **every time** you start a new session of R. The set up time is about 10 seconds.
* Mac or Linux users
    ```r
    JWASr::jwasr_setup()
    ```

 * Windows users
    ```r    
    path_libjulia <- file.path(JuliaCall:::julia_locate(), "libjulia.dll")
    JWASr::jwasr_setup_win(path_libjulia)
    ```
    If R session aborted, please click "Start New Session" and set up again.

### Workflow
Note that all data can be found in our subfolder named "data".

  #### Step 1: Load Package
```r
library("JWASr")
```
Please make sure you've already set up.

  #### Step 2: Read data

```r
ped_path <- system.file("extdata", "pedigree.txt", package = "JWASr")
pedigree <- get_pedigree(ped_path, separator = ',', header = TRUE)  
```
You can import your own data by [read.table()](https://www.rdocumentation.org/packages/utils/versions/3.5.1/topics/read.table).

#### Step 3: Build Model Equations

```r
model_equation <- "y1 = intercept + x1*x3 + x2 + x3 + ID + dam";
R <- 1.0

model <- build_model(model_equation,R)
```


#### Step 4: Set Factors or Covariate

```r
set_covariate(model, "x1")
```


#### Step 5: Set Random or Fixed Effects

```r
G1 <- 1.0
set_random(model, "x2", G1)
```


```r
G2 <- diag(2)
set_random_ped(model, "ID dam", pedigree, G2)
```


#### Step 6: Use Genomic Information

```r
G3 <- 1.0
geno_path <- system.file("extdata", "genotypes.txt", package = "JWASr")

add_genotypes(model, geno_path, G3, separator = ',', header = TRUE)  
```

#### Step 7: Run Bayesian Analysis

```r
outputMCMCsamples(model, "x2")
```

``` r
out <- runMCMC(model, phenotypes, methods = "BayesC", estimatePi = TRUE,
                     chain_length = 5000, output_samples_frequency = 100)
```


### For developers
If you change any function in subfolder "R", please run `devtools::document()` in R to update the package. (under path of JWASr).


# GUI
In the package, we provide a user friendly Graphical User Interface application, which was build by `shiny`.

### Installation
After complete installation above for `JWAS`, please also install `shiny` by `install.packages("shiny")` in R.

### Usage
In R, please run:
```r
JWASr::runShiny()
```

### To-do list
 * script to install required packages if not installed
 * improve GUI interface
 * add the complete interface to JWAS.jl
