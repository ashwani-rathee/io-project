using Libdl

push!(DL_LOAD_PATH, "./libgifextra")

OutFileName = "intermediate.rgb";
FileName = "Nasa-logo.gif";
ref = pointer(FileName)
ref2 = pointer(OutFileName)
NumFiles = Cint(1);
OneFileFlag = Bool(true);
ccall((:GIF2RGB, :libgifextra), Cvoid, ( Cint, Ptr{Cchar}, Bool,  Ptr{Cchar}),  NumFiles, ref, OneFileFlag, ref2)

InfileName = "intermediate.rgb"
ref1 = pointer(InfileName)
FileName = "out.gif"
FileName = Vector{UInt8}(FileName)

ref = pointer(FileName)
OneFileFlag = Bool(true);
Width = Cint(1008)
Height = Cint(863)
NumFiles = Cint(1)
ExpNumOfColors = Cint(4)

ccall((:RGB2GIF, :libgifextra), Cvoid, (Bool, Cint, Ptr{Cchar}, Ptr{Cchar}, Cint, Cint, Cint), OneFileFlag, NumFiles, ref, ref1, ExpNumOfColors, Width, Height)