/**************************************************************************************************************************
                             TETRIS on Processing Version 8 - MAIN (1/5)
     
   Copyright (C) 2018  JuanGg  -  https://juangg-projects.blogspot.com/

   This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
   To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ 
    
   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
   
****************************************************************************************************************************/


////////////////////////VARIABLE DEFINITION//////////////////
//Grid parameters-------------------------------------------
//Setable

int gridWidth = 12;
color gridBackground = #000000;
color gridLinesColor = #B2B9B2;

//Window size dependant:
int squareSize;
int gridHeight;
int gridWidthLen;
int gridHeightLen ;
int gridXPos;
int gridYPos;

//mainGrid 2d array
color[][] mainGrid; 

//Colors------------------------------------------------
color themeColor;
color[] themeColors = {#FF050E, #1BB205, #0539FF, #EEFF05, #FF05E7};


//Game variables---------------------------------------------
int gameState = 0;
int level = 0;
int record = 0;
int points = 0;
int livesLeft = 3;
boolean gameRunning = true;

//Game variables---------------------------------------------
Piece nextPiece; 
Piece currentPiece;

boolean pieceFalling = false;
long prevDownMillis;
long pieceDownTime = 400;

///////////////////////SETUP////////////////////////////////

void setup()
{
  //Define windowSize
  //size(800,500);
  fullScreen();
  
  //Arrange mainGrid dimensions to fit window size:
  gridYPos = 10;
  
  squareSize = (width/3)/gridWidth;
  gridHeight = height/squareSize - gridYPos/squareSize-1;
  
  gridWidthLen = gridWidth * squareSize;
  gridHeightLen = gridHeight * squareSize;
 
  //Define mainGrid dimensions and location: 
  mainGrid= new color[gridWidth][gridHeight];
  gridXPos = width/2- gridWidthLen/2;
  resetMainGrid();
  
  //Instance a random nextPiece object:
  nextPiece = new Piece(int(random(7)), int(random(4)), int(random(7)));
}

//////////////////////MAIN LOOP///////////////////////////////
void draw()
{
  switch(gameState)
  {
    case 0: //Welcome screen
      resetBackground();
      drawGrid();
      updateMainGrid();
      showIntroMessage();
      break;
    case 1: //Game screen
      resetBackground();
      drawGrid();
      updateMainGrid();
      playGame();
      checkLevels();
      break;
    case 2: //Game over screen
      resetBackground();
      drawGrid();
      updateMainGrid();
      showOutroMessage();
      break; 
    case 3: //Finish game screen
      resetBackground();
      drawGrid();
      updateMainGrid();
      showEndMessage();
      break;
  }
}

//////////////////////////////////KEYBOARD////////////////////////////////
void keyPressed()
{
  switch(gameState)
  {
    case 0: //Intro
      if(key == ' ')
         gameState = 1;
      break;
    case 1: //Game
      if(currentPiece != null)
      {
         if(keyCode == UP)
             currentPiece.rotateRight();        
         if(keyCode == RIGHT)
             currentPiece.move(1);         
         if(keyCode == DOWN)
             currentPiece.move(2);
         if(keyCode == LEFT)
             currentPiece.move(3);   
      }
      if(key == 'p' || key == 'P') //Pause and resume game
      {
        gameRunning = !gameRunning;
        if(gameRunning)
          loop();
        else
        {
          fill(themeColor);
          text("PAUSED", width*0.05, height * 0.6);
          noLoop();
        }
      }
      break;
     case 2: //Game over
     case 3: //Game end
       if(key == ' ') //Reset game variables and start game.
       {
         gameState = 1;
         record = points;
         points = 0;
         level = 0;
         livesLeft = 3;
       }
       break;
  }
}
