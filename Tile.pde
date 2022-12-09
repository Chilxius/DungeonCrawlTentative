static color safeColor = #FFFFFF;

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
  
  TileType type;
  Object obj;
  
  public Tile()
  {
    this(1,1,color(255),true,false,false); 
  }
  
  public Tile( int X, int Y, char t )
  {
    x = X;
    y = Y;
    occupied = false;
    safe = false;
    occupantColor = color(255);
    
    switch(t)
    {
      case '#':type=TileType.WALL;break;
      case '~':type=TileType.GRASS;break;
      case '+':type=TileType.DOOR;break;
      case 'w':type=TileType.WATER;break;
      case '%':type=TileType.FLOWER;break;
      case 'T':type=TileType.TREE;break;
      case 't':type=TileType.TREE_PATH;break;
      case 'D':type=TileType.DARK_TREE;break;
      //different key types
      case 'c':
      case 'i':
      case 's':type=TileType.DOORSTEP;safe=true;break;
      case '.':type=TileType.SAFE;safe=true;break;
      default :type=TileType.EMPTY;safe=true;break;
    }
    
    switch(t)  //For objects
    {
      case '=':obj=Object.CHEST;type=TileType.SAFE;break;
      case '?':obj=Object.SIGN;type=TileType.SAFE;break;
      case '*':obj=Object.SAVEPOINT;type=TileType.SAFE;break;
      default: obj=Object.NONE;break;
    }
    
    setTraitsByType(t);
  }
  
  private void setTraitsByType(){setTraitsByType(' ');}
  
  private void setTraitsByType(char t)
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
      case SAFE: {
        tileColor = safeColor;
        pathable = true;
        interactive = false;
        event = false; safe = true; break;
      }
      case FLOWER:
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
        addToProgressSwitches();
        break;
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
  
  void addToProgressSwitches()
  {
    doorSwitches[doorSwitchCount++] = new ProgressSwitch( SwitchType.DOOR, x, y );
  }
  
  public void placeOccupant( color c, String message )
  {
    occupied = true;
    pathable = false;
    occupantColor = c;
    occupantText = message;
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
      default: return "A strange door...";
    }
    
  }
  
  /*public void drawTile() //old version
  {
    fill(tileColor);noStroke();
    rect(x*30,y*30,30,30);
  }*/
  
  public void drawTile(int xPos, int yPos)
  {
    rectMode(CORNER);
    if(obj!=Object.NONE)  //tiles with objects will fill with the color of the last pathable tile above it
      fill(safeColor);
    else
    {
      fill(tileColor);
      if(pathable && type!=TileType.DOORSTEP)
        safeColor=tileColor;
      else if(type == TileType.WALL)
        safeColor=#FFFFFF;
    }
    noStroke();
    rect(xPos,yPos,30,30);
    if(type == TileType.WALL)
    {
      stroke(150); strokeWeight(1);
      line(xPos,yPos,xPos+30,yPos);
      line(xPos,yPos+15,xPos+30,yPos+15);
      line(xPos+7.5,yPos,xPos+7.5,yPos+15);
      line(xPos+22.5,yPos,xPos+22.5,yPos+15);
      line(xPos,yPos+15,xPos,yPos+30);
      line(xPos+15,yPos+15,xPos+15,yPos+30);
      line(xPos+30,yPos+15,xPos+30,yPos+30);
    }
    else if(type == TileType.FLOWER)
    {
      noStroke();
      fill(255,50,50); ellipse(xPos+4.75,yPos+7.5,9,6);
      fill(255,50,50); ellipse(xPos+4.75,yPos+7.5,6,9);
      fill(250,250,0); ellipse(xPos+4.75,yPos+7.5,3,3);
      
      fill(255,50,50); ellipse(xPos+10.75,yPos+22.5,9,6);
      fill(255,50,50); ellipse(xPos+10.75,yPos+22.5,6,9);
      fill(250,250,0); ellipse(xPos+10.75,yPos+22.5,3,3);
      
      fill(255,50,50); ellipse(xPos+19.25,yPos+7.5,9,6);
      fill(255,50,50); ellipse(xPos+19.25,yPos+7.5,6,9);
      fill(250,250,0); ellipse(xPos+19.25,yPos+7.5,3,3);
      
      fill(255,50,50); ellipse(xPos+25.25,yPos+22.5,9,6);
      fill(255,50,50); ellipse(xPos+25.25,yPos+22.5,6,9);
      fill(250,250,0); ellipse(xPos+25.25,yPos+22.5,3,3);
    }
    else if(type == TileType.WATER)
    {
      stroke(220,220,255); strokeWeight(1);
      curve(xPos,yPos+30+tileAnimation/4,xPos+3.75,yPos+7.5,xPos+15,yPos+7.5,xPos+30,yPos-18.75);
      curve(xPos,yPos+67.5,xPos+11.25,yPos+18.75,xPos+26.35,yPos+18.75,xPos+30,yPos-18.75-tileAnimation/6);
    }
    else if(type == TileType.TREE || type == TileType.DARK_TREE)
    {
      strokeWeight(1);
      if(type==TileType.DARK_TREE)
      {
        //fill(85,65,25); rect(xPos-3,yPos+5,7,13);
        //fill(0,160,0); stroke(0,140,0); triangle(xPos+1.5,yPos-15,xPos-9.5,yPos+10,xPos+10.5,yPos+10);
        fill(85,65,25); noStroke(); rect(xPos+11,yPos+5,7,13);
        fill(0,160,0); stroke(0,140,0); triangle(xPos+15.5,yPos-15,xPos+2.5,yPos+10,xPos+25.5,yPos+10);
      }
      fill(88,68,28); noStroke(); rect(xPos+1.5,yPos+10,7,16);
      fill(0,180,0); stroke(0,140,0);  triangle(xPos+5,yPos-10,xPos-5,yPos+15,xPos+15,yPos+15);
      fill(90,70,30); noStroke(); rect(xPos+16.5,yPos+15,7,13);
      fill(0,200,0); stroke(0,140,0);  triangle(xPos+20,yPos-5,xPos+10,yPos+20,xPos+30,yPos+20);
    }
    else if(type == TileType.TREE_PATH)
    {
      strokeWeight(1);
      fill(88,68,28); noStroke(); rect(xPos+1.5,yPos+10,7,16);
      fill(0,180,0); stroke(0,160,0); triangle(xPos+5,yPos-10,xPos-5,yPos+15,xPos+15,yPos+15);
      fill(90,70,30); noStroke(); rect(xPos+16.5,yPos+15,7,13);
      fill(0,200,0); stroke(0,160,0); triangle(xPos+20,yPos-5,xPos+10,yPos+20,xPos+30,yPos+20);
    }
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
    {
      strokeWeight(1);
      fill(88,68,28); noStroke(); rect(xPos+1.5,yPos+10,7,16);
      fill(0,180,0); stroke(0,160,0); triangle(xPos+5,yPos-10,xPos-5,yPos+15,xPos+15,yPos+15);
      fill(90,70,30); noStroke(); rect(xPos+16.5,yPos+15,7,13);
      fill(0,200,0); stroke(0,160,0); triangle(xPos+20,yPos-5,xPos+10,yPos+20,xPos+30,yPos+20);
    }
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
}

public enum TileType
{
  EMPTY, WALL, GRASS, EVENT, FLOWER, WATER, TREE, DARK_TREE, TREE_PATH,
  DOOR, DOORSTEP, SAFE
}

public enum Key //special items for interactive tiles
{
  COPPER_KEY, SKELETON_KEY, IRON_KEY, NONE
}

public enum Object //tile has an object (still pathable)
{
  CHEST, SIGN, SAVEPOINT,
  NONE
}
