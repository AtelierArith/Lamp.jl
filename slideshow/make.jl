#=

using Remark

for d in
    ["lamp"]
    Remark.slideshow(
        joinpath(@__DIR__, d);
        options=Dict("ratio" => "16:9"), title="Lamp.jl",
    )
end

=#

using NodeJS

run(`$(npm_cmd()) install --save-dev @marp-team/marp-cli`)

npx_executable_path = joinpath(NodeJS.nodejs_path, "bin", "npx")

function npx_cmd()
    `$npx_executable_path`
end

mdfile = joinpath(@__DIR__, "lamp/src/index.md")
themefile = joinpath(@__DIR__, "lamp/src/custom.css")
run(`$(npx_cmd()) @marp-team/marp-cli $(mdfile) --theme $(themefile)`)