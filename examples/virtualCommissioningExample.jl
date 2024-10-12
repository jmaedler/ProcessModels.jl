using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using DifferentialEquations
using Plots

# Create a simple Tank model with reading and writing events
function affect!(integ,vars,pars,_)
    integ.ps[pars.S] = 0.5 + 0.5*sin(2*3.14*integ.ps[pars.freq]*integ.t)
    L = integ.u[vars.V]/integ.ps[pars.A] # Calculate L using V and A
    println("$L") # Read L using the passed identifier
    u_modified!(integ,false) # Avoid reinitialization due to BUG
end

@mtkmodel Tank begin
    @constants begin
        g::Float64 = 9.81, [description = "Gravitational acceleration."]
    end
    @parameters begin
        S(t)::Float64 = 0.0
        k_V::Float64 = 10.0
        rho::Float64 = 1000.0
        A::Float64 = 1.0
        freq::Float64 = 0.1
    end
    @variables begin
        F_in(t)::Float64, [guess = 0.0]
        F_out(t)::Float64, [guess = 0.0]
        L(t)::Float64, [guess = 0.0] 
        V(t)::Float64 = 1.0, [irreducible = true] # Making V irreducible, since it is necessary for the calculation in the callback
        Dp(t)::Float64, [guess = 0.0]
    end
    @equations begin
        D(V) ~ F_in - F_out
        V ~ A*L
        Dp ~ rho*g*L
        F_out ~ S*k_V*sign(Dp)*sqrt(abs(Dp)/100000*1000/rho)
    end
    @discrete_events begin
        1.0 => (affect!,[V],[freq,S,A],[S],nothing) # Pass indentfier for L to affect! function
    end
end

# Create composite model
@mtkmodel SimulateTankSystem begin
    @components begin
        tank1 = Tank(;A=1.0)
        tank2 = Tank(;A=2.0,freq=0.2)
    end
    @equations begin
        tank1.F_in ~ 2.0
        tank2.F_in ~ tank1.F_out
    end
end

# Main function
function main()
    @mtkbuild sys = SimulateTankSystem()

    prob = ODEProblem(sys, [], (0.0, 10.0);tstops=0:0.1:10.0)

    sol = solve(prob,Tsit5()) # Hier wird ein DAE-Solver gebraucht, da die Gleichung für L erhalten bleibt!

    # Plotting
    S_plot = plot(sol;idxs=sys.tank1.S);
    S_plot = plot!(sol;idxs=sys.tank2.S);
    L_plot = plot(sol;idxs=sys.tank1.L, denseplot = false);
    L_plot = plot!(sol;idxs=sys.tank2.L, denseplot = false);
    V_plot = plot(sol;idxs=sys.tank1.V, denseplot = false);
    V_plot = plot!(sol;idxs=sys.tank2.V, denseplot = false);
    plot(S_plot,L_plot,V_plot,layout=(3,1))
end

main()