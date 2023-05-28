//These track changes to the world, such as open chests and doors
//This class facilitats saving/loading game files

class ProgressSwitch
{
  SwitchType type;
  int X, Y, floor;
  boolean active;
  
  public ProgressSwitch()
  {
    type = SwitchType.NONE;
    X=0;
    Y=0;
    active = false;
  }
  
  public ProgressSwitch( SwitchType t, int xInput, int yInput, int floorInput )
  {
    type = t;
    X = xInput;
    Y = yInput;
    floor = floorInput;
    active = true;
  }
  
  public void switchOff()
  {
    active = false;
  }
}

public enum SwitchType
{
  CHEST, DOOR, BOSS, NONE
}

//************************//
//************************//

class SavePoint
{
  int X;
  int Y;
  int floor;
  int zone;
  
  public SavePoint()
  {
    this(1,1,0);
  }
  
  public SavePoint( int f, int xPos, int yPos )
  {
    X = xPos;
    Y = yPos;
    floor = f;
    zone = -1;
  }
  
  public SavePoint( int f, int xPos, int yPos, int z )
  {
    X = xPos;
    Y = yPos;
    floor = f;
    zone = z;
  }
}
