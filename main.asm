org 0x0100

section .data


tabEntier: dw 10,0,0,0,0,0,0,0,0,0,0	
erreurTableauVide: db  "Erreur, le tableau est vide!!!",10,13,'$'
tailleDuTableauEst: db  "La taille du tableau est : ",'$'
nombreDeNombreLus:  db 10,10,13, "Nombre d'entiers lu est : ",'$'

section .text
main:
mov cx, [tabEntier]
cmp cx, 0
    jg tableauNonVide	
	
	mov dx, erreurTableauVide
	push dx
    call printMess
	add sp, 2
	jmp finProg
	
	
    
tableauNonVide:	
    ;; Impression message "La taille du tableau est : "
    mov dx, tailleDuTableauEst
	push dx
    call printMess
	add sp, 2
	;; Impression de la taille du tableau 
	push cx
	call printInt
	add sp,2
	;; Initialisation du parcours du tableau pour le remplir. La boucle se base sur le contenude cx
	;; positionnement de l'indice de parcours sur le premier element du tableau
	;; nous supposons que le tableau contient au moins 1 element
	mov di, tabEntier + 2;; positionnement indice
	mov dx, 0  ;; initialisation du compteur Nombre de nombre entiers lu
debutBoucleLireTableau:
	call mess_pour_lire_entier

	sub sp, 2   ;; Reservation de la zone de retour
	call readInteger
	pop ax   ; recuperation de la valeur de retour et remise en forme de la pile
	
	cmp ax, 999
	je   finLectureDuTableau
	mov [di], ax
	inc dx  ;; Incrémentation du compteur
	add di,2  ;; passer à l'element suivant du tableau
	loop  debutBoucleLireTableau

finLectureDuTableau:
;; Affichage du nombre d'entiers lu
    mov bx, nombreDeNombreLus
	push bx
    call printMess
	add sp, 2
    push dx
    call printInt
	add sp,2
	
	;; Affichage du tableau.. Juste les nombres lu
	call affichagePartielDuTableau
	mov cx, dx   ;; initialisation du compteur de boucle
	mov si, tabEntier + 2 ;;  positionnement de l'indice de parcours
    
	

	;; Affichage complet du tableau.. 
	call affichageDeToutLeTableau
	mov cx, [tabEntier]   ;; initialisation du compteur de boucle
	mov si, tabEntier + 2 ;;  positionnement de l'indice de parcours
	
	
bouclePrintCompleteIntArray:
    call sautDeLIgne
    mov  ax, [si]
	push ax
	call printInt
    add sp, 2
	add si,2
    loop bouclePrintCompleteIntArray ;;

	
	
	;mov cx, [tabEntier]   ;; initialisation du compteur de boucle
	;mov si, tabEntier + 2 
   

 ;sommeTab:
  ;  add dx,[si]
	;add si,2
	;loop sommeTab
mov ax,0
mov dx,0
   call sautDeLIgne
   
   
   
    mov ax,tabEntier
	push ax
	sub sp,2
	call sumIntArray
    pop dx
	add sp,2
	
	
	
	call message_somme
	push dx
	call printInt
	add sp,2
	
	call sautDeLIgne
	
	
	call message_merci 
	;; Fin de main
finProg:	ret
















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ci dessous qudelques fonctions utilitaires
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



sumIntArray:
pusha
	mov bp, sp
	add bp, 18
	mov si, [bp+2]
	mov cx, [si]
	
	add si,2
	mov dx,0
   
	
	sum:
	add dx,[si]
	add si,2
	loop sum
	
	
	mov [bp],dx

popa
ret

section .data
affichageTabPartiel: db 10,13,'Affichage seulement  des elements lu du tableau',10,13,'$'	
section .text
affichagePartielDuTableau:
		pusha
		mov ah,0x9
		mov dx, affichageTabPartiel
		int 0x21
		popa
		ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .data
affichageTabEntier: db 10,13,'Affichage de tous les elements du tableau',10,13,'$'	
section .text
affichageDeToutLeTableau:
		pusha
		mov ah,0x9
		mov dx, affichageTabEntier
		int 0x21
		popa
		ret

section .data
buffsautDeLIgne: db 10,13,'$'	
section .text
sautDeLIgne:
		pusha
		mov ah,0x9
		mov dx, buffsautDeLIgne
		int 0x21
		popa
		ret
