using Clang.Generators

cd(@__DIR__)

road = joinpath(@__DIR__, "src")
headers = [joinpath(road, header) for header in readdir(road) if endswith(header, ".h")]

options = load_options(joinpath(@__DIR__, "wrap.toml"))

args =   get_default_args("x86_64-linux-gnu")
ctx = create_context(headers, args, options)

build!(ctx)