using MQTT
using Documenter

DocMeta.setdocmeta!(MQTT, :DocTestSetup, :(using MQTT); recursive=true)

makedocs(;
    modules=[MQTT],
    authors="Nicholas Shindler <nick@shindler.tech> and contributors",
    repo="https://github.com/JuliaMQTT/MQTT.jl/blob/{commit}{path}#{line}",
    sitename="MQTT.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaMQTT.github.io/MQTT.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaMQTT/MQTT.jl",
    devbranch="main",
)
