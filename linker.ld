/* set arch to i386 (32-bit x86)*/
OUTPUT_FORMAT("elf32-i386")

ENTRY(_main)

SECTIONS
{
	. = 0x00400000; /* load up the app on this address (4 MiB) */
	.text : {
		*(.text)
	}

	.data : {
		*(.data)
	}

	.bss : {
		*(.bss)
		*(COMMON)
	}
}

