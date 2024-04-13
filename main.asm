.include "tn13Adef.inc"

.equ button = PB1
.equ led = PB0
.equ delay = 10 ; Задержка в миллисекундах для дебаунсинга
.org 0
    rjmp main
.org INT0addr
    rjmp interr

main:
    ldi r16, (1<<led)
    out DDRB, r16
    ; Настройка вывода PB1 как входа для кнопки с внутренним pull-up резистором
    ldi r17, (0<<button)
    out DDRB, r17
    sbi PORTB, button ; Включение внутреннего pull-up резистора для PB1
    ; Настройка прерывания INT0 на срабатывание по изменению уровня на PB1
    ldi r18, (0<<ISC01) | (0<<ISC00) 
    out MCUCR, r18
    ; Разрешение прерывания INT0
    ldi r19, (1<<INT0)
    out GIMSK, r19
	//ldi r20, (1<<7)
	//out SREG, r20
    ; Установка флага глобальных прерываний
    sei
interr:
    ; Запускаем таймер для дебаунсинга
    ldi r20, delay
    mov r21, r20
debounce_loop:
    ; Ожидаем окончания задержки
    dec r21
    brne debounce_loop
    ; Считываем состояние кнопки
    in r18, PINB
    sbrs r18, button ; Проверяем, нажата ли кнопка
    rjmp LED_on ; Если кнопка не нажата, выключаем светодиод
    ; Выключаем светодиод
    cbi PORTB, led
    reti
LED_on:
    ; Включаем светодиод
    sbi PORTB, led
    reti
