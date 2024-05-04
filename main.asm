.equ delaym = 250
.org 0

rjmp main

main:
    ldi r17, (1 << PB0) | (1 << PB1) | (1 << PB2) | (1 << PB3) | (1 << PB4) | (1 << PB5) | (1 << PB6) 
    ldi r18, (0 << PB7)
    out DDRB, r17
    out DDRB, r18 
    sbi PORTB, PB7 
    ldi r19, 0    

button_check:
    sbic PINB, PB7 
    rjmp button_check 
    inc r19
    cpi r19, 6
    breq reset_counter
    rjmp segment_select

reset_counter:
    ldi r19, 0
    rjmp delay

segment_select:
    cpi r19, 1
    breq name1
    cpi r19, 2
    breq name2
    cpi r19, 3
    breq name3
    cpi r19, 4
    breq name4
    cpi r19, 5
    breq name5
    rjmp button_check


name1:
    ldi r23, 0
    ldi r23, 0b1110111
    out PORTB, r23
    rjmp delay

name2:
    ldi r24, 0
    ldi r24, 0b1010110
    out PORTB, r24
    rjmp delay

name3:
    ldi r25, 0
    ldi r25, 0b1111001
    out PORTB, r25
    rjmp delay

name4:
    ldi r26, 0
    ldi r26, 0b1110110
    out PORTB, r26
    rjmp delay

name5:
    ldi r27, 0
    ldi r27, 0b1110111
    out PORTB, r27
    rjmp delay
 
 


delay:
    ldi r20, delaym
    ldi r21, 0
delay_loop:
    inc r21
    cp r21, r20
    brne delay_loop
    rjmp button_check