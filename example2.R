## To install "JuliaCall" in newest version:
# library(devtools)
# install_github("Non-Contradiction/JuliaCall")


library(JuliaCall)
## Do initial setup
julia <- julia_setup()

#check version
julia_installed_package("JWAS")
#using Pkg
julia_library("JWAS")
julia_library("CSV")

#Functions

build_model = function(model_equation,R){
  JuliaCall::julia_assign("R", R)
  JuliaCall::julia_assign("model_equation", model_equation)
  JuliaCall::julia_command("model = build_model(model_equation, R)");
  model=julia$eval("model") #print out
  return(model)
}

runMCMC = function(model,phenotypes){
  JuliaCall::julia_assign("model", model)
  JuliaCall::julia_assign("phenotypes", phenotypes)
  JuliaCall::julia_command("out = runMCMC(model, phenotypes)")
  out=julia$eval("out")  
  return(out)
}






#File path
file_path = "/Users/qtlcheng/Github/JWASr/phenotypes.txt"
phenotypes = read.csv(file_path,header=T,sep = ',')

# equation
model_equation = "y1 = intercept + x1"
R=1.0

# run model
model=build_model(model_equation,R)
runMCMC(model,phenotypes)

