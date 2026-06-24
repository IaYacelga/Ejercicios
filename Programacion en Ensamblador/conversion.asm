.model small
.stack 100h
.data
    menu           db 13,10,'Ingresar el numero en base: ', 13, 10,
                   db '1.- Base Decimal', 13, 10,
                   db '2.- Base Binaria', 13, 10,
                   db '3.- Base Hexadecimal', 13, 10,
                   db 'Escoja una opcion: $'

    opcion         db ?

    msgHexadecimal db 13,10,'Ingrese el numero en hexadecimal (max 3 digitos): ', 13,10, '$'
    msgBinario     db 13,10,'Ingrese el numero en binario (8 bits): ', 13,10, '$'
    msgDecimal     db 13,10,'Ingrese el numero en decimal (max 3 digitos): ', 13,10, '$'

    msgBin         db 13,10,'Binario:     $'
    msgHex         db 13,10,'Hexadecimal: $'
    msgDec         db 13,10,'Decimal:     $'
    msgH           db 'h$'

    buffer         db 10, 0, 10 dup(?)

.code


; aqui empieza el codigo -------------------------------------
main PROC
                       mov  ax, @data
                       mov  ds, ax

                       ; muestra el menu de opciones de base numerica
                       mov  ah, 09h
                       mov  dx, offset menu
                       int  21h

                       ; lee la opcion ingresada por el usuario
                       mov  ah, 01h
                       int  21h
                       mov  opcion, al

                       ; compara la opcion y salta a la etiqueta correspondiente
                       cmp  opcion, '1'
                       je   opcionDecimal

                       cmp  opcion, '2'
                       je   opcionBinario

                       cmp  opcion, '3'
                       je   opcionHexadecimal

                       jmp  fin

    ; estiquetas que van a cada opcione que el usuario ingreso(1,2,3)


    ;  OPCION 1

    opcionDecimal:

                       ; muestra el mensaje de ingreso en decimal
                       mov  ah, 09h
                       mov  dx, offset msgDecimal
                       int  21h

                       ; lee la cadena ingresada con int 21h funcion 0ah
                       mov  ah, 0Ah
                       lea  dx, buffer
                       int  21h

                       ; inicializa el contador y el puntero al buffer de entrada
                       mov  cl, [buffer+1]
                       mov  ch, 0
                       mov  si, offset buffer+2
                       mov  ax, 0                        ; aqui el acumulador que su guardara el numero

    ; convierte la cadena decimal a valor binario en ax
    decLoop:
                       cmp  cx, 0
                       je   decListo
                       mov  bl, [si]
                       sub  bl, 30h                      ; convierte ascii a digito numerico
                       mov  bh, 0

                       push cx
                       mov  cx, 10
                       mul  cx
                       pop  cx
                       add  ax, bx                       ; suma el digito actual
                       inc  si
                       dec  cx
                       jmp  decLoop

    decListo:
                       ; muestra el numero convertido en binario
                       push ax
                       mov  ah, 09h
                       mov  dx, offset msgBin
                       int  21h
                       pop  ax
                       call binarioABits

                       ; muestra el numero convertido en hexadecimal
                       push ax
                       mov  ah, 09h
                       mov  dx, offset msgHex
                       int  21h
                       pop  ax
                       call decimalAHexadecimal

                       jmp  fin


    ;  OPCION 2 ---------------------------

    opcionBinario:
                       ; muestra el mensaje de ingreso en binario
                       mov  ah, 09h
                       mov  dx, offset msgBinario
                       int  21h

                       ; lee la cadena ingresada con int 21h funcion 0ah
                       mov  ah, 0Ah
                       lea  dx, buffer
                       int  21h

                       ; inicializa el puntero y el contador de 8 bits
                       mov  si, offset buffer+2
                       mov  cx, 8                        ; se esperan exactamente 8 bits
                       mov  ax, 0                        ; ax = acumulador del resultado

    ; convierte la cadena binaria a valor decimal en ax
    binLoop:
                       mov  bl, [si]
                       sub  bl, 30h                      ; convierte ascii a decimal
                       mov  bh, 0
                       shl  ax, 1                        ; desplaza ax un bit a la izquierda
                       add  ax, bx                       ; suma el bit actual
                       inc  si
                       loop binLoop

                       ; muestra el numero convertido en decimal
                       push ax
                       mov  ah, 09h
                       mov  dx, offset msgDec
                       int  21h
                       pop  ax
                       call decimalACadena

                       ; muestra el numero convertido en hexadecimal
                       push ax
                       mov  ah, 09h
                       mov  dx, offset msgHex
                       int  21h
                       pop  ax
                       call decimalAHexadecimal

                       jmp  fin


    ;  OPCION 3 -------------------
    opcionHexadecimal:

                       ; muestra el mensaje de ingreso en hexadecimal
                       mov  ah, 09h
                       mov  dx, offset msgHexadecimal
                       int  21h

                       ; lee la cadena ingresada con int 21h funcion 0ah
                       mov  ah, 0Ah
                       lea  dx, buffer
                       int  21h

                       ; inicializa el puntero y el contador de caracteres
                       mov  si, offset buffer+2
                       mov  cl, [buffer+1]               ; se guarda la cantidad de caracteres leidos
                       mov  ch, 0
                       mov  ax, 0                        ; acumulador del resultado

    ; convierte la cadena hexadecimal a valor decimal en ax
    hexLoop:
                       cmp  cx, 0
                       je   hexListo
                       mov  bl, [si]


                       cmp  bl, 'a'
                       jl   noEsMinuscula
                       cmp  bl, 'f'
                       jg   noEsMinuscula
                       sub  bl, 20h
    noEsMinuscula:

                       ; determina si el caracter es letra o digito
                       cmp  bl, 'A'
                       jl   esDigitoHex
                       sub  bl, 'A'
                       add  bl, 10                       ; convierte cada numero a hecadecimal
                       jmp  sumarHex

    esDigitoHex:
                       sub  bl, 30h                      ; convierte caracteres ACII a numeros

    sumarHex:
                       mov  bh, 0
                       push cx
                       mov  cx, 16
                       mul  cx
                       pop  cx
                       add  ax, bx                       ; suma el digito actual
                       inc  si
                       dec  cx
                       jmp  hexLoop

    hexListo:


                       ; muestra el numero convertido en decimal
                       push ax
                       mov  ah, 09h
                       mov  dx, offset msgDec
                       int  21h
                       pop  ax
                       call decimalACadena

                       ; muestra el numero convertido en binario
                       push ax
                       mov  ah, 09h
                       mov  dx, offset msgBin
                       int  21h
                       pop  ax
                       call binarioABits

                       jmp  fin

    fin:
.exit

main ENDP

; procedimiento que convierte decimal a binario de 16 bits ---------------------
binarioABits PROC
                        mov  cx, 16
                        mov  bx, 2


    divBin:
                        mov  dx, 0              ; limpia dx antes de cada division
                        div  bx
                        push dx
                        loop divBin

                        ; imprime los 16 bits desde el mas significativo
                        mov  cx, 16
    impBin:
                        pop  dx
                        add  dl, 30h            ; convierte de numero a ASCII
                        mov  ah, 02h
                        int  21h
                        loop impBin
                        ret
binarioABits ENDP


; procedimiento que convierte decimal a hexadecimal --------------------
decimalAHexadecimal PROC
                        mov  cx, 0
                        mov  bx, 16

    ; divide sucesivamente entre 16 y guardando restos en la pila
    divHex:
                        mov  dx, 0              ; limpia dx antes de cada division
                        div  bx
                        cmp  dl, 10
                        jl   esNumHex
                        add  dl, 'A' - 10       ; convierte numeros a hexadecimal
                        jmp  pushHex
    esNumHex:
                        add  dl, 30h            ; convierte numeros a ASCII
    pushHex:
                        push dx
                        inc  cx
                        cmp  ax, 0
                        jne  divHex

    ; imprime los digitos hexadecimales en orden correcto
    impHex:
                        pop  dx
                        mov  ah, 02h
                        int  21h
                        loop impHex

                        ; imprime cada suffijo
                        mov  ah, 09h
                        mov  dx, offset msgH
                        int  21h
                        ret


decimalAHexadecimal ENDP

; procedimiento que convierte decimal a cadena de texto para imprimir ------------
decimalACadena PROC
                        mov  cx, 0
                        mov  bx, 10

    ; divide sucesivamente entre 10 y guardando restos en la pila
    divDec:
                        mov  dx, 0              ; limpia dx antes de cada division
                        div  bx
                        add  dl, 30h            ; convierte numeros a ASCII
                        push dx
                        inc  cx
                        cmp  ax, 0
                        jne  divDec

    ; imprime los digitos decimales en orden correcto
    impDec:
                        pop  dx
                        mov  ah, 02h
                        int  21h
                        loop impDec
                        ret
decimalACadena ENDP

end main