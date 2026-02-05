//we going for simplicity because open source + i understan the pain of online tutorials where everyone assumes you have 10 years in os dev ;D
//meow :3

char *VGA = (char*)0xB8000;

void pause(unsigned int t) {
    unsigned int i, j;
    for (i = 0; i < t; i++) {
        for (j = 0; j < 1000; j++) {
            // just burn cycles
        }
    }
}

int strlen(char *s) {
    int len = 0;
    while (s[len] != 0) {
        len++;
    }
    return len;
}

void out(char *string, int row, unsigned char color) {
  int i = 0;
  int rowbyte = row * 80 * 2;
  for (i = 0; i < strlen(string); i++) {
    VGA[rowbyte + i*2] = string[i];
    VGA[rowbyte + i*2 + 1] = color;
  }
}

void kernel_main(void) {
  out("Hello User!", 0, 0x0F);
  pause(1000);
  out("Welcome to the alpha of XMeowwwOS!", 1, 0x0F);
  pause(1000);
  out("If you got this cd outside of the official github repo...", 2, 0x0F);
  pause(1000);
  out("GGWP bro your computer is gone :(", 3, 0x04);
  pause(1000);
  out("Instructions on github Usage.md", 4, 0x0F);
  out("Btw you get no warranty", 5, 0x0F);
  while (1) {
    //do your mother ;]
  }
}