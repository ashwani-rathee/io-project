using BinaryBuilder, Pkg

name = "libgifextra"
version = v"1.0.1"
sources = [
    ArchiveSource("https://github.com/ashwani-rathee/io-project/raw/main/gifwrapper/gen/libgifextra.zip", "sha256 hash"),
]

script = raw"""
cd ${WORKSPACE}/srcdir/libgifextra-*
make -j${nproc}
make install
"""
# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:x86_64, libc=:glibc),
    Linux(:aarch64, libc=:glibc),
    Linux(:i686, libc=:glibc),
    MacOS(:x86_64),
    Windows(:x86_64),
]

products = [
    LibraryProduct("libgifextra", :libgifextra),
]

dependencies = [
    Dependency("Giflib_jll"),
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)