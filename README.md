



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
Please set up **every time** you start a new session of R. The set up time is about 10 seconds.
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
Note that all data can be found in our subfolder named "data".

  #### Step 1: Load Package
```bash
library("JWASr")
```
Please make sure you've already set up.

  #### Step 2: Read data

```bash
phenotypes = phenotypes #build-in data

ped_path = "D:\\JWASr\\data\\pedigree.txt" #please change to your local path
pedigree = get_pedigree(ped_path, separator = ',', header = TRUE)  
```
You can import your own data by [read.table()](https://www.rdocumentation.org/packages/utils/versions/3.5.1/topics/read.table).


#### Step 3: Build Model Equations

```bash
model_equation = "y1 = intercept + x1*x3 + x2 + x3 + ID + dam";
R = 1.0

model = build_model(model_equation,R) 
```


#### Step 4: Set Factors or Covariate

```bash
set_covariate(model, "x1")
```


#### Step 5: Set Random or Fixed Effects

```bash
G1 = 1.0
set_random(model, "x2", G1)
```


```bash
G2 = diag(2)
set_random_ped(model, "ID dam", pedigree, G2)
```


#### Step 6: Use Genomic Information

```bash
G3 = 1.0
geno_path = "D:/JWASr/data/genotypes.txt"  #please change to your local path

add_genotypes(model, geno_path, G3, separator=',', header = TRUE)  
```

#### Step 7: Run Bayesian Analysis

```bash
outputMCMCsamples(model, "x2")
```

``` r
out = runMCMC(model, phenotypes, methods = "BayesC", estimatePi = TRUE, 
                     chain_length = 5000, output_samples_frequency = 100) 
```


### For developers
If you change any function in subfolder "R", please run `devtools::document()` in R to update the package. (under path of JWASr).


# JWASr_GUI
[JWASr_GUI](https://github.com/zhaotianjing/JWASr_GUI) is a shiny app for JWASr, which provide GUI for user.

### Installation
The process is exactly same as R package [JWASr](https://github.com/zhaotianjing/JWASr), except you should also install `shiny` by `install.packages("shiny")` in R.

### Usage
There are two ways.
*  Use in package
	```bash
	JWASr::runShiny()
	```
* Or download&use from GitHub 
	```bash
	shiny::runGitHub('JWASr_GUI','zhaotianjing')
	```
