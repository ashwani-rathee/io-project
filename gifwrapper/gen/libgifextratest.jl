using Libdl
using FileIO
using ColorTypes
using ColorVectorSpace
using FixedPointNumbers

push!(DL_LOAD_PATH, "./libgifextra")
include("LibGif.jl")
# OutFileName = "intermediate.rgb";
# FileName = "Nasa-logo.gif";
# ref = pointer(FileName)
# ref2 = pointer(OutFileName)
# NumFiles = Cint(1);
# OneFileFlag = Bool(true);
# ccall((:GIF2RGB, :libgifextra), Cvoid, ( Cint, Ptr{Cchar}, Bool,  Ptr{Cchar}),  NumFiles, ref, OneFileFlag, ref2)

# InfileName = "intermediate.rgb"
# ref1 = pointer(InfileName)
# FileName = "out.gif"
# FileName = Vector{UInt8}(FileName)

# ref = pointer(FileName)
# OneFileFlag = Bool(true);
# Width = Cint(1008)
# Height = Cint(863)
# NumFiles = Cint(1)
# ExpNumOfColors = Cint(4)

# ccall((:RGB2GIF, :libgifextra), Cvoid, (Bool, Cint, Ptr{Cchar}, Ptr{Cchar}, Cint, Cint, Cint), OneFileFlag, NumFiles, ref, ref1, ExpNumOfColors, Width, Height)


# # load a image from filename:

function load(filename::AbstractString;)
    n = ccall((:returnGIF, :libgifextra), Ptr{LibGif.GifFileType}, (Ptr{Cchar},), filename)
    N = unsafe_load(n)
    components = unsafe_wrap(Array, N.SavedImages, N.ImageCount)
    println("Width:", N.SWidth)
    println("Height:", N.SHeight)
    println("Number of Images:", N.ImageCount)
    final = []
    for i in 1:N.ImageCount
        img = unsafe_wrap(Array, components[i].RasterBits, N.SWidth * N.SHeight) 
        res = reinterpret(Gray{N0f8}, img)
        res = reshape(res, Int64(N.SWidth), Int64(N.SHeight))
        res =  res'
        save("./testrunresults/test$(i).jpg",res)
        append!(final, res)
    end
    return final
end

# (base) ashwani@user:~/Desktop/GSOC/io-project/gifwrapper/gen$ julia --project=./.. libgifextratest.jl 
# Width:265
# Height:199
# Number of Images:11

filename = "giphy.gif"
load(filename)