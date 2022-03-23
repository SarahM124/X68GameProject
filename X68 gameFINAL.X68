*-----------------------------------------------------------
* Title      : SAVE PLANET EARTH
* Written by : Sarah Martin 
* Date       : 23/03/2022
* Description: A game that allows the user to increase planet Earths health and decreases Carbon levels 
 * Known bugs: issue with money increasing when players money hits below zero
*-----------------------------------------------------------
    ORG    $1000
START:


    ; name of player is located in $4000
    
    MOVE.B #100, $3000 ; Amount of carbon in air 
    TRAP #15
    
    MOVE.B #50, $2000  ; World health 
    TRAP #15
    
    MOVE.B #0, $3010 ; tree location 
    TRAP #15

    MOVE.B #0, $3020  ; Solar panel location
    TRAP #15

    MOVE.B #0, $3030 ; Windmill location 
    TRAP #15  

    MOVE.L #1000, $3060 ; MONEY
    TRAP #15   

    MOVE.B #0, $4010 ; Trees in world
    TRAP #15
    
    MOVE.B #0, $4020 ; solar panels in world
    TRAP #15 
    
    MOVE.B #0, $4030 ; windmills in world 
    TRAP #15 
    
; Tree raises world health by 5
; solar panel raises world health by 10
; windmill raises world health by 20

; tree lowers carbon level by 5
; solar panel lowers carbon level by 10
; windmill lowers carbon level by 10
TREE_PRICE EQU 25
SOLARPANEL_PRICE EQU 100
WINDMILL_PRICE EQU 150
TORNADOES EQU 10
FLOODS EQU 10



GAME_SETUP:       ; begining of the game 
    BSR BEGINING
    BSR ENDGAME 
    BSR CLEAR_SCREEN 
    BSR WELCOME
    BSR QUESTIONS
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
    

    RTS
    
WELCOME:      ; introduces player to game
    LEA INTRO_MSG, A1 
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
    
     LEA MESSAGE, A1 
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
    RTS
    
     
    
   ; BSR QUESTIONS
    
    
QUESTIONS:  ; user can ask npc questions about the game 
        

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
    CMP #3, D1
    BEQ PAID
    CMP #4, D1
    BEQ HOW_TO_PLAY
    CMP #5, D1
    BEQ NO_QUESTIONS


******QUESTIONS******  

HOW_TO_PLAY: 

           LEA HOW_TO_PLAY_MSG, A1
         MOVE.B #14, D0
         TRAP #15
         BSR QUESTIONS        
PAID:

         LEA PAID_MSG, A1
         MOVE.B #14, D0
         TRAP #15
         BSR QUESTIONS 
  
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
        
        
                        
    
               

INPUT: ; User menu 

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
    

MENU_OPTIONS: ; menu for shop, place items, check world status, inventory, game info 
    
     
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
    
    

PLACE_ITEMS: ; subroutine that allows user to place items in world 

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
    BEQ ITEMS
    CMP #5, D1
    BEQ INPUT 
    BSR CHECK_WORLD_STATUS
         
ITEMS:   ; number of items that are currently in the world 
             LEA CRLF, A1
            MOVE.B #14, D0
             TRAP #15
             
            LEA NO_OF_ITEMS, A1
            MOVE.B #14, D0
            TRAP #15
            
             LEA CRLF, A1
             MOVE.B #14, D0
            TRAP #15

             
            LEA NO_OF_TREES, A1
            MOVE.B #14, D0
            TRAP #15 
            
             LEA $4010, A1
             MOVE.B (A1), D1
             MOVE.B #3, D0
             TRAP #15
             
               LEA CRLF, A1
             MOVE.B #14, D0
             TRAP #15
             
             LEA NO_OF_SOLARPANELS, A1
             MOVE.B #14, D0
             TRAP #15
             
             LEA $4020, A1
             MOVE.B (A1), D1
             MOVE.B #3, D0
             TRAP #15
             
               LEA CRLF, A1
               MOVE.B #14, D0
                TRAP #15
             
              LEA NO_OF_WINDMILLS, A1
             MOVE.B #14, D0
             TRAP #15
             
             LEA $4030, A1
             MOVE.B (A1), D1
             MOVE.B #3, D0
             TRAP #15
             
               LEA CRLF, A1
             MOVE.B #14, D0
             TRAP #15
             BSR INPUT



COLLISION: ; collision occurs when user places items in world 
          LEA $2000, A1
          MOVE.B (A1), D1
          BSR RANDOM_NUMBER
         CMP #25, D2
         BLT COLLISION1 
         CMP #50, D1
         BLT COLLISION2
         CMP #75, D1
         BLT COLLISION3
         CMP #100, D1
         BGT INPUT 
         BSR INPUT
         
         
         
 
 
COLLISION1: 


                LEA COLLISION1_MSG, A1 
                MOVE.B #14, D0
                TRAP #15
                
                LEA LOST_HEALTH, A1
                MOVE.B #14, D0
                TRAP #15 
                
                 LEA $2000, A1
                 MOVE.B (A1), D2
                 SUB #10, D2
                 MOVE.B D2, (A1)
                 BSR INPUT
                
COLLISION2: 

             LEA COLLISION2_MSG, A1 
                MOVE.B #14, D0
                TRAP #15
                
                LEA GAINED_CARBON, A1
                MOVE.B #14, D0
                TRAP #15 
                
                 LEA $3000, A1
                 MOVE.B (A1), D2
                 ADD #10, D2
                 MOVE.B D2, (A1)
                 BSR INPUT
                                
COLLISION3: 

                 LEA COLLISION3_MSG, A1 
                MOVE.B #14, D0
                TRAP #15
                
                LEA LOST_HEALTH, A1
                MOVE.B #14, D0
                TRAP #15 
                
                 LEA $2000, A1
                 MOVE.B (A1), D2
                 SUB #10, D2
                 MOVE.B D2, (A1)
                 BSR INPUT

                                      
COLLISION4: 

             LEA COLLISION2_MSG, A1 
                MOVE.B #14, D0
                TRAP #15
                
                LEA GAINED_CARBON, A1
                MOVE.B #14, D0
                TRAP #15 
                
                 LEA $3000, A1
                 MOVE.B (A1), D2
                 ADD #10, D2
                 MOVE.B D2, (A1)
                 BSR INPUT
                           

            
                 
         
PLACE_TREES:
        
    LEA PLACETREES_MSG, A1
    MOVE.B #14, D0
    TRAP #15
        
    MOVE.B #4, D0
    TRAP #15
    
    LEA $4010, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
        
    MULU #5, D1    ; The amount of carbon reduced by 5 
    MOVE.B D1, D4
        
    LEA $3000, A1
    MOVE.B (A1), D3
    SUB D4, D3
    MOVE.B D3, (A1)
         
        
        
    LEA $2000, A1   
    MOVE.B (A1), D3
    ADD D4, D3   ; increases health 
    MOVE.B D3, (A1)
   
    
    
    BSR COLLISION
        
PLACE_SOLARPANELS:

    LEA PLACEPANELS_MSG, A1
    MOVE.B #14, D0
    TRAP #15
        
    MOVE.B #4, D0
    TRAP #15
    
     LEA $4020, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
        
    MULU #10, D1 ; Reduces the amount of carbon by 10 and multiplied by number in D1
    MOVE.B D1, D4
        
    LEA $3000, A1
    MOVE.B (A1), D3
    SUB D4, D3
    MOVE.B D3, (A1)
         
        
        
    LEA $2000, A1
    MOVE.B (A1), D3
    ADD D4, D3   ; Increases planets health adding 
    MOVE.B D3, (A1)
    BSR PLACE_ITEMS
            
PLACE_WINDMILLS:

    LEA PLACEWINDMILLS_MSG, A1
    MOVE.B #14, D0
    TRAP #15
        
    MOVE.B #4, D0
    TRAP #15
    
     LEA $4030, A1
    MOVE.B (A1), D2
    ADD D1, D2
    MOVE.B D2, (A1)
        
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
         CMP #40, D1
         BLT STATUS3
         CMP #80, D1
         BLT STATUS2
         CMP #99, D1
         BLT STATUS1
         CMP #100, D1
         BEQ PLANET_HEALTH

    
    
    
    
    
    
    
STATUS1:

    LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15

    LEA STATUS1_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    BSR INPUT
             
             
              
              
STATUS2: 

     LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
    
    LEA STATUS2_MSG, A1
    MOVE.B #14, D0
    TRAP #15
    BSR INPUT
 
STATUS3: 

     LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
   
    LEA STATUS3_MSG, A1
    MOVE.B #14, D0
    TRAP #15 
    BSR INPUT

ENDGAME:

    LEA $2000, A1
    MOVE.B (A1), D1
    CMP #100, D1
    BEQ PLANET_HEALTH
    
    LEA $3000, A1
    MOVE.B (A1), D1
    CMP #0, D1
    BEQ PLANET_CARBON 
    RTS
    
    
PLANET_HEALTH:

        LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15

        LEA HEALTH_MSG, A1
        MOVE.B #14, D0
        TRAP #15 
        RTS
        
PLANET_CARBON:

            LEA CRLF, A1
    MOVE.B #14, D0
    TRAP #15
            
        LEA CARBON_MSG, A1
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
    MOVE.L (A1), D3
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
    MOVE.L (A1), D3
    SUB D4, D3
    MOVE.L D3, (A1)
    
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
    MOVE.L (A1), D3
    SUB D4, D3
    MOVE.L D3, (A1)
    
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
    MOVE.L (A1), D3
    SUB D4, D3
    MOVE.L D3, (A1)
    
    BSR SHOP
    
RANDOM_NUMBER:     
    MOVE.B #8, D0 
    TRAP #15  
   

    AND.L #$5FFFFF, D1 

    DIVU #100, D1 

    SWAP D1 

    ADDQ.W #1, D1 

    MOVE.W D1, D2 

    CLR.L D1 

    MOVE.W D2, D1 
    RTS

       
                


                  
        
    
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
       MOVE.L (A1), D1
       MOVE.L #3, D0
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
        DC.B 'You, an expert environmental scientist have been hired by the U.N to tackle the problem at hand '
         DC.B $0D, $0A
         DC.B 'Your mission is to reduce the amount of carbon in the air and to bring Earths health back to a stable level'
          DC.B $0D, $0A
         DC.B ''
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
            DC.B 'Hello, before we begin lets start with your name ', 0

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
     DC.B '(1) TREES:'
     DC.B $0D, $0A
     DC.B  '(2) SOLAR PANELS:'
     DC.B $0D, $0A
     DC.B  '(3) WINDMILLS:'
     DC.B $0D, $0A
     DC.B  '(4) EXIT SHOP'
  DC.B $0D, $0A,0
TREE_MSG DC.B 'How many trees do you want to buy?'
   DC.B $0D, $0A
   DC.B '$25 per tree', 0
SOLAR_MSG DC.B 'How many solar panels do you want to buy?'
     DC.B $0D, $0A
     DC.B '$100 per solar panel', 0
WINDMILL_MSG DC.B 'How many windmills do you want to buy?'
         DC.B $0D, $0A
         DC.B '$50 per windmill', 0
TREEINVENTORY_MSG DC.B 'Trees:',0
SOLARINVENTORY_MSG DC.B 'Solar panels:',0
WINDMILLINVENTORY_MSG DC.B 'Windmills:',0
MONEYINVENTORY_MSG DC.B 'Money:',0

CANTPURCHASE_MSG DC.B 'You dont have enough money to buy this item', 0
PRESS_KEY DC.B 'Press Enter to continue', 0
CCTF_MSG DC.B 'C.C.T.F is a group that was created in 2090 by the U.N to tackle the climate change problem '
                DC.B $0D, $0A
                DC.B ' Our division is made up of different subgroups of scientists.'
                  DC.B $0D, $0A
                DC.B 'As you can see we have not been as successful with our mission as we should be' 
                DC.B $0D, $0A
                DC.B 'Which is why you were brought on board the mission', 0
                DC.B $0D, $0A
SAVEPLANET_MSG DC.B 'Well since you are an expert in your field of science '
                DC.B $0D, $0A
                DC.B ', we would like to think its in your best interest '
                DC.B $0D, $0A
                DC.B 'to help save the planet' 
                DC.B $0D, $0A, 0
PAID_MSG DC.B 'Yes youre being paid but that money is to be used to save the world', 0
HOW_TO_PLAY_MSG DC.B 'Purchase items from the shop and place them in the world'
                     DC.B $0D, $0A
                     DC.B ', those items will increase health and decrease carbon levels'
                      DC.B $0D, $0A
                      DC.B ', just make sure you keep an eye on natural disasters'
                       DC.B $0D, $0A, 0

             
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
   
   
STATUS1_MSG DC.B  'Planet Earths health is stable but can be improved!'
                     DC.B $0D, $0A
                     DC.B 'Increase Earths health!' 
                      DC.B $0D, $0A, 0
STATUS2_MSG DC.B 'Health is low! ' 
                  DC.B $0D, $0A
                  DC.B 'Place more items in world', 0

STATUS3_MSG DC.B 'Earths healthy is dangerously low!'
                     DC.B $0D, $0A
                     DC.B 'Increase Earths health to prevent disaster'
                      DC.B $0D, $0A, 0
                  
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
                    DC.B '(4) Check number of items in world'
                     DC.B $0D, $0A
                     DC.B '(5) Exit'
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
COLLISION1_MSG DC.B 'AUSTRALIA HAS BEEN HIT BY A TORNADO '
                DC.B $0D, $0A
                DC.B 'EARTH HAS LOST HEALTH'
                  DC.B $0D, $0A, 0
COLLISION2_MSG DC.B 'A FOREST HAS BEEN DESTROYED IN BRAZIL '
                  DC.B $0D, $0A
                  DC.B 'CARBON HAS INCREASED'
                  DC.B $0D, $0A, 0
COLLISION3_MSG DC.B 'GERMANY IS EXPERIENCING MASS FLOODS'
                  DC.B $0D, $0A
                  DC.B 'EARTH HAS LOST HEALTH' 
                    DC.B $0D, $0A, 0
COLLISION4_MSG DC.B 'A NEW COAL PLANT HAS OPENED UP IN CROATIA'
                    DC.B $0D, $0A
                   DC.B 'CARBON HAS INCREASED'
                   DC.B $0D, $0A, 0

LOST_HEALTH DC.B 'Earth has lost health ' , 0
GAINED_CARBON DC.B 'Earth has gained carbon', 0
NO_OF_ITEMS DC.B 'NUMBER OF ITEMS PLACED IN THE WORLD', 0 
NO_OF_TREES DC.B 'TREES :', 0
NO_OF_SOLARPANELS DC.B 'SOLAR PANELS: ', 0
NO_OF_WINDMILLS DC.B 'WINDMILLS: ', 0
HEALTH_MSG DC.B 'Congratulations you have successfully increased Earths health to a healthy level', 0
CARBON_MSG DC.B 'Congratulations you have successfully decreased Earths carbon to zero', 0

        

            


    

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
