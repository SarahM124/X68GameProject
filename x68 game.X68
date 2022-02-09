*-----------------------------------------------------------
*---------------------X68 GAME------------------------------

    ORG    $1000
START:                

*-----------------------------------------------------------
*--------------------GAME SETUP ----------------------------



    MOVE.L #0, $3000 ; player points
    lEA $3000, A3 ; Assign player points to memory location A3
    MOVE.L #5, $3020 ; Menu options 
    BSR INTRO    ;
    BSR GAME_OPTIONS
    


*-----------------------------------------------------------
*--------------------- INTRO -------------------------------

INTRO: 
        LEA INTRO_MSG, A1
        MOVE.B #14, D0
        TRAP #15
    


*-----------------------------------------------------------
*-------------------GAME OPTIONS ---------------------------
GAME_OPTIONS 

    SIMHALT 
INTRO_MSG DC.B 'Intro dialogue', 0
            
            



    END    START       

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
