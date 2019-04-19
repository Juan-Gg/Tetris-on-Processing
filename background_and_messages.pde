/**************************************************************************************************************************
                             TETRIS on Processing Version 8 - BACKGROUND AND MESSAGES (3/5)
     
   Copyright (C) 2018  JuanGg  -  https://juangg-projects.blogspot.com/

   This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
   To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ 
    
   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
   
****************************************************************************************************************************/



//Reset background------------------------------------------
void resetBackground()
{
  themeColor = themeColors[level];
  background(0);
  stroke(themeColor);
  fill(themeColor);
  textSize(width/20);
  text("TETRIS", width*0.05, height * 0.15);
  textSize(width/40);
  text("Use arrow keys to \nmove, UP to rotate. \nPress 'p' to pause and \nresume the game.\n\n\n\n(c) JuanGg \n2018", width*0.05, height * 0.3);
  String livesCounter = "";
  for(int i=0;i<livesLeft; i++)
    livesCounter = livesCounter.concat("■");
  text("Level: " + level + "       Lives: " + livesCounter + "\nPoints:  " + points + "\nRecord: " + record + "\nNext piece: ", width*0.7, height * 0.1); 
  fill(0);
  rect(width*0.7, height * 0.33, 6*squareSize, 5*squareSize);
  showNextPiece(width*0.75, height*0.35);
}


//Messages--------------------------------------------------
void showIntroMessage()
{
  fill(0);
  float rectWidth = width * 0.3;
  float rectHeight = height *0.3;
  rect(width/2-rectWidth/2, height/2-rectHeight/2, rectWidth, rectHeight);
  stroke(themeColor);
  textSize(width/40);
  fill(themeColor);
  text("Press space to start", width*0.38, height * 0.5); 
  
}

void showOutroMessage()
{
  fill(0);
  float rectWidth = width * 0.3;
  float rectHeight = height *0.3;
  rect(width/2-rectWidth/2, height/2-rectHeight/2, rectWidth, rectHeight);
  stroke(themeColor);
  textSize(width/40);
  fill(themeColor);
  text("GAME OVER!\nPress space to\n  play again", width*0.38, height * 0.4);
  if(points > record)
  {
    text("New record!", width*0.38, height * 0.6);
  } 
}

void showEndMessage()
{
  fill(0);
  float rectWidth = width * 0.3;
  float rectHeight = height *0.3;
  rect(width/2-rectWidth/2, height/2-rectHeight/2, rectWidth, rectHeight);
  stroke(themeColor);
  textSize(width/40);
  fill(themeColor);
  text("YOU WON!\nPress space to\n   play again.", width*0.4, height * 0.45);  
}
