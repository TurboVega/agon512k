1000 REM File: testmem.bas
1010 REM Purpose: Use Agon 512KB external RAM in BASIC
1020 REM Copyright (C) 2023 by Curtis Whitley
1030 REM
1040 REM This program does a simple-minded memory test. It clears out the extended
1050 REM memory (RAM above 64KB), reads one arbitrarily-sized (1KB) block, verifies
1060 REM that the block contains zeros, writes over the block, reads the block again,
1070 REM and verifies that the block contains what was written.
1080 REM
1090 REM MIT License
1100 REM
1110 REM Permission is hereby granted, free of charge, to any person obtaining a copy
1120 REM of this software and associated documentation files (the "Software"), to deal
1130 REM in the Software without restriction, including without limitation the rights
1140 REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
1150 REM copies of the Software, and to permit persons to whom the Software is
1160 REM furnished to do so, subject to the following conditions:
1170 REM
1180 REM The above copyright notice and this permission notice shall be included in all
1190 REM copies or substantial portions of the Software.
1200 REM
1210 REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
1220 REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
1230 REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
1240 REM AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
1250 REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
1260 REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
1270 REM SOFTWARE.
1280 REM
1290 PRINT "Simple-Minded Extended Memory Test"
1300 PRINT "If this program STOPs, an error has occurred."
1310 PRINT ""
1320 REM --- memory related constants ---
1330 PRINT "Initializing various constants"
1340 mycode%=&FEB0: REM location of assembly code
1350 buffer%=&EEB0: REM location of my local buffer
1360 bufsize%=&1000: REM arbitrary size of my local buffer
1370 emloc%=&50000: REM location of extended memory (past 64KB)
1380 emsize%=&70000: REM size of extended memory (512KB - 64KB)
1390 srcaddress%=&FEB0: REM location of source address parameter
1400 dstaddress%=&FEB4: REM location of destination address parameter
1410 blocksize%=&FEB8: REM location of block size parameter
1420 bytevalue%=&FEBC: REM location of byte (fill) value parameter
1430 copyram%=&FEC0: REM location of RAM copy routine
1440 clearram%=&FED8: REM location of RAM clear routine
1450 fillram%=&FEDB: REM location of RAM fill routine
1460 HIMEM=buffer%: REM reserve memory for buffer and code
1470 REM
1480 REM --- assembly code ---
1490 PRINT "Copying assembly code above HIMEM"
1500 DATA &00, &00, &00, &00, &00, &00, &00, &00
1510 DATA &00, &00, &00, &00, &00, &00, &00, &00
1520 DATA &5B, &CD, &C6, &FE, &00, &C9, &2A, &B0
1530 DATA &FE, &00, &ED, &5B, &B4, &FE, &00, &ED
1540 DATA &4B, &B8, &FE, &00, &ED, &B0, &5B, &C9
1550 DATA &AF, &18, &03, &3A, &BC, &FE, &5B, &CD
1560 DATA &E4, &FE, &00, &C9, &ED, &5B, &B4, &FE
1570 DATA &00, &ED, &4B, &B8, &FE, &00, &12, &13
1580 DATA &0B, &C2, &EE, &FE, &00, &5B, &C9
1600 FOR address%=&FEB0 TO &FEF6
1610   READ assembly%
1615   PRINT ~" ",STR$~(assembly%),
1620   ?address%=assembly%
1630 NEXT address%
1635 PRINT ""
1640 REM
1650 REM --- clear extended memory ---
1660 REM "Clearing extended memory"
1670 !bufsize%=blocksize%
1680 FOR address%=emloc% TO emloc%+emsize%-1 STEP bufsize%
1690   PRINT " ",STR$~(address%),
1700   !dstaddress%=address%
1710   CALL clearram%
1720 NEXT address%
1730 PRINT ""
1740 REM
1750 REM --- read extended memory ---
1760 REM (blocksize% is still set)
1770 PRINT "Reading one block of extended memory"
1780 !srcaddress%=emloc%
1790 !dstaddress%=buffer%
1800 CALL copyram%
1810 REM
1820 REM --- verify that buffer has all zeros ---
1830 PRINT "Verifying that local buffer is all zeros"
1840 FOR idx%=0 TO bufsize%-1
1850   address%=buffer%+idx%
1860   IF ?address%<>0 THEN STOP
1870 NEXT idx%
1880 REM
1890 REM --- change the buffer to something more interesting ---
1900 PRINT "Filling local buffer contents"
1910 FOR idx%=0 TO bufsize%-1
1920   POKE buffer%+idx%, idx% AND &FF
1930 NEXT idx%
1940 REM
1950 REM --- write extended memory ---
1960 REM (blocksize% is still set)
1970 PRINT "Writing one block of extended memory"
1980 !srcaddress%=buffer%
1990 !dstaddress%=emloc%
2000 CALL copyram%
2010 REM
2020 REM --- purposely erase local buffer ---
2030 PRINT "Erasing local buffer"
2040 FOR idx%=0 TO bufsize%-1
2050   address%=buffer%+idx%
2060   ?address%=0
2070 NEXT idx%
2080 REM
2090 REM --- read extended memory again ---
2100 REM (blocksize% is still set)
2110 PRINT "Reading one block of extended memory"
2120 !srcaddress%=emloc%
2130 !dstaddress%=buffer%
2140 CALL copyram%
2150 REM
2160 REM --- verify that buffer looks interesting ---
2170 PRINT "Verifying that local buffer has data"
2180 FOR idx%=0 TO bufsize%-1
2190   address%=buffer%+idx%
2200   IF ?address%<>(idx% AND &FF) THEN STOP
2210 NEXT idx%
2220 REM
2230 REM --- fill extended memory ---
2240 REM (blocksize% is still set)
2250 PRINT "Filling one block of extended memory"
2260 !bytevalue%=&CA
2270 !dstaddress%=emloc%
2280 CALL copyram%
2290 REM
2300 REM --- purposely erase local buffer ---
2310 PRINT "Erasing local buffer"
2320 FOR idx%=0 TO bufsize%-1
2330   address%=buffer%+idx%
2340   ?address%=0
2350 NEXT idx%
2360 REM
2370 REM --- read extended memory again ---
2380 REM (blocksize% is still set)
2390 PRINT "Reading one block of extended memory"
2400 !srcaddress%=emloc%
2410 !dstaddress%=buffer%
2420 CALL copyram%
2430 REM
2440 REM --- verify that buffer looks interesting ---
2450 PRINT "Verifying that local buffer has data"
2460 FOR idx%=0 TO bufsize%-1
2470   address%=buffer%+idx%
2480   IF ?address%<>&CA THEN STOP
2490 NEXT idx%
2500 PRINT "Simple-minded memory test passed."
2510 END
