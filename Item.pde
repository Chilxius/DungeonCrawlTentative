class Item
{
  String name;
  int value;
  Key keyType;
  
  public Item()
  {
    this( "Empty", 0 );
  }
  
  public Item( Item i )
  {
    name = i.name;
    value = i.value;
    keyType = i.keyType;
  }
  
  public Item( String n, int v )
  {
    name = n;
    value = v;
    keyType = Key.NONE;
  }
  
  public Item( Key k )
  {
    keyType = k;
    name = keyName(k);
  }
  
  public boolean isFood() //all foods will have unique values
  {
    //10-bread  20-pork  30-fruit  40-crab
    if(value == 10 || value == 20 || value == 30 || value == 40)
      return true;
    return false;
  }
  
  public boolean isPotion() //all potions have unique values
  {
    if(value == 12 || value == 24 || value == 36 || value == 48 )
      return true;
    return false;
  }
  
  public String toString()
  {
    return name;
  }

}
