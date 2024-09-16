using ProcessModels
using Test
using ModelingToolkit
using DifferentialEquations

function test_simpleBSTR1(c_Ainit, c_Binit)
    @mtkbuild bstr = SimpleBSTR(;k = 1)
    u_0 = [bstr.c_A => c_Ainit, bstr.c_B => c_Binit] 
    tspan = (0,1000)
    prob = ODEProblem(bstr,u_0,tspan)
    sol = solve(prob)
    return sol       
end

sol1 = test_simpleBSTR1(0,0)
sol2 = test_simpleBSTR1(1,0)

@testset "ProcessModels.jl" begin
    # Write your tests here.
    @test isapprox(sol1.u[end][1], 0; atol = 1e-06)
    @test isapprox(sol1.u[end][2], 0; atol = 1e-06)
    @test isapprox(sol2.u[end][1], 0; atol = 1e-06)
    @test isapprox(sol2.u[end][2], 1; atol = 1e-06)
end