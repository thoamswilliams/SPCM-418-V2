from pyspcm import *
from spcm_tools import *
import sys
import time
from generate import PS
import numpy as np

start = time.time()

# open card
hCard = spcm_hOpen (create_string_buffer (b'/dev/spcm0'))
if hCard == None:
    sys.stdout.write("no card found...\n")
    exit (1)

spcm_dwSetParam_i32 (hCard, SPC_M2CMD, M2CMD_CARD_RESET)


spcm_vClose (hCard)
