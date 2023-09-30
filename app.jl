module App

using Base64
using Random

using GenieFramework
using ImageCore
using ImageShow
# Edit lib/sample.jl to update `Aladding module`
using ..Aladdin

@genietools

function encode(io::IOBuffer, img)
    io2=IOBuffer()
    b64pipe=Base64EncodePipe(io2)
    write(io,"data:image/png;base64,")
    show(b64pipe, MIME"image/png"(), img) # will be valid if we load ImageShow.jl
    write(io, read(seekstart(io2)))
end

function encode(img::Matrix{<:Colorant})
    io = IOBuffer()
    encode(io, img)
    String(take!(io))
end

@app begin
    @in seed = 0
    timg = rand(RGB, 10, 10)
    @out imageurl = encode(timg)
    @onchange seed begin
        rng = Xoshiro(seed)
        ifs = rand(rng, Aladdin.IFSType)
        fill!(Aladdin.canvas, 0)
        timg = Aladdin.render!(rng, Aladdin.canvas, Aladdin.xs, Aladdin.ys, ifs)
        imageurl = encode(timg)
    end
end

@page("/", "app.jl.html")

end
