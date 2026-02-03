/* Minimal kernel: VGA text mode, print "not windows" */

#include <stdint.h>

#define VGA_BASE  0xB8000
#define VGA_WIDTH  80
#define VGA_HEIGHT 25

enum vga_color {
    VGA_BLACK = 0,
    VGA_BLUE,
    VGA_GREEN,
    VGA_CYAN,
    VGA_RED,
    VGA_MAGENTA,
    VGA_BROWN,
    VGA_LIGHT_GRAY,
    VGA_DARK_GRAY,
    VGA_LIGHT_BLUE,
    VGA_LIGHT_GREEN,
    VGA_LIGHT_CYAN,
    VGA_LIGHT_RED,
    VGA_LIGHT_MAGENTA,
    VGA_YELLOW,
    VGA_WHITE,
};

static inline uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg) {
    return fg | (bg << 4);
}

static inline uint16_t vga_entry(unsigned char c, uint8_t color) {
    return (uint16_t)c | ((uint16_t)color << 8);
}

void kernel_main(uint32_t magic, uint32_t addr) {
    (void)magic;
    (void)addr;

    volatile uint16_t *vga = (volatile uint16_t *)VGA_BASE;
    uint8_t color = vga_entry_color(VGA_LIGHT_GRAY, VGA_BLUE);

    /* Clear screen */
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++)
        vga[i] = vga_entry(' ', color);

    /* "not windows" at center-ish */
    const char *msg = "not windows";
    int row = 12;
    int col = (VGA_WIDTH - 11) / 2;
    for (int i = 0; msg[i]; i++)
        vga[row * VGA_WIDTH + col + i] = vga_entry(msg[i], color);

    /* Bottom line: hint */
    const char *hint = "this is an OS. (not windows)";
    int h = VGA_HEIGHT - 1;
    for (int i = 0; hint[i]; i++)
        vga[h * VGA_WIDTH + i] = vga_entry(hint[i], color);
}
