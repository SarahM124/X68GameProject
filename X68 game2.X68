*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:

CR EQU $0D
LF EQU $0A

    MOVE.B #100, $3000 ; Amount of carbon in air 
    TRAP #15
    
    MOVE.B #0, $3010 ; tree location 
    TRAP #15

    MOVE.B #0, $3020
    TRAP #15

    MOVE.B #0, $3030
    TRAP #15     
    

    
HURRICANE EQU 10
SANDSTORM EQU 20
FLOODS EQU 15 



GAME_SETUP:
    
    BSR WELCOME 
    BSR USER
    BSR INTRODUCTION
    
  
    

WELCOME:
    LEA WELCOME_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    
    MOVE.B #7, D0 
    TRAP #15
    RTS

  



USER:
    MOVE.B #2, D0 
    LEA $4000, A1 ; username is located at memory address 4000
    TRAP  #15
    
    LEA MESSAGE, A1 ; welcomes user
    MOVE.B #14, D0
    TRAP #15
    
    LEA $4000, A1
    MOVE.B #14, D0
    TRAP #15
    RTS
    
    
 
    
INTRODUCTION:
    LEA INTRO_MSG, A1 ; explains purpose of game
    MOVE.B #14, D0
    TRAP #15
    BSR INPUT
    
    
               

INPUT: 
    LEA INPUT_MSG, A1 
    MOVE.B #14, D0
    TRAP #15
    
    MOVE #4, D0
    TRAP #15
    
    CMP #1, D1
    BLT INPUT ; If number in d1 is less than 1, return to input choices
    CMP #4, D1 
    BGT INPUT ; If number in d1 is greater than 3, return to input choices
    BRA MENU_OPTIONS ; if number is 1, 2, or 3, branch to menu options 
    

MENU_OPTIONS: 
    
    CMP #1, D1
    BEQ SHOP 
    CMP #2, D1
    BEQ PLACE_ITEMS 
    CMP #3, D1
    BEQ CHECK_WORLD_STATUS
    CMP #4, D1 
    BEQ INVENTORY
    
    BRA INPUT

SHOP:
    LEA SHOP_CHOICE, A1
    MOVE.B #14, D0
    TRAP #15
    
     MOVE #4, D0
    TRAP #15
    
    CMP #1, D1
    BEQ TREES
    CMP #2, D1
    BEQ SOLAR_PANELS
    CMP #3, D1
    BEQ WINDMILLS
    CMP #4, D1
    BEQ MENU_OPTIONS
    BRA SHOP
    

PLACE_ITEMS:

CHECK_WORLD_STATUS:

TREES:
    LEA TREE_MSG, A1
    MOVE.B #14, D0 
   TRAP #15
    
    MOVE.B #4, D0 
     TRAP #15
     
    LEA $3010, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
    BSR SHOP 
      

  
    
    
    
    
    
    

SOLAR_PANELS:
  LEA SOLAR_MSG, A1
    MOVE.B #14, D0 
   TRAP #15
    
    MOVE.B #4, D0 
     TRAP #15
    
    LEA $3020, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
    BSR SHOP

WINDMILLS:
    LEA WINDMILL_MSG, A1
    MOVE.B #14, D0 
    TRAP #15
    
    MOVE.B #4, D0 
     TRAP #15
     
    LEA $3030, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
    BSR SHOP
    
INVENTORY: 

       LEA INVENTORY_MSG, A1
       MOVE.B #14, D0
       TRAP #15 
       
       LEA $3010, A1
       MOVE.B (A1), D1
       MOVE.B #0, D0
       TRAP #15
       BSR MENU_OPTIONS
    



    SIMHALT             ; halt simulator
CRLF: DC.B $0D, $0A,0
WELCOME_MSG DC.B 'Hi, please enter your name! ', 0
   DC.B $0D, $0A,0
MESSAGE DC.B 'Welcome ', 0
     DC.B $0D, $0A
INTRO_MSG DC.B '*game explanation* '
   DC.B $0D, $0A,0
INPUT_MSG DC.B '(1) SHOP (2) PLACE ITEMS (3) CHECK WORLD STATUS (4) INVENTORY',0
SHOP_CHOICE DC.B ' CHOOSE WHAT TO BUY (1) TREES (2) SOLAR PANELS (3) WINDMILLS  (4) EXIT SHOP',0
TREE_MSG DC.B 'How many trees do you want to buy?',0
SOLAR_MSG DC.B 'How many solar panels do you want to buy?',0
WINDMILL_MSG DC.B 'How many windmills do you want to buy?',0
INVENTORY_MSG DC.B 'Trees:',0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
