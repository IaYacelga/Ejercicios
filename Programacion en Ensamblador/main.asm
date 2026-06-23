.model small
.stack
.data

    mensaje  db 'Ingrese un numero: ', 0dh, 0ah, '$'
    mensaje1 db 'Ingrese un segundo numero:' , 0dh, 0ah, '$'

    var1     db ?
    var2     db ?
    suma     db ?



.code

main PROC
         mov ax, @data
         mov ds, ax


         mov ah, 09h
         mov dx,  offset mensaje
         int 21h

         mov ah, 01h
         int 21h
         mov var1, al

         mov al, var1
         sub al, 30h
         mov var1, al


         mov ah, 09h
         mov dx, offset mensaje1
         int 21h

         mov ah, 01h
         int 21h
         mov var2, al




         mov al, var2
         sub al, 30h
         mov var2, al



         mov al, var1
         add al, var2
         mov suma, al

         mov al, suma
         add al, 30h
         mov suma, al

         mov al, suma
         mov ah, 02h
         mov dl,  al
         int 21h



.exit
main ENDP


end main






















.exit
main ENDP


end main