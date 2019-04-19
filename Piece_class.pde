/**************************************************************************************************************************
                             TETRIS on Processing Version 8 - PIECE CLASS (2/5)
     
   Copyright (C) 2018  JuanGg  -  https://juangg-projects.blogspot.com/

   This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
   To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ 
    
   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
   
****************************************************************************************************************************/


//Pieces and letter codes:
/*  
PIECES
        #     ##      #    #    #      #
####   ###    ##    ###    ###  ##    ##
                                 #    #
  i     t      r      l     j    s      z
  0     1      2      3      4    5     6     

ORIENTATION: 0 (up) 1(right) 2(down) 3(left)

COLORS: 0(light blue) 1(dark blue) 2(orange) 3(yellow) 4(green) 5(purple) 6(red)
*/

public class Piece
{
  //Class variables------------------------------------------------------------------------------------------------------------------------------------------
  private int pieceKind;
  private int pieceOrientation;
  private int pieceX;
  private int pieceY;
  private int pieceColor = 0;
  //Colors:
  private color[] pieceColors = {#03F4FF,#3003FF,#FF8E03,#FFF703,#12FF03,#E103FF,#B20505};
  //Piece matrices--------------------------------------------------------------------------------------------------------------------------------------------
  //All pieces, all possible orientations
  final private  boolean[][][][] pieceMatrices =
  {
   //i
   {{{false, false, false, false},{true, true, true, true},{false, false, false, false},{false, false, false, false}}, //Up (columna, columna, columna, columna)
   {{false, true, false, false},{false, true, false, false},{false, true, false, false},{false, true, false, false}}, //Right
   {{false, false, false, false},{true, true, true, true},{false, false, false, false},{false, false, false, false}}, //Down
   {{false, true, false, false},{false, true, false, false},{false, true, false, false},{false, true, false, false}}},
   //t
   {{{false, true, false, false},{false, true, true, false},{false, true, false, false},{false, false, false, false}}, //Up
   {{false, true, false, false},{true, true, true, false},{false, false, false, false},{false, false, false, false}}, //Right
   {{false, true, false, false},{true, true, false, false},{false, true, false, false},{false, false, false, false}}, //Down
   {{false, false, false, false},{true, true, true, false},{false, true, false, false},{false, false, false, false}}},//Left ///////////////ACABAR
   //r
   {{{true, true, false, false},{true, true, false, false},{false, false, false, false},{false, false, false, false}}, //Up
   {{true, true, false, false},{true, true, false, false},{false, false, false, false},{false, false, false, false}}, //Right
   {{true, true, false, false},{true, true, false, false},{false, false, false, false},{false, false, false, false}}, //Down
   {{true, true, false, false},{true, true, false, false},{false, false, false, false},{false, false, false, false}}}, //Left
   //l
   {{{false, true, false, false},{false, true, false, false},{true, true, false, false},{false, false, false, false}}, //Up
   {{false, false, false, false},{true, true, true, false},{false, false, true, false},{false, false, false, false}}, //Right
   {{false, true, true, false},{false, true, false, false},{false, true, false, false},{false, false, false, false}}, //Down
   {{true, false, false, false},{true, true, true, false},{false, false, false, false},{false, false, false, false}}}, //Left
   //j
   {{{true, true, false, false},{false, true, false, false},{false, true, false, false},{false, false, false, false}}, //Up
   {{false, false, false, false},{true, true, true, false},{true, false, false, false},{false, false, false, false}}, //Right
   {{false, true, false, false},{false, true, false, false},{false, true, true, false},{false, false, false, false}}, //Down
   {{false, false, true, false},{true, true, true, false},{false, false, false, false},{false, false, false, false}}}, //Left
   //s
   {{{false, false, false, false},{true, true, false, false},{false, true, true, false},{false, false, false, false}}, //Up
   {{false, false, true, false},{false, true, true, false},{false, true, false, false},{false, false, false, false}}, //Right
   {{true, true, false, false},{false, true, true, false},{false, false, false, false},{false, false, false, false}}, //Down
   {{false, true, false, false},{true, true, false, false},{true, false, false, false},{false, false, false, false}}}, //Left
   //z
   {{{false, false, false, false},{false, true, true, false},{true, true, false, false},{false, false, false, false}}, //Up
   {{false, true, false, false},{false, true, true, false},{false, false, true, false},{false, false, false, false}}, //Right
   {{false, true, true, false},{true, true, false, false},{false, false, false, false},{false, false, false, false}}, //Down
   {{true, false, false, false},{true, true, false, false},{false, true, false, false},{false, false, false, false}}}, //Left
  };
                                 
  //Construtor-------------------------------------------------------------------------------------------------------------------------------------------------
  public Piece(int kind, int orientation, int newColor )
  {
    pieceKind = kind;
    pieceOrientation = orientation;
    pieceColor = newColor;
    
    pieceX = gridWidth/2-2;
    pieceY = 0;
  }

  
  /////////////////////////////////////////////////////////CLASS METHODS//////////////////////////////////////////////////////////// 

  //MOVEMENT---------------------------------------------------
  
  //Check is a proposed position and orientation are safe for the piece to be:
  public boolean isMoveSafe(color[][] mainGrid, color backgroundColor, int gridWidth, int gridHeight, int newPieceX, int newPieceY, int newPieceOrientation)
  {
    if(newPieceOrientation >3)
      newPieceOrientation = 0;
      
    for(int x=0;x<4;x++)
    {
      for(int y=0;y<4;y++)
      {
         if(pieceMatrices[pieceKind][newPieceOrientation][x][y])
         {
           if(x+newPieceX < 0 ||x+newPieceX > gridWidth-1 || y+newPieceY < 0|| y+newPieceY > gridHeight-1) //Check if we are still inside the mainGrid
           {
             //println("out of mainGrid");
             return false;
           }
           else if(mainGrid[x+newPieceX][y+newPieceY] != backgroundColor)
           {
             //println("colision with object");
             return false;
           }
         }
      }
    }
    return true;    
  }
  
  //Move up, down left or right. If achieved returns true, false if not.
  public boolean move(int direction)
  {
    switch(direction)
    {
      case 0:
        if(this.isMoveSafe(mainGrid, gridBackground, gridWidth,gridHeight, pieceX, pieceY-1,pieceOrientation))
        {
          pieceY--;
          return true;
        }
        break;
      case 1:
        if(this.isMoveSafe(mainGrid, gridBackground, gridWidth,gridHeight, pieceX+1, this.getPieceY(),pieceOrientation))
        {
          pieceX++;
          return true;
        }
        break;
      case 2:
        if(this.isMoveSafe(mainGrid, gridBackground, gridWidth,gridHeight, pieceX, pieceY+1,pieceOrientation))
        {
          pieceY++;
          return true;
        }
        break;
      case 3:
        if(this.isMoveSafe(mainGrid, gridBackground, gridWidth,gridHeight, pieceX-1, pieceY,pieceOrientation))
        {
          pieceX--;
          return true;
        }
        break;
    }
    return false;
  }
   
  //Rotate piece right if safe to do so:
  public void rotateRight()
  {
    if(this.isMoveSafe(mainGrid, gridBackground, gridWidth,gridHeight, pieceX, pieceY,pieceOrientation+1))
    {
    if(pieceOrientation < 3)
      pieceOrientation ++;
    else
      pieceOrientation = 0;
    }
  }
  
  
  //GETTERS / SETTERS --------------------------------------------
  public boolean[][] getPieceMatrix()
  {
    return pieceMatrices[pieceKind][pieceOrientation];
  }
  
  public int getPieceX()
  {
    return pieceX;
  }
  
  public int getPieceY()
  {
    return pieceY;
  }
  public int getPieceOrientation()
  {
    return pieceOrientation;
  }
  
  public color getColor()
  {
    return pieceColors[pieceColor];
  }
  
  public boolean[][] getPieceMatrix(int kind, int orientation)
  {
    return pieceMatrices[kind][orientation];
  }
  
  public color getColor(int newColor)
  {
    return pieceColors[newColor];
  }
  
    
}
