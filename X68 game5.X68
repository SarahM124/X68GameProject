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
    
    MOVE.B #50, $2000  ; World health 
    TRAP #15
    
    MOVE.B #0, $3010 ; tree location 
    TRAP #15

    MOVE.B #0, $3020 
    TRAP #15

    MOVE.B #0, $3030
    TRAP #15  

    MOVE.B  #20, $3060 ; MONEY
    TRAP #15    
    
; Tree raises world health by 5
; solar panel raises world health by 10
; windmill raises world health by 20

; tree lowers carbon level by 5
; solar panel lowers carbon level by 10
; windmill lowers carbon level by 10
TREE_PRICE EQU 5
SOLARPANEL_PRICE EQU 100
WINDMILL_PRICE EQU 150
HURRICANE EQU 10
SANDSTORM EQU 20
FLOODS EQU 15 



GAME_SETUP:
    BSR BEGINING
     BSR CLEAR_SCREEN 
    BSR WELCOME
    BSR CLEAR_SCREEN 
    BSR INPUT
    
    
    
  
    
BEGINING:

       LEA TITLE, A1
       MOVE.B #14, D0
       TRAP #15
       
     LEA BEGINING_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    
      LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
    
    LEA PRESS_KEY, A1
    MOVE.B #14, D0
    TRAP #15
    
    MOVE.B #4, D0
    TRAP #15
    
    ;BSR CLEAR_SCREEN 
    RTS
    
WELCOME:
    LEA INTRO_MSG, A1 ; explains purpose of game
    MOVE.B #14, D0
    TRAP #15
     
       LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15

    LEA ENTERNAME_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    
      MOVE.B #2, D0 
    LEA $4000, A1 ; username is located at memory address 4000
    TRAP  #15
    
    LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
    
     LEA MESSAGE, A1 ; welcomes user
    MOVE.B #14, D0
    TRAP #15
    
    LEA $4000, A1
    MOVE.B #14, D0
    TRAP #15
    
    LEA NPC_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    
     LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
    
    
    
    LEA QUESTIONS_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    
    
    
    
    
    LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
    
     
    
    BSR QUESTIONS
    
    
QUESTIONS:
        

     LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
    
    LEA QUESTIONS2_MSG, A1
    MOVE.B #14, D0
    TRAP #15
        

        MOVE.B #4, D0 
        TRAP #15
        
        CMP #1, D1
    BEQ CCTF
    CMP #2, D1
    BEQ SAVE_PLANET
    CMP #5, D1
    BEQ NO_QUESTIONS


        

  
CCTF:
        LEA CCTF_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        BSR QUESTIONS 

SAVE_PLANET: 
         LEA SAVEPLANET_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        BSR QUESTIONS
        
NO_QUESTIONS:
         BSR CLEAR_SCREEN 

        LEA NOQUESTIONS_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        BSR INPUT
        
        
        


USER:
    ;MOVE.B #2, D0 
   ; LEA $4000, A1 ; username is located at memory address 4000
   ; TRAP  #15
    
   
    
      LEA CRLF, A1
      MOVE.B #14, D0
     TRAP #15
    RTS
    
    
 
    

    
    
               

INPUT: 

    LEA INPUT_MSG, A1 
    MOVE.B #14, D0
    TRAP #15
    
    MOVE #4, D0
    TRAP #15
    
    CMP #1, D1
    BLT INPUT ; If number in d1 is less than 1, return to input choices
    CMP #5, D1 
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
    CMP #5, D1
    BEQ GAME_INFO
    
    BRA INPUT
    
GAME_INFO:
        LEA GAMEINFO_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        BSR INPUT

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
    BEQ INPUT
   
    BRA SHOP
    
    

PLACE_ITEMS:

        LEA CHOOSEITEM, A1
         MOVE.B #14, D0 
         TRAP #15
     
         
           MOVE.B #4, D0
        TRAP #15
         
         CMP #1, D1
         BEQ PLACE_TREES
    CMP #2, D1
    BEQ PLACE_SOLARPANELS
    CMP #3, D1
    BEQ PLACE_WINDMILLS
    CMP #4, D1
    BEQ INPUT
         
         
         
PLACE_TREES:
        
        LEA PLACETREES_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        
        MOVE.B #4, D0
        TRAP #15
        
         MULU #5, D1
        MOVE.B D1, D4
        
         LEA $3000, A1
         MOVE.B (A1), D3
         SUB D4, D3
         MOVE.B D3, (A1)
         
        
        
          LEA $2000, A1
         MOVE.B (A1), D3
         ADD D4, D3
         MOVE.B D3, (A1)
         BSR PLACE_ITEMS
        
PLACE_SOLARPANELS:

        LEA PLACEPANELS_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        
        MOVE.B #4, D0
        TRAP #15
        
         MULU #10, D1
        MOVE.B D1, D4
        
         LEA $3000, A1
         MOVE.B (A1), D3
         SUB D4, D3
         MOVE.B D3, (A1)
         
        
        
          LEA $2000, A1
         MOVE.B (A1), D3
         ADD D4, D3
         MOVE.B D3, (A1)
         BSR PLACE_ITEMS

PLACE_WINDMILLS:

        LEA PLACEWINDMILLS_MSG, A1
        MOVE.B #14, D0
        TRAP #15
        
        MOVE.B #4, D0
        TRAP #15
        
         MULU #15, D1
        MOVE.B D1, D4
        
         LEA $3000, A1
         MOVE.B (A1), D3
         SUB D4, D3
         MOVE.B D3, (A1)
         
        
        
          LEA $2000, A1
         MOVE.B (A1), D3
         ADD D4, D3
         MOVE.B D3, (A1)
         BSR PLACE_ITEMS
    
        
        
        
         ;MOVE.B #100, $3000 ; Amount of carbon in air 
        ; TRAP #15
    
         ;MOVE.B #50, $2000  ; World health 
            ; TRAP #15
        
        
        

CHECK_WORLD_STATUS:

    LEA WORLD_HEALTH, A1
    MOVE.B #14, D0
    TRAP #15
    
     LEA $2000, A1
       MOVE.B (A1), D1
       MOVE.B #3, D0
       TRAP #15
       
        LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15

    LEA CARBON_LEVEL, A1
    MOVE.B #14, D0
    TRAP #15
    
    LEA $3000, A1
    MOVE.B (A1), D1
    MOVE.B #3, D0
    TRAP #15
    
    
    

        LEA $2000, A1
    MOVE.B (A1), D1
    CMP #50, D1
    BEQ STATUS1
    CMP #40, D1
    BEQ STATUS2
    
    
    
    
STATUS1:

             LEA CRLF, A1
             MOVE.B #14, D0
             TRAP #15

            LEA STATUS1_MSG, A1
              MOVE.B #14, D0
              TRAP #15
             BSR INPUT
             
             
              
              
STATUS2: 
            LEA STATUS2_MSG, A1
            MOVE.B #14, D0
            TRAP #15
            RTS
 
STATUS3: 
            LEA STATUS3_MSG, A1
            MOVE.B #14, D0
            TRAP #15 
            RTS        

TREES:

    
    
    LEA TREE_MSG, A1
    MOVE.B #14, D0  
   TRAP #15
   
   
    
    MOVE.B #4, D0 
     TRAP #15
     
     
     
   
    
    LEA $3060, A1
    MOVE.B (A1), D3
    CMP #0, D3
    BNE TREEPURCHASE
    BEQ CANT_PURCHASE 
    

    
    
    
TREEPURCHASE:

  LEA $3010, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
    
    
    
    MULU #5, D1
    MOVE.B D1, D4
 
    
    LEA $3060, A1
    MOVE.B (A1), D3
    SUB D4, D3
    MOVE.B D3, (A1)
    
    BSR SHOP

    
CANT_PURCHASE:
      LEA CANTPURCHASE_MSG, A1
      MOVE.B #14, D0
      TRAP #15
       
      LEA CRLF, A1
      MOVE.B #14, D0
      TRAP #15

       BSR SHOP
       
      

  
    
    
    
    
    
    

SOLAR_PANELS:
  LEA SOLAR_MSG, A1
    MOVE.B #14, D0 
   TRAP #15
    
    MOVE.B #4, D0 
     TRAP #15
     
      LEA $3060, A1
    MOVE.B (A1), D3
    CMP #0, D3
    BNE SOLARPANEL_PURCHASE
    BEQ CANT_PURCHASE
    
   
    
    
SOLARPANEL_PURCHASE: 
        
        LEA $3020, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
    
     MULU #10, D1
    MOVE.B D1, D4
 
    
    LEA $3060, A1
    MOVE.B (A1), D3
    SUB D4, D3
    MOVE.B D3, (A1)
    
    BSR SHOP


    

WINDMILLS:
    LEA WINDMILL_MSG, A1
    MOVE.B #14, D0 
    TRAP #15
    
    MOVE.B #4, D0 
     TRAP #15
     
      LEA $3060, A1
    MOVE.B (A1), D3
    CMP #0, D3
    BNE WINDMILL_PURCHASE
    BEQ CANT_PURCHASE
     
  
    
    
WINDMILL_PURCHASE:
     LEA $3030, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
    
     MULU #15, D1
    MOVE.B D1, D4
 
    
    LEA $3060, A1
    MOVE.B (A1), D3
    SUB D4, D3
    MOVE.B D3, (A1)
    
    BSR SHOP

COLLISION: 
          LEA $2000, A1
          MOVE.B (A1), D1
         CMP #70, D1 
         BEQ STATUS2 
         
         
         LEA $2000, A1
         MOVE.B (A1), D1
         CMP #40, D1
         BEQ STATUS3
 
       
        
    
INVENTORY: 

       LEA TREEINVENTORY_MSG, A1
       MOVE.B #14, D0
       TRAP #15 
       
       LEA $3010, A1
       MOVE.B (A1), D1
       MOVE.B #3, D0
       TRAP #15
       
       LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
       
        LEA SOLARINVENTORY_MSG, A1
       MOVE.B #14, D0
       TRAP #15
       
        LEA $3020, A1
       MOVE.B (A1), D1
       MOVE.B #3, D0
       TRAP #15
       
       LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
       
        LEA WINDMILLINVENTORY_MSG, A1
       MOVE.B #14, D0
       TRAP #15
       
        LEA $3030, A1
       MOVE.B (A1), D1
       MOVE.B #3, D0
       TRAP #15
       
        LEA CRLF, A1
       MOVE.B #14, D0
       TRAP #15
    
    LEA MONEYINVENTORY_MSG, A1
       MOVE.B #14, D0
       TRAP #15
       
        LEA $3060, A1
       MOVE.B (A1), D1
       MOVE.B #3, D0
       TRAP #15
       
        LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15


       
       BSR INPUT
       
CLEAR_SCREEN:
    MOVE.B #11, D0
    MOVE.W #$FF00, D1
    TRAP #15
    RTS
       

    



    SIMHALT             ; halt simulator

TITLE DC.B '               ***************************************************'
             DC.B $0D, $0A
             DC.B '                            SAVING PLANET EARTH'
              DC.B $0D, $0A
              DC.B '               ***************************************************'
               DC.B $0D, $0A, 0
BEGINING_MSG DC.B $0D, $0A
        DC.B 'The year is 2099, planet Earth has been changed forever by climate change'
        DC.B $0D, $0A
        DC.B 'You, an expert environmental scientist have been hired by the U.N'
         DC.B $0D, $0A
         DC.B 'Your mission is to reduce the amount of carbon in the air'
          DC.B $0D, $0A
         DC.B 'and to bring earth back to normal'
           DC.B $0D, $0A, 0
           
        
ENTERNAME_MSG DC.B 'Enter your name! ', 0
   DC.B $0D, $0A,0
MESSAGE DC.B 'Welcome ', 0
NPC_MSG        DC.B ', my name is John and Im the senior lead of' 
                 DC.B $0D, $0A
                DC.B 'Climate Change Task Force....or C.C.T.F if you prefer acronyms'
                    DC.B $0D, $0A
                DC.B 'Your mission is to reduce the amount of carbon levels in the air' 
                 DC.B $0D, $0A
                 DC.B 'and bring planet Earths health back to a more stable level'
                 DC.B $0D, $0A,0
                
              
QUESTIONS_MSG DC.B 'Do you have any questions for me?'
                 DC.B $0D, $0A
                  
                DC.B  '1) What is C.C.T.F?'
                  DC.B $0D, $0A
                  DC.B '2) What if I dont want to save planet earth?'
                  DC.B $0D, $0A
                 DC.B '3) Am I being paid?'
                 DC.B $0D, $0A
                 DC.B '4) Explain how I save the planet'
                  DC.B $0D, $0A
                  DC.B '5) Nope, no questions!', 0
                  DC.B $0D, $0A
              
                 
                
     

INTRO_MSG      DC.B $0D, $0A
            DC.B 'Guy: Hello, before we begin lets start with your name * ', 0

INPUT_MSG DC.B $0D, $0A 
           DC.B '(1) SHOP' 
          DC.B $0D, $0A 
          DC.B  '(2) PLACE ITEMS' 
          DC.B $0D, $0A
          DC.B '(3) CHECK WORLD STATUS'
          DC.B $0D, $0A
          DC.B '(4) INVENTORY'
            DC.B $0D, $0A
          DC.B '(5) GAME INFO'    
          DC.B $0D, $0A,0
SHOP_CHOICE DC.B 'Shop Merchant: "Oh? a customer...what do you want to buy?"' 
   DC.B $0D, $0A
     DC.B '(1) TREES'
     DC.B $0D, $0A
     DC.B  '(2) SOLAR PANELS'
     DC.B $0D, $0A
     DC.B  '(3) WINDMILLS'
     DC.B $0D, $0A
     DC.B  '(4) EXIT SHOP'
  DC.B $0D, $0A,0
TREE_MSG DC.B 'How many trees do you want to buy?',0
SOLAR_MSG DC.B 'How many solar panels do you want to buy?',0
WINDMILL_MSG DC.B 'How many windmills do you want to buy?',0
TREEINVENTORY_MSG DC.B 'Trees:',0
SOLARINVENTORY_MSG DC.B 'Solar panels:',0
WINDMILLINVENTORY_MSG DC.B 'Windmills:',0
MONEYINVENTORY_MSG DC.B 'Money:',0

CANTPURCHASE_MSG DC.B 'You dont have enough money to buy this item', 0
PRESS_KEY DC.B 'Press Enter to continue', 0
CCTF_MSG DC.B 'EXPLAIN cctf',0
SAVEPLANET_MSG DC.B 'explain planet',0
QUESTIONS2_MSG DC.B '...So any questions?'
                DC.B $0D, $0A, 0
   DC.B $0D, $0A
NOQUESTIONS_MSG DC.B $0D, $0A
        DC.B 'John: Well if you have no questions lets get started!'
         DC.B $0D, $0A
         DC.B 'The U.N has granted you $1000 to combat climate change'
          DC.B $0D, $0A
          DC.B 'Use that money wisely!'
           DC.B $0D, $0A
          DC.B 'Also dont forget to check the worlds status as natural disasters' 
           DC.B $0D, $0A
           DC.B 'can occur at any moment and kill the planet instantly....Goodluck!'
            DC.B $0D, $0A, 0

   DC.B $0D, $0A, 0
   
   
STATUS1_MSG DC.B  'Planet Earths health is stable', 0
STATUS2_MSG DC.B 'Australia has been hit by a fire tornado' 
                  DC.B $0D, $0A
                  DC.B 'Earth has lost health', 0
STATUS3_MSG DC.B 'India is experiencing heavy floods', 0
                  
CARBON_LEVEL DC.B 'CURRENT CARBON LEVEL IN AIR: ', 0
WORLD_HEALTH DC.B ' CURRENT EARTH HEALTH LEVEL: ', 0
CHOOSEITEM DC.B 'Choose what item to place in the world'
                 DC.B $0D, $0A
                 DC.B '(1) Trees'
                  DC.B $0D, $0A
                  DC.B '(2) Solar Panels' 
                   DC.B $0D, $0A
                   DC.B '(3) Windmills'
                    DC.B $0D, $0A
                    DC.B '(4) Exit'
                     DC.B $0D, $0A, 0
PLACETREES_MSG DC.B 'How many trees to place?', 0
PLACEPANELS_MSG DC.B 'How many solar panels to place?', 0
PLACEWINDMILLS_MSG DC.B 'How many windmills to place', 0
GAMEINFO_MSG DC.B 'How each item effects the planets health and carbon levels'
                  DC.B $0D, $0A
                   DC.B $0D, $0A
                  DC.B 'TREES'
                  DC.B $0D, $0A
                  DC.B ' Raises Earths health by 5'
                  DC.B $0D, $0A
                  DC.B 'Decreases Earths carbon level by 5'
                  DC.B $0D, $0A
                   DC.B $0D, $0A
                  DC.B 'SOLAR PANELS' 
                  DC.B $0D, $0A
                  DC.B 'Raises Earths health by 10'
                  DC.B $0D, $0A
                  DC.B 'Decreases Earths carbon levels by 10'
                  DC.B $0D, $0A
                   DC.B $0D, $0A
                  DC.B 'WINDMILLS' 
                  DC.B $0D, $0A
                  DC.B 'Rasies Earths health by 15'
                  DC.B $0D, $0A
                  DC.B 'Decreases Earths carbon levels by 15'
                  DC.B $0D, $0A, 0
CRLF: DC.B $0D, $0A,0

        

            


    

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
