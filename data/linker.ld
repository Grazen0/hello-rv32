ENTRY(_start)

MEMORY
{
  RAM (rxw) : ORIGIN = 0x0, LENGTH = 128K
}

SECTIONS
{
  .text : {
    *(.text*)
  } > RAM
}

