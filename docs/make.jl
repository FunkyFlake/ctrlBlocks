using ctrlBlocks
using Documenter

DocMeta.setdocmeta!(ctrlBlocks, :DocTestSetup, :(using ctrlBlocks); recursive=true)

makedocs(;
    modules=[ctrlBlocks],
    authors="Jan Lauble",
    repo="https://github.com/FunkyFlake/ctrlBlocks.jl/blob/{commit}{path}#{line}",
    sitename="ctrlBlocks.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://FunkyFlake.github.io/ctrlBlocks.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/FunkyFlake/ctrlBlocks.jl",
    devbranch="master",
)
