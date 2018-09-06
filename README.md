# JWASr

### Installation

1. Install [Julia](https://julialang.org/downloads/).
2. Install [R](https://www.r-project.org) and RStudio (GUI).
3. Install R package `JuliaCall` and `devtools`.

    ```bash
    install.package("JuliaCall")
    install.package("devtools")
    ```

    If the error massage is shown as follows,
    ```bash
    Installation failed: Command failed (50)
    ```
    please install the latest version of devtools as
    ```bash
    devtools::install_github("hadley/devtools")
    ```

4. Install R package from Github

    ```bash
    library(devtools)
    install_github("zhaotianjing/JWASr")
    ```
5. Set up JWASr.
    * Mac or Linux users
    ```bash
    JWASr::jwasr_setup()
    ```

    * Windows users
    ```bash
    # find your own path to libjulia.dll
    path_libjulia = "C:/Users/ztjsw/AppData/Local/Julia-0.7.0/bin/libjulia.dll"
    JWASr::jwasr_setup_win(path_libjulia)
    ```
