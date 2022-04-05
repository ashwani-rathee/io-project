Code for learning about giflib and we can provide it in julia:
```
 (base) ashwani@user:~/Desktop/GSOC/io-project/gifwrapper/gen$ julia libgifextratest.jl 

gif2rgb: Image 1 at (0, 0) [400x400]: 399 
gif2rgb: Image 2 at (59, 31) [280x281]: 280 
gif2rgb: Image 3 at (57, 31) [282x281]: 280 
gif2rgb: Image 4 at (57, 31) [283x281]: 280 
gif2rgb: Image 5 at (58, 31) [282x281]: 280 
gif2rgb: Image 6 at (59, 31) [280x280]: 279 
gif2rgb: Image 7 at (59, 31) [280x280]: 279 
gif2rgb: Image 8 at (60, 31) [278x280]: 279 
gif2rgb: Image 9 at (59, 31) [278x280]: 279 
gif2rgb: Image 10 at (58, 31) [279x280]: 279 
gif2rgb: Image 11 at (58, 31) [280x280]: 279 
gif2rgb: Image 12 at (56, 31) [282x281]: 280 
gif2rgb: Image 13 at (56, 31) [283x281]: 280 
gif2rgb: Image 14 at (57, 31) [282x281]: 280 
gif2rgb: Image 15 at (57, 31) [280x280]: 279 
gif2rgb: Image 16 at (58, 31) [279x280]: 279 
gif2rgb: Image 17 at (58, 31) [277x280]: 279 
gif2rgb: Image 18 at (57, 31) [278x280]: 279 
gif2rgb: Image 19 at (57, 31) [279x280]: 279 
gif2rgb: Image 20 at (56, 31) [280x280]: 279 
gif2rgb: Image 21 at (54, 31) [284x281]: 280 

113 # writing back to gif errors out currently for multiple image case

(base) ashwani@user:~/Desktop/GSOC/io-project/gifwrapper/gen$ julia libgifextratest.jl 

gif2rgb: Image 1 at (0, 0) [1008x863]: 1   
gif2rgb: RGB image:     out.gif
862 
```


- `gifwrapper/gen/libgifextra`

This place holds code for extra utils provided by giflib in form of shared object library for use in Julia. Intention is to create a jll through this and maintain it. The code in them makes it easier to handle gif conversion to rgb and vice versa a lot easier

- `gifwrapper/gen/libgifextra/notes`
  
Holds code for my tests in c

- `gifwrapper/gen/libgifextratest.jl`
  
Holds code for usage of shared library in julia

- `gifwrapper/lib/LibGif.jl`
  
Clang.jl wrapper of giflib
Issues that need to be figured out:
- How to make jll
- Multi image write error
- How to work with Julian Image and provide it to write to gif and how to read a gif and convert it to a Julian vector array of images.

