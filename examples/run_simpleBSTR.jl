using ProcessModels
using ModelingToolkit
using DifferentialEquations
using Plots

@mtkbuild bstr = SimpleBSTR(;k = 1)

u_0 = [bstr.c_A => 10, bstr.c_B => 0] 

tspan = (0,1000)

prob = ODEProblem(bstr,u_0,tspan)

sol = solve(prob)

plot(sol)

