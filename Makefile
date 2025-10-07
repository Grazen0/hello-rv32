TARGET_EXEC := hello.elf

BUILD_DIR := ./build
SRC_DIRS := ./src

SRCS := $(shell find $(SRC_DIRS) -name '*.c' -or -name '*.s')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
LINKER := ./data/linker.ld

DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CFLAGS := $(INC_FLAGS) -MMD -MP -nostdlib -march=rv32i -mabi=ilp32 -std=c23 -g

CC := riscv32-none-elf-gcc

RV32_EMU := rv32-emu

GDB := riscv32-none-elf-gdb
GDB_PORT := 3333

BEAR := bear
CDB := compile_commands.json

all: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS) $(LINKER)
	$(CC) $(CFLAGS) -T $(LINKER) -o $@ $(OBJS) $(LDFLAGS)

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.s.o: %.s
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

run: $(BUILD_DIR)/$(TARGET_EXEC)
	$(RV32_EMU) $(RV32_EMU_FLAGS) -p $(GDB_PORT) $<

debug: $(BUILD_DIR)/$(TARGET_EXEC)
	$(GDB) $<

clean:
	rm -r $(BUILD_DIR)

compdb:
	mkdir -p $(BUILD_DIR)
	$(BEAR) --output $(BUILD_DIR)/$(CDB) -- make -B

.PHONY: all clean run debug compdb

-include $(DEPS)
