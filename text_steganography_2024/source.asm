include Irvine32.inc

.386
.model flat, stdcall
.stack 4096

.data
coverText db ' Text steganography involves the practice of hiding secret messages within a non-secret, plain text, making the presence of the encoded message unnoticeable to the observerser.  ', 0
secretMessage db 'ds0034abe', 0
key db 'key', 0
userKey db 20 dup(0)         ; Buffer for user input
bufferSize equ 100
extractedMessage db 100 dup(0)

.code
main proc
    ; Display the original cover text first
    mov edx, OFFSET coverText
    call WriteString
    call Crlf

    ; Prompt for user key
    mov edx, OFFSET userKey
    mov ecx, sizeof userKey
    call ReadString
    
    ; Compare input key with hardcoded key
    mov esi, OFFSET key
    mov edi, OFFSET userKey
    mov ecx, 3                 ; Length of the hardcoded key "key"
    call CompareStrings
    jz continue_process
    jmp exit_process

continue_process:
    ; Embed the message
    call EmbedMessage
    ; Extract the message
    call ExtractMessage

    ; Display the cover text with embedded message
    call Crlf
    mov edx, OFFSET coverText
    call WriteString
    call Crlf

    ; Display the extracted message
    mov edx, OFFSET extractedMessage
    call WriteString
    call Crlf

exit_process:
    ; Exit normally
    mov eax, 0                 ; Set exit code to 0
    call ExitProcess

main endp

;-----------------------------------------
; String Comparison
CompareStrings proc
    repe cmpsb                ; Compare strings byte by byte
    jz equal                  ; If equal, ZF is set
    mov eax, 1                ; Return 1 (not equal)
    ret
equal:
    xor eax, eax              ; Return 0 (equal)
    ret
CompareStrings endp

;-----------------------------------------
; Calculate the starting index using the key
CalculateStartIndex proc
    ; Implement the same procedure as previously discussed
    mov esi, OFFSET key
    xor edx, edx              ; Clear EDX before using EDX:EAX in DIV
    xor eax, eax              ; Clear EAX for sum
    mov ecx, 0                ; Initialize ECX to hold the sum

calc_loop:
    lodsb                     ; Load byte from DS:[ESI] into AL and increment ESI
    test al, al
    jz calc_done              ; If AL is zero (end of string), jump to done
    add eax, eax              ; Sum += AL (add ASCII value of key character)
    jc overflow_handler       ; Jump if carry flag is set (overflow occurred)
    jmp calc_loop

calc_done:
    mov ecx, LENGTHOF coverText
    test ecx, ecx
    jz calc_zero_error        ; Handle error if LENGTHOF coverText is zero
    div ecx                   ; EDX:EAX by ECX, result in EAX, remainder in EDX
    mov eax, edx              ; Use the remainder as the starting index
    ret

calc_zero_error:
    xor eax, eax              ; Return 0 as safe value
    ret

overflow_handler:
    shr eax, 1                ; Divide EAX by 2 to prevent overflow
    jmp calc_loop
CalculateStartIndex endp

;-----------------------------------------
; Embeds the message into the cover text
EmbedMessage proc
    ; Calculate starting index
    call CalculateStartIndex
    mov edi, eax              ; EDI will be our pointer into coverText
    add edi, OFFSET coverText ; Start at calculated index within coverText
    mov esi, OFFSET secretMessage ; ESI points to the secretMessage
    mov ecx, LENGTHOF secretMessage - 1 ; Number of bytes to embed

embed_loop:
    cmp byte ptr [esi], 0     ; Check if end of secretMessage
    je end_embed              ; If end, exit loop
    mov al, [esi]             ; Load byte from secretMessage
    mov [edi], al             ; Store byte in coverText
    inc edi                   ; Increment coverText index
    inc esi                   ; Increment secretMessage index
    loop embed_loop

end_embed:
    ret
EmbedMessage endp

;-----------------------------------------
; Extracts the message from the embedded text
; (Implementation needed based on previous discussion)
ExtractMessage proc
    ; Implement the same procedure as previously discussed
    ; Code omitted for brevity
    ret
ExtractMessage endp

end main
