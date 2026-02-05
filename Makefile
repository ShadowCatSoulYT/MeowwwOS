# Compiler and flags
CC = gcc
AS = as
LDFLAGS = -m32 -ffreestanding -O2 -nostdlib -T config/linker.ld

# Directories
SRC_DIR = src
OBJ_DIR = obj
CONFIG_DIR = config

# Files
SRCS = $(SRC_DIR)/boot.s $(SRC_DIR)/kernel.c
OBJS = $(OBJ_DIR)/boot.o $(OBJ_DIR)/kernel.o
KERNEL = myos.bin
ISO = XMeowwwOS.iso

all: $(ISO)

$(ISO): $(KERNEL)
	mkdir -p isodir/boot/grub
	cp $(KERNEL) isodir/boot/myos.bin
	cp $(CONFIG_DIR)/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO) isodir

$(KERNEL): $(OBJS)
	$(CC) -m32 -o $(KERNEL) $(OBJS) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(OBJ_DIR)
	$(CC) -m32 -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	mkdir -p $(OBJ_DIR)
	$(AS) --32 $< -o $@

clean:
	rm -rf $(OBJ_DIR) $(KERNEL) $(ISO) isodir

run: $(ISO)
	qemu-system-i386 -display curses -cdrom $(ISO)
