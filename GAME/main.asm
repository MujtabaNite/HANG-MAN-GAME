.MODEL SMALL
.STACK 100H


.DATA
; ==============================
;  HANGMAN SPRITES (8x8 each)
; ==============================

hang_ve     db 11110000b, 11110000b, 11110000b, 11110000b
            db 11110000b, 11110000b, 11110000b, 11110000b, "$"   ; Vertical beam

hang_ho     db 00000000b, 00000000b, 00000000b, 00000000b
            db 11111111b, 11111111b, 11111111b, 11111111b, "$"   ; Horizontal beam

rope        db 00011000b, 00011000b, 00011000b, 00011000b
            db 00011000b, 00011000b, 00011000b, 00011000b, "$"   ; Rope

head        db 00011000b, 00111100b, 01000010b, 10100101b
            db 10000001b, 01000010b, 00111100b, 00011000b, "$"   ; Head

body_1      db 00111100b, 00111100b, 00111100b, 00111100b
            db 00111100b, 00111100b, 00111100b, 00111100b, "$"   ; Body stage 1 (simple)

body_2      db 00111100b, 11111100b, 10111100b, 10111100b
            db 10111100b, 10111100b, 10111100b, 00111100b, "$"   ; Body stage 2 (detailed)

body_3      db 00111100b, 11111111b, 10111101b, 10111101b
            db 10111101b, 10111101b, 10111101b, 00111100b, "$"   ; Body stage 3 (fully detailed)

leg_1       db 01100000b, 01100000b, 01100000b, 01100000b
            db 01100000b, 01100000b, 01100000b, 11100000b, "$"   ; Left leg

leg_2       db 01100110b, 01100110b, 01100110b, 01100110b
            db 01100110b, 01100110b, 01100110b, 11100111b, "$"   ; Both legs


; ===========================
;  POSITION TRACKERS
; ===========================

line                dw 0           ; Y position for drawing sprites
column_a            dw 0           ; X position for drawing sprites


; ==============================
;  LETTER BITMAPS (A-Z, 8x8)
; ==============================

letter_a    db 0x0C, 0x1E, 0x33, 0x33, 0x3F, 0x33, 0x33, 0x00, "$"
letter_b    db 0xFC, 0x66, 0x66, 0x7C, 0x66, 0x66, 0xFC, 0x00, "$"
letter_c    db 0x3C, 0x66, 0xC0, 0xC0, 0xC0, 0x66, 0x3C, 0x00, "$"
letter_d    db 0xF8, 0x6C, 0x66, 0x66, 0x66, 0x6C, 0xF8, 0x00, "$"
letter_e    db 0xFE, 0x62, 0x68, 0x78, 0x68, 0x62, 0xFE, 0x00, "$"
letter_f    db 0xFE, 0x62, 0x68, 0x78, 0x68, 0x60, 0xF0, 0x00, "$"
letter_g    db 0x3C, 0x66, 0xC0, 0xC0, 0xCE, 0x66, 0x3E, 0x00, "$"
letter_h    db 0x33, 0x33, 0x33, 0x3F, 0x33, 0x33, 0x33, 0x00, "$"
letter_i    db 0x3C, 0x18, 0x18, 0x18, 0x18, 0x18, 0x3C, 0x00, "$"
letter_j    db 0x1E, 0x0C, 0x0C, 0x0C, 0xCC, 0xCC, 0x78, 0x00, "$"
letter_k    db 0xE6, 0x66, 0x6C, 0x78, 0x6C, 0x66, 0xE6, 0x00, "$"
letter_l    db 0xF0, 0x60, 0x60, 0x60, 0x62, 0x66, 0xFE, 0x00, "$"
letter_m    db 0x63, 0x77, 0x7F, 0x7F, 0x6B, 0x63, 0x63, 0x00, "$"
letter_n    db 0xC6, 0xE6, 0xF6, 0xDE, 0xCE, 0xC6, 0xC6, 0x00, "$"
letter_o    db 0x1C, 0x36, 0x63, 0x63, 0x63, 0x36, 0x1C, 0x00, "$"
letter_p    db 0xFC, 0x66, 0x66, 0x7C, 0x60, 0x60, 0xF0, 0x00, "$"
letter_q    db 0x78, 0xCC, 0xCC, 0xCC, 0xDC, 0x78, 0x1C, 0x00, "$"
letter_r    db 0xFC, 0x66, 0x66, 0x7C, 0x6C, 0x66, 0xE6, 0x00, "$"
letter_s    db 0x78, 0xCC, 0xE0, 0x70, 0x1C, 0xCC, 0x78, 0x00, "$"
letter_t    db 0x3F, 0x2D, 0x0C, 0x0C, 0x0C, 0x0C, 0x1E, 0x00, "$"
letter_u    db 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x3F, 0x00, "$"
letter_v    db 0x33, 0x33, 0x33, 0x33, 0x33, 0x1E, 0x0C, 0x00, "$"
letter_w    db 0x63, 0x63, 0x63, 0x6B, 0x7F, 0x77, 0x63, 0x00, "$"
letter_x    db 0x63, 0x63, 0x36, 0x1C, 0x1C, 0x36, 0x63, 0x00, "$"
letter_y    db 0x33, 0x33, 0x33, 0x1E, 0x0C, 0x0C, 0x1E, 0x00, "$"
letter_z    db 0xFE, 0xC6, 0x8C, 0x18, 0x32, 0x66, 0xFE, 0x00, "$"


; ======================================
;  SUPPORT SPRITES / CHARACTERS
; ======================================

str_colon              db 0x00, 0x30, 0x30, 0x00, 0x00, 0x30, 0x30, 0x00, "$"
exclamation_mark       db 0x18, 0x3C, 0x3C, 0x18, 0x18, 0x00, 0x18, 0x00, "$"
space_line             db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, "$"
str_line               db 11111111b
str_empty              db 00000000b


; =====================================
;  GAME LOGIC VARIABLES & MESSAGES
; =====================================

str_word               db "HELLO WORLD$"         ; Word to guess
size_none              db 0                      ; Total letters in word
size_none_minor        db 0                      ; Count of non-space letters
mistakes               db 0                      ; Mistake counter
success_guess_counter  db 0                      ; Correct guesses made
str_guess              db 26 dup("$")            ; Guessed letters

alphabet_validation    db "ABCDEFGHIJKLMNOPQRSTUVWXYZ$"   ; Valid inputs

;  Messages
msg_top                dw "THE HANGMAN GAME$"
msg_restart            dw "PRESS ANY KEY$"
msg_won                dw "YOU WON$"
msg_lost               dw "YOU LOSE$"
already_guessed        dw "ALREADY GUESSED$"
invalid_char           dw "INVALID CHARACTER$"

;  Letter reference table (A-Z)
alphabet               dw letter_a, letter_b, letter_c, letter_d, letter_e, letter_f
                       dw letter_g, letter_h, letter_i, letter_j, letter_k, letter_l
                       dw letter_m, letter_n, letter_o, letter_p, letter_q, letter_r
                       dw letter_s, letter_t, letter_u, letter_v, letter_w, letter_x
                       dw letter_y, letter_z, "$"

;  Index helpers
alplhabet_index        dw 0
index_str_word         dw 0

;  Memory placeholder for rendered string display
str_lines              db ?                      ; Output version of str_word with guessed letters filled



 ; ========================================================================
; HANGMAN GAME - MODULARIZED VERSION
; ========================================================================
; This is a complete hangman game implementation in x86 assembly language
; The game displays a gallows, manages word guessing, and tracks mistakes
; ========================================================================

code segment
start:
    ; Initialize data and extra segments
    mov ax, data            ; Load data segment address into AX
    mov ds, ax              ; Set DS to point to data segment
    mov es, ax              ; Set ES to point to data segment

    ; Set graphics mode (320x200, 256 colors)
    mov ah, 0               ; BIOS video function: set video mode
    mov al, 0dh             ; Video mode 13h (320x200, 256 colors)
    int 10h                 ; Call BIOS video interrupt

    ; Set ES to point to video memory
    mov si, 0a000h          ; Video memory segment address
    mov es, si              ; Point ES to video memory

    jmp the_beginning       ; Jump to main game initialization

; ========================================================================
; PROCEDURE: GAME_INITIALIZATION
; Description: Initializes all game variables and starts the main game loop
; Input: None
; Output: None
; Modifies: AX, BX, CX, DX, SI, DI
; ========================================================================
the_beginning:
    ; Clear all general-purpose registers
    xor bx, bx              ; Clear BX register
    xor ax, ax              ; Clear AX register
    xor cx, cx              ; Clear CX register
    xor dx, dx              ; Clear DX register
    xor si, si              ; Clear SI register
    xor di, di              ; Clear DI register

    ; Initialize game variables
    mov mistakes, 0                     ; Reset mistake counter to 0
    mov success_guess_counter, 0        ; Reset successful guess counter

    ; Set initial drawing position for gallows
    mov column_a, 2         ; Starting column position
    mov line, 9             ; Starting line position

    jmp shows_hang_vertical ; Jump to gallows drawing routine

; ========================================================================
; PROCEDURE: DRAW_VERTICAL_GALLOWS
; Description: Draws the vertical part of the gallows structure
; Input: BL (counter), line, column_a (position variables)
; Output: Vertical gallows displayed on screen
; Modifies: BL, SI, line
; ========================================================================
shows_hang_vertical:
    lea si, hang_ve         ; Load address of vertical hangman character

    cmp bl, 8               ; Check if we've drawn 8 vertical lines
    je shows_hang_horizontal ; If yes, move to horizontal part

    call shows_letter       ; Display the vertical character

    inc bl                  ; Increment counter
    inc line                ; Move to next line
    jmp shows_hang_vertical ; Continue drawing vertical lines

; ========================================================================
; PROCEDURE: DRAW_HORIZONTAL_GALLOWS
; Description: Draws the horizontal part of the gallows structure
; Input: BX (counter), line, column_a (position variables)
; Output: Horizontal gallows displayed on screen
; Modifies: BX, SI, column_a, line
; ========================================================================
shows_hang_horizontal:
    mov bx, 0               ; Reset counter for horizontal drawing
    mov column_a, 2         ; Reset column position
    mov line, 9             ; Reset line position

repeat_hang_horizontal:
    lea si, hang_ho         ; Load address of horizontal hangman character

    cmp bl, 4               ; Check if we've drawn 4 horizontal characters
    je shows_rope           ; If yes, move to rope drawing

    call shows_letter       ; Display the horizontal character

    inc bl                  ; Increment counter
    inc column_a            ; Move to next column
    jmp repeat_hang_horizontal ; Continue drawing horizontal lines

; ========================================================================
; PROCEDURE: DRAW_ROPE
; Description: Draws the hanging rope part of the gallows
; Input: None
; Output: Rope displayed at specified position
; Modifies: column_a, line, SI
; ========================================================================
shows_rope:
    mov column_a, 5         ; Set rope column position
    mov line, 10            ; Set rope line position
    lea si, rope            ; Load address of rope character
    call shows_letter       ; Display the rope

    jmp begin               ; Jump to word processing initialization

; ========================================================================
; PROCEDURE: INITIALIZE_WORD_DISPLAY
; Description: Processes the target word and creates display lines
; Input: str_word (target word string)
; Output: str_lines (display format with underscores)
; Modifies: BX, AL, str_lines array
; ========================================================================
begin:
    mov bx, 0               ; Initialize index counter

fills_str_lines:
    cmp str_word[bx],"$"    ; Check for end of string marker
    je  continues           ; If end found, continue to next phase

    cmp str_word[bx]," "    ; Check if current character is space
    je  str_spaceline       ; If space, handle differently

    ; For regular letters, show underscore
    mov al,str_line         ; Load underscore character
    mov str_lines[bx], al   ; Store underscore in display array

    inc bx                  ; Move to next character
    jmp fills_str_lines     ; Continue processing

str_spaceline:
    ; For spaces, show empty space in display
    mov al,str_empty        ; Load empty space character
    mov str_lines[bx], al   ; Store space in display array
    inc bx                  ; Move to next character
    jmp fills_str_lines     ; Continue processing

; ========================================================================
; PROCEDURE: CALCULATE_WORD_SIZE
; Description: Calculates the size of the word excluding spaces
; Input: str_word (target word)
; Output: size_none, size_none_minor (word length variables)
; Modifies: BX, DL, size_none, size_none_minor
; ========================================================================
continues:
    ; Calculate total word size
    mov bx,offset size_none ; Get address of size variable
    sub bx,offset str_word  ; Subtract word start address
    sub bx, 1               ; Adjust for zero-based indexing
    mov size_none,bl        ; Store total size

    mov bx, 0               ; Reset index
    mov dl, size_none       ; Copy size to working variable
    mov size_none_minor, dl ; Store working size

counts_space_lines:
    cmp str_word[bx], 32    ; Check if character is space (ASCII 32)
    je discard_space_lines  ; If space, don't count it
    cmp str_word[bx], "$"   ; Check for end of string
    je continues_two        ; If end, continue to display

    inc bx                  ; Move to next character
    jmp counts_space_lines  ; Continue counting

discard_space_lines:
    inc bx                  ; Move past the space
    sub size_none_minor, 1  ; Reduce count (don't count spaces)
    jmp counts_space_lines  ; Continue counting

; ========================================================================
; PROCEDURE: DISPLAY_WORD_LINES
; Description: Displays the word as underscores/spaces on screen
; Input: str_lines (processed word display), size_none
; Output: Word display rendered on screen
; Modifies: BX, CL, SI, DI, AL, column_a, line
; ========================================================================
continues_two:
    ; Set display position for word
    mov line,14             ; Set line position for word display
    mov column_a,16         ; Set starting column position
    mov bx,0                ; Reset character index
    mov cl,0                ; Reset character counter

shows_str_lines:
    lea si,str_lines[bx]    ; Load address of current display character

    cmp cl,size_none        ; Check if all characters processed
    je  show_msg_top        ; If done, show top message

    cmp column_a, 38        ; Check if line is full (38 characters)
    je  new_line            ; If full, move to new line

    call calculate_line_and_column ; Calculate screen position

    mov al,[si]             ; Load character to display
    mov es:[di], al         ; Write character to video memory

    inc bx                  ; Move to next character
    inc cl                  ; Increment character counter
    add column_a,2          ; Move 2 positions right (spacing)

    jmp shows_str_lines     ; Continue displaying characters

new_line:
    mov column_a,16         ; Reset to starting column
    add line, 2             ; Move down 2 lines
    jmp shows_str_lines     ; Continue displaying

; ========================================================================
; PROCEDURE: DISPLAY_TOP_MESSAGE
; Description: Displays the game instructions at the top of screen
; Input: msg_top (message string)
; Output: Instructions displayed on screen
; Modifies: line, column_a, SI
; ========================================================================
show_msg_top:
    mov line, 1             ; Set line position for top message
    mov column_a, 13        ; Set column position for message
    lea si, msg_top         ; Load address of top message
    call ascii_to_bitmap    ; Convert and display message
    jmp guess               ; Jump to input handling

; ========================================================================
; PROCEDURE: GET_USER_INPUT
; Description: Gets a character input from user and processes it
; Input: User keyboard input
; Output: Character stored for processing
; Modifies: AX, AL, BX, DI
; ========================================================================
guess:
    mov ah, 08              ; DOS function: get character without echo
    int 21h                 ; Call DOS interrupt

    call nobreak           ; Call stack management routine
    call limpa_line        ; Clear input line
    push di                ; Save DI register

    cmp al,96               ; Check if character is lowercase (> 96)
    ja uppercase            ; If lowercase, convert to uppercase

    jmp guess_validation    ; Jump to input validation

; ========================================================================
; PROCEDURE: CONVERT_TO_UPPERCASE
; Description: Converts lowercase letters to uppercase
; Input: AL (character to convert)
; Output: AL (converted uppercase character)
; Modifies: AL
; ========================================================================
uppercase:
    sub al,20h              ; Subtract 32 to convert to uppercase
    jmp guess_validation    ; Jump to validation

; ========================================================================
; PROCEDURE: STACK_MANAGEMENT
; Description: Manages stack operations for function calls
; Input: Stack state
; Output: Managed stack state
; Modifies: BX (temporarily)
; ========================================================================
nobreak:
    pop  bx                 ; Pop return address
    push bx                 ; Push it back
    mov  bx,0               ; Clear BX
    ret                     ; Return to caller

; ========================================================================
; PROCEDURE: STORE_VALID_GUESS
; Description: Stores a validated guess in the guess string
; Input: AL (character), DI (index)
; Output: Character stored in str_guess array
; Modifies: str_guess array
; ========================================================================
list_alphabet_validation:
    mov str_guess[di],al    ; Store guessed character
    mov str_guess[di+1],"$" ; Add string terminator
    ret                     ; Return to caller

; ========================================================================
; PROCEDURE: PROCESS_VALIDATED_INPUT
; Description: Processes input that has passed initial validation
; Input: Validated character in AL
; Output: Continues to character validation
; Modifies: None (calls other procedures)
; ========================================================================
validated:
    call nobreak           ; Manage stack
    jmp  ascii             ; Jump to ASCII validation

; ========================================================================
; PROCEDURE: CHECK_ALREADY_GUESSED
; Description: Checks if the character has already been guessed
; Input: AL (character), str_guess (previous guesses)
; Output: Either continues or shows "already guessed" message
; Modifies: BX, DI
; ========================================================================
guess_validation:
    mov  di,bx              ; Save BX in DI
    cmp  str_guess[bx],al   ; Check if character already guessed
    je shows_text_two       ; If already guessed, show message
    cmp  str_guess[bx],"$"  ; Check for end of guess string
    je   validated          ; If end reached, character is new

    inc  bx                 ; Move to next guess
    jmp  guess_validation   ; Continue checking

; ========================================================================
; PROCEDURE: DISPLAY_ALREADY_GUESSED_MESSAGE
; Description: Shows message when user enters a previously guessed letter
; Input: already_guessed (message string)
; Output: Message displayed on screen
; Modifies: line, column_a, SI
; ========================================================================
shows_text_two:
    mov line, 5             ; Set message line position
    mov column_a, 13        ; Set message column position
    lea si, already_guessed ; Load "already guessed" message
    call ascii_to_bitmap    ; Display the message
    jmp guess               ; Return to input loop

; ========================================================================
; PROCEDURE: VALIDATE_ALPHABETIC_CHARACTER
; Description: Checks if input character is a valid letter (A-Z)
; Input: AL (character), alphabet_validation (valid character string)
; Output: Either continues or shows invalid character message
; Modifies: BX
; ========================================================================
ascii:
    cmp  alphabet_validation[bx],al ; Check against valid alphabet
    je   eascii             ; If valid, continue processing
    cmp  alphabet_validation[bx],"$" ; Check for end of alphabet string
    je shows_text_three     ; If end reached, character is invalid

    inc  bx                 ; Move to next valid character
    jmp  ascii              ; Continue validation

; ========================================================================
; PROCEDURE: DISPLAY_INVALID_CHARACTER_MESSAGE
; Description: Shows message when user enters invalid character
; Input: invalid_char (message string)
; Output: Message displayed on screen
; Modifies: line, column_a, SI
; ========================================================================
shows_text_three:
    mov line, 5             ; Set message line position
    mov column_a, 12        ; Set message column position
    lea si, invalid_char    ; Load "invalid character" message
    call ascii_to_bitmap    ; Display the message
    jmp guess               ; Return to input loop

; ========================================================================
; PROCEDURE: STORE_ALPHABET_INDEX
; Description: Stores the index of the valid character in alphabet
; Input: BX (alphabet index)
; Output: alplhabet_index updated
; Modifies: alplhabet_index variable
; ========================================================================
eascii:
    mov  alplhabet_index,bx ; Store alphabet index
    call nobreak           ; Manage stack
    jmp  comparing          ; Jump to word comparison

; ========================================================================
; PROCEDURE: COMPARE_WITH_TARGET_WORD
; Description: Checks if guessed letter exists in target word
; Input: AL (guessed character), str_word (target word)
; Output: Branches to correct/incorrect handling
; Modifies: BX, index_str_word
; ========================================================================
comparing:
    cmp  str_word[bx], al   ; Compare guess with word character
    je   got_it             ; If match found, handle correct guess
    cmp  str_word[bx], "$"  ; Check for end of word
    je   u_wrong            ; If end reached, guess is wrong

    inc  bx                 ; Move to next character in word
    jmp  comparing          ; Continue comparing
    mov  index_str_word, bx ; Store current word index

; ========================================================================
; PROCEDURE: HANDLE_CORRECT_GUESS
; Description: Processes a correct letter guess
; Input: AL (correct character), BX (position in word)
; Output: Letter revealed in display, checks for win condition
; Modifies: Various registers and game state variables
; ========================================================================
got_it:
    call list_alphabet_validation ; Store the guess
    mov  index_str_word, bx ; Store word position
    pop  di                 ; Restore DI
    pop  bx                 ; Restore BX

    call letter_bitmap      ; Display the revealed letter

    call nobreak           ; Manage stack

    ; Check for win condition
    mov  bl, size_none_minor ; Load required correct guesses
    cmp  success_guess_counter, bl ; Compare with current successes
    je gameover             ; If all letters guessed, game over

    jmp  guess              ; Continue game loop

; ========================================================================
; PROCEDURE: HANDLE_INCORRECT_GUESS
; Description: Processes an incorrect letter guess
; Input: AL (incorrect character)
; Output: Mistake counter incremented, hangman part drawn
; Modifies: mistakes counter, game state
; ========================================================================
u_wrong:
    call list_alphabet_validation ; Store the guess

    pop  bx                 ; Restore BX
    pop  di                 ; Restore DI

    inc  mistakes           ; Increment mistake counter
    call verify_mistakes    ; Draw corresponding hangman part
    cmp  mistakes,6         ; Check if maximum mistakes reached
    je gameover             ; If 6 mistakes, game over

    jmp  guess              ; Continue game loop

; ========================================================================
; PROCEDURE: CLEAR_MESSAGE_LINE
; Description: Clears the message line by overwriting with spaces
; Input: None
; Output: Message line cleared on screen
; Modifies: line, column_a, SI
; ========================================================================
limpa_line:
    mov line, 5             ; Set line to clear
    mov column_a, 8         ; Set starting column

repeat_limpa_line:
    lea si, space_line      ; Load space character

    cmp column_a, 35        ; Check if end of line reached
    je returns              ; If yes, return

    call shows_letter       ; Display space character
    add column_a, 1         ; Move to next column

    jmp repeat_limpa_line   ; Continue clearing

; ========================================================================
; PROCEDURE: DISPLAY_REVEALED_LETTER
; Description: Shows correctly guessed letters in the word display
; Input: AL (character), various position variables
; Output: Letter displayed in correct word position(s)
; Modifies: Multiple registers and position variables
; ========================================================================
letter_bitmap:
    inc success_guess_counter ; Increment successful guess counter

    mov cx, ax              ; Save character in CX

    ; Calculate alphabet bitmap index
    mov  dx, 2              ; Each alphabet entry is 2 bytes
    mov  ax, alplhabet_index ; Get alphabet index
    mul  dx                 ; Multiply by 2
    mov  di, ax             ; Store result in DI

    ; Set up display parameters
    mov  si, alphabet[di]   ; Get character bitmap address
    mov  line, 13           ; Set display line
    mov column_a,16         ; Set starting column

    ; Calculate display position
    mov  dx, index_str_word ; Get word position
    add  column_a, dx       ; Add to column position
    add  column_a, dx       ; Double spacing

    ; Handle line wrapping for long words
    cmp dx, 54              ; Check if position > 54
    jg  line_six            ; If yes, use line 6
    cmp dx, 43              ; Check if position > 43
    jg  line_five           ; If yes, use line 5
    cmp dx, 32              ; Check if position > 32
    jg  line_four           ; If yes, use line 4
    cmp dx, 21              ; Check if position > 21
    jg  line_three          ; If yes, use line 3
    cmp dx, 10              ; Check if position > 10
    jg  line_two            ; If yes, use line 2

a:
    call shows_letter       ; Display the character

    mov ax, cx              ; Restore character

    ; Find next occurrence of same letter
    mov bx, index_str_word  ; Get current position
    add bx, 1               ; Move to next position
    add index_str_word, 1   ; Update index

repeat_letter:
    cmp str_word[bx], al    ; Check if same letter found
    je  letter_bitmap       ; If found, display it too
    cmp str_word[bx], "$"   ; Check for end of word
    je returns              ; If end, return
    inc bx                  ; Move to next character
    add index_str_word, 1   ; Update index
    jmp repeat_letter       ; Continue searching

; Line positioning routines for word wrapping
line_two:
    add line, 2             ; Move down 2 lines
    mov column_a, 16        ; Reset column
    add column_a, dx        ; Add position
    add column_a, dx        ; Double spacing
    sub column_a, 22        ; Adjust for line offset
    jmp a                   ; Display character

line_three:
    add line, 4             ; Move down 4 lines
    mov column_a, 16        ; Reset column
    add column_a, dx        ; Add position
    add column_a, dx        ; Double spacing
    sub column_a, 44        ; Adjust for line offset
    jmp a                   ; Display character

line_four:
    add line, 6             ; Move down 6 lines
    mov column_a, 16        ; Reset column
    add column_a, dx        ; Add position
    add column_a, dx        ; Double spacing
    sub column_a, 66        ; Adjust for line offset
    jmp a                   ; Display character

line_five:
    add line, 8             ; Move down 8 lines
    mov column_a, 16        ; Reset column
    add column_a, dx        ; Add position
    add column_a, dx        ; Double spacing
    sub column_a, 88        ; Adjust for line offset
    jmp a                   ; Display character

line_six:
    add line, 10            ; Move down 10 lines
    mov column_a, 16        ; Reset column
    add column_a, dx        ; Add position
    add column_a, dx        ; Double spacing
    sub column_a, 110       ; Adjust for line offset
    jmp a                   ; Display character

; ========================================================================
; PROCEDURE: GAME_OVER_HANDLER
; Description: Handles end game conditions (win or lose)
; Input: mistakes counter
; Output: Appropriate end game message displayed
; Modifies: Screen display
; ========================================================================
gameover:
    cmp mistakes,6          ; Check if player lost (6 mistakes)
    je  shows_msg_failure   ; If lost, show failure message

    jmp shows_msg_success   ; Otherwise, show success message

; ========================================================================
; PROCEDURE: PROGRAM_TERMINATION
; Description: Terminates the program and returns to DOS
; Input: None
; Output: Program ends
; Modifies: AX
; ========================================================================
the_end:
    mov ax, 4c00h           ; DOS terminate program function
    int 21h                 ; Call DOS interrupt

; ========================================================================
; PROCEDURE: DISPLAY_SUCCESS_MESSAGE
; Description: Shows winning message when player guesses the word
; Input: msg_won (success message)
; Output: Success message displayed
; Modifies: Screen display, position variables
; ========================================================================
shows_msg_success:
    call clean_screen       ; Clear the screen
    mov line, 10            ; Set message line
    mov column_a, 17        ; Set message column
    lea si, msg_won         ; Load success message
    call ascii_to_bitmap    ; Display message
    jmp shows_msg_restart   ; Show restart option

; ========================================================================
; PROCEDURE: DISPLAY_FAILURE_MESSAGE
; Description: Shows losing message when player makes 6 mistakes
; Input: msg_lost (failure message)
; Output: Failure message displayed
; Modifies: Screen display, position variables
; ========================================================================
shows_msg_failure:
    call clean_screen       ; Clear the screen
    mov line, 10            ; Set message line
    mov column_a, 16        ; Set message column
    lea si, msg_lost        ; Load failure message
    call ascii_to_bitmap    ; Display message
    jmp shows_msg_restart   ; Show restart option

; ========================================================================
; PROCEDURE: DISPLAY_RESTART_MESSAGE
; Description: Shows restart instructions to player
; Input: msg_restart (restart message)
; Output: Restart message displayed
; Modifies: Screen display, position variables
; ========================================================================
shows_msg_restart:
    mov line, 12            ; Set message line
    mov column_a, 14        ; Set message column
    lea si, msg_restart     ; Load restart message
    call ascii_to_bitmap    ; Display message
    jmp restart             ; Jump to restart handler

; ========================================================================
; PROCEDURE: CLEAR_SCREEN
; Description: Clears the entire screen by filling video memory with zeros
; Input: None
; Output: Screen cleared to black
; Modifies: AX, ES, DI, CX
; ========================================================================
clean_screen:
    mov ax,0a000h           ; Video memory segment
    mov es,ax               ; Point ES to video memory
    xor di,di               ; Start at beginning of video memory
    xor ax,ax               ; Clear AX (value to fill with)
    mov cx,32000d           ; Number of words to clear (64000 bytes / 2)
    cld                     ; Clear direction flag (forward)
    rep stosw               ; Repeat store word (clear screen)
    ret                     ; Return to caller

; ========================================================================
; PROCEDURE: DRAW_HANGMAN_PARTS
; Description: Draws appropriate hangman part based on mistake count
; Input: mistakes (current mistake count)
; Output: Corresponding body part drawn
; Modifies: Position variables, screen display
; ========================================================================
verify_mistakes:
    cmp mistakes, 1         ; Check for first mistake
    je shows_head           ; Draw head

    cmp mistakes, 2         ; Check for second mistake
    je shows_body           ; Draw body

    cmp mistakes, 3         ; Check for third mistake
    je shows_arm            ; Draw arms

    cmp mistakes, 4         ; Check for fourth mistake
    je shows_body_complete  ; Complete body

    cmp mistakes, 5         ; Check for fifth mistake
    je shows_leg            ; Draw first leg

    cmp mistakes, 6         ; Check for sixth mistake
    je shows_guy_complete   ; Complete hangman figure

; Individual hangman part drawing procedures
shows_head:
    mov column_a, 5         ; Set head position column
    mov line, 11            ; Set head position line
    lea si, head            ; Load head character
    call shows_letter       ; Display head
    ret                     ; Return

shows_body:
    mov column_a, 5         ; Set position column
    mov line, 11            ; Set head line
    lea si, head            ; Display head
    call shows_letter       

    mov line, 12            ; Set body line
    lea si, body_1          ; Load body part 1
    call shows_letter       ; Display body part
    ret                     ; Return

shows_arm:
    mov column_a, 5         ; Set position column
    mov line, 11            ; Set head line
    lea si, head            ; Display head
    call shows_letter       

    mov line, 12            ; Set body line
    lea si, body_2          ; Load body part 2 (with arms)
    call shows_letter       ; Display body with arms
    ret                     ; Return

shows_body_complete:
    mov column_a, 5         ; Set position column
    mov line, 11            ; Set head line
    lea si, head            ; Display head
    call shows_letter       

    mov line, 12            ; Set body line
    lea si, body_3          ; Load complete body
    call shows_letter       ; Display complete body
    ret                     ; Return

shows_leg:
    mov column_a, 5         ; Set position column
    mov line, 11            ; Set head line
    lea si, head            ; Display head
    call shows_letter       

    mov line, 12            ; Set body line
    lea si, body_3          ; Display complete body
    call shows_letter       

    mov line, 13            ; Set leg line
    lea si, leg_1           ; Load first leg
    call shows_letter       ; Display first leg
    ret                     ; Return

shows_guy_complete:
    mov column_a, 5         ; Set position column
    mov line, 11            ; Set head line
    lea si, head            ; Display head
    call shows_letter       

    mov line, 12            ; Set body line
    lea si, body_3          ; Display complete body
    call shows_letter       

    mov line, 13            ; Set legs line
    lea si, leg_2           ; Load both legs
    call shows_letter       ; Display both legs
    ret                     ; Return

; ========================================================================
; PROCEDURE: CALCULATE_SCREEN_POSITION
; Description: Converts line/column coordinates to video memory address
; Input: line, column_a (screen coordinates)
; Output: DI (video memory offset)
; Modifies: AX, BX, DI (preserves original values on stack)
; ========================================================================
calculate_line_and_column:
    push line               ; Save line value
    push column_a           ; Save column value
    push ax                 ; Save AX register
    push bx                 ; Save BX register

    mov di, 0               ; Initialize DI

    ; Calculate line offset: line * 40 * 8
    mov ax, line            ; Load line number
    mov bx, 40              ; 40 characters per line
    mul bx                  ; AX = line * 40

    mov bx, 08              ; 8 pixels per character height
    mul bx                  ; AX = line * 40 * 8

    mov line, ax            ; Store calculated line offset

    add di, column_a        ; Add column offset
    add di, line            ; Add line offset

    pop bx                  ; Restore BX
    pop ax                  ; Restore AX
    pop column_a            ; Restore column_a
    pop line                ; Restore line

    ret                     ; Return with DI = video memory offset

; ========================================================================
; PROCEDURE: DISPLAY_CHARACTER_BITMAP
; Description: Displays a character bitmap at current screen position
; Input: SI (pointer to character data), DI (screen position)
; Output: Character displayed on screen
; Modifies: DL, DI, SI
; ========================================================================
shows_letter:
    call calculate_line_and_column ; Calculate screen position

writes:
    mov dl, [si]            ; Load byte from character data
    cmp dl, "$"             ; Check for end marker
    je returns              ; If end, return

    mov es:[di], dl         ; Write byte to video memory

    add di, 40              ; Move to next line (40 bytes per line)
    inc si                  ; Move to next byte in character data
    jmp writes              ; Continue writing

returns:
    ret                     ; Return to caller

; ========================================================================
; PROCEDURE: DISPLAY_SINGLE_CHARACTER
; Description: Displays a single character at calculated position
; Input: SI (character pointer), screen position variables
; Output: Single character displayed
; Modifies: AL, DI
; ========================================================================
shows_str_line:
    call calculate_line_and_column ; Calculate screen position

    mov al, [si]            ; Load character
    mov es:[di], al         ; Write to video memory

    ret                     ; Return

; ========================================================================
; PROCEDURE: CLEAR_GUESS_ARRAY
; Description: Clears the array storing previous guesses
; Input: str_guess array
; Output: Array filled with string terminators
; Modifies: DI, str_guess array
; ========================================================================
clean_guess:
    mov di, 0               ; Initialize index

repeat_lmp_palp:
    mov str_guess[di], "$"  ; Set terminator

    cmp di, 25              ; Check if end of array reached
    je clean_done           ; If yes, finish

    inc di                  ; Move to next position

    jmp repeat_lmp_palp     ; Continue clearing

; ========================================================================
; PROCEDURE: RESTART_GAME_HANDLER
; Description: Handles game restart input and cleanup
; Input: User keypress
; Output: Game restarted or terminated
; Modifies: AX, screen display
; ========================================================================
restart:
    mov ah, 08              ; Get character input
    int 21h                 ; Call DOS interrupt

    push ax                 ; Save input character
    call clean_screen       ; Clear the screen
    pop ax                  ; Restore input character

    push di                 ; Save DI register
    call clean_guess        ; Clear previous guesses

clean_done:
    pop di                  ; Restore DI register
    jmp the_end             ; Jump to program termination

; ========================================================================
; PROCEDURE: CONVERT_ASCII_TO_BITMAP
; Description: Converts ASCII text string to bitmap display characters
; Input: SI (pointer to ASCII string), position variables
; Output: Text displayed as bitmap characters on screen
; Modifies: AX, BX, DX, DI, SI, column_a
; ========================================================================
ascii_to_bitmap:
    push ax                 ; Save AX register
    push bx                 ; Save BX register
    push dx                 ; Save DX register
    push di                 ; Save DI register

repeat_ascii_to_bitmap:
    mov ah, 0               ; Clear high byte of AX
    mov al, [si]            ; Load current character
    sub al, 65              ; Convert to alphabet index (A=0, B=1, etc.)
    mov dl, 2               ; Each alphabet entry is 2 bytes
    mul dl                  ; Calculate offset in alphabet array

    cmp [si], "$"           ; Check for string terminator
    je word_finished        ; If end of string, finish
    cmp [si], " "           ; Check for space character
    je empty_space          ; If space, handle differently

    mov di, ax              ; Store alphabet offset in DI

    push si                 ; Save string pointer
    mov si, alphabet[di]    ; Get bitmap address for character
    call shows_letter       ; Display the character bitmap
    pop si                  ; Restore string pointer

empty_space:
    inc column_a            ; Move to next column position
    inc si                  ; Move to next character in string

    jmp repeat_ascii_to_bitmap ; Continue processing string

word_finished:
    pop ax                  ; Restore AX register
    pop bx                  ; Restore BX register
    pop dx                  ; Restore DX register
    pop di                  ; Restore DI register
    ret                     ; Return to caller

ends                        ; End of code segment
end start                   ; End of program, entry point is 'start'