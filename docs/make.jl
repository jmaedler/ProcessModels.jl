using ProcessModels
using Documenter

DocMeta.setdocmeta!(ProcessModels, :DocTestSetup, :(using ProcessModels); recursive=true)

makedocs(;
    modules=[ProcessModels],
    authors="Jonathan Mädler <j.maedler@gmx.net>",
    sitename="ProcessModels.jl",
    format=Documenter.HTML(;
        canonical="https://jmaedler.github.io/ProcessModels.jl",
        edit_link="main",
        assets=String[],
        prettyurls = get(ENV, "CI", nothing) == "true", # Modifiziert: für ordentliche lokale Verlinkung
    ),
    pages=[
        "Home" => "index.md",
        "BSTR" => "examples/simple_bstr.md",
        "Virtual Commissioning" => "examples/virtualCommissioningExample.md"
    ],
)

deploydocs(;
    repo="github.com/jmaedler/ProcessModels.jl",
    devbranch="main",
)