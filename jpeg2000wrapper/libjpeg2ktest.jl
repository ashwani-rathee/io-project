using Libdl
include("lib/LibOpenJpeg.jl")
push!(DL_LOAD_PATH, "./libopenjpegextra")

filename = "./libopenjpegextra/notes/sample1.jp2"
println("\n")
n = ccall((:decode, :libopenjpegextra), Ptr{LibOpenJpeg.opj_image_t}, (Ptr{Cchar},), filename)
println("\n")

N = unsafe_load(n)
# print(N)
println(unsafe_load(unsafe_load(N.comps).data))
# load a image from filename:
# support different versions of colorspaces
# save in different versions

function load(filename::String)
    filename = "./libopenjpegextra/notes/sample1.jp2"
    n = ccall((:decode, :libopenjpegextra), Ptr{LibOpenJpeg.opj_image_t}, (Ptr{Cchar},), filename)
    N = unsafe_load(n)
    println(N.numcomps)
end