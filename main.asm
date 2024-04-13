.include "tn13adef.inc"
.org 0
rjmp main
main:  
    ldi r17, (1<<PB1)  
    ldi r18, (0<<PB2) 
    out DDRB, r18   
    sbi PORTB, PB2  

button_loop:
    sbis PINB, PB2      
    rjmp button_pressed  
    cbi PORTB, PB1  
    rjmp button_loop

button_pressed:     
    sbi PORTB, PB1      
    rjmp button_loop  
