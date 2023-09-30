using HDF5Indexer
using Documenter

DocMeta.setdocmeta!(HDF5Indexer, :DocTestSetup, :(using HDF5Indexer); recursive=true)

makedocs(;
    modules=[HDF5Indexer],
    authors="Mark Kittisopikul <markkitt@gmail.com> and contributors",
    repo="https://github.com/mkitti/HDF5Indexer.jl/blob/{commit}{path}#{line}",
    sitename="HDF5Indexer.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mkitti.github.io/HDF5Indexer.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mkitti/HDF5Indexer.jl",
    devbranch="main",
)
