module Aladdin

using Random

using Images
using RandomLogos

const npoints = 100_000
const H = 384
const W = 384
const canvas = zeros(RGB{N0f8}, H, W)
const xs = Vector{Float64}(undef, npoints)
const ys = Vector{Float64}(undef, npoints)
const IFSType = RandomLogos.SigmaFactorIFS{2,Float64}
const render! = RandomLogos.render!

end
