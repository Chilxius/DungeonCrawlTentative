class SavePoint
{
  int X;
  int Y;
  int floor;
  
  public SavePoint()
  {
    this(1,1,0);
  }
  
  public SavePoint( int xPos, int yPos, int f )
  {
    X = xPos;
    Y = yPos;
    floor = f;
  }
}
