//MAP class
//PORTAL class
//DANGER MAP class

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
    if(debugMode)
      println("Tiles in map "+f+": "+m.length());
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
          tiles[i][j].drawTile(155+(xDraw),180+(yDraw)); //Draw Tile
        else
          tiles[0][0].drawTile(155+(xDraw),180+(yDraw)); //Draw default tile, which is the tile at 0,0
          
    drawPartyPosition(a,b,c);  //Draws the heroes
    //println(tiles[party.X][party.Y].type);
    tiles[party.X][party.Y].drawForegroundObject(); //Re-draws the tile art if the heroes move behind it
    
    if(vanGogh.titleCardDuration > 0) //Location Title Card
      vanGogh.drawLocationTitleCard();
  }
  
  //Debug tool
  public void drawDangerMap( int x, int y )
  {
    push();
    textAlign(CENTER);
    textSize(30);
    fill(250,127);
    for(int i = x-6, xDraw = 0; i <= x+6; i++,xDraw+=30)
      for(int j = y-6, yDraw = 0; j <= y+6; j++,yDraw+=30)
        if( i >= 0 && j >= 0 && i < 100 && j < 100 )
          text(dm[party.floor].dangerValueChar(i,j),162+(xDraw),203+(yDraw));
          //tiles[i][j].drawTile(155+(xDraw),180+(yDraw)); //Draw Tile
    pop();
  }
  
  //Debug tool
  public void drawLocationMap( int x, int y )
  {
    push();
    textAlign(CENTER);
    textSize(10);
    fill(250,127);
    for(int i = x-6, xDraw = 0; i <= x+6; i++,xDraw+=30)
      for(int j = y-6, yDraw = 0; j <= y+6; j++,yDraw+=30)
        if( i >= 0 && j >= 0 && i < 100 && j < 100 )
        {
          text( i + "," + j, 170+(xDraw), 195+(yDraw));
        }
    pop();
  }
  
  void drawPartyPosition(color a,color b,color c)
  {
    //fullscreen testing
    noStroke();
    fill(a); ellipse(350,370,10,10);
    fill(b); ellipse(350-7,380,10,10);
    fill(c); ellipse(350+7,380,10,10);
    
    if(debugMode)
    {
      //For Testing
      textSize(10);
      fill(255);
      textAlign(LEFT);
      text(party.X + ", " + party.Y,width/2-35,height/2+20);
    }
    
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
    //if(tiles[xPos-1][yPos].canOpen())
    //{  tiles[xPos-1][yPos].type = TileType.EMPTY; tiles[xPos-1][yPos].setTraitsByType(floorNumber);}
    //if(tiles[xPos+1][yPos].canOpen())
    //{  tiles[xPos+1][yPos].type = TileType.EMPTY; tiles[xPos+1][yPos].setTraitsByType(floorNumber);}
    //if(tiles[xPos][yPos-1].canOpen())
    //{  tiles[xPos][yPos-1].type = TileType.EMPTY; tiles[xPos][yPos-1].setTraitsByType(floorNumber);}
    //if(tiles[xPos][yPos+1].canOpen())
    //{  tiles[xPos][yPos+1].type = TileType.EMPTY; tiles[xPos][yPos+1].setTraitsByType(floorNumber);}
    
    if(tiles[xPos-1][yPos].canOpen())
      openDoor( xPos-1, yPos );
    if(tiles[xPos+1][yPos].canOpen())
      openDoor( xPos+1, yPos );
    if(tiles[xPos][yPos-1].canOpen())
      openDoor( xPos, yPos-1 );
    if(tiles[xPos][yPos+1].canOpen())
      openDoor( xPos, yPos+1 );
      
    flipDoorSwitch(xPos,yPos); 
  }
  
  public void openDoor( int x, int y )
  {
    switch( tiles[x][y].type )
    {
      case DOOR:
      case PORTCULLIS:
        tiles[x][y].type = TileType.DOOR_FRAME;
        break;
      case DOOR_GATE:
        tiles[x][y].type = TileType.GATE_FRAME;
        break;
      case CAVE_DOOR:
        tiles[x][y].type = TileType.CAVE_DOOR_OPEN;
        break;
      default:
        tiles[x][y].type = TileType.EMPTY;
    }
    tiles[x][y].setTraitsByType(floorNumber);
  }
  
  public void removeBoss( int xPos, int yPos )
  {
    //tiles[xPos][yPos].isBoss = false;
    //tiles[xPos][yPos].occupied = false;
    tiles[xPos][yPos].removeBoss();
    flipBossSwitch(xPos,yPos);
  }
  
  public boolean isStair( int x, int y )
  {
    for(Portal p: exits)
    {
      if( p.originX == x && p.originY == y )
        return true;
    }
    return false;
  }
}

//**************************************************************************//
//**************************************************************************//

public class Portal //for switching maps
{
  int originX, originY;
  int destinationX, destinationY;
  int originFloor, destinationFloor;
  String title;
  
  public Portal( int oF, int oX, int oY, int dF, int dX, int dY )
  {
    this( oF, oX, oY, dF, dX, dY, "" );
  }
  
  public Portal( int oF, int oX, int oY, int dF, int dX, int dY, String t )
  {
    originX = oX;
    originY = oY;
    destinationX = dX;
    destinationY = dY;
    originFloor = oF;
    destinationFloor = dF;
    title = t;
  }
}

//**************************************************************************//
//**************************************************************************//

//Secondary map of danger levels, checked when triggering battles
//Danger of 0 will not trigger battles
//Danger level rises 1-9, then a-w
//Anything else will default to 0

class DangerMap
{
  char map[][] = new char[100][100];
  
  public DangerMap( String input )
  {
    if( input.length() != 10000 )
      println("Danger Map error:  length " + input.length() );
    while( input.length() < 10000 )
      input += "x";
      
    for(int i = 0; i < 100; i++)
      for(int j = 0; j < 100; j++)
        map[j][i] = input.charAt(i*100+j);
  }
  
  char dangerValueChar( int x, int y )
  {
    return map[x][y];
  }
}
