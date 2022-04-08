##
# Run this file as: julia --project=. libjpeg2ktest.jl inside (base) ashwani@user:~/Desktop/GSOC/io-project/jpeg2000wrapper$
##
## imports
using Libdl
using FileIO
using ColorTypes
using ColorVectorSpace
using FixedPointNumbers

include("lib/LibOpenJpeg.jl")
push!(DL_LOAD_PATH, "./libopenjpegextra")


# load a image from filename:
# support different versions of colorspaces
# save in different versions

RGB = 1
GRAY = 0

function load(filename::AbstractString;)
    n = ccall((:decode, :libopenjpegextra), Ptr{LibOpenJpeg.opj_image_t}, (Ptr{Cchar},), filename)
    N = unsafe_load(n)
    components = unsafe_wrap(Array, N.comps, N.numcomps)
    println("Width:", N.x1,", Height:", N.y1)
    data = convert(Array{UInt8}, (unsafe_wrap(Array, components[1].data, N.x1 * N.y1)))
    res = reinterpret(Gray{N0f8}, data)
    res = reshape(res, Int64(N.x1), Int64(N.y1))
    res =  res'
    # save("./test.jpg",res)
    return res
end

filename = "./libopenjpegextra/notes/sample1.jp2"
load(filename)