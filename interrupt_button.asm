.include "tn13Adef.inc"

.equ button = PB1
.equ led = PB0
.equ delay = 10 
.org 0
    rjmp main
.org INT0addr
    rjmp interr

main:
    ldi r16, (1<<led)
    out DDRB, r16
    ldi r17, (0<<button)
    out DDRB, r17
    sbi PORTB, button 
    ldi r18, (0<<ISC01) | (0<<ISC00) 
    out MCUCR, r18
    ldi r19, (1<<INT0)
    out GIMSK, r19
	//ldi r20, (1<<7)
	//out SREG, r20
    sei
interr:
    ldi r20, delay
    mov r21, r20
debounce_loop:
    dec r21
    brne debounce_loop
    in r18, PINB
    sbrs r18, button 
    rjmp LED_on 
    cbi PORTB, led
    reti
LED_on:
    sbi PORTB, led
    reti
