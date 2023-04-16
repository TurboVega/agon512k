REM File: testmem.bas
REM Purpose: Use Agon 512KB external RAM in BASIC
REM Copyright (C) 2023 by Curtis Whitley
REM
REM This program does a simple-minded memory test. It clears out the extended
REM memory (RAM above 64KB), reads one arbitrarily-sized (1KB) block, verifies
REM that the block contains zeros, writes over the block, reads the block again,
REM and verifies that the block contains what was written.
REM
REM MIT License
REM
REM Permission is hereby granted, free of charge, to any person obtaining a copy
REM of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights
REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
REM copies of the Software, and to permit persons to whom the Software is
REM furnished to do so, subject to the following conditions:
REM
REM The above copyright notice and this permission notice shall be included in all
REM copies or substantial portions of the Software.
REM
REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
REM AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
REM SOFTWARE.
REM
PRINT "Simple-Minded Extended Memory Test"
PRINT "If this program STOPs, an error has occurred."
PRINT ""
REM --- memory related constants ---
PRINT "Initializing various constants"
mycode%=&FFC0: REM location of assembly code
buffer%=&EFC0: REM location of my local buffer
bufsize%=&1000: REM arbitrary size of my local buffer
emloc%=&10000: REM location of extended memory (past 64KB)
emsize%=&70000: REM size of extended memory (512KB - 64KB)
srcaddress%=&FFC0: REM location of source address parameter
dstaddress%=&FFC3: REM location of destination address parameter
blocksize%=&FFC6: REM location of block size parameter
copyram%=&FFC9: REM location of RAM copy routine
clearram%=&FFCF: REM location of RAM clear routine
HIMEM=buffer%: REM reserve memory for buffer and code
REM
REM --- assembly code ---
PRINT "Copying assembly code above HIMEM"
DATA &00, &00, &00, &00, &00, &00, &00, &00
DATA &00, &52, &CD, &D5, &FF, &00, &C9, &52
DATA &CD, &E5, &FF, &00, &C9, &21, &C0, &FF
DATA &00, &11, &C3, &FF, &00, &01, &C6, &FF
DATA &00, &ED, &B0, &5B, &C9, &11, &C3, &FF
DATA &00, &01, &C6, &FF, &00, &3E, &00, &12
DATA &13, &0B, &C2, &EF, &FF, &00, &5B, &C9
FOR OFFSET%=0 TO &38
  READ assembly%
  POKE mycode%+OFFSET%,assembly%
NEXT OFFSET%
REM
REM --- clear extended memory ---
REM "Clearing all of extended memory"
POKE blocksize%+2, bufsize%/&10000
POKE blocksize%+1, (bufsize%/&100) AND &FF
POKE blocksize%, bufsize% AND &FF
FOR address%=emloc% TO emloc%+emsize% STEP bufsize%
  PRINT " ";STR$~(address%);
  POKE dstaddress%+2, address%/&10000
  POKE dstaddress%+1,(address%/&100) AND &FF
  POKE dstaddress%, address% AND &FF
  USR clearram%
NEXT ADDRESS%
PRINT ""
REM
REM --- read extended memory ---
REM (blocksize% is still set)
PRINT "Reading one block of extended memory"
POKE srcaddress%+2, emloc%/&10000
POKE srcaddress%+1,(emloc%/&100) AND &FF
POKE srcaddress%, emloc% AND &FF
POKE dstaddress%+2, buffer%/&10000
POKE dstaddress%+1,(buffer%/&100) AND &FF
POKE dstaddress%, buffer% AND &FF
USR copyram%
REM
REM --- verify that buffer has all zeros ---
PRINT "Verifying that local buffer is all zeros"
FOR idx%=0 TO bufsize%
  IF PEEK(buffer%+idx%)<>0 THEN STOP
NEXT idx%
REM
REM --- change the buffer to something more interesting ---
PRINT "Modifying local buffer contents"
FOR idx%=0 TO bufsize%
  POKE buffer%+idx%, idx% AND &FF
NEXT idx%
REM
REM --- write extended memory ---
REM (blocksize% is still set)
PRINT "Writing one block of extended memory"
POKE srcaddress%+2, buffer%/&10000
POKE srcaddress%+1,(buffer%/&100) AND &FF
POKE srcaddress%, buffer% AND &FF
POKE dstaddress%+2, emloc%/&10000
POKE dstaddress%+1,(emloc%/&100) AND &FF
POKE dstaddress%, emloc% AND &FF
USR copyram%
REM
REM --- purposely erase local buffer ---
PRINT "Erasing local buffer"
FOR idx%=0 TO bufsize%
  POKE buffer%+idx%, 0
NEXT idx%
REM
REM
REM --- read extended memory again ---
REM (blocksize% is still set)
PRINT "Reading one block of extended memory"
POKE srcaddress%+2, emloc%/&10000
POKE srcaddress%+1,(emloc%/&100) AND &FF
POKE srcaddress%, emloc% AND &FF
POKE dstaddress%+2, buffer%/&10000
POKE dstaddress%+1,(buffer%/&100) AND &FF
POKE dstaddress%, buffer% AND &FF
USR copyram%
REM
REM --- verify that buffer looks interesting ---
PRINT "Verifying that local buffer has data"
FOR idx%=0 TO bufsize%
  IF PEEK(buffer%+idx%)<>(idx% AND &FF)) THEN STOP
NEXT idx%
PRINT "Simple-minded memory test passed."
END
