## Simple Batch Rector

This is a simple model of an batch stirred tank reactor (BSTR). Assuming a reaction system of

```math
\mathrm{A} \rightarrow \mathrm{B}
```

the following system of differential equations can be derived:


```math
\begin{align*}
\frac{\mathrm{d} \, c_\mathrm{A}}{\mathrm{d} \, t} &= - k \, c_\mathrm{A} \\
\frac{\mathrm{d} \, c_\mathrm{B}}{\mathrm{d} \, t} &= k \, c_\mathrm{B}
\end{align*}
```

| Name  | Unit  | Description |
| :--- | :--- | :--- |
|``c_\mathrm{A}``| ``\mathrm{mol \, L^{-1}}`` | Molar concentration of species A |
|``c_\mathrm{B}``| ``\mathrm{mol \, L^{-1}}`` | Molar concentration of species B |