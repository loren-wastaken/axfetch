# vars for toolchain
ASM = nasm
LD = ld

TARGET = axfetch.elf
MEDIA = /run/media/kotekun/1234-5678/APPS/FETCH.ELF

SRC = main.asm
OBJ = main.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(LD) -m elf_i386 -T linker.ld $(OBJ) -o $(TARGET)

$(OBJ): $(SRC)
	$(ASM) -f elf32 $(SRC) -o $(OBJ)

clean: 
	rm -f $(OBJ) $(TARGET)

copy:
	cp $(TARGET) $(MEDIA)

.PHONY: all clean
