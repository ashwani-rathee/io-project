using Libdl
include("lib/LibOpenJpeg.jl")
push!(DL_LOAD_PATH, "./libopenjpegextra")

filename = "./libopenjpegextra/notes/sample1.jp2"

n = ccall((:decode, :libopenjpegextra), LibOpenJpeg.opj_image_t, (Ptr{Cchar},), filename)

print(typeof(n.numcomps))