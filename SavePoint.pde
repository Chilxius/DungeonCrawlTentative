class SavePoint
{
  int X;
  int Y;
  int floor;
  
  public SavePoint()
  {
    this(1,1,0);
  }
  
  public SavePoint(  int f, int xPos, int yPos )
  {
    X = xPos;
    Y = yPos;
    floor = f;
  }
}
