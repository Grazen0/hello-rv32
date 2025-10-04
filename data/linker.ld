ENTRY(_start)

SECTIONS {
  . = 0x0;

  .text : {
    KEEP(*(.text.startup))
    KEEP(*(.init))
    *(.text*)
    *(.rodata*)
  }

  .data : {
    *(.data*)
  }

  .bss : {
    *(.bss*)
    *(COMMON)
  }

  _stack_top = 0xFFFFFFFF;
}
