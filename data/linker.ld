ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 4096M
}

SECTIONS {
  . = ORIGIN(RAM);

  .text : ALIGN(4) {
    *(.text*)
    *(.rodata*)
  } > RAM

  .data : ALIGN(4) {
    *(.data*)
  } > RAM

  .bss : ALIGN(4) {
    *(.bss*)
    *(COMMON)
  } > RAM

  _end = .;
}
