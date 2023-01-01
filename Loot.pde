//For the contents of chests
class Loot
{
  int xPos;
  int yPos;
  Item item;
  String message;
  
  public Loot()
  {
    this( 0, 0, new Item(), "This is an ERROR" );
  }
  
  public Loot( int x, int y, Item i )
  {
    this( x, y, i, "You find a " + i );
  }
  
  public Loot( int x, int y, Key k )
  {
    this( x, y, new Item(k), "You find " + indefArticle(k.toString()) + " " + keyName(k) );
  }
  
  public Loot( int x, int y, Item i, String m )
  {
    xPos = x;
    yPos = y;
    item = i;
    message = m;
  }
}
