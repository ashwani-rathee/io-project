using BinaryBuilder

name = "libgifextra"
version = v"1.0.1"
sources = [
    ArchiveSource("<url to source tarball>", "sha256 hash"),
]

script = raw"""
cd ${WORKSPACE}/srcdir/libgifextra-*
make -j${nproc}
make install
"""

platforms = supported_platforms()

products = [
    LibraryProduct("libfoo", :libfoo),
    ExecutableProduct("fooifier", :fooifier),
]

dependencies = [
    Dependency("giflib_jll"),
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)