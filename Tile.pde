static color safeColor = #C8C8C8;
//static color previousColor = #000000;

//Key:  D-dark tree    T-tree    t-secret tree    #-wall      =-chest    ?-sign    *-save crystal  •-fake crystal
//       -darkness     £-darkness wall (alt+3)    3-dark wall 5-sandstone wall     [-barrel        ©-werewolf statue (alt+©)
//      G-gargoyle     R-dark gargoyle            W-wood      ∑-dark wood (alt+w)     „-light wood (alt+shift+w)
//      .-stone floor  r-red floor  ∫-blue floor

//      +-locked door  _-safe path  w-water       g-grave   &-stained glass    @-campsite/tavern
//      c-copper key   i-iron key   s-skel key    b-brass key   ç-crypt key    ˝-gate key (alt+shift+g)  ~-grass    `-dirt    ,-dark dirt
//      6-cave        §-brown cave
//      $-secret wall   ¢-secret dark wall (alt+4)

//      >-Stairs    <-Door(stairs)

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
      //case '@':type=TileType.CAMP;break;
      case '#':type=TileType.WALL;break;
      case '$':type=TileType.SECRET_WALL;break;
      case 'ş':type=TileType.WALL_CRACK;break; //ş
      case '3':type=TileType.DARK_WALL;break;
      case '‹':type=TileType.DARK_CRACK;break; //alt+shift+3
      case '¢':type=TileType.SECRET_DARK_WALL;break; //alt+4
      case '›':type=TileType.DARK_WALL_CLIMBABLE;break; //shift+alt+4
      case '4':type=TileType.SAND_WALL;break;
      case '6':type=TileType.CAVE; break;
      case '░':type=TileType.CAVE_DOOR; break;
      case '▒':type=TileType.CAVE_DOOR_OPEN; break;
      case '§':type=TileType.CAVE_BROWN; break; //alt+6
      case 'ﬂ':type=TileType.CAVE_HONEY; break; //alt+shift+6
      case 'ö':type=TileType.COMB; break;
      case 'Ö':type=TileType.COMB_FULL; break;
      case '~':type=TileType.GRASS;break;
      case '¨':type=TileType.GRASS_DARK;break; //alt+u+?
      case '`':type=TileType.DIRT;break;
      case ',':type=TileType.DIRT_DARK;break; //alt+d
      case '+':type=TileType.DOOR;break;
      case '∏':type=TileType.DOOR_GATE;break; //shift+alt+p
      case 'π':type=TileType.PORTCULLIS;break;
      //case '░':type=TileType.DOOR_FRAME;break;
      case '‰':type=TileType.BIG_RAT;break; //shift+alt+r
      case 'w':type=TileType.WATER;break;
      case '…':type=TileType.RAPIDS;break;  //alt+;
      case 'Ú':type=TileType.RAPIDS_UP;break; //alt+shift+;
      case 'æ':type=TileType.RAPIDS_LEFT;break; //alt+'
      case 'Æ':type=TileType.RAPIDS_RIGHT;break; //alt+shift+'
      case '%':type=TileType.FLOWER;break;
      case 'ﬁ':type=TileType.FLOWER_BLUE;break; //alt+shift+7
      case '∞':type=TileType.CROP;break;
      case 'T':type=TileType.TREE;break;
      case 't':type=TileType.TREE_PATH;break;
      case 'D':type=TileType.DARK_TREE;break;
      case 'Y':type=TileType.DEAD_TREE;break;
      case 'y':type=TileType.DEAD_TREE_PATH;break;
      //case 'g':type=TileType.GRAVE;break;
      case '&':type=TileType.S_GLASS;break;
      case '‡':type=TileType.SECRET_GLASS;break;
      case '>':type=TileType.STAIR;break;
      case '<':type=TileType.STAIR_DOOR;break;
      case '≤':type=TileType.CURTAIN;break;
      case '¯':type=TileType.CURTAIN_RED;break; //alt+shift+,
      case 'M':type=TileType.STAIR_WOOD;break;
      case ' ':type=TileType.DARK;break;
      case '£':type=TileType.BLACK_WALL;break;
      case 'G':type=TileType.GARGOYLE;break;
      case 'R':type=TileType.GARGOYLE_DARK;break;
      case 'J':type=TileType.GARGOYLE_JADE;break;
      case '©':type=TileType.WEREWOLF_WHITE;break;
      case 'W':type=TileType.WOOD;break;
      case '∑':type=TileType.WOOD_DARK;break;
      case '„':type=TileType.WOOD_LIGHT;break;
      case '⁄':type=TileType.WOOD_CRACK;break; //alt+shift+1
      case 'Ç':type=TileType.CRATE;break; //alt+shift+c
      case 'B':type=TileType.BOOK;break;
      case 'ß':type=TileType.BOOK_EMPTY;break; //shift+s
      case 'Í':type=TileType.BOOK_SECRET;break; //shift+alt+s
      case '(':type=TileType.TILE_ROOF;break;
      case ')':type=TileType.TILE_BLUE;break;
      //case '|':type=TileType.RUBBLE;break;
      case 'ı':type=TileType.BK_BOOK;break; //shift+alt+b
      case '¬':type=TileType.BL_BOOK;break; //alt+l
      case 'Ò':type=TileType.GAME;break; //alt+shift+l
      case '≈':type=TileType.CHAIN;break; //alt+x
      case '˛':type=TileType.CHAIN_HOLE;break; //alt+shift+x
      case '^':type=TileType.HILL;break;
      case 'ø':type=TileType.HILL_CAVE;break; //alt+o
      case '»':type=TileType.AUTO_DOOR;break;
      case 'Œ':type=TileType.AUTO_CAVE_DOOR;break; 
      case 'Ā':type=TileType.STALAGMITE;break; //U+0100
      //different key types
      case 'c': // copper
      case 'ç':
      case 'i': // iron
      case 's':
      case 'k':
      case '˝': // shift+alt+g (gatehouse key)
      case '˚': // shift+k (Father Charis's notes)
      case '': // shift+alt+k (Gravekeeper's notes)
      case '˙': // alt+h (Cheese)
      case '‘': // alt+] (Passport)
      case '¥': // (yen) (Graveyard Girl)
      case '“': // alt+[ (Cave key)
      case 'b':type=TileType.DOORSTEP;safe=true;break;
      case '.':type=TileType.FLOOR;safe=false;break;
      case 'ˇ':type=TileType.TILE;safe=false;break; //alt+shift+t
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
      case '≥':obj=Object.CHEST_BONE;type=TileType.SAFE;break; //alt+.
      case '˘':obj=Object.CHEST_HONEY;type=TileType.SAFE;break; //alt+shift+.
      case '?':obj=Object.SIGN;type=TileType.SAFE;break;
      case '/':obj=Object.SIGN_E;type=TileType.SAFE;break;
      case '÷':obj=Object.SIGN_F;type=TileType.SAFE;break; //alt+/
      case '¿':obj=Object.SIGN_D;type=TileType.SAFE;break; //shift+alt+/
      case 'ˆ':obj=Object.SIGN_I;type=TileType.SAFE;break; //shift+alt+i
      case '*':obj=Object.SAVEPOINT;type=TileType.SAFE;break;
      case '•':obj=Object.FAKE_SAVE;type=TileType.SAFE;break; //alt+8
      case '[':obj=Object.BARREL;type=TileType.SAFE;break;
      case ']':obj=Object.BARREL2;type=TileType.SAFE;break;
      case '{':obj=Object.BARREL_H;type=TileType.SAFE;break;
      case 'g':obj=Object.GRAVE;type=TileType.SAFE;break;
      case '|':obj=Object.RUBBLE;type=TileType.RUBBLE_OBJ;break;
      case '@':obj=Object.TENT;type=TileType.SAFE;break;
      case '€':obj=Object.BED;type=TileType.SAFE;break;
      case 'V':obj=Object.GARGOYLE;type=TileType.SAFE;break;
      case '¶':obj=Object.BROKE_GLASS;break; //alt+7
      case '}':obj=Object.CRATE_OBJ;type=TileType.CRATE_OBJ;break;
      case '╚':obj=Object.FENCE_CORNER;type=TileType.FENCE_OBJ;break; //
      case '╝':obj=Object.FENCE_CORNER2;type=TileType.FENCE_OBJ;break; //
      case '═':obj=Object.FENCE_HORIZONTAL;type=TileType.FENCE_OBJ;break; //
      case '║':obj=Object.FENCE_VERTICAL;type=TileType.FENCE_OBJ;break; //
      case 'ƛ':obj=Object.STALAGMITE;type=TileType.STALAGMITE_OBJ;break; //U+019B
      default: obj=Object.NONE;break;
    }
    
    setTraitsByType(t,fl);
    //if( obj != Object.NONE )
     // tileColor = previousColor;
    //previousColor = tileColor;
    //if( obj == Object.SIGN_E)
    //  println( "Prev: " + previousColor + "  Current: "+ tileColor );
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
      case TILE: 
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
      case AUTO_DOOR:
      case AUTO_CAVE_DOOR:
        tileColor = color(0);
        break;
      case DARK_WALL: 
        tileColor = color(200);
        pathable = false;
        break;
      case SAND_WALL:
        tileColor = color(190,170,130);
        pathable = false;
        break;
      case CHAIN:
      case CHAIN_HOLE:
        pathable = false;
        break;
      case SECRET_DARK_WALL: 
      case DARK_CRACK:
        tileColor = color(200);
        break;
      case BLACK_WALL:
        tileColor = color(0);
        pathable = false;
        break;
      case CAVE:
      case CAVE_DOOR:
        tileColor = color(120);
        pathable = false;
        break;
      case CAVE_DOOR_OPEN:
        tileColor = color(120);
        pathable = true;
        break;
      case CAVE_BROWN:
      case CAVE_BROWN_DOOR:
        tileColor = color(100,70,0);
        pathable = false;
        break;
      case CAVE_BROWN_DOOR_OPEN:
        tileColor = color(100,70,0);
        pathable = true;
        break;
      case CAVE_HONEY:
        tileColor = color(200,200,0);
        pathable = false;
        break;
      case HILL:
        //tileColor = color(#6e6d6b);
        //tileColor = color(0,180,0);
        tileColor = color(#555553);
        pathable = false;
        break;
      case HILL_CAVE:
        tileColor = color(#555553);
        pathable = true;
        break;
      case STALAGMITE:
        tileColor = color(200);
        pathable = false;
        break;
      //case RUBBLE:
      //  tileColor = color(200);
      //  pathable = false;
      //  break;
      case BL_BOOK:
      case BK_BOOK:
      case GAME:
        tileColor = color(90,70,30);
        pathable = false;
        break;
      case BOOK:
      case BOOK_EMPTY:
      case TILE_BLUE:
      case WOOD_DARK:
      case WOOD:
      case CRATE:
        tileColor = color(90,70,30);
        pathable = false;
        break;
      case WOOD_CRACK:
        tileColor = color(90,70,30);
        pathable = true;
        break;
      case BOOK_SECRET:
      case TILE_ROOF:
      case WOOD_LIGHT:
        tileColor = color(190,170,130);
        break;
      case SAFE: 
        tileColor = safeColor;
        //tileColor = color((x+y)*5%50+150,(x+y)*5%50+150,(x+y)*5%50+150);
        safe = true; break;
      case FENCE_OBJ:
        tileColor = color(0,180,0);
        pathable = false;
        break;
      case STALAGMITE_OBJ:
        tileColor = safeColor;
        pathable = false;
        break;
      case RUBBLE_OBJ:
      case CRATE_OBJ:
        tileColor = safeColor;
        pathable = false;
        //tileColor = color((x+y)*5%50+150,(x+y)*5%50+150,(x+y)*5%50+150);
        safe = true; break;
      case CAMP: 
        //tileColor = color(170,150,110);
        tileColor = safeColor;
        safe = true; break;
      case FLOWER:
      case FLOWER_BLUE:
      case GRASS:
        tileColor = color(0,180,0);
        break;
      case DIRT:
        tileColor = color(170,150,110);
        break;
      case CROP:
      case DIRT_DARK:
      case COMB:
      case COMB_FULL:
        tileColor = color(100,70,0);
        break;
      case GRAVE:
        tileColor = color(0,100,0);
        break;
      case DARK_TREE:
      case TREE:
        tileColor = color(0,180,0);
        pathable = false;
        break;
      case GRASS_DARK:
        tileColor = color(0,100,0);
        break;
      case DEAD_TREE:
        tileColor = color(0,100,0);
        pathable = false;
        break;
      case TREE_PATH: 
        tileColor = color(0,180,0);
        break;
      case DEAD_TREE_PATH: 
        tileColor = color(0,100,0);
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
      case SECRET_GLASS:
        tileColor = color(120);
        break;
      case GARGOYLE_JADE:
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
        tileColor = color(#1c8cbd);
        pathable = false;
        break;
      case RAPIDS:
      case RAPIDS_UP:
      case RAPIDS_LEFT:
      case RAPIDS_RIGHT:
        tileColor = color(#1c8cbd);
        pathable = true;
        break;
      case PORTCULLIS:
      case DOOR_GATE:
      case DOOR:
        tileColor = color(100,70,0);
        pathable = false;
        break;
      case DOOR_FRAME:
        tileColor = color(200);
        pathable = true;
        break;
      case GATE_FRAME:
        tileColor = color(100,70,0);
        pathable = true;
        break;
      case BIG_RAT:
        tileColor = color(200,150,80);
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
        else if( t == '' )
          createInteraction( Key.GRAVE_NOTES );
        else if( t == 'ç' )
          createInteraction( Key.CRYPT_KEY );
        else if( t == '‘' ) //alt+]
          createInteraction( Key.PASSPORT );
        else if( t == '¥' ) //yen
        {
          createInteraction( Key.GRAVE );
          tileColor = color(0);
        }
        else if( t == '“' ) //alt+[
        {
          createInteraction( Key.CAVE );
          tileColor = color(100,70,0);
        }
        else if( t == '˙' ) //alt+h
        {
          createInteraction( Key.CHEESE );
          tileColor = color(200,150,80);
        }
        else if( t == '˝' )
        {
          createInteraction( Key.GATE );
          tileColor = color(100,70,0);
        }
        addToProgressSwitches(floor);
        break;
      }
      case STAIR:
      case STAIR_DOOR:
      case CURTAIN:
      case CURTAIN_RED:
        tileColor = safeColor;
        break;
      case STAIR_WOOD:
        tileColor = color(90,70,30);
        break;
      default:
        tileColor = color(200,0,0);
        pathable = true;
        interactive = false;
        //event = true; break;  //WHY WAS EVENT TRUE?
        event = false; break;
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
    
    event = true;
    repeatable = true;
    eventText=i.shopString(price);
  }
  
  public void placeBuyer()
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
    //type = TileType.EVENT;
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
          SFX[0].play();
        }
        else if( keys[i] == Key.CHARIS_NOTES )
        {
          advanceText("- His notes. His work! Enter, quickly!");
          SFX[7].play();
        }
        else if( keys[i] == Key.CHEESE )
        {
          displayTextLine("It hungrily grabs the cheese from you and waddles away to enjoy it.");
          SFX[4].play();
        }
        else if( keys[i] == Key.GRAVE_NOTES )
        {
          advanceText("- TEXT FOR GRAVE NOTES");
        }
        else if( keys[i] == Key.GATE )
        {
          SFX[7].play();
          advanceText("The gate creaks open.");
        }
        else if( keys[i] == Key.PASSPORT )
        {
          SFX[8].play();
          advanceText("- Everything is in order. You may proceed.");
        }
        else if( keys[i] == Key.GRAVE )
        {
          SFX[0].play();
          advanceText("She nods in approval.");
        }
        else
        {
          advanceText("You use your " + keyName(k) + ".");
          SFX[0].play();
        }
        keys[i] = Key.NONE;
        interactive = false;
        //openDoorSound.play();
        return true;
      }
    advanceText("You lack the required item.");
    if( k != Key.CHEESE )
      SFX[2].play();
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
      case BRASS_KEY: return "An old door decorated with brass symbols.";
      case CHARIS: return "The door has Father Charis's seal.";
      case CRYPT_KEY: return "A ancient doorway.";
      case GATE: return "A solid iron gate.";
      case DRAGON: return "A door embossed with a serpentine dragon.";
      case CHARIS_NOTES: return "- Away with you! I will speak only with Brother Charis.";
      case CHEESE: return "The massive rat does not want to fight, but it does look hungry.";
      case PASSPORT: return "- Please present your documents.";
      case GRAVE: return "This gate has motifs of the Black Vanguard.";
      case CAVE: return "There is a door here with an odd keyhole.";
      default: return "A locked door.";
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
      if(pathable && type!=TileType.DOORSTEP )//&& type!=TileType.DARK)
        safeColor=tileColor;
      else if(type == TileType.WALL)
        safeColor=#C8C8C8;
      else if(type == TileType.DARK_WALL)
        safeColor=#C8C8C8;
    }
    noStroke();
    rect(xPos,yPos,30,30);
    //if(type == TileType.FLOOR )
    //  image(tileImage[100],xPos,yPos);
    if(type == TileType.WALL || type == TileType.SECRET_WALL)
      image(tileImage[0],xPos,yPos);
    else if(type == TileType.DARK_WALL || type == TileType.SECRET_DARK_WALL || type == TileType.DARK_WALL_CLIMBABLE)
      image(tileImage[49],xPos,yPos); //49
    else if(type == TileType.DARK_CRACK)
      image(tileImage[86],xPos,yPos);
    else if(type == TileType.WOOD_CRACK)
      image(tileImage[122],xPos,yPos);
    else if(type == TileType.WALL_CRACK)
      image(tileImage[123],xPos,yPos);
    else if(type == TileType.SAND_WALL)
      image(tileImage[50],xPos,yPos);
    //else if(type == TileType.RUBBLE)
    //  image(tileImage[67],xPos-5,yPos-5);
    else if(type == TileType.BK_BOOK)
    { image(tileImage[57],xPos,yPos); image(tileImage[78],xPos+5,yPos+5); }
    else if(type == TileType.BL_BOOK)
    { image(tileImage[57],xPos,yPos); image(tileImage[80],xPos+5,yPos+5); }
    else if(type == TileType.GAME)
      image(tileImage[107],xPos,yPos);
    else if(type == TileType.CAVE_BROWN)
      image(tileImage[69],xPos,yPos);
    else if(type == TileType.CAVE)
      image(tileImage[70],xPos,yPos);
    else if(type == TileType.CAVE_DOOR)
      image(tileImage[113],xPos,yPos);
    else if(type == TileType.CAVE_DOOR_OPEN || type == TileType.AUTO_CAVE_DOOR)
      image(tileImage[114],xPos,yPos);
    else if(type == TileType.CAVE_HONEY)
      image(tileImage[97],xPos,yPos);
    else if(type == TileType.COMB)
      image(tileImage[117],xPos,yPos);
    else if(type == TileType.COMB_FULL)
      image(tileImage[118],xPos,yPos);
    else if(type == TileType.HILL)
    {  image(tileImage[70],xPos,yPos); image(tileImage[98],xPos-10,yPos-10); }
    else if(type == TileType.HILL_CAVE)
      image(tileImage[99],xPos-10,yPos-10);
    else if(type == TileType.STALAGMITE)
      image(tileImage[126],xPos-5,yPos-10);
    else if(type == TileType.CAMP)
      image(tileImage[55],xPos,yPos);
    else if(type == TileType.WOOD)
      image(tileImage[57],xPos,yPos);
    else if(type == TileType.WOOD_DARK)
      image(tileImage[58],xPos,yPos);
    else if(type == TileType.WOOD_LIGHT)
      image(tileImage[59],xPos,yPos);
    else if(type == TileType.CRATE)
      image(tileImage[88],xPos,yPos);
    else if(type == TileType.TILE_ROOF)
      image(tileImage[72],xPos,yPos-4);
    else if(type == TileType.TILE_BLUE)
      image(tileImage[74],xPos,yPos-4);
    else if(type == TileType.S_GLASS||type==TileType.SECRET_GLASS)
      image(tileImage[43],xPos,yPos);
    else if(type == TileType.DOOR)
      image(tileImage[39],xPos,yPos);
    else if(type == TileType.DOOR_GATE)
      image(tileImage[41],xPos,yPos);
    else if(type == TileType.PORTCULLIS)
      image(tileImage[54],xPos,yPos);
    else if(type == TileType.DOOR_FRAME)
      image(tileImage[115],xPos,yPos);
    else if(type == TileType.GATE_FRAME)
      image(tileImage[116],xPos,yPos);
    else if(type == TileType.FLOWER)
      image(tileImage[3],xPos,yPos);
    else if(type == TileType.FLOWER_BLUE)
      image(tileImage[105],xPos,yPos);
    else if(type == TileType.CROP)
      image(tileImage[73],xPos,yPos);
    else if(type == TileType.WATER || type == TileType.RAPIDS || type == TileType.RAPIDS_UP || type == TileType.RAPIDS_LEFT || type == TileType.RAPIDS_RIGHT )
      image(tileImage[int(4+vanGogh.stage()/10)],xPos,yPos);
    else if(type==TileType.DARK_TREE)
      image(tileImage[2],xPos-10,yPos-10);
    else if(type==TileType.TREE)
      image(tileImage[1],xPos-10,yPos-10);
    else if(type==TileType.DEAD_TREE)
      image(tileImage[71],xPos-10,yPos-10);
    else if(type == TileType.TREE_PATH)
      image(tileImage[47],xPos-10,yPos-10);
    else if(type == TileType.DEAD_TREE_PATH)
      image(tileImage[71],xPos-10,yPos-10);
    else if(type == TileType.GRAVE)
      image(tileImage[42],xPos,yPos);
    else if(type == TileType.SELL)
      image(tileImage[29],xPos,yPos);
    //else if(type == TileType.MERCHANT)
    //  image(tileImage[48],xPos,yPos);
    else if(type == TileType.STAIR)
      image(tileImage[56],xPos,yPos);
    else if(type == TileType.STAIR_DOOR)
      image(tileImage[38],xPos,yPos);
    else if(type == TileType.CURTAIN )
      image(tileImage[106],xPos,yPos);
    else if(type == TileType.CURTAIN_RED )
      image(tileImage[110],xPos,yPos);
    else if(type == TileType.STAIR_WOOD)
      image(tileImage[87],xPos,yPos);
    else if(type == TileType.GARGOYLE)
      image(tileImage[51],xPos,yPos);
    else if(type == TileType.GARGOYLE_DARK)
      image(tileImage[52],xPos,yPos);
    else if(type == TileType.GARGOYLE_JADE)
      image(tileImage[53],xPos,yPos);
    else if(type == TileType.WEREWOLF_WHITE)
      image(tileImage[60],xPos,yPos);
    else if(type == TileType.BOOK)
      image(tileImage[75],xPos,yPos);
    else if(type == TileType.BOOK_EMPTY)
      image(tileImage[76],xPos,yPos);
    else if(type == TileType.BOOK_SECRET)
      image(tileImage[76],xPos,yPos);
    else if(type == TileType.CHAIN)
      image(tileImage[94],xPos,yPos);
    else if(type == TileType.CHAIN_HOLE)
      image(tileImage[96],xPos,yPos);
    else if(type == TileType.BIG_RAT)
      image(tileImage[95],xPos,yPos);
    else if(type == TileType.TILE)
      image(tileImage[109],xPos,yPos);
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
    float xPos = frameWidth/2-15;
    float yPos = 360;
    if(type == TileType.TREE_PATH)
      image(tileImage[47],xPos-10,yPos-10);
    if(type == TileType.DEAD_TREE_PATH)
      image(tileImage[71],xPos-10,yPos-10);
    if(type == TileType.SECRET_WALL)
      image(tileImage[0],xPos,yPos);
    if(type == TileType.SECRET_DARK_WALL)
      image(tileImage[49],xPos,yPos);
    if(type == TileType.DARK_CRACK)
      image(tileImage[86],xPos,yPos);
    if(type == TileType.WALL_CRACK)
      image(tileImage[123],xPos,yPos);
    if(type == TileType.WOOD_CRACK)
      image(tileImage[122],xPos,yPos);
    if(type == TileType.TILE_ROOF)
      image(tileImage[72],xPos,yPos-4);
    if(type == TileType.BOOK_SECRET)
      image(tileImage[76],xPos,yPos);
    if(type == TileType.CURTAIN)
      image(tileImage[108],xPos,yPos);
    if(type == TileType.CURTAIN_RED)
      image(tileImage[111],xPos,yPos);
    if(type == TileType.CAVE_DOOR_OPEN)
      image(tileImage[119],xPos,yPos);
    if(type == TileType.CAVE_BROWN_DOOR_OPEN)
      image(tileImage[120],xPos,yPos);
    if(obj == Object.TENT)
      image(tileImage[124],xPos,yPos);
    if(type == TileType.RAPIDS || type == TileType.RAPIDS_UP || type == TileType.RAPIDS_LEFT || type == TileType.RAPIDS_RIGHT)
    {
      push();
      tint(255,70);
      image(tileImage[int(4+vanGogh.stage()/10)],xPos,yPos);
      pop();
    }
    if(obj == Object.GARGOYLE)
      image(tileImage[51],xPos,yPos);
  }
  
  public boolean canOpen()
  {
    if( type == TileType.DOOR
    || type == TileType.PORTCULLIS
    || type == TileType.DOOR_GATE
    || type == TileType.BIG_RAT
    || type == TileType.CAVE_DOOR 
    || type == TileType.CAVE_BROWN_DOOR )
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
    if(event)
      return true;
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
  FLOOR, FLOOR_RD, FLOOR_BL, TILE,
  GRASS, GRASS_DARK, DIRT, DIRT_DARK,
  FLOWER, FLOWER_BLUE, CROP, FENCE_OBJ,
  WATER, RAPIDS, RAPIDS_UP, RAPIDS_LEFT, RAPIDS_RIGHT,
  TREE, DARK_TREE, TREE_PATH, DEAD_TREE, DEAD_TREE_PATH,
  WOOD, WOOD_DARK, WOOD_LIGHT, WOOD_CRACK, CRATE, TILE_ROOF, TILE_BLUE,
  HILL, HILL_CAVE,
  DARK, BLACK_WALL,
  CAVE, CAVE_BROWN, CAVE_DOOR, CAVE_DOOR_OPEN, CAVE_BROWN_DOOR, CAVE_BROWN_DOOR_OPEN, CAVE_HONEY,
  COMB, COMB_FULL,
  BOOK, BOOK_EMPTY, BOOK_SECRET, BL_BOOK, BK_BOOK, GAME,
  WALL, SECRET_WALL, WALL_CRACK, DARK_WALL, SECRET_DARK_WALL, DARK_WALL_CLIMBABLE, DARK_CRACK, SAND_WALL, RUBBLE_OBJ, CRATE_OBJ,
  STALAGMITE, STALAGMITE_OBJ,
  DOOR, DOOR_GATE, PORTCULLIS, DOOR_FRAME, GATE_FRAME,
  BIG_RAT, DOORSTEP,
  GRAVE, S_GLASS, SECRET_GLASS, GARGOYLE, GARGOYLE_DARK, GARGOYLE_JADE, WEREWOLF_WHITE,
  CAMP, MERCHANT, SHOP, SELL,
  STAIR, STAIR_DOOR, CURTAIN, CURTAIN_RED, STAIR_WOOD,
  CHAIN, CHAIN_HOLE,
  AUTO_DOOR, AUTO_CAVE_DOOR
}

public enum Key //special items for interactive tiles
{
  COPPER_KEY, SKELETON_KEY, IRON_KEY, BRASS_KEY, GATE,
  CHARIS, CHARIS_NOTES, GRAVE_NOTES,
  CRYPT_KEY, CHEESE,
  PASSPORT, GRAVE, CAVE,
  DRAGON, NONE,
  
  F,I,A,W,
  FI,FA,FW,IA,IW,AW,
  FIA,FIW,FAW,IAW,
  FIAW
}

public enum Object //tile has an object (still usually pathable)
{
  CHEST, CHEST_GOLD, CHEST_DARK, CHEST_BONE, CHEST_HONEY,
  SIGN, SIGN_E, SIGN_F, SIGN_D, SIGN_I,
  SAVEPOINT, FAKE_SAVE,
  BARREL, BARREL2, BARREL_H, CRATE_OBJ,
  FENCE_CORNER, FENCE_CORNER2, FENCE_HORIZONTAL, FENCE_VERTICAL,
  GRAVE, RUBBLE,
  TENT, BED,
  GARGOYLE,
  BROKE_GLASS,
  STALAGMITE,
  NONE
}
