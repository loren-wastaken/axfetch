# vars for toolchain
ASM = nasm
LD = ld

TARGET = axfetch.elf

SRC = main.asm
OBJ = main.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(LD) -m elf_i386 -T linker.ld $(OBJ) -o $(TARGET)

$(OBJ): $(SRC)
	$(ASM) -f elf32 $(SRC) -o $(OBJ)

clean:
	rm -f $(OBJ) $(TARGET)
# i cooked here, now i dont understand 50% of it f**k...
copy: $(TARGET)
	@printf "Path to disk image: "; \
	read IMAGE; \
	if [ ! -f "$$IMAGE" ]; then \
		echo "Error: disk image not found: $$IMAGE"; \
		exit 1; \
	fi; \
	MOUNT_DIR=$$(mktemp -d); \
	LOOP=$$(sudo losetup --find --show --partscan "$$IMAGE") || { \
		rmdir "$$MOUNT_DIR"; \
		exit 1; \
	}; \
	cleanup() { \
		sudo umount "$$MOUNT_DIR" 2>/dev/null || true; \
		sudo losetup -d "$$LOOP" 2>/dev/null || true; \
		rmdir "$$MOUNT_DIR"; \
	}; \
	trap cleanup EXIT INT TERM; \
	echo "Loop device: $$LOOP"; \
	PART="$${LOOP}p1"; \
	if [ ! -b "$$PART" ]; then \
		echo "Error: partition $$PART not found."; \
		exit 1; \
	fi; \
	echo "Mounting $$PART..."; \
	sudo mount "$$PART" "$$MOUNT_DIR" || exit 1; \
	if [ ! -d "$$MOUNT_DIR/APPS" ]; then \
		echo "Error: APPS directory not found."; \
		exit 1; \
	fi; \
	echo "Copying $(TARGET) to APPS/FETCH.ELF..."; \
	sudo cp "$(TARGET)" "$$MOUNT_DIR/APPS/FETCH.ELF"; \
	echo "Successfully installed FETCH.ELF."

.PHONY: all clean copy
