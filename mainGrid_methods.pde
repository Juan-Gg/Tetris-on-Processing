/**************************************************************************************************************************
                             TETRIS on Processing Version 8 - MAINGRID METHODS (5/5)
     
   Copyright (C) 2018  JuanGg  -  https://juangg-projects.blogspot.com/

   This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
   To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ 
    
   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
   
****************************************************************************************************************************/


//Main grid--------------------------------------------------

//Draw grid outline
void drawGrid()
{
  fill(themeColor);
  rect(gridXPos-5, gridYPos-5, gridWidthLen+10, gridHeightLen+10);
}

//Refresh mainGrid on screen
void updateMainGrid()
{
  //Fixed grid  
  for(int x = 0; x < gridWidth; x++)
  {
    for(int y = 0; y <gridHeight; y++)
    {
      fill(mainGrid[x][y]);
      rect(gridXPos+x*squareSize,gridYPos+y*squareSize,squareSize, squareSize);
    }
  }
  //Current piece
  if(currentPiece != null)
  {
    boolean[][] pieceMatrix = currentPiece.getPieceMatrix();
    int pieceX = currentPiece.getPieceX();
    int pieceY = currentPiece.getPieceY();
    
    fill(currentPiece.getColor());
    for(int i =0; i<4; i++)
    {
      for(int j =0; j<4; j++)
      {
        if(pieceMatrix[i][j])
        {
          rect(gridXPos+(pieceX+i)*squareSize,gridYPos+(pieceY+j)*squareSize,squareSize, squareSize);
        }
      }
    }
  }
}

//Clear mainGrid
void resetMainGrid()
{
  for(int x = 0; x < gridWidth; x++)
  {
    for(int y = 0; y <gridHeight; y++)
      mainGrid[x][y] = gridBackground;
  }
}

//Incorpaorate piece to mainGrid
void copyPieceToMainGrid()
{
  if(currentPiece != null)
  {
    //Copy piece to mainGrid
    boolean[][] pieceMatrix = currentPiece.getPieceMatrix();
    int pieceX = currentPiece.getPieceX();
    int pieceY = currentPiece.getPieceY();
    color pieceColor = currentPiece.getColor();
  
    for(int i =0; i<4; i++)
    {
      for(int j =0; j<4; j++)
      {
        if(pieceMatrix[i][j])
        {
          fill(currentPiece.getColor());
          mainGrid[pieceX+i][pieceY+j] = pieceColor;
        }
      }
    } 
  }
}
