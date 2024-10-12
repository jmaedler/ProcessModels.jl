# Virtual Commissioning
## Concept
Virtual commissioning using [ModelingToolkit.jl](https://docs.sciml.ai/ModelingToolkit/stable/) can be achieve
- using the [Integrator Interface](https://docs.sciml.ai/DiffEqDocs/stable/basics/integrator/) of [DifferentialEquations.jl](https://docs.sciml.ai/DiffEqDocs/stable/basics/integrator/) to achieved fixed simulation speed
- using [Discrete Events](https://docs.sciml.ai/ModelingToolkit/stable/basics/Events/) for
  - writing inputs to actuators from an external soft-controller to the simulation
  - writing sensor values from the simulation to an external soft-controller

## Example: Two Tanks
The model equation system is
```math
\begin{align}
    \frac{\mathrm{d}V}{\mathrm{d}t} &= \dot{F}_\mathrm{in} - \dot{F}_\mathrm{out} \\
    V &= A \, L \\
    \Delta p &= p_\infty + \, \rho \, g \, L - p_\mathrm{out} \\
    \dot{F}_\mathrm{out} &= S\, k_\mathrm{V} \sqrt{\frac{\Delta p}{p_0} \, \frac{\rho_0}{\rho}}
\end{align}
```

## Implementation

