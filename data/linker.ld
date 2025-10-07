ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 4096M
}

PHDRS {
  rwx PT_LOAD FLAGS(7); /* RWX */
}

SECTIONS {
  . = 0x0;

  .text : {
    *(.text*)
    *(.rodata*)
  } > RAM :rwx

  .data : {
    *(.data*)
  } > RAM :rwx

  .bss : {
    *(.bss*)
    *(COMMON)
  } > RAM :rwx
}
