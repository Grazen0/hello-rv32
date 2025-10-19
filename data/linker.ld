ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 4096M
}

PHDRS {
  text PT_LOAD FLAGS(5); /* r-x */
  data PT_LOAD FLAGS(6); /* rw- */
}

SECTIONS {
  . = 0x0;

  .text : {
    *(.text*)
    *(.rodata*)
  } > RAM :text

  .data : {
    *(.data*)
  } > RAM :data

  .bss : {
    *(.bss*)
    *(COMMON)
  } > RAM :data
}
