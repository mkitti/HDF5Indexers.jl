using HDF5Indexers
using Documenter

DocMeta.setdocmeta!(HDF5Indexers, :DocTestSetup, :(using HDF5Indexers); recursive=true)

makedocs(;
    modules=[HDF5Indexers],
    authors="Mark Kittisopikul <markkitt@gmail.com> and contributors",
    repo="https://github.com/mkitti/HDF5Indexers.jl/blob/{commit}{path}#{line}",
    sitename="HDF5Indexers.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mkitti.github.io/HDF5Indexers.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mkitti/HDF5Indexers.jl",
    devbranch="main",
)
