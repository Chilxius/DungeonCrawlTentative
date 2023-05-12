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
