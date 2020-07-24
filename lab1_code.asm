.thumb
.text
 .align 2

 .global main
 .thumbfunc main

main: .asmfunc
; This line is a comment. Your program goes here
; Add LOTS of Comments!
; foo MOV R0, #0x01 ; This is a sample line of code with a label ‘foo’

;------ init buttons
;store address for p1sel0 in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c0A
 add r0, r2, r3
;store value for p1sel0 in register 1
 MOV R1, #0x00
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;store address for p1sel1 in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c0C
 add r0, r2, r3
;store value for p1sel1 in register 1
 MOV R1, #0x00
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;store address for p1dir in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c04
 add r0, r2, r3
;store value for p1dir in register 1
 MOV R1, #0x00
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;store address for p1ren in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c06
 add r0, r2, r3
;store value for p1ren in register 1
 MOV R1, #0x12
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]


;--------------------------------------------------------------
;-------- init LEDs
;store address for p2sel0 in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c0b
 add r0, r2, r3
;store value for p2sel0 in register 1
 MOV R1, #0x00
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;store address for p2sel1 in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c0d
 add r0, r2, r3
;store value for p2sel1 in register 1
 MOV R1, #0x00
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;store address for p2dir in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c05
 add r0, r2, r3
;store value for p2dir in register 1
 MOV R1, #0x07
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;store address for p2ren in register 0
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c07
 add r0, r2, r3
;store value for p2ren in register 1
 MOV R1, #0x07
;store value into memory location stored in r0 with an offset of 0
 STRB R1, [R0, #0]

;-----------------------------------------------------------------

loopStart
;check port1 input register
;load from io register
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c00
 add r0, r2, r3

 mov r12, #0
 ldrb r12, [r0,#0]

; we want to look at bits 1 and 4, so and result with 0x12
; the buttons are active low, so bits 1 and 4 will be 0 if they are pressed
 and r4, r12, #0x12
 cmp r4, #0x00
; branch if not equal to 00
 bne not11
; if both buttons output 00 we have a correct button combo, display green
; address of P2OUT for LEDs
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c03
 add r0, r2, r3

; value to store is 0x02
 mov r1, #0x02
 strb r1, [r0, #0]
 b loopEnd

not11
 cmp r4, #0x12
; branch if not equal to 12
 bne not00
;if both buttons output 11 we are in standby, display blue
; address of P2OUT for LEDs
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c03
 add r0, r2, r3

; value to store is 0x04
 mov r1, #0x04
 strb r1, [r0, #0]
 b loopEnd

not00
; button combo is 01 or 10 bc its not 00 or 11, this is incorrect, display red
; address of P2OUT for LEDs
 mov r2, #0x4000
 lsl r3, r2, #0x10
 mov r2, #0x4c03
 add r0, r2, r3

; value to store is 0x01
 mov r1, #0x01
 strb r1, [r0, #0]

loopEnd B loopStart

.end
