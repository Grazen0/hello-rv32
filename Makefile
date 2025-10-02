TARGET_EXEC := hello.elf
DTB := memory.dtb


BUILD_DIR := ./build
SRC_DIRS := ./src

SRCS := $(shell find $(SRC_DIRS) -name '*.c' -or -name '*.s')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
LINKER := data/linker.ld
DTS := data/memory.dts

DEPS := $(OBJS:.o=.d)

ISA := RV32I

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CFLAGS := $(INC_FLAGS) -MMD -MP
ASFLAGS := $(INC_FLAGS)

AS := riscv32-none-elf-as
CC := riscv32-none-elf-gcc
LD := riscv32-none-elf-ld
PICORV32 := picorv32

all: $(BUILD_DIR)/$(TARGET_EXEC) $(BUILD_DIR)/$(DTB)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(LD) $< -T data/linker.ld -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.s.o: %.s
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

$(BUILD_DIR)/$(DTB): $(DTS)
	dtc -I dts -O dtb -o $@ $<

run: $(BUILD_DIR)/$(TARGET_EXEC) $(BUILD_DIR)/$(DTB)
	$(SPIKE) --isa=$(ISA) --dc=0x0:0x20000 $(BUILD_DIR)/$(TARGET_EXEC)

clean:
	rm -r $(BUILD_DIR)

.PHONY: all clean run

-include $(DEPS)
