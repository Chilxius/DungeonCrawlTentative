static color safeColor = #C8C8C8;

class Tile
{
  int x, y;
  color tileColor;
  int tileAnimation=0;
  boolean animationIncreasing=true;
  //static char safeColor = '~'; //for placing under objects
  boolean pathable; //can walk on
  boolean safe; //monsters won't spawn
  
  boolean occupied; //is someone standing there
  color occupantColor; //color of occupant
  String occupantText = "";
  
  boolean interactive; //doors, etc
  Key k; //key item/event to trigger interaction
  int interactionDirection; //direction of tile affected by interaction - numpad directions
  //String searchText[] = {"","",""}; //for non-door interactions (people, signs, chests)

  boolean event; //true if event is trigger-able
  boolean repeatable; //true if event re-triggers
  String eventText = " ";//[] = {" "," "," "," "," "," "," "," "," "," "}; //text displayed when event is triggered - sends to queue as [0],[1],[2]
  
  boolean isBoss;
  //Monster boss;
  
  TileType type;
  Object obj;
  
  boolean isShop;
  Item itemForSale;
  int itemPrice;
  
  public Tile()
  {
    this(1,1,color(255),true,false,false); 
  }
  
  public Tile( int X, int Y, int fl, char t )
  {
    x = X;
    y = Y;
    occupied = false;
    safe = false;
    isBoss = false;
    occupantColor = color(255);
    
    switch(t)
    {
      case '@':type=TileType.CAMP;break;
      case '#':type=TileType.WALL;break;
      case '$':type=TileType.SECRET_WALL;break;
      case '3':type=TileType.DARK_WALL;break;
      case '¢':type=TileType.SECRET_DARK_WALL;break;
      case '4':type=TileType.SAND_WALL;break;
      case '~':type=TileType.GRASS;break;
      case '+':type=TileType.DOOR;break;
      case 'w':type=TileType.WATER;break;
      case '%':type=TileType.FLOWER;break;
      case 'T':type=TileType.TREE;break;
      case 't':type=TileType.TREE_PATH;break;
      case 'D':type=TileType.DARK_TREE;break;
      case 'g':type=TileType.GRAVE;break;
      case '&':type=TileType.S_GLASS;break;
      case '>':type=TileType.STAIR_DOWN;break;
      case ' ':type=TileType.DARK;break;
      case '£':type=TileType.BLACK_WALL;break;
      case 'G':type=TileType.GARGOYLE;break;
      case 'R':type=TileType.GARGOYLE_DARK;break;
      //different key types
      case 'c':
      case 'i':
      case 's':
      case 'b':type=TileType.DOORSTEP;safe=true;break;
      case '.':type=TileType.SAFE;safe=true;break;
      default :type=TileType.EMPTY;safe=true;break;
    }
    
    switch(t)  //For objects
    {
      case '=':obj=Object.CHEST;type=TileType.SAFE;break;
      case '?':obj=Object.SIGN;type=TileType.SAFE;break;
      case '*':obj=Object.SAVEPOINT;type=TileType.SAFE;break;
      case '[':obj=Object.BARREL;type=TileType.SAFE;break;
      default: obj=Object.NONE;break;
    }
    
    setTraitsByType(t,fl);
  }
  
  private void setTraitsByType(int floor){setTraitsByType(' ',floor);}
  
  private void setTraitsByType(char t, int floor)
  {
    interactive = false;
    event = false;
    switch(type)
    {
      case EMPTY: {
        tileColor = color(190);
        pathable = true;
        interactive = false;
        event = false; break;
      }
      case DARK: {
        tileColor = color(0);
        pathable = true;
        interactive = false;
        event = false; break;
      }
      case DARK_WALL: {
        tileColor = color(200);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case SECRET_DARK_WALL: {
        tileColor = color(200);
        pathable = true;
        interactive = false;
        event = false; break;
      }
      case BLACK_WALL: {
        tileColor = color(0);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case SAFE: {
        tileColor = safeColor;
        pathable = true;
        interactive = false;
        event = false; safe = true; break;
      }
      case CAMP: {
        tileColor = color(150,0,0);
        pathable = true;
        interactive = false;
        event = false; safe = true; break;
      }
      case FLOWER:
      case GRAVE:
      case GRASS: {
        tileColor = color(0,180,0);
        pathable = true;
        interactive = false;
        event = false; break;
      }
      case DARK_TREE:
      case TREE: {
        tileColor = color(0,180,0);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case TREE_PATH: {
        tileColor = color(0,180,0);
        pathable = true; break;
      }
      case WALL: {
        tileColor = color(120);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case SECRET_WALL: {
        tileColor = color(120);
        pathable = true;
        interactive = false;
        event = false; break;
      }
      case S_GLASS: {
        tileColor = color(255);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case GARGOYLE_DARK:
      case GARGOYLE: {
        tileColor = color(200);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case WATER: {
        tileColor = color(0,0,220);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case DOOR: {
        tileColor = color(90,70,30);
        pathable = false;
        interactive = false;
        event = false; break;
      }
      case DOORSTEP: {
        tileColor = color(200);
        pathable = true;
        interactive = false;
        event = false;
        if( t == 'c' )
          createInteraction( Key.COPPER_KEY );
        else if( t == 'i' )
          createInteraction( Key.IRON_KEY );
        else if( t == 's' )
          createInteraction( Key.SKELETON_KEY );
        else if( t == 'b' )
          createInteraction( Key.BRASS_KEY );
        addToProgressSwitches(floor);
        break;
      }
      case STAIR_DOWN: {
        tileColor = color(0);
        pathable = true;
        interactive = false;
        event = false; break;
      }
      default: {
        tileColor = color(200,0,0);
        pathable = true;
        interactive = false;
        event = true; break;
      }
    }
  }
  
  public Tile( int X, int Y, color c, boolean p, boolean i, boolean e )
  {
    x = X;
    y = Y;
    tileColor = c;
    pathable = p;
    interactive = i;
    event = e;
  }
  
  void addToProgressSwitches( int floor )
  {
    doorSwitches[doorSwitchCount++] = new ProgressSwitch( SwitchType.DOOR, x, y, floor );
  } 
  
  void addBossProgressSwitch( int floor )
  {
    bossSwitches[bossSwitchCount++] = new ProgressSwitch( SwitchType.BOSS, x, y, floor );
  }
  
  void removeBoss()
  {
    occupied = false;
    pathable = true;
    isBoss = false;
  }
  
  public void placeOccupant( color c, String message )
  {
    occupied = true;
    pathable = false;
    occupantColor = c;
    occupantText = message;
  }
  
  public void placeShop( Item i, int price )
  {
    occupied = false;
    pathable = true;
    itemPrice = price;
    itemForSale = i;
    type = TileType.SHOP;
  }
  
  public void placeSeller()
  {
    occupied = false;
    pathable = true;
    type = TileType.SELL;
  }
  
  public void placeBoss( int floor, color c, String message, Monster m ) //not working properly - boss is being replaced
  {
    occupied = true;
    pathable = false;
    occupantColor = c;
    occupantText = message;
    isBoss = true;
    zoo.addBossToList(m);
    addBossProgressSwitch( floor );
  }
  
  public void createEvent( boolean r, String s )
  {
    type = TileType.EVENT;
    event = true;
    repeatable = r;
    eventText=s;
  }
  
  /*//x determines the numeber of lines of text to be read
  public void createEvent( boolean r, int x, String [] s )
  {
    type = TileType.EVENT;
    event = true;
    repeatable = r;
    for(int i = 0; i < x && i < s.length; i++)
    {
      eventText[i] = s[i];
    }
  }*/
  
  public void createInteraction( Key keyType )
  {
    k = keyType;
    interactive = true;
  }
  
  public boolean interact( Key keys[] )
  {
    for(int i = 0; i < keys.length; i++)
      if( keys[i] == k )
      {
        advanceText("You use your " + keyName(k) + ".");
        keys[i] = Key.NONE;
        interactive = false;
        openDoorSound.play();
        return true;
      }
    advanceText("You lack the required item.");
    lockedDoorSound.play();
    return false;
  }
  
  public boolean isPathable()
  {
    return pathable;
  }
  
  public boolean hasEvent()
  {
    return event;
  }
  
  public void playEvent() //text not displaying if less than 3
  {
    if(eventText!="")pushTextLine(eventText);
    if(!repeatable)
      event=false;
  }
  
  public String keyMessage()
  {
    switch(k)
    {
      case COPPER_KEY: return "A door with a copper handle.";
      case IRON_KEY: return "A door banded with iron.";
      case SKELETON_KEY: return "A door with a skull-shaped emblem.";
      case BRASS_KEY: return "An old door decorated with copper symbols.";
      default: return "A strange door...";
    }
  }
  
  public void drawTile(int xPos, int yPos)
  {
    rectMode(CORNER); imageMode(CORNER);
    if(obj!=Object.NONE)  //tiles with objects will fill with the color of the last pathable tile above it
      fill(safeColor);
    else
    {
      fill(tileColor);
      if(pathable && type!=TileType.DOORSTEP)
        safeColor=tileColor;
      else if(type == TileType.WALL)
        safeColor=#FFFFFF;
      else if(type == TileType.DARK_WALL)
        safeColor=#C8C8C8;
    }
    noStroke();
    rect(xPos,yPos,30,30);
    if(type == TileType.WALL || type == TileType.SECRET_WALL)
      image(tileImage[0],xPos,yPos);
    else if(type == TileType.DARK_WALL || type == TileType.SECRET_DARK_WALL)
      image(tileImage[49],xPos,yPos);
    else if(type == TileType.SAND_WALL)
      image(tileImage[50],xPos,yPos);
    else if(type == TileType.S_GLASS)
      image(tileImage[43],xPos,yPos);
    else if(type == TileType.DOOR)
      image(tileImage[39],xPos,yPos);
    else if(type == TileType.FLOWER)
      image(tileImage[3],xPos,yPos);
    else if(type == TileType.WATER)
      image(tileImage[int(4+vanGogh.stage()/10)],xPos,yPos);
    else if(type==TileType.DARK_TREE)
      image(tileImage[2],xPos-10,yPos-10);
    else if(type==TileType.TREE)
      image(tileImage[1],xPos-10,yPos-10);
    else if(type == TileType.TREE_PATH)
      image(tileImage[47],xPos-10,yPos-10);
    else if(type == TileType.GRAVE)
      image(tileImage[42],xPos,yPos);
    else if(type == TileType.SELL)
      image(tileImage[28],xPos,yPos);
    else if(type == TileType.MERCHANT)
      image(tileImage[48],xPos,yPos);
    else if(type == TileType.STAIR_DOWN)
      image(tileImage[40],xPos,yPos);
    else if(type == TileType.GARGOYLE)
      image(tileImage[51],xPos,yPos);
    else if(type == TileType.GARGOYLE_DARK)
      image(tileImage[52],xPos,yPos);
    if(occupied)
    {
      fill(occupantColor); noStroke();
      ellipse(xPos+15,yPos+15,12,12);
    }
    if(obj!=Object.NONE);
      vanGogh.drawObject(obj,xPos,yPos);
      
    animate(); //Causes animation variable to change
  }
  
  public void drawForegroundObject()
  {
    float xPos = width/2-15;
    float yPos = 360;
    if(type == TileType.TREE_PATH)
      image(tileImage[47],xPos-10,yPos-10);
    if(type == TileType.SECRET_WALL)
      image(tileImage[0],xPos,yPos);
    if(type == TileType.SECRET_DARK_WALL)
      image(tileImage[49],xPos,yPos);
  }
  
  public boolean canOpen()
  {
    if( type == TileType.DOOR )
      return true;
    return false;
  }
  
  public boolean isSavePoint()
  {
    if(obj == Object.SAVEPOINT)
      return true;
    return false;
  }
  
  public void animate()
  {
    if(animationIncreasing)
      tileAnimation++;
    else
      tileAnimation--;
    if(tileAnimation>=100)
      animationIncreasing=false;
    if(tileAnimation<=0)
      animationIncreasing=true;
  }
  
  public boolean isSafe()
  {
    switch( type )
    {
      case SAFE:
      case SHOP:
      case SELL:
      case CAMP:
      return true;
    }
    return false;
  }
}

public enum TileType
{
  EMPTY, WALL, SECRET_WALL, GRASS, EVENT, FLOWER, WATER, TREE, DARK_TREE, TREE_PATH,
  DARK, BLACK_WALL, DARK_WALL, SECRET_DARK_WALL, SAND_WALL, DOOR, DOORSTEP, GRAVE, S_GLASS, SAFE, GARGOYLE, GARGOYLE_DARK,
  CAMP, MERCHANT, SHOP, SELL,
  STAIR_DOWN
}

public enum Key //special items for interactive tiles
{
  COPPER_KEY, SKELETON_KEY, IRON_KEY, BRASS_KEY, NONE
}

public enum Object //tile has an object (still pathable)
{
  CHEST, SIGN, SAVEPOINT, BARREL,
  NONE
}
