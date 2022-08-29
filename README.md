# SPCM-418

The following is a Python wrapper to control the **Spectrum M4i6631-x8** arbitrary wave generator:
- PCI Express x8 Gen 2 interface
- 2 channels 16 bit 1.25 GS/s,
- +/-2.0 V into 50 ohm,
- 2 G Sample memory

The board comes with Windows and Linux drivers as well as a programming interface (API) that can be implemented in various languages. The instructions for downloading the software are located [here](https://spectrum-instrumentation.com/products/details/M4i6631-x8.php).

Potentially useful information:
- The username/password for the computer where this is currently installed is *Eli, S12D52qubit*
- The drivers may require a specific version of Ubuntu
- The documentation for the API is located: `SPCM-418/Doc/english/hwmanuals/m4i_m4x_66xx`

Overview: in order to generate pulse sequences, our python script must (1) establish a connection with the Spectrum AWG board, (2) calculate the array of voltages that the AWG DAC should output, (3) send this data to the AWG board, (4) enable triggering of the AWG.

All four steps are implemented and wrapped into a single class `SPCM-418/Examples/python/spcm_m4i_6631-x8.py`. While not incredibly well documented, the code should be understandable. Note: currently the default (and only) triggering behavior implemented is TTL, but more advanced option are available (see the API documentation).

Notably, a unique aspect of my implementation is during steps 2-3. In order to write data (i.e. the waveform) to the board, we must place those values into a specific buffer that is given to us by the API. Furthermore, the waveform is an extremely large array so it is not feasible (i.e. runtime) to calculate the waveform in python. Using numpy (which is written in C) *would* be fast enough, *however*, it is not possible in numpy to specify the particular memory location where an ndarray should be stored. Therefore, using numpy, we can quickly calculate the waveform, but the waveform will be stored in an area of the computer's memory separate the buffer the API wants. We can transfer the waveform into the API's buffer after it has generated, but this takes too long.

The workaround implemented is that I have written so functions in C located `SPCM-418/Examples/python/calc.c` that can calculate the waveform *and* write the data to a specific buffer. This is both fast and places the waveform in the right memory location. `calc.c` must be compiled into a librarry `calc.so` so that it can be invoked in Python `spcm_m4i_6631-x8.py`. Therefore, if you edit `calc.c`, you must recompile. To compile:

`gcc -shared -o calc.so -fPIC calc.c`