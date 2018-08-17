
using CSV,JWAS
phenotypes = CSV.read("phenotypes.txt",delim = ',',header=true)
model_equation = "y1 = intercept + x1"
R=1.0
model=build_model(model_equation, R)
out=runMCMC(model,phenotypes)
