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
  
  public ProgressSwitch( SwitchType t, int xInput, int yInput )
  {
    this( t, xInput, yInput, 0 );
  }
  
  public ProgressSwitch( SwitchType t, int xInput, int yInput, int floorInput )
  {
    type = t;
    X = xInput;
    Y = yInput;
    floor = 0;
    active = true;
  }
  
  public void switchOff()
  {
    active = false;
  }
}

public enum SwitchType
{
  CHEST, DOOR, NONE
}
