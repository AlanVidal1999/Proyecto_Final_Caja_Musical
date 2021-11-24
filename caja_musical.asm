#include "p16F628a.inc"   
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
 
RES_VECT  CODE    0x0000
    GOTO    START                   

INT_VECT  CODE	  0x0004
    GOTO ISR
    
  
MAIN_PROG CODE                   
i EQU 0x20
j EQU 0x21
k EQU 0x25
m EQU 0x26
x equ 0x30
y equ 0x31
z equ 0x32
a equ 0x33 
CNT equ 0x40
AUXI equ 0x34
AUXM equ 0x35
AUXJ equ 0x36
AUXK equ 0x37
SILENCIO equ 0x38
NOTA_NUMERO equ 0x39

START
    
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CMCON
    MOVLW b'10100000'
    MOVWF INTCON 
    BCF STATUS, RP1 ;Cambiar al banco 1
    BSF STATUS, RP0 
    MOVLW b'00000000'
    MOVWF TRISA
    MOVLW b'00000000'
    MOVWF TRISB 
    movlw b'10000111' ;!!! configuración de la prescaler en 1:256
    movwf OPTION_REG  ;!!! dentro del banco 1
    BCF STATUS, RP0 ;Regresar al banco 0

    			; setup registers		
			; setp TMR0 operation
			; internal clock, pos edge, prescale 256
  
			; setup TMR0 INT, 
			; must be cleared after interrupt
			; 256uS * 195 =~ 50mS
			; 255 - 195 = 60
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'6'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    CLRF PORTA
    CLRF PORTB
    CLRF NOTA_NUMERO
    CALL SOL

    
INITLCD
    CLRF PORTA
    CLRF PORTB
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time    
    
INICIO:
    NOP
    NOP
    BTFSS SILENCIO, 0
    BSF PORTA, 3
    CALL tiempo
    BCF PORTA, 3
    CALL tiempo
    NOP
    GOTO INICIO

RE:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW d'33'
    MOVWF AUXM
    MOVLW d'3'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'10'
    MOVWF AUXK
    RETURN
    
SOL:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    
    MOVLW d'38'
    MOVWF AUXM
    MOVLW d'2'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'11'
    MOVWF AUXK
    RETURN
 
SI:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'S'
    MOVWF PORTB
    CALL exec
    MOVLW 'I'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW d'157'
    MOVWF AUXM
    MOVLW d'1'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'10'
    MOVWF AUXK
    RETURN
 
RE2:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    MOVLW 'E'
    MOVWF PORTB
    CALL exec
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    
    MOVLW d'103'
    MOVWF AUXM
    MOVLW d'1'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'10'
    MOVWF AUXK
    RETURN
 
DO:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'D'
    MOVWF PORTB
    CALL exec
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW d'138'
    MOVWF AUXM
    MOVLW d'1'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'10'
    MOVWF AUXK
    RETURN

LA:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'L'
    MOVWF PORTB
    CALL exec
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW d'21'
    MOVWF AUXM
    MOVLW d'2'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'10'
    MOVWF AUXK
    RETURN
  
FA:
    BCF PORTA,0		
    CALL time
    MOVLW 0x87	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'F'
    MOVWF PORTB
    CALL exec
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    MOVLW '#'
    MOVWF PORTB
    CALL exec
    
    MOVLW d'3'
    MOVWF AUXM
    MOVLW d'2'
    MOVWF AUXI
    MOVLW d'15'
    MOVWF AUXJ
    MOVLW d'13'
    MOVWF AUXK
    RETURN
    
tiempo:  
    movfw AUXM
    movwf m
    
mloop:
    decfsz m,f
    goto mloop
    movfw AUXI
    movwf i
    
iloop:
    nop 
    nop
    movfw AUXJ
    movwf j
    
jloop:
    nop 
    movfw AUXK
    movwf k
kloop:
    decfsz k,f
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop
    return 
    
   
ISR: 
    BCF INTCON, GIE
    DECFSZ CNT 
    GOTO Salto
    INCF NOTA_NUMERO
    
    ; SILENCIO / 0.3seg
    MOVFW NOTA_NUMERO
    XORLW 0x01
    BTFSS STATUS,Z
    GOTO $+6
    
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    
    ; RE / 0.3seg
    MOVFW NOTA_NUMERO
    XORLW 0x02
    BTFSS STATUS,Z
    GOTO $+7
    BCF SILENCIO, 0
    CALL RE
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT

    ; SOL / 0.55seg
    MOVFW NOTA_NUMERO
    XORLW 0x03
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x04
    BTFSS STATUS,Z
    GOTO $+6
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; RE / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x05
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL RE
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x06
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; RE / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x07
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL RE
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x08
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; SI / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x09
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SI
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; RE / 0.55seg
    MOVFW NOTA_NUMERO
    XORLW 0x0A
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL RE
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO / 0.55 seg
    MOVFW NOTA_NUMERO
    XORLW 0x0B
    BTFSS STATUS,Z
    GOTO $+6
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; DO / 0.55 seg
    MOVFW NOTA_NUMERO
    XORLW 0x0C
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL DO
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO/ 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x0D
    BTFSS STATUS,Z
    GOTO $+6
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x0E
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; DO / 0.55 seg
    MOVFW NOTA_NUMERO
    XORLW 0x0F
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL DO
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x10
    BTFSS STATUS,Z
    GOTO $+6
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x11
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; DO / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x012
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL DO
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x13
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; FA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x14
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL FA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x15
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 6 = 0.3 Sec.
    MOVWF CNT
    
    ; RE / 0.55 seg
    MOVFW NOTA_NUMERO
    XORLW 0x16
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL RE
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO / 0.55 seg
    MOVFW NOTA_NUMERO
    XORLW 0x17
    BTFSS STATUS,Z
    GOTO $+6
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'7'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x18
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x19
    BTFSS STATUS,Z
    GOTO $+6
    
    BCF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.849 seg
    MOVFW NOTA_NUMERO
    XORLW 0x1A
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'10'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SI / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x1B
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SI
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x1C
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x1D
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x1E
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; FA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x1F
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL FA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; FA / 0.849 seg
    MOVFW NOTA_NUMERO
    XORLW 0x20
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL FA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'10'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x21
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; DO / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x22
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL DO
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; FA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x23
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL FA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x24
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x25
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.849 seg
    MOVFW NOTA_NUMERO
    XORLW 0x26
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'10'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SI / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x27
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SI
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; LA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x28
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL LA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x29
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SOL / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x2A
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL SOL
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; FA / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x2B
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL FA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; FA / 0.849 seg
    MOVFW NOTA_NUMERO
    XORLW 0x2C
    BTFSS STATUS,Z
    GOTO $+7
    
    BCF SILENCIO, 0
    CALL FA
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'10'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    ; SILENCIO / 0.3 seg
    MOVFW NOTA_NUMERO
    XORLW 0x2D
    BTFSS STATUS,Z
    GOTO $+6
    
    BSF SILENCIO, 0
    MOVLW D'195'	; preload value
    MOVWF TMR0
    MOVLW D'4'		; 50mS * 11 = 0.55 Sec.
    MOVWF CNT
    
    Salto
    MOVWF TMR0
    BCF INTCON, T0IF ;Clear external interrupt flag bit
    BSF INTCON, GIE ;Enable all interrupts on exit
    retfie  ; return from interrupt


    
exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    
    END