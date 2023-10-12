#define MESSAGE "Hello world! Writing to UART from bare metal.\n"

volatile char *UART = (char*) 0x10000000;

void print_to_uart(char *message, int len) {
  for (int i = 0; i < len; i++) {
    *UART = message[i];
  }
}

int main() {
  print_to_uart(MESSAGE, sizeof(MESSAGE));

  while (1) {}
  
  return 0;
}
