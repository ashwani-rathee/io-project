using Clang.JLLEnvs
using Clang.Generators
using OpenJpeg_jll
cd(@__DIR__)

include_dir = normpath(OpenJpeg_jll.artifact_dir, "include")

road = joinpath(@__DIR__, "src")
headers = [
    joinpath(include_dir, "openjpeg-2.4/openjpeg.h"),
    joinpath(include_dir, "openjpeg-2.4/opj_config.h"),
    joinpath(include_dir, "openjpeg-2.4/opj_stdint.h")
]

# data = ["/usr/lib/clang/10/include/stdint.h"]
# headers = [data; headers]

options = load_options(joinpath(@__DIR__, "wrap.toml"))

# args =   get_default_args("x86_64-linux-gnu")
# push!(args, "-lexif")
args =   get_default_args()
push!(args, "-I$include_dir")
push!(args, "--include=stdint.h")

ctx = create_context(headers, args, options)

build!(ctx)