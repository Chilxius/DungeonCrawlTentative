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

  public boolean usableBy( Job j )
  {
    println("ERROR - CHECKED ITEM FOR EQUIPABILITY");
    return false;
  }
  
  public boolean isSellable()
  {
    if( value == 10 || value == 20 || value == 30 || value == 40
     || value == 12 || value == 24 || value == 36 || value == 48 || value == 0 )
     return false;
    return true;
  }
}

public String keyName( Key k )
{
  switch(k)
  {
    case COPPER_KEY: return "Copper Key";
    case SKELETON_KEY: return "Skeleton Key";
    case IRON_KEY: return "Iron Key";
    case BRASS_KEY: return "Brass Key";
    case CRYPT_KEY: return "Key to the Crypt";
    case CHARIS: return "Charis's Iron Key";
    case DRAGON: return "Dragon Key";
    case GATE: return "Iron Gate Key";
    case CHARIS_NOTES: return "notebook with Charis's seal";
    case GRAVE_NOTES: return "Charis and Pavel's notes";
    default: return "";
  }
}
  
Key stringToKey( String s )
{
  switch(s)
  {
    case "COPPER_KEY": return Key.COPPER_KEY;
    case "SKELETON_KEY": return Key.SKELETON_KEY;
    case "IRON_KEY": return Key.IRON_KEY;
    case "CRYPT_KEY": return Key.CRYPT_KEY;
    case "CHARIS": return Key.CHARIS;
    case "CHARIS_NOTES": return Key.CHARIS_NOTES;
    case "GRAVE_NOTES": return Key.GRAVE_NOTES;
    case "BRASS_KEY": return Key.BRASS_KEY;
    case "GATE": return Key.GATE;
    case "DRAGON": return Key.DRAGON;
    default: return Key.NONE;
  }
}

//Food synergy:
/* Food heals more for every other kind of food item in the invenory (+20%, +25%, +50%)
Bread:  10 / 11 / 12 / 15
Meat:   20 / 22 / 25 / 30
Fruit:  30 / 33 / 37 / 45
Crab:   40 / 44 / 50 / 60
*/
