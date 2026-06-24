.model small
.stack
.data

    mensaje    db 'Ingrese un numero: ', 0dh, 0ah, '$'
    mensaje1   db 'Ingrese un segundo numero:' , 0dh, 0ah, '$'
    sonIguales db 'Los dos numeros son iguales $'
    esMayor    db 'el primero numero es mayor que el segudor $'
    esMenor    db 'el primero numero es menor que el segundo $'

    var1       db ?
    var2       db ?
    suma       db ?



.code

main PROC

             mov ax,@data
             mov ds, ax


             ;-----------------Lecutr del primero numero --------
             mov ah, 09h
             mov dx, offset mensaje
             int 21h

             mov ah, 01h
             int 21h
             mov var1, al

             mov al, var1
             sub al,30h
             mov var1, al

    ;-----------------Lecutr del segudo numero numero --------

             mov ah, 09h
             mov dx, offset mensaje1
             int 21h

             mov ah,01h
             int 21h
             mov var2, al

             mov al, var2
             sub al, 30h
             mov var2, al

    ;-----------------Comparacion de numeros--------


             mov al, var1
             mov bl, var2
             cmp al, bl

             je  esigual
             jg  aMayorb
             jl  aMenorb

    esigual:

             mov ah, 09h
             mov dx, offset sonIguales
             int 21h
             jmp fin



    aMayorb:


             mov ah, 09h
             mov dx, offset esMayor
             int 21h
             jmp fin

    aMenorb:


             mov ah, 09h
             mov dx, offset esMenor
             int 21h
             jmp fin











    fin:

.exit
main ENDP


end main






















.exit
main ENDP


end main