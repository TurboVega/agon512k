# agon512k
<b>Access 512KB RAM from within BASIC on AgonLight (TM)</b>

This collection of assembler functions provide access to the extended memory (including and beyond the first 64KB) attached to the EZ80 CPU.
The RAM resides at addresses &40000 to &BFFFF, with BASIC normally using the lower 64KB (&40000 to &4FFFF). Now, you have another 448KB of RAM accessible from BASIC, ranging from
&50000 to &BFFFF.
<br>
<br>
Versions:<br>
V0.1 - Initial release of code for beta testing of a number of routines.
<br>
<br>
<b>NOTE: Only those routines that are specifically called (via CALL or USR) in "emtests.bas" have been tested some. Other routines have not yet been tested,
but I'm working on that.</b>
<br>
<br>
NOTE: The provided routines do not modify or enhance the BASIC language, nor provide an easy way to allow you to write BASIC
programs that are larger than would normally fit within the 40+KB available for programs. They provide a way to store <i>data variables</i> and/or blocks of <i>data bytes</i> in
the upper RAM. This extends the variable/array capacity greatly. When used with the CHAIN command in BASIC, you could
write large programs with lots of data.
<br>
<br>
The assembler functions can read or write the entire memory range, implying that you should be very careful not to clobber
any memory used by BASIC, unless you know what effect it will have. It is up to you how to arrange or manage the upper memory.
No allocation, deallocation, or garbage collection is provided. You simply call routines that write or read using specific addresses determine by your application.
<br>
<br>
In the following descriptions, the prefix "emp" means "extended memory procedure". The prefix "emf" means "extended memory function". The prefix "emd" means "extended memory data", and refers to a data parameter
passed into or out of one of the extended memory procedures.
The name "var" is a placeholder for a variable name of your choosing.

Regarding parameters, with the exception of string values,
numeric expressions are typically expected, and may be constants, variables, computation results, function results, etc.

Many of the routines work with arrays. When working with 8-, 16-,
24-, or 32-bit array item values, the code automatically assumes
the size of an array item to be 1, 2, 3, or 4 bytes, respectively.
When working with float values, each item is 5 bytes in size.
When working with an array of string values, the maximum item size
must be specified manually, because strings have various lengths.
The maximum item size in a string array is 256 bytes, meaning that
the maximum string length inside an item is 255 bytes, because of
the trailing CR character stored with the string.

The maximum array index size for any array is 65535 (&FFFF). This does not prevent you from having larger arrays, because you can arrange two
or more arrays in memory such that they are physically together. It only means that you may need to reference the second (or third)
array separately from the first array, and be sure to use base zero
indexes in each array (i.e., range 0 to 65535).

The code does not presently support storing <i>record-oriented</i> data
fields in an obvious manner; however, you can mimic that behavior
in a couple of ways: (1) store data fields in subsequent memory
locations such that they form a "record" (a set of consecutive
data values of various types), and store a series of records in
consecutive memory locations, or (2) use multiple arrays, with
one array per data field, where each array holds only items of a
particular data type. Typically, such arrays would have equal
lengths (the same number of array items).
Method (1) requires you to manage the
memory yourself, but method (2) helps with array indexing, and
only requires that the arrays do not overlap in memory.
<br>
<br>
## PROC_empInit - Initialize routine addresses
This BASIC procedure will initialize the variables
that are described in the following sections, with the addresses
of the various assembler routines that may be called
to read and to write extended memory. <i>Call this procedure
before calling the others.</i>

Usage: PROC_empInit
<br>
<br>
## emdSA% - Source address parameter
This parameter is a 24-bit source address that is required by some routines, as specified below.
To access the first 64KB of memory, the address must be
in the range &40000 to &4FFFF, not &00000 to &0FFFF.
Any address in the range &40000 to &BFFFF is allowed.

Usage: !emdSA% = <i>sourceaddress</i>
<br>
<br>
## emdDA% - Destination address parameter
This parameter is a 24-bit destination address that is required by some routines, as specified below.
To access the first 64KB of memory, the address must be
in the range &40000 to &4FFFF, not &00000 to &0FFFF.
Any address in the range &40000 to &BFFFF is allowed.

Usage: !emdDA% = <i>destinationaddress</i>
<br>
<br>
## emdAI% - Array index parameter
This parameter is a 16-bit array index that is required by some routines, as specified below. The array index ranges from 0
to 65535 (&FFFF). See comments above about splitting large arrays.

Usage: !emdAI% = <i>arrayindex</i>
<br>
<br>
## emdIS% - Array item size parameter
This parameter is a 16-bit array item size that is required by some routines, as specified below. The item size ranges from 1 to 256
(&100). See comments above about splitting large arrays.

Usage: !emdIS% = <i>itemsize</i>
<br>
<br>
## emdRC% - Repeat count parameter
This parameter is a 24-bit repeat count that is required by some routines, as specified below.

Usage: !emdRC% = <i>repeatcount</i>
<br>
<br>
## emdV8% - Value parameter as 8 bits
This parameter is an 8-bit value that is required by some routines, as specified below.

Usage: ?emdV8% = <i>value</i><br>
Or: !emdV8% = <i>value</i>
<br>
<br>
## emdV16% - Value parameter as 16 bits
This parameter is a 16-bit value that is required by some routines, as specified below.

Usage: !emdV16% = <i>value</i>
<br>
<br>
## emdV24% - Value parameter as 24 bits
This parameter is a 24-bit value that is required by some routines, as specified below.

Usage: !emdV24% = <i>value</i>
<br>
<br>
## emdV32% - Value parameter as 32 bits
This parameter is a 32-bit value that is required by some routines, as specified below.

Usage: !emdV32% = <i>value</i>
<br>
<br>
## emdVS% - Value parameter as string
This parameter is a string value that is required by some routines, as specified below. When stored in memory, the string will be
terminated by a carriage-return (CR, 0DH) character; therefore,
the original string should not contain a carriage-return.

Usage: $emdVS% = <i>stringvalue</i>
<br>
<br>
## empI% - Initialize upper RAM
This procedure clears (to zero) the upper 448KB of memory.

Usage: CALL empI%
<br>
<br>
## emfG8% - Get 8-bit value
This function reads an 8-bit value from memory.

Usage: !emdSA% = <i>sourceaddress</i>: var%=USR(emfG8%) 
<br>
<br>
## emfG16% - Get 16-bit value
This function reads a 16-bit value from memory.

Usage: !emdSA% = <i>sourceaddress</i>: var%=USR(emfG16%)
<br>
<br>
## emfG24% - Get 24-bit value
This function reads a 24-bit value from memory.

Usage: !emdSA% = <i>sourceaddress</i>: var%=USR(emfG24%)
<br>
<br>
## emfG32% - Get 32-bit value
This function reads a 32-bit value from memory.

Usage: !emdSA% = <i>sourceaddress</i>: var%=USR(emfG32%)
<br>
<br>
## empGS% - Get String (0..255 characters)
This procedure reads a string value from memory.

Usage: !emdSA% = <i>sourceaddress</i>: CALL empGS%: var$=$emdVS%
<br>
<br>
## empGF% - Get Float (40 bits)
This procedure reads a float value from memory, and copies the value into the specified variable.

Usage: !emdSA% = <i>sourceaddress</i>: CALL empGF%,<i>floatvariable</i>
<br>
<br>
## emfG8AI% - Get 8-bit item from array
This function reads an 8-bit array item from memory.

Usage: !emdSA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: var%=USR(emfG8AI%) 
<br>
<br>
## emfG16AI% - Get 16-bit item from array
This function reads a 16-bit array item from memory.

Usage: !emdSA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: var%=USR(emfG16AI%) 
<br>
<br>
## emfG24AI% - Get 24-bit item from array
This function reads a 24-bit array item from memory.

Usage: !emdSA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: var%=USR(emfG24AI%) 
<br>
<br>
## emfG32AI% - Get 32-bit item from array
This function reads a 32-bit array item from memory.

Usage: !emdSA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: var%=USR(emfG32AI%) 
<br>
<br>
## empGSAI% - Get String (0..255 characters) item from array
This function reads a string array item from memory. The given start address
points to the start of the array (at item #0). The item size tells how big each
array item is, which determines the maximum size of the string that can be stored
there. For example, using an item size of 21, the maximum string length is 20,
because of the trailing CR at the end of the string, while stored.

Usage: !emdSA% = <i>arrayaddress</i>: !emdIS% = <i>itemsize</i>: !emdAI% = <i>array index</i>: CALL empGSAI%: var$ = $emdVS%
<br>
<br>
## empGFAI% - Get Float (40 bits) item from array
This procedure reads a float array item from memory, and copies the value into the specified variable.

Usage: !emdSA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: CALL empGFAI%,<i>floatvariable</i>
<br>
<br>
## empP8% - Put 8-bit value
This procedure writes an 8-bit value to memory.

Usage: !emdDA% = <i>destinationaddress</i>: !emdV8% = <i>value</i>: CALL empP8%<br>
Or: !emdDA% = <i>destinationaddress</i>: ?emdV8% = <i>value</i>: CALL empP8%
<br>
<br>
## empP16% - Put 16-bit value
This procedure writes a 16-bit value to memory.

Usage: !emdDA% = <i>destinationaddress</i>: !emdV16% = <i>value</i>: CALL empP16%
<br>
<br>
## empP24% - Put 24-bit value
This procedure writes a 24-bit value to memory.

Usage: !emdDA% = <i>destinationaddress</i>: !emdV24% = <i>value</i>: CALL empP24%
<br>
<br>
## empP32% - Put 32-bit value
This procedure writes a 32-bit value to memory.

Usage: !emdDA% = <i>destinationaddress</i>: !emdV32% = <i>value</i>: CALL empP32%
<br>
<br>
## empPS% - Put String (0..255 characters)
This procedure writes a string value to memory. The original string
must not contain a carriage-return (CR, 0DH) character, because
BASIC will append one as a terminator when the $emdVS% construct
is used in an assignment.

Usage: !emdDA% = <i>destinationaddress</i>: $emdVS% = <i>stringvalue</i>: CALL empPS%
<br>
<br>
## empPF% - Put Float (40 bits)
This procedure copies the value from the specified float variable into memory.

Usage: !emdDA% = <i>destinationaddress</i>: CALL empPF%,<i>floatvariable</i>
<br>
<br>
## empP8AI% - Put 8-bit item into array
This procedure writes an 8-bit array item to memory.

Usage: !emdDA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: !emdV8% = <i>value</i>: CALL empP8AI%<br>
Or: !emdDA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: ?emdV8% = <i>value</i>: CALL empP8AI%
<br>
<br>
## empP16AI% - Put 16-bit item into array
This procedure writes a 16-bit array item to memory.

Usage: !emdDA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: !emdV16% = <i>value</i>: CALL empP16AI%
<br>
<br>
## empP24AI% - Put 24-bit item into array
This procedure writes a 24-bit array item to memory.

Usage: !emdDA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: !emdV24% = <i>value</i>: CALL empP24AI%
<br>
<br>
## empP32AI% - Put 32-bit item into array
This procedure writes a 32-bit array item to memory.

Usage: !emdDA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: !emdV32% = <i>value</i>: CALL empP32AI%
<br>
<br>
## empPSAI% - Put String (0..255 characters) item into array
This procedure writes a string array item to memory. The given start address
points to the start of the array (at item #0). The item size tells how big each
array item is, which determines the maximum size of the string that can be stored
there. For example, using an item size of 21, the maximum string length is 20,
because of the trailing CR at the end of the string, while stored.

Usage: !emdDA% = <i>arrayaddress</i>: !emdIS% = <i>itemsize</i>: !emdAI% = <i>array index</i>: $emdVS% = <i>stringvalue</i>: CALL empPSAI%
<br>
<br>
## empPFAI% - Put Float (40 bits) item into array
This procedure copies the value from the specified float variable into a float array item in memory.

Usage: !emdDA% = <i>arrayaddress</i>: !emdAI% = <i>array index</i>: CALL empPFAI%,<i>floatvariable</i>
<br>
<br>
## empCMBI% - Copy memory block by incrementing addresses
This procedure copies a memory block from one location to another location, while incrementing addresses.
 It expects that
either the source block or the destination block do not overlap, or the source address is
greater than (or equal to) the destination address. If you know that the two blocks overlap,
and the source address is less than the destination address, use the empCMBD% routine instead.

The source address must equal the <i>lowest</i> address in the source memory block.
The destination address must equal the <i>lowest</i> address in the destination memory block.
When this routine completes, the addresses will each point <i>just past</i> the high end of each block.

This procedure copies bytes, so the repeat count is a number of bytes.
To copy N entities of size M, set the repeat count to <i>N*M</i>.

To set an address to the start of a particular array item, set the address
to <i>A+I*S</i>, where A is the address of the array, I is the array index, and S is the size of one array item.

Usage: !emdSA% = <i>sourceaddress</i>: !emdDA% = <i>destinationaddress</i>: !emdRC% = <i>repeatcount</i>: CALL empCMBI%
<br>
<br>
## empCMBD% - Copy memory block by decrementing addresses
This procedure copies a memory block from one location to another location, while decrementing addresses.
 It expects that
either the source block or the destination block do not overlap, or the source address is
less than (or equal to) the destination address. If you know that the two blocks overlap,
and the source address is greater than the destination address, use the empCMBI% routine instead.

The source address must equal the <i>highest</i> address in the source memory block, <i>plus 1</i>.
The destination address must equal the <i>highest</i> address in the destination memory block, <i>plus 1</i>.
When this routine completes, the addresses will each point <i>at</i> the low end of each block.

This procedure copies bytes, so the repeat count is a number of bytes.
To copy N entities of size M, set the repeat count to <i>N*M</i>.

To set an address to the start of a particular array item, set the address
to <i>A+I*S</i>, where A is the address of the array, I is the array index, and S is the size of one array item. Note that to copy
array item #I, you would set the address to point to array item #(I+1), because this routine copies bytes in reverse.

Usage: !emdSA% = <i>sourceaddress</i>: !emdDA% = <i>destinationaddress</i>: !emdRC% = <i>repeatcount</i>: CALL empCMBD%
<br>
<br>
## empXMB% - Exchange (swap) memory blocks
This procedure moves the data from the source memory block
into the destination memory block, and vice versa. The two
blocks must not overlap.

This procedure copies bytes, so the repeat count is a number of bytes.
To exchange N entities of size M, set the repeat count to <i>N*M</i>.

To set an address to the start of a particular array item, set the address
to <i>A+I*S</i>, where A is the address of the array, I is the array index, and S is the size of one array item.

Usage: !emdSA% = <i>sourceaddress</i>: !emdDA% = <i>destinationaddress</i>: !emdRC% = <i>repeatcount</i>: CALL empXMB%
<br>
<br>
## empZMB% - Zero memory block
This procedure fills the destination memory block with zeros, erasing any data that were there.

This procedure fills bytes, so the repeat count is a number of bytes.
To fill N entities of size M, set the repeat count to <i>N*M</i>.

To set an address to the start of a particular array item, set the address
to <i>A+I*S</i>, where A is the address of the array, I is the array index, and S is the size of one array item.

Usage: !emdDA% = <i>destinationaddress</i>: !emdRC% = <i>repeatcount</i>: CALL empZMB%
