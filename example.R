## To install "JuliaCall" in newest version:
# library(devtools)
# install_github("Non-Contradiction/JuliaCall")


JuliaCall:::juliacall_initialize("C:\\Users\\ztjsw\\AppData\\Local\\Julia-0.7.0\\bin\\libjulia.dll")
library(JuliaCall)
## Do initial setup
julia <- julia_setup()

#check version
julia_installed_package("JWAS")
#using Pkg
julia_library("JWAS")
julia_library("CSV")

file_path = "D:\\julialearn\\phenotypes.txt"
JuliaCall::julia_assign("file_path", file_path)

# load data
julia_command("phenotypes = CSV.read(file_path, delim = ',', header=true)")
julia$eval("phenotypes") # print data

# equation
model_equation = "y1 = intercept + x1"
JuliaCall::julia_assign("model_equation", model_equation)

# R
R=1.0
JuliaCall::julia_assign("R", 0.1)

# run model
JuliaCall::julia_command("model = build_model(model_equation, R)")
JuliaCall::julia_command("out = runMCMC(model, phenotypes)")  #bugs!
julia$eval("out") #print out

