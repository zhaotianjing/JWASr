# JWASr

### Installation

1. Install [Julia](https://julialang.org/downloads/).
2. Install [R](https://www.r-project.org) and RStudio (GUI).
3. Install prerequisite R package `JuliaCall` and `devtools`.

    ```bash
    install.package("JuliaCall")
    install.package("devtools")
    ```

    If the error massage `Installation failed: Command failed (50)` is shown, please install the latest version of devtools as `devtools::install_github("hadley/devtools")`.

4. Install R package `JWASr` from Github

    ```bash
    library(devtools)
    install_github("zhaotianjing/JWASr")
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

