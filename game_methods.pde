/**************************************************************************************************************************
                             TETRIS on Processing Version 8 - GAME METHODS (4/5)
     
   Copyright (C) 2018  JuanGg  -  https://juangg-projects.blogspot.com/

   This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
   To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ 
    
   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
   
****************************************************************************************************************************/

//Main game logic:
void playGame()
{
  if(! pieceFalling)
  {
    currentPiece = nextPiece;
    nextPiece = new Piece(int(random(7)), int(random(4)), int(random(7)));
    pieceFalling = true;
  }
  
  if(millis()-prevDownMillis > pieceDownTime)
  {
    boolean pieceMoved = currentPiece.move(2);
    if(!pieceMoved && currentPiece.getPieceY() == 0)
    {
      resetMainGrid();
      livesLeft--;
      if(livesLeft <0)
        gameState = 2;
    }
    else if(!pieceMoved)
    {
      copyPieceToMainGrid();
      pieceFalling = false;
    }
    prevDownMillis = millis();
  }
  removeFullRows();
}

//Handle levels, increase them with points and make it go faster.
void checkLevels()
{
  int newLevel = points/10;
  if(newLevel == 5)
    gameState = 3;
  else{
    if(newLevel > level)
    {
      if(livesLeft<3)
        livesLeft++;
      level = newLevel;
      pieceDownTime = 500-100*level;
    }
  }
}

//Check for full rows, delete them and increase points:
void removeFullRows()
{
  for(int y = 0; y < gridHeight; y++)
  {
    boolean rowFull = true;
    for(int x = 0; x <gridWidth; x++)
    {
      if(mainGrid[x][y] == gridBackground)
        rowFull = false;
    }
    if(rowFull)
    {
      points += level +1 ;
      for(int j = y; j >= 0; j--)
      {
        for(int i = 0; i <gridWidth; i++)
        {
          if(j!=0)
            mainGrid[i][j] = mainGrid[i][j-1];
          else
            mainGrid[i][j] = gridBackground;
        }
      }
    }
  }
}

//Show a preview of the next piece to fall:
void showNextPiece(float posX, float posY)
{
  boolean[][] pieceMatrix = nextPiece.getPieceMatrix();
  fill(nextPiece.getColor());
  for(int i =0; i<4; i++)
  {
    for(int j =0; j<4; j++)
    {
      if(pieceMatrix[i][j])
      {
        rect(posX +(i)*squareSize,posY +(j)*squareSize,squareSize, squareSize);
      }
    }
  }
}
