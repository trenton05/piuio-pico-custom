
rm -fR build
mkdir -p build
cd build
cmake ..
make -j16
cd ..
./elf2uf2/elf2uf2 ./build/piuio_pico.elf ./piuio_pico.uf2
cp ./piuio_pico.uf2 /Volumes/RPI-RP2/