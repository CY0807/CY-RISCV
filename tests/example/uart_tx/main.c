#include <stdint.h>

#include "../include/uart.h"
#include "../include/xprintf.h"
#include "../include/utils.h"



int main()
{
  
  uart_init();

  xprintf("hello RISC-V!\n");

  set_test_pass();
}
