using NodeJS

run(`$(npm_cmd()) install --save-dev @marp-team/marp-cli`)

npx_executable_path = joinpath(NodeJS.nodejs_path, "bin", "npx")

function npx_cmd()
    `$npx_executable_path`
end

for d in ["lamp", "art"]
    mdfile = joinpath(@__DIR__, "$(d)/src/index.md")
    themefile = joinpath(@__DIR__, "$(d)/src/custom.css")
    run(`$(npx_cmd()) @marp-team/marp-cli $(mdfile) --theme $(themefile)`)
end
