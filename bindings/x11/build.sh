gcc -shared -o libX11extra.so -fPIC x11.c -lX11
mv libX11extra.so ../../dependency/linux/lib