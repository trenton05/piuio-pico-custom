set(PICO_BOARD pico CACHE STRING "Board type")

cmake_minimum_required(VERSION 3.13)

set(PICO_SDK_FETCH_FROM_GIT ON)
include(pico_sdk_import.cmake)

project(piuio_pico)

pico_sdk_init()

# add pico-pio-usb library for examples
set(PICO_PIO_USB_DIR "${CMAKE_CURRENT_LIST_DIR}/Pico-PIO-USB/")
# the second argument to add_subdirectory is needed here because this isn't
# a subdirectory, it's out of tree.
add_subdirectory(${PICO_PIO_USB_DIR} pico_pio_usb)

add_executable(piuio_pico
    main.c)

target_sources(piuio_pico PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}/main.c
        ${CMAKE_CURRENT_LIST_DIR}/piuio_ws2812.c
        ${CMAKE_CURRENT_LIST_DIR}/usb_descriptors.c
        ${CMAKE_CURRENT_LIST_DIR}/input_mux4067.c
        ${CMAKE_CURRENT_LIST_DIR}/input_mode.c
        ${CMAKE_CURRENT_LIST_DIR}/lights_latch32.c
        ${CMAKE_CURRENT_LIST_DIR}/host_hid.c
        ${CMAKE_CURRENT_LIST_DIR}/xinput_driver.c
        #${CMAKE_CURRENT_LIST_DIR}/RS485_protocol.c
        # can use 'tinyusb_pico_pio_usb' library later when pico-sdk is updated
        ${PICO_TINYUSB_PATH}/src/portable/raspberrypi/pio_usb/dcd_pio_usb.c
        ${PICO_TINYUSB_PATH}/src/portable/raspberrypi/pio_usb/hcd_pio_usb.c
        )

# Make sure TinyUSB can find tusb_config.h
target_include_directories(piuio_pico PUBLIC
        ${CMAKE_CURRENT_LIST_DIR})

pico_generate_pio_header(piuio_pico ${CMAKE_CURRENT_LIST_DIR}/ws2812.pio)
pico_generate_pio_header(piuio_pico ${CMAKE_CURRENT_LIST_DIR}/sspi.pio)

# In addition to pico_stdlib required for common PicoSDK functionality, add dependency on tinyusb_device
# for TinyUSB device support and tinyusb_board for the additional board support library used by the example
target_link_libraries(piuio_pico
                      PUBLIC
                      pico_stdlib
                      pico_multicore
                      pico_pio_usb
                      tinyusb_board
                      tinyusb_device
                      tinyusb_host
                      hardware_pio
                      hardware_dma
                      hardware_irq
                      hardware_flash
                      hardware_sync)

# Uncomment this line to enable fix for Errata RP2040-E5 (the fix requires use of GPIO 15)
#target_compile_definitions(piuio_pico PUBLIC PICO_RP2040_USB_DEVICE_ENUMERATION_FIX=1)

# pico_add_extra_outputs(piuio_pico)
pico_enable_stdio_usb(piuio_pico 0)
pico_enable_stdio_uart(piuio_pico 0)
# pico_add_extra_outputs(piuio_pico)

# Fix custom RP2040 boards with out-of-spec capacitance values for the crystal
# oscillator by delaying startup slightly.
# Thank you so much dj505 for showing me this fix and
# speedypotato/somewhatlurker for the solution!
add_compile_definitions(
    PICO_XOSC_STARTUP_DELAY_MULTIPLIER=128
)