using Pkg
Pkg.activate(".")
include("LibExif.jl")
ed_ptr = LibExif.exif_data_new_from_file("test.jpg")

# file non existent case
# julia> ed_ptr = LibExif.exif_data_new_from_file("test.jpg")
# Ptr{Main.LibExif._ExifData} @0x0000000000000000
ed_ptr = LibExif.exif_data_new_from_file("test.jpg")
ed = unsafe_load(ed_ptr)
content_ptr = ed.ifd[1]
make_ptr = LibExif.exif_content_get_entry(content_ptr, LibExif.EXIF_TAG_ARTIST)
# if tag non existent, nothing returned and weird stuff returned
# even this cost

str = Vector{Cuchar}(undef, 1024);
LibExif.exif_entry_get_value(make_ptr, str, length(str))
rstrip(String(str), '\0')

function printallexifdata(filepath, data=1)
    # 0 doesn't work
    ed_ptr = LibExif.exif_data_new_from_file(filepath)
    ed = unsafe_load(ed_ptr)
    content_ptr = ed.ifd[data]
    LibExif.exif_content_dump(content_ptr, 0)
    return
end

function readtag(filepath,  tag)
    ed_ptr = LibExif.exif_data_new_from_file(filepath)
    ed = unsafe_load(ed_ptr)
    content_ptr = ed.ifd[1]
    make_ptr = LibExif.exif_content_get_entry(content_ptr, tag)
    str = Vector{Cuchar}(undef, 1024);
    LibExif.exif_entry_get_value(make_ptr, str, length(str))
    return rstrip(String(str), '\0')
end
LibExif.EXIF_TAG_ARTIST

function getmeallindict(filepath)

end

function noofifd(filepath)
    ed_ptr = LibExif.exif_data_new_from_file(filepath)
    ed = unsafe_load(ed_ptr)
    return length(ed.ifd)
end

# WE HAVE A LOT OF directory but idk what they contain
# but let's still with pulling data from a single directory
function getmeentriescount(content_ptr)
    data = unsafe_load(content_ptr)
    return Int(data.count)
end


function read_exifcontent(content_ptr)
    data = unsafe_load(content_ptr)
    count = Int(data.count)
    res = unsafe_wrap(Array, data.entries, count)
    result = Dict()
    for i in 1:count
        str = Vector{Cuchar}(undef, 1024);
        LibExif.exif_entry_get_value(Ref(unsafe_load(res[i])), str, length(str))
        result[string(unsafe_load(res[i]).tag)] = rstrip(String(str), '\0')
    end
    return result
end


function getthumbnail(filepath)

end