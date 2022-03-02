*-----------------------------------------------------------
*---------------------X68 GAME------------------------------

    ORG    $1000
START:                

*-----------------------------------------------------------
*--------------------GAME SETUP ----------------------------



    MOVE.B #0, $3000 ; player points
    LEA $3000, A3 ; Assign player points to memory location A3
    MOVE.B #5, $3020 ; Menu options 
    BSR INTRO    ; 
         
  
    


*-------------------------------------------------------------- 
*--------------------- INTRO -------------------------------

INTRO: 
        LEA INTRO_MSG, A1 ; Player introduction
 
        MOVE.B #14, D0
        TRAP #15
        BSR MISSION
       
        
 *-------------------------------------------------------------- 
*--------------------- SHOP -------------------------------

                BSR WINDMILLS
                BSR TREES 
                BSR SOLARPANELS
                BSR ELECTRIC_CARS 
                
                RTS 
        
                        
    


*---------------------------------------------------------------------------
*------------------MISSION OBJECTIVE ---------------------------
MISSION 
    LEA MISSION_OBJ, A1
        MOVE.B #14, D0
        TRAP #15



    SIMHALT
CRLF: DC.B $0, $0A, 0
INTRO_MSG DC.B 'Intro dialogue'
    DC.B $0D, $0A, 0
    DC.B $0D, $0A, 0
MISSION_OBJ DC.B 'Idk mission objective something with climate change '
       DC.B $0D, $0A, 0          
            



    END    START       


*~Font name~Courier New~
*~Font size~14~
*~Tab type~1~
*~Tab size~4~
