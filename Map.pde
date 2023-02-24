//Top-left corner of the map sets the "out-of-bounds" tile types

class Map
{
  Tile [][] tiles = new Tile[100][100];
  int floorNumber;
  
  public Map()
  {
    for(int y = 0; y < tiles[0].length; y++)
      for(int x = 0; x < tiles.length; x++)
        tiles[x][y] = new Tile();
  }
  
  //Assumes m will be 100x100 (10,000 total tiles) Fills in the gaps otherwise.
  public Map( String m, int f )
  {
    floorNumber = f;
    //Fills empty map slots - will probably create a bad map if unintentional
    while(m.length()<tiles.length*tiles[0].length)
    {
      print("EMPTY FILLED.");
      m+=' ';
    }
    
    //convert to tiles
    for(int y = 0; y < tiles.length; y++)
      for(int x = 0; x < tiles.length; x++)
        tiles[x][y] = new Tile(x,y,floorNumber,m.charAt(x+y*100));
  }
  
  /*public void drawMap()
  {
    for(int i = 0; i < tiles.length; i++)
      for(int j = 0; j < tiles[0].length; j++)
        tiles[i][j].drawTile();
  }*/

  //Draws a 15x15 square of tiles centered on the party
  public void drawMapOnPosition( int pX, int pY, color a, color b, color c )
  {
    for(int i = pX-6, xDraw = 0; i <= pX+6; i++,xDraw+=30)
      for(int j = pY-6, yDraw = 0; j <= pY+6; j++,yDraw+=30)
        if( i >= 0 && j >= 0 && i < 100 && j < 100 )
          tiles[i][j].drawTile(155+(xDraw),180+(yDraw));
        else
          tiles[0][0].drawTile(155+(xDraw),180+(yDraw));
          
    drawPartyPosition(a,b,c);  //Draws the heroes
    tiles[party.X][party.Y].drawForegroundObject(); //Re-draws the tile art if the heroes move behind it
  }
  
  void drawPartyPosition(color a,color b,color c)
  {
    //fullscreen testing
    noStroke();
    fill(a); ellipse(350,370,10,10);
    fill(b); ellipse(350-7,380,10,10);
    fill(c); ellipse(350+7,380,10,10);
    
    //For Testing
    textSize(10);
    fill(0);
    textAlign(LEFT);
    text(party.X + ", " + party.Y,width/2-10,height/2+45);
  }
  
  public boolean tilePathable(int xPos, int yPos)
  {
    if(tiles[xPos][yPos].isPathable())
      return true;
    return false;
  }
  
  public boolean tileHasEvent(int xPos, int yPos)
  {
    if(tiles[xPos][yPos].hasEvent())
    {
    //  println("EVENT");
      return true;
    }
    //println("NO EVENT");
    return false;
  }
  
  public void openDoorsAround(int xPos, int yPos)
  {
    if(tiles[xPos-1][yPos].canOpen())
    {  tiles[xPos-1][yPos].type = TileType.EMPTY; tiles[xPos-1][yPos].setTraitsByType(floorNumber);}
    if(tiles[xPos+1][yPos].canOpen())
    {  tiles[xPos+1][yPos].type = TileType.EMPTY; tiles[xPos+1][yPos].setTraitsByType(floorNumber);}
    if(tiles[xPos][yPos-1].canOpen())
    {  tiles[xPos][yPos-1].type = TileType.EMPTY; tiles[xPos][yPos-1].setTraitsByType(floorNumber);}
    if(tiles[xPos][yPos+1].canOpen())
    {  tiles[xPos][yPos+1].type = TileType.EMPTY; tiles[xPos][yPos+1].setTraitsByType(floorNumber);}
    
    flipDoorSwitch(xPos,yPos); 
  }
  
  public void removeBoss( int xPos, int yPos )
  {
    //tiles[xPos][yPos].isBoss = false;
    //tiles[xPos][yPos].occupied = false;
    tiles[xPos][yPos].removeBoss();
    flipBossSwitch(xPos,yPos);
  }
}

public class Portal //for switching maps
{
  int originX, originY;
  int destinationX, destinationY;
  int originFloor, destinationFloor;
  
  public Portal( int oF, int oX, int oY, int dF, int dX, int dY )
  {
    originX = oX;
    originY = oY;
    destinationX = dX;
    destinationY = dY;
    originFloor = oF;
    destinationFloor = dF;
  }
}
