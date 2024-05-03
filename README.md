# SPCM-418-V2

The following is a Python wrapper to control the **Spectrum M4i6631-x8** arbitrary wave generator:
- PCI Express x8 Gen 2 interface
- 2 channels 16 bit 1.25 GS/s,
- +/-2.0 V into 50 ohm,
- 2 G Sample memory

The board comes with Windows and Linux drivers as well as a programming interface (API) that can be implemented in various languages. The instructions for downloading the software are located [here](https://spectrum-instrumentation.com/products/details/M4i6631-x8.php).

Potentially useful information:
- The username/password for the computer where this is currently installed is *Lattice, S12D52qubit*
- The drivers may require a specific Ubuntu kernel. If the software does not detect the card after it is installed, it may be necessary to manually select the correct kernel when booting the computer.
- The documentation for the API is located: `SPCM-418-V2/Doc/english/hwmanuals/m4i_m4x_66xx`

## Overview
In order to generate pulse sequences, our python script must (1) establish a connection with the Spectrum AWG board, (2) calculate the array of voltages that the AWG DAC should output, (3) send this data to the AWG board, (4) enable triggering of the AWG.

All four steps are implemented and wrapped into a single class. While not incredibly well documented, the code should be understandable. Note: currently the default (and only) triggering behavior implemented is TTL, but more advanced option are available (see the API documentation).

## Versions
### Current Implementation
The most recent version uses the spcm library distributed via PyPA, which is more recently maintained and requires Python 3.9+. The source code is located at `SPCM-418-V2/v2/`. To install, ensure that a Python 3.9+ version is installed, and run:

`pip install spcm`

An arbitrary waveform generation function is located at `SPCM-418-V2/v2/`, which accepts any Numpy function that maps from times to amplitudes. It is recommended to write a function that uses 64-bit immediates, even though the output amplitudes will ultimately be downsampled to 16 bits, to avoid numerical drift error. The AWG is limited to approx. 50ms at the default sampling rate of 1GHz. Theoretically, it is possible to generate a signal of length as much as 1.5s, but the current limiting factor is the amount of memory on the installed computer. 

Additionally, there is a pulse generation function located at `SPCM-418-V2/v2/`, which uses the card DDS functionality. DDS is faster than the AWG function, because individual voltage values no longer have to be computed directly, but is limited to sinusoidal waveforms.
### Original Implementation

This version uses the self-contained SPCM Python library located at `SPCM-418-V2/v1/` and supports both Python 2 and Python 3 versions. However, this library is no longer maintained, and therefore lacks the features necessary for DDS functionality. Additionally, this library operates at a lower level than the new version and is less user-friendly, particularly with regards to error handling.

A pulse generation function is located at `SPCM-418-V2/v1/spcm_m4i_6631-x8_pulse_gen.py`. For the purpose of reducing generation time, this function uses utilities in C located `SPCM-418-V2/Examples/python/calc.c` that can calculate the waveform and write the data to a specific buffer. This is both fast and places the waveform in the right memory location. `calc.c` must be compiled into a librarry `calc.so` so that it can be invoked in Python `spcm_m4i_6631-x8.py`. Therefore, if you edit `calc.c`, you must recompile. To compile:

`gcc -shared -o calc.so -fPIC calc.c`

Additionally, an arbitrary function generation utility is located at `SPCM-418-V2/v1/` and can generate a waveform given any numpy function that acts on arrays. This takes 2-3x as long as the pulse generation function written in C, when generating the same waveform, but allows for arbitrary waveforms to be generated.

*Updated by Thomas Lu in May 2024. Originally written in August 2021 by Yi Zhu*
