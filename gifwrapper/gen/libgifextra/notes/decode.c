#include <gif_lib.h>
#include <stdio.h>

int main()
{
    int Error;
    GifFileType* gif = DGifOpenFileName("/home/ashwani/Desktop/GSOC/io-project/gifwrapper/giphy.gif", &Error);

    if (gif == NULL) {
        printf("Failed to open .gif, return error with type \n");
        return false;
    }

    int slurpReturn = DGifSlurp(gif);
    if (slurpReturn != GIF_OK) {
        printf("Failed to read .gif file");
        return false;
    }

    printf("Opened .gif with width/height =\n");
    printf("Width: %d \n",(int) gif->SWidth);
    printf("Height: %d \n",(int) gif->SHeight);
    for(int i = 0; i < 265*199; ++i){
        printf("Data: %d \n", (int) gif->SavedImages[0].RasterBits[i]);
    }
}