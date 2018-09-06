library(devtools)
install_github("zhaotianjing/JWASr")
#devtools::document()
library("JWASr")

pheno_path = phenotypes

model_equation = "y1 = intercept + x1*x3 + x2 + x3"
R = 1.0

build_model(model_equation, R)  #build "model" in Julia


JWASr::jwasr_setup()
JWASr::jwasr_setup_win()