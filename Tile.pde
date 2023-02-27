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
  boolean multipleBoss;
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
    multipleBoss = false;
    occupantColor = color(255);
    k = Key.NONE;
    
    switch(t)
    {
      case '@':type=TileType.CAMP;break;
      case '#':type=TileType.WALL;break;
      case '$':type=TileType.SECRET_WALL;break;
      case '3':type=TileType.DARK_WALL;break;
      case '¢':type=TileType.SECRET_DARK_WALL;break;
      case '4':type=TileType.SAND_WALL;break;
      case '~':type=TileType.GRASS;break;
      case '`':type=TileType.DIRT;break;
      case '+':type=TileType.DOOR;break;
      case '∏':type=TileType.DOOR_GATE;break; //shift+alt+p
      case 'π':type=TileType.PORTCULLIS;break;
      case 'w':type=TileType.WATER;break;
      case '%':type=TileType.FLOWER;break;
      case 'T':type=TileType.TREE;break;
      case 't':type=TileType.TREE_PATH;break;
      case 'D':type=TileType.DARK_TREE;break;
      case 'g':type=TileType.GRAVE;break;
      case '&':type=TileType.S_GLASS;break;
      case '>':type=TileType.STAIR;break;
      case '<':type=TileType.STAIR_DOOR;break;
      case ' ':type=TileType.DARK;break;
      case '£':type=TileType.BLACK_WALL;break;
      case 'G':type=TileType.GARGOYLE;break;
      case 'R':type=TileType.GARGOYLE_DARK;break;
      case '©':type=TileType.WEREWOLF_WHITE;break;
      case 'W':type=TileType.WOOD;break;
      case '∑':type=TileType.WOOD_DARK;break;
      case '„':type=TileType.WOOD_LIGHT;break;
      //different key types
      case 'c':
      case 'i':
      case 's':
      case 'k':
      case '˚': // shift+k (Father Charis's notes)
      case 'b':type=TileType.DOORSTEP;safe=true;break;
      case '.':type=TileType.FLOOR;safe=false;break;
      case 'r':type=TileType.FLOOR_RD;safe=false;break;
      case '∫':type=TileType.FLOOR_BL;safe=false;break; //shift+b
      case '_':type=TileType.SAFE;safe=true;break;
      default :type=TileType.EMPTY;safe=true;break;
    }
    
    switch(t)  //For objects
    {
      case '=':obj=Object.CHEST;type=TileType.SAFE;break;
      case '≠':obj=Object.CHEST_GOLD;type=TileType.SAFE;break; //alt+=
      case '±':obj=Object.CHEST_DARK;type=TileType.SAFE;break; //shift+alt+=
      case '?':obj=Object.SIGN;type=TileType.SAFE;break;
      case '/':obj=Object.SIGN_E;type=TileType.SAFE;break;
      case '÷':obj=Object.SIGN_F;type=TileType.SAFE;break; //alt+/
      case '¿':obj=Object.SIGN_D;type=TileType.SAFE;break; //shift+alt+/
      case 'ˆ':obj=Object.SIGN_I;type=TileType.SAFE;break; //shift+alt+i
      case '*':obj=Object.SAVEPOINT;type=TileType.SAFE;break;
      case '•':obj=Object.FAKE_SAVE;type=TileType.SAFE;break; //alt+8
      case '[':obj=Object.BARREL;type=TileType.SAFE;break;
      case ']':obj=Object.BARREL2;type=TileType.SAFE;break;
      default: obj=Object.NONE;break;
    }
    
    setTraitsByType(t,fl);
  }
  
  private void setTraitsByType(int floor){setTraitsByType(' ',floor);}
  
  private void setTraitsByType(char t, int floor)
  {
    interactive = false;
    event = false;
    pathable = true;
    switch(type)
    {
      case EMPTY: 
        tileColor = color(190);
        break;
      case FLOOR: 
        tileColor = color(200);
        break;
      case FLOOR_RD: 
        tileColor = color(200,0,0);
        break;
      case FLOOR_BL: 
        tileColor = color(0,0,200);
        break;
      case DARK: 
        tileColor = color(0);
        break;
      case DARK_WALL: 
        tileColor = color(200);
        pathable = false;
        break;
      case SECRET_DARK_WALL: 
        tileColor = color(200);
        break;
      case BLACK_WALL:
        tileColor = color(0);
        pathable = false;
        break;
      case WOOD_DARK:
      case WOOD:
        tileColor = color(90,70,30);
        pathable = false;
        break;
      case WOOD_LIGHT:
        tileColor = color(190,170,130);
        break;
      case SAFE: 
        tileColor = safeColor;
        //tileColor = color((x+y)*5%50+150,(x+y)*5%50+150,(x+y)*5%50+150);
        safe = true; break;
      case CAMP: 
        tileColor = color(150,0,0);
        safe = true; break;
      case FLOWER:
      case GRASS:
        tileColor = color(0,180,0);
        break;
      case DIRT:
        tileColor = color(170,150,110);
        break;
      case GRAVE:
        tileColor = color(0,100,0);
        break;
      case DARK_TREE:
      case TREE:
        tileColor = color(0,180,0);
        pathable = false;
        break;
      case TREE_PATH: 
        tileColor = color(0,180,0);
        break;
      case WALL:
        tileColor = color(120);
        pathable = false;
        break;
      case SECRET_WALL:
        tileColor = color(120);
        break;
      case S_GLASS:
        tileColor = color(120);
        pathable = false;
        break;
      case GARGOYLE_DARK:
      case GARGOYLE:
        tileColor = color(200);
        pathable = false;
        break;
      case WEREWOLF_WHITE:
        tileColor = color(200);
        pathable = false;
        break;
      case WATER:
        tileColor = color(0,0,220);
        pathable = false;
        break;
      case PORTCULLIS:
      case DOOR_GATE:
      case DOOR:
        tileColor = color(90,70,30);
        pathable = false;
        break;
      case DOORSTEP: 
      {
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
        else if( t == 'k' )
          createInteraction( Key.CHARIS );
        else if( t == '˚' )
          createInteraction( Key.CHARIS_NOTES );
        addToProgressSwitches(floor);
        break;
      }
      case STAIR:
      case STAIR_DOOR:
        tileColor = color(0);
        break;
      default:
        tileColor = color(200,0,0);
        pathable = true;
        interactive = false;
        event = true; break;
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
  
  public void placeBoss( int floor, color c, String message, Monster m )
  {
    placeBoss( floor, c, message, m, false );
    //occupied = true;
    //pathable = false;
    //occupantColor = c;
    //occupantText = message;
    //isBoss = true;
    //multipleBoss = multiple;
    //zoo.addBossToList(m);
    //addBossProgressSwitch( floor );
  }
  
  public void placeBoss( int floor, color c, String message, Monster m, boolean multiple )
  {
    occupied = true;
    pathable = false;
    occupantColor = c;
    occupantText = message;
    isBoss = true;
    multipleBoss = multiple;
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
        if( keys[i] == Key.CHARIS )
        {
          party.addToInventory( new Item( Key.CHARIS ) );
          advanceText("Father Charis's Key opens the door.");
        }
        else if( keys[i] == Key.CHARIS_NOTES )
        {
          advanceText("USED FATHER CHARIS'S NOTES");
        }
        else
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
      case CHARIS: return "The door has Father Charis's seal.";
      case CHARIS_NOTES: return "THIS IS WHERE THE NOTES ARE USED";
      default: return "A strange door...";
    }
  }
  
  public void drawTile(int xPos, int yPos)
  {
    rectMode(CORNER); imageMode(CORNER);
    if(obj!=Object.NONE)  //tiles with objects will fill with the color of the last pathable tile above it (or below, in case of screen wrap)
      fill(safeColor);
    else
    {
      fill(tileColor);
      if(pathable && type!=TileType.DOORSTEP)
        safeColor=tileColor;
      else if(type == TileType.WALL)
        safeColor=#C8C8C8;
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
    else if(type == TileType.WOOD)
      image(tileImage[57],xPos,yPos);
    else if(type == TileType.WOOD_DARK)
      image(tileImage[58],xPos,yPos);
    else if(type == TileType.WOOD_LIGHT)
      image(tileImage[59],xPos,yPos);
    else if(type == TileType.S_GLASS)
      image(tileImage[43],xPos,yPos);
    else if(type == TileType.DOOR)
      image(tileImage[39],xPos,yPos);
    else if(type == TileType.DOOR_GATE)
      image(tileImage[41],xPos,yPos);
    else if(type == TileType.PORTCULLIS)
      image(tileImage[54],xPos,yPos);
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
    else if(type == TileType.STAIR)
      image(tileImage[40],xPos,yPos);
    else if(type == TileType.STAIR_DOOR)
      image(tileImage[38],xPos,yPos);
    else if(type == TileType.GARGOYLE)
      image(tileImage[51],xPos,yPos);
    else if(type == TileType.GARGOYLE_DARK)
      image(tileImage[52],xPos,yPos);
    else if(type == TileType.WEREWOLF_WHITE)
      image(tileImage[60],xPos,yPos);
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
    if( type == TileType.DOOR || type == TileType.PORTCULLIS )
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
  EMPTY, EVENT, SAFE,
  FLOOR, FLOOR_RD, FLOOR_BL,
  GRASS, DIRT, FLOWER, WATER,
  TREE, DARK_TREE, TREE_PATH,
  WOOD, WOOD_DARK, WOOD_LIGHT,
  DARK, BLACK_WALL,
  WALL, SECRET_WALL, DARK_WALL, SECRET_DARK_WALL, SAND_WALL,
  DOOR, DOOR_GATE, PORTCULLIS, DOORSTEP,
  GRAVE, S_GLASS, GARGOYLE, GARGOYLE_DARK, WEREWOLF_WHITE,
  CAMP, MERCHANT, SHOP, SELL,
  STAIR, STAIR_DOOR
}

public enum Key //special items for interactive tiles
{
  COPPER_KEY, SKELETON_KEY, IRON_KEY, BRASS_KEY, 
  CHARIS, CHARIS_NOTES, NONE
}

public enum Object //tile has an object (still pathable)
{
  CHEST, CHEST_GOLD, CHEST_DARK,
  SIGN, SIGN_E, SIGN_F, SIGN_D, SIGN_I,
  SAVEPOINT, FAKE_SAVE,
  BARREL, BARREL2,
  NONE
}
