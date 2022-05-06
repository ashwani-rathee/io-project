#include <stdio.h>
#include <libgifextra.h>
// #include "../src/gif_lib.h"

int main(){
    // int ColorMapSize;

    // GifByteType *RedBuffer = NULL, *GreenBuffer = NULL, *BlueBuffer = NULL,
    //             *OutputBuffer = NULL;
    // ColorMapObject *OutputColorMap = NULL;
    // char *FileName = "porschse.rgb";
    // bool OneFileFlag = true;
    // int Width = 100, Height = 100, NumFiles = 0, ExpNumOfColors = 0;

    // GIF RGB
    // char *OutFileName = "out.rgb";
    // char *FileName = "Nasa-logo.gif";
    // int NumFiles = 1;
    // bool OneFileFlag = true;
    // GIF2RGB(NumFiles, FileName, OneFileFlag, OutFileName);

    // RGB GIF
    // char *FileName = "porsche.rgb";
    // char *OutFileName = "Nasa-logo1.gif";
    // bool OneFileFlag = false;
    // int Width = 1008, Height = 863, NumFiles = 1, ExpNumOfColors = 4;
    // RGB2GIF(OneFileFlag, NumFiles, OutFileName, FileName, ExpNumOfColors, Width, Height);

    char *FileName = "Nasa-logo.gif";
    GifFileType *GifFile;
    GifFile = returnGIF(FileName);
    return 0;
}