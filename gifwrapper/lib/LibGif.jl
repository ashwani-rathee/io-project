module LibGif

using Giflib_jll

function GAPrintErrMsg(Error)
    ccall((:GAPrintErrMsg, libgif), Cvoid, (Cint,), Error)
end

function GAPrintHowTo(CtrlStr)
    ccall((:GAPrintHowTo, libgif), Cvoid, (Ptr{Cchar},), CtrlStr)
end

function PrintGifError(ErrorCode)
    ccall((:PrintGifError, libgif), Cvoid, (Cint,), ErrorCode)
end

const GifByteType = Cuchar

struct GifColorType
    Red::GifByteType
    Green::GifByteType
    Blue::GifByteType
end

function GifQuantizeBuffer(Width, Height, ColorMapSize, RedInput, GreenInput, BlueInput, OutputBuffer, OutputColorMap)
    ccall((:GifQuantizeBuffer, libgif), Cint, (Cuint, Cuint, Ptr{Cint}, Ptr{GifByteType}, Ptr{GifByteType}, Ptr{GifByteType}, Ptr{GifByteType}, Ptr{GifColorType}), Width, Height, ColorMapSize, RedInput, GreenInput, BlueInput, OutputBuffer, OutputColorMap)
end

function LoadRGB(FileName, OneFileFlag, RedBuffer, GreenBuffer, BlueBuffer, Width, Height)
    ccall((:LoadRGB, libgif), Cvoid, (Ptr{Cchar}, Cint, Ptr{Ptr{GifByteType}}, Ptr{Ptr{GifByteType}}, Ptr{Ptr{GifByteType}}, Cint, Cint), FileName, OneFileFlag, RedBuffer, GreenBuffer, BlueBuffer, Width, Height)
end

struct ColorMapObject
    ColorCount::Cint
    BitsPerPixel::Cint
    SortFlag::Bool
    Colors::Ptr{GifColorType}
end

function SaveGif(OutputBuffer, Width, Height, ExpColorMapSize, OutputColorMap)
    ccall((:SaveGif, libgif), Cvoid, (Ptr{GifByteType}, Cint, Cint, Cint, Ptr{ColorMapObject}), OutputBuffer, Width, Height, ExpColorMapSize, OutputColorMap)
end

function RGB2GIF(OneFileFlag, NumFiles, FileName, ExpNumOfColors, Width, Height)
    ccall((:RGB2GIF, libgif), Cvoid, (Bool, Cint, Ptr{Cchar}, Cint, Cint, Cint), OneFileFlag, NumFiles, FileName, ExpNumOfColors, Width, Height)
end

const GifRowType = Ptr{Cuchar}

function DumpScreen2RGB(FileName, OneFileFlag, ColorMap, ScreenBuffer, ScreenWidth, ScreenHeight)
    ccall((:DumpScreen2RGB, libgif), Cvoid, (Ptr{Cchar}, Cint, Ptr{ColorMapObject}, Ptr{GifRowType}, Cint, Cint), FileName, OneFileFlag, ColorMap, ScreenBuffer, ScreenWidth, ScreenHeight)
end

function GIF2RGB(NumFiles, FileName, OneFileFlag, OutFileName)
    ccall((:GIF2RGB, libgif), Cvoid, (Cint, Ptr{Cchar}, Bool, Ptr{Cchar}), NumFiles, FileName, OneFileFlag, OutFileName)
end

struct GifHashTableType
    HTable::NTuple{8192, UInt32}
end

function _InitHashTable()
    ccall((:_InitHashTable, libgif), Ptr{GifHashTableType}, ())
end

function _ClearHashTable(HashTable)
    ccall((:_ClearHashTable, libgif), Cvoid, (Ptr{GifHashTableType},), HashTable)
end

function _InsertHashTable(HashTable, Key, Code)
    ccall((:_InsertHashTable, libgif), Cvoid, (Ptr{GifHashTableType}, UInt32, Cint), HashTable, Key, Code)
end

function _ExistsHashTable(HashTable, Key)
    ccall((:_ExistsHashTable, libgif), Cint, (Ptr{GifHashTableType}, UInt32), HashTable, Key)
end

const GifPixelType = Cuchar

const GifPrefixType = Cuint

const GifWord = Cint

struct GifImageDesc
    Left::GifWord
    Top::GifWord
    Width::GifWord
    Height::GifWord
    Interlace::Bool
    ColorMap::Ptr{ColorMapObject}
end

struct ExtensionBlock
    ByteCount::Cint
    Bytes::Ptr{GifByteType}
    Function::Cint
end

struct SavedImage
    ImageDesc::GifImageDesc
    RasterBits::Ptr{GifByteType}
    ExtensionBlockCount::Cint
    ExtensionBlocks::Ptr{ExtensionBlock}
end

struct GifFileType
    SWidth::GifWord
    SHeight::GifWord
    SColorResolution::GifWord
    SBackGroundColor::GifWord
    AspectByte::GifByteType
    SColorMap::Ptr{ColorMapObject}
    ImageCount::Cint
    Image::GifImageDesc
    SavedImages::Ptr{SavedImage}
    ExtensionBlockCount::Cint
    ExtensionBlocks::Ptr{ExtensionBlock}
    Error::Cint
    UserData::Ptr{Cvoid}
    Private::Ptr{Cvoid}
end

@enum GifRecordType::UInt32 begin
    UNDEFINED_RECORD_TYPE = 0
    SCREEN_DESC_RECORD_TYPE = 1
    IMAGE_DESC_RECORD_TYPE = 2
    EXTENSION_RECORD_TYPE = 3
    TERMINATE_RECORD_TYPE = 4
end

# typedef int ( * InputFunc ) ( GifFileType * , GifByteType * , int )
const InputFunc = Ptr{Cvoid}

# typedef int ( * OutputFunc ) ( GifFileType * , const GifByteType * , int )
const OutputFunc = Ptr{Cvoid}

struct GraphicsControlBlock
    DisposalMode::Cint
    UserInputFlag::Bool
    DelayTime::Cint
    TransparentColor::Cint
end

function EGifOpenFileName(GifFileName, GifTestExistence, Error)
    ccall((:EGifOpenFileName, libgif), Ptr{GifFileType}, (Ptr{Cchar}, Bool, Ptr{Cint}), GifFileName, GifTestExistence, Error)
end

function EGifOpenFileHandle(GifFileHandle, Error)
    ccall((:EGifOpenFileHandle, libgif), Ptr{GifFileType}, (Cint, Ptr{Cint}), GifFileHandle, Error)
end

function EGifOpen(userPtr, writeFunc, Error)
    ccall((:EGifOpen, libgif), Ptr{GifFileType}, (Ptr{Cvoid}, OutputFunc, Ptr{Cint}), userPtr, writeFunc, Error)
end

function EGifSpew(GifFile)
    ccall((:EGifSpew, libgif), Cint, (Ptr{GifFileType},), GifFile)
end

function EGifGetGifVersion(GifFile)
    ccall((:EGifGetGifVersion, libgif), Ptr{Cchar}, (Ptr{GifFileType},), GifFile)
end

function EGifCloseFile(GifFile, ErrorCode)
    ccall((:EGifCloseFile, libgif), Cint, (Ptr{GifFileType}, Ptr{Cint}), GifFile, ErrorCode)
end

function EGifPutScreenDesc(GifFile, GifWidth, GifHeight, GifColorRes, GifBackGround, GifColorMap)
    ccall((:EGifPutScreenDesc, libgif), Cint, (Ptr{GifFileType}, Cint, Cint, Cint, Cint, Ptr{ColorMapObject}), GifFile, GifWidth, GifHeight, GifColorRes, GifBackGround, GifColorMap)
end

function EGifPutImageDesc(GifFile, GifLeft, GifTop, GifWidth, GifHeight, GifInterlace, GifColorMap)
    ccall((:EGifPutImageDesc, libgif), Cint, (Ptr{GifFileType}, Cint, Cint, Cint, Cint, Bool, Ptr{ColorMapObject}), GifFile, GifLeft, GifTop, GifWidth, GifHeight, GifInterlace, GifColorMap)
end

function EGifSetGifVersion(GifFile, gif89)
    ccall((:EGifSetGifVersion, libgif), Cvoid, (Ptr{GifFileType}, Bool), GifFile, gif89)
end

function EGifPutLine(GifFile, GifLine, GifLineLen)
    ccall((:EGifPutLine, libgif), Cint, (Ptr{GifFileType}, Ptr{GifPixelType}, Cint), GifFile, GifLine, GifLineLen)
end

function EGifPutPixel(GifFile, GifPixel)
    ccall((:EGifPutPixel, libgif), Cint, (Ptr{GifFileType}, GifPixelType), GifFile, GifPixel)
end

function EGifPutComment(GifFile, GifComment)
    ccall((:EGifPutComment, libgif), Cint, (Ptr{GifFileType}, Ptr{Cchar}), GifFile, GifComment)
end

function EGifPutExtensionLeader(GifFile, GifExtCode)
    ccall((:EGifPutExtensionLeader, libgif), Cint, (Ptr{GifFileType}, Cint), GifFile, GifExtCode)
end

function EGifPutExtensionBlock(GifFile, GifExtLen, GifExtension)
    ccall((:EGifPutExtensionBlock, libgif), Cint, (Ptr{GifFileType}, Cint, Ptr{Cvoid}), GifFile, GifExtLen, GifExtension)
end

function EGifPutExtensionTrailer(GifFile)
    ccall((:EGifPutExtensionTrailer, libgif), Cint, (Ptr{GifFileType},), GifFile)
end

function EGifPutExtension(GifFile, GifExtCode, GifExtLen, GifExtension)
    ccall((:EGifPutExtension, libgif), Cint, (Ptr{GifFileType}, Cint, Cint, Ptr{Cvoid}), GifFile, GifExtCode, GifExtLen, GifExtension)
end

function EGifPutCode(GifFile, GifCodeSize, GifCodeBlock)
    ccall((:EGifPutCode, libgif), Cint, (Ptr{GifFileType}, Cint, Ptr{GifByteType}), GifFile, GifCodeSize, GifCodeBlock)
end

function EGifPutCodeNext(GifFile, GifCodeBlock)
    ccall((:EGifPutCodeNext, libgif), Cint, (Ptr{GifFileType}, Ptr{GifByteType}), GifFile, GifCodeBlock)
end

function DGifOpenFileName(GifFileName, Error)
    ccall((:DGifOpenFileName, libgif), Ptr{GifFileType}, (Ptr{Cchar}, Ptr{Cint}), GifFileName, Error)
end

function DGifOpenFileHandle(GifFileHandle, Error)
    ccall((:DGifOpenFileHandle, libgif), Ptr{GifFileType}, (Cint, Ptr{Cint}), GifFileHandle, Error)
end

function DGifSlurp(GifFile)
    ccall((:DGifSlurp, libgif), Cint, (Ptr{GifFileType},), GifFile)
end

function DGifOpen(userPtr, readFunc, Error)
    ccall((:DGifOpen, libgif), Ptr{GifFileType}, (Ptr{Cvoid}, InputFunc, Ptr{Cint}), userPtr, readFunc, Error)
end

function DGifCloseFile(GifFile, ErrorCode)
    ccall((:DGifCloseFile, libgif), Cint, (Ptr{GifFileType}, Ptr{Cint}), GifFile, ErrorCode)
end

function DGifGetScreenDesc(GifFile)
    ccall((:DGifGetScreenDesc, libgif), Cint, (Ptr{GifFileType},), GifFile)
end

function DGifGetRecordType(GifFile, GifType)
    ccall((:DGifGetRecordType, libgif), Cint, (Ptr{GifFileType}, Ptr{GifRecordType}), GifFile, GifType)
end

function DGifGetImageHeader(GifFile)
    ccall((:DGifGetImageHeader, libgif), Cint, (Ptr{GifFileType},), GifFile)
end

function DGifGetImageDesc(GifFile)
    ccall((:DGifGetImageDesc, libgif), Cint, (Ptr{GifFileType},), GifFile)
end

function DGifGetLine(GifFile, GifLine, GifLineLen)
    ccall((:DGifGetLine, libgif), Cint, (Ptr{GifFileType}, Ptr{GifPixelType}, Cint), GifFile, GifLine, GifLineLen)
end

function DGifGetPixel(GifFile, GifPixel)
    ccall((:DGifGetPixel, libgif), Cint, (Ptr{GifFileType}, GifPixelType), GifFile, GifPixel)
end

function DGifGetExtension(GifFile, GifExtCode, GifExtension)
    ccall((:DGifGetExtension, libgif), Cint, (Ptr{GifFileType}, Ptr{Cint}, Ptr{Ptr{GifByteType}}), GifFile, GifExtCode, GifExtension)
end

function DGifGetExtensionNext(GifFile, GifExtension)
    ccall((:DGifGetExtensionNext, libgif), Cint, (Ptr{GifFileType}, Ptr{Ptr{GifByteType}}), GifFile, GifExtension)
end

function DGifGetCode(GifFile, GifCodeSize, GifCodeBlock)
    ccall((:DGifGetCode, libgif), Cint, (Ptr{GifFileType}, Ptr{Cint}, Ptr{Ptr{GifByteType}}), GifFile, GifCodeSize, GifCodeBlock)
end

function DGifGetCodeNext(GifFile, GifCodeBlock)
    ccall((:DGifGetCodeNext, libgif), Cint, (Ptr{GifFileType}, Ptr{Ptr{GifByteType}}), GifFile, GifCodeBlock)
end

function DGifGetLZCodes(GifFile, GifCode)
    ccall((:DGifGetLZCodes, libgif), Cint, (Ptr{GifFileType}, Ptr{Cint}), GifFile, GifCode)
end

function DGifGetGifVersion(GifFile)
    ccall((:DGifGetGifVersion, libgif), Ptr{Cchar}, (Ptr{GifFileType},), GifFile)
end

function GifErrorString(ErrorCode)
    ccall((:GifErrorString, libgif), Ptr{Cchar}, (Cint,), ErrorCode)
end

function GifMakeMapObject(ColorCount, ColorMap)
    ccall((:GifMakeMapObject, libgif), Ptr{ColorMapObject}, (Cint, Ptr{GifColorType}), ColorCount, ColorMap)
end

function GifFreeMapObject(Object)
    ccall((:GifFreeMapObject, libgif), Cvoid, (Ptr{ColorMapObject},), Object)
end

function GifUnionColorMap(ColorIn1, ColorIn2, ColorTransIn2)
    ccall((:GifUnionColorMap, libgif), Ptr{ColorMapObject}, (Ptr{ColorMapObject}, Ptr{ColorMapObject}, Ptr{GifPixelType}), ColorIn1, ColorIn2, ColorTransIn2)
end

function GifBitSize(n)
    ccall((:GifBitSize, libgif), Cint, (Cint,), n)
end

function GifApplyTranslation(Image, Translation)
    ccall((:GifApplyTranslation, libgif), Cvoid, (Ptr{SavedImage}, Ptr{GifPixelType}), Image, Translation)
end

function GifAddExtensionBlock(ExtensionBlock_Count, ExtensionBlocks, Function, Len, ExtData)
    ccall((:GifAddExtensionBlock, libgif), Cint, (Ptr{Cint}, Ptr{Ptr{ExtensionBlock}}, Cint, Cuint, Ptr{Cuchar}), ExtensionBlock_Count, ExtensionBlocks, Function, Len, ExtData)
end

function GifFreeExtensions(ExtensionBlock_Count, ExtensionBlocks)
    ccall((:GifFreeExtensions, libgif), Cvoid, (Ptr{Cint}, Ptr{Ptr{ExtensionBlock}}), ExtensionBlock_Count, ExtensionBlocks)
end

function GifMakeSavedImage(GifFile, CopyFrom)
    ccall((:GifMakeSavedImage, libgif), Ptr{SavedImage}, (Ptr{GifFileType}, Ptr{SavedImage}), GifFile, CopyFrom)
end

function GifFreeSavedImages(GifFile)
    ccall((:GifFreeSavedImages, libgif), Cvoid, (Ptr{GifFileType},), GifFile)
end

function DGifExtensionToGCB(GifExtensionLength, GifExtension, GCB)
    ccall((:DGifExtensionToGCB, libgif), Cint, (Csize_t, Ptr{GifByteType}, Ptr{GraphicsControlBlock}), GifExtensionLength, GifExtension, GCB)
end

function EGifGCBToExtension(GCB, GifExtension)
    ccall((:EGifGCBToExtension, libgif), Csize_t, (Ptr{GraphicsControlBlock}, Ptr{GifByteType}), GCB, GifExtension)
end

function DGifSavedExtensionToGCB(GifFile, ImageIndex, GCB)
    ccall((:DGifSavedExtensionToGCB, libgif), Cint, (Ptr{GifFileType}, Cint, Ptr{GraphicsControlBlock}), GifFile, ImageIndex, GCB)
end

function EGifGCBToSavedExtension(GCB, GifFile, ImageIndex)
    ccall((:EGifGCBToSavedExtension, libgif), Cint, (Ptr{GraphicsControlBlock}, Ptr{GifFileType}, Cint), GCB, GifFile, ImageIndex)
end

function GifDrawText8x8(Image, x, y, legend, color)
    ccall((:GifDrawText8x8, libgif), Cvoid, (Ptr{SavedImage}, Cint, Cint, Ptr{Cchar}, Cint), Image, x, y, legend, color)
end

function GifDrawBox(Image, x, y, w, d, color)
    ccall((:GifDrawBox, libgif), Cvoid, (Ptr{SavedImage}, Cint, Cint, Cint, Cint, Cint), Image, x, y, w, d, color)
end

function GifDrawRectangle(Image, x, y, w, d, color)
    ccall((:GifDrawRectangle, libgif), Cvoid, (Ptr{SavedImage}, Cint, Cint, Cint, Cint, Cint), Image, x, y, w, d, color)
end

function GifDrawBoxedText8x8(Image, x, y, legend, border, bg, fg)
    ccall((:GifDrawBoxedText8x8, libgif), Cvoid, (Ptr{SavedImage}, Cint, Cint, Ptr{Cchar}, Cint, Cint, Cint), Image, x, y, legend, border, bg, fg)
end

function openbsd_reallocarray(optr, nmemb, size)
    ccall((:openbsd_reallocarray, libgif), Ptr{Cvoid}, (Ptr{Cvoid}, Csize_t, Csize_t), optr, nmemb, size)
end

struct GifFilePrivateType
    FileState::GifWord
    FileHandle::GifWord
    BitsPerPixel::GifWord
    ClearCode::GifWord
    EOFCode::GifWord
    RunningCode::GifWord
    RunningBits::GifWord
    MaxCode1::GifWord
    LastCode::GifWord
    CrntCode::GifWord
    StackPtr::GifWord
    CrntShiftState::GifWord
    CrntShiftDWord::Culong
    PixelCount::Culong
    File::Ptr{Cint}
    Read::InputFunc
    Write::OutputFunc
    Buf::NTuple{256, GifByteType}
    Stack::NTuple{4095, GifByteType}
    Suffix::NTuple{4096, GifByteType}
    Prefix::NTuple{4096, GifPrefixType}
    HashTable::Ptr{GifHashTableType}
    gif89::Bool
end

const VERSION_COOKIE = " Version %d.%d, "

const CMD_ERR_NotAnOpt = 1

const CMD_ERR_NoSuchOpt = 2

const CMD_ERR_WildEmpty = 3

const CMD_ERR_NumRead = 4

const CMD_ERR_AllSatis = 5

const PROGRAM_NAME = "gif2rgb"

const HT_SIZE = 8192

const HT_KEY_MASK = 0x1fff

const HT_KEY_NUM_BITS = 13

const HT_MAX_KEY = 8191

const HT_MAX_CODE = 4095

const _GIF_LIB_H_ = 1

const GIFLIB_MAJOR = 5

const GIFLIB_MINOR = 2

const GIFLIB_RELEASE = 1

const GIF_ERROR = 0

const GIF_OK = 1

const GIF_STAMP = "GIFVER"

# Skipping MacroDefinition: GIF_STAMP_LEN sizeof ( GIF_STAMP ) - 1

const GIF_VERSION_POS = 3

const GIF87_STAMP = "GIF87a"

const GIF89_STAMP = "GIF89a"

const CONTINUE_EXT_FUNC_CODE = 0x00

const COMMENT_EXT_FUNC_CODE = 0xfe

const GRAPHICS_EXT_FUNC_CODE = 0xf9

const PLAINTEXT_EXT_FUNC_CODE = 0x01

const APPLICATION_EXT_FUNC_CODE = 0xff

const DISPOSAL_UNSPECIFIED = 0

const DISPOSE_DO_NOT = 1

const DISPOSE_BACKGROUND = 2

const DISPOSE_PREVIOUS = 3

const NO_TRANSPARENT_COLOR = -1

const E_GIF_SUCCEEDED = 0

const E_GIF_ERR_OPEN_FAILED = 1

const E_GIF_ERR_WRITE_FAILED = 2

const E_GIF_ERR_HAS_SCRN_DSCR = 3

const E_GIF_ERR_HAS_IMAG_DSCR = 4

const E_GIF_ERR_NO_COLOR_MAP = 5

const E_GIF_ERR_DATA_TOO_BIG = 6

const E_GIF_ERR_NOT_ENOUGH_MEM = 7

const E_GIF_ERR_DISK_IS_FULL = 8

const E_GIF_ERR_CLOSE_FAILED = 9

const E_GIF_ERR_NOT_WRITEABLE = 10

const D_GIF_SUCCEEDED = 0

const D_GIF_ERR_OPEN_FAILED = 101

const D_GIF_ERR_READ_FAILED = 102

const D_GIF_ERR_NOT_GIF_FILE = 103

const D_GIF_ERR_NO_SCRN_DSCR = 104

const D_GIF_ERR_NO_IMAG_DSCR = 105

const D_GIF_ERR_NO_COLOR_MAP = 106

const D_GIF_ERR_WRONG_RECORD = 107

const D_GIF_ERR_DATA_TOO_BIG = 108

const D_GIF_ERR_NOT_ENOUGH_MEM = 109

const D_GIF_ERR_CLOSE_FAILED = 110

const D_GIF_ERR_NOT_READABLE = 111

const D_GIF_ERR_IMAGE_DEFECT = 112

const D_GIF_ERR_EOF_TOO_SOON = 113

const GIF_FONT_WIDTH = 8

const GIF_FONT_HEIGHT = 8

const EXTENSION_INTRODUCER = 0x21

const DESCRIPTOR_INTRODUCER = 0x2c

const TERMINATOR_INTRODUCER = 0x3b

const LZ_MAX_CODE = 4095

const LZ_BITS = 12

const FLUSH_OUTPUT = 4096

const FIRST_CODE = 4097

const NO_SUCH_CODE = 4098

const FILE_STATE_WRITE = 0x01

const FILE_STATE_SCREEN = 0x02

const FILE_STATE_IMAGE = 0x04

const FILE_STATE_READ = 0x08

const reallocarray = openbsd_reallocarray

end # module
