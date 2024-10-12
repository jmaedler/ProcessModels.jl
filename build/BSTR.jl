using ModelingToolkit: t_nounits as t, D_nounits as D

@mtkmodel SimpleBSTR begin
    @parameters begin
        k
    end
    @variables begin
        c_A(t)
        c_B(t)
    end
    @equations begin
        D(c_A) ~ -k*c_A
        D(c_B) ~ k*c_A
    end
end