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
  
  //Combine existing bomb kits  (this is getting verbose)
  public void consolidateBombKit()
  {
    //Previous kit
    int existingKitIndex = -1; //<>//
    //Find kit's index
    for(int i = 0; i < party.keyInventory.length; i++)
    {
      if( isBombKit( party.keyInventory[i] ) )
      {
        existingKitIndex = i;
        break;
      }
    }
    //No kit - leave method
    if( existingKitIndex == -1 )
      return;
    
    keyType = fusedKit( party.keyInventory[existingKitIndex] );
    party.keyInventory[existingKitIndex] = Key.NONE;
  }
  
  public Key fusedKit( Key old )
  {
    if( keyType == Key.F )
    {
      if( old == Key.I ) return Key.FI;
      if( old == Key.A ) return Key.FA;
      if( old == Key.W ) return Key.FW;
      if( old == Key.IA ) return Key.FIA;
      if( old == Key.IW ) return Key.FIW;
      if( old == Key.AW ) return Key.FAW;
      if( old == Key.IAW ) return Key.FIAW;
    }
    else if( keyType == Key.I )
    {
      if( old == Key.F ) return Key.FI;
      if( old == Key.A ) return Key.IA;
      if( old == Key.W ) return Key.IW;
      if( old == Key.FA ) return Key.FIA;
      if( old == Key.FW ) return Key.FIW;
      if( old == Key.AW ) return Key.IAW;
      if( old == Key.FAW ) return Key.FIAW;
    }
    else if( keyType == Key.A )
    {
      if( old == Key.F ) return Key.FA;
      if( old == Key.I ) return Key.IA;
      if( old == Key.W ) return Key.AW;
      if( old == Key.FI ) return Key.FIA;
      if( old == Key.FW ) return Key.FAW;
      if( old == Key.IW ) return Key.IAW;
      if( old == Key.FIW ) return Key.FIAW;
    }
    else if( keyType == Key.W )
    {
      if( old == Key.F ) return Key.FW;
      if( old == Key.I ) return Key.IW;
      if( old == Key.A ) return Key.AW;
      if( old == Key.FI ) return Key.FIW;
      if( old == Key.FA ) return Key.FAW;
      if( old == Key.IA ) return Key.IAW;
      if( old == Key.FIA ) return Key.FIAW;
    }
    
    println("ISSUE COMBINING BOMB KIT");
    return old;
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
  
  public String shopString( int p )
  {
    return name+": "+p+" Gold";
  }
  
  public String usableByText()
  {
    return "SHOULD NOT DISPLAY FOR ITEMS";
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
    case CHEESE: return "pungent wheel of cheese";
    case DRAGON: return "Dragon Key";
    case GATE: return "Iron Gate Key";
    case CHARIS_NOTES: return "notebook with Charis's seal";
    case GRAVE_NOTES: return "Charis and Pavel's notes";
    case PASSPORT: return "Passport Documents";
    case GRAVE: return "Graveyard Girl's Key";
    case CAVE: return "Long Metal Key";
    
    case F: return "Fire Bomb Kit";
    case I: return "Ice Bomb Kit";
    case A: return "Acid Bomb Kit";
    case W: return "Wind Bomb Kit";
    case FI: return "Fire and Ice Bomb Kit";
    case FA: return "Fire and Acid Bomb Kit";
    case FW: return "Fire and Wind Bomb Kit";
    case IA: return "Ice and Acid Bomb Kit";
    case IW: return "Ice and Wind Bomb Kit";
    case AW: return "Acid and Wind Bomb Kit";
    case FIA: return "Fire/Ice/Acid Bomb Kit";
    case FIW: return "Fire/Ice/Wind Bomb Kit";
    case FAW: return "Fire/Acid/Wind Bomb Kit";
    case IAW: return "Ice/Acid/Wind Bomb Kit";
    case FIAW: return "Complete Bomb Kit";
    
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
    case "CHEESE": return Key.CHEESE;
    case "CHARIS_NOTES": return Key.CHARIS_NOTES;
    case "GRAVE_NOTES": return Key.GRAVE_NOTES;
    case "BRASS_KEY": return Key.BRASS_KEY;
    case "GATE": return Key.GATE;
    case "DRAGON": return Key.DRAGON;
    case "PASSPORT": return Key.PASSPORT;
    case "GRAVE": return Key.GRAVE;
    case "CAVE": return Key.CAVE;
    
    case "F":    return Key.F;
    case "I":    return Key.I;
    case "A":    return Key.A;
    case "W":    return Key.W;
    case "FI":   return Key.FI;
    case "FA":   return Key.FA;
    case "FW":   return Key.FW;
    case "IA":   return Key.IA;
    case "IW":   return Key.IW;
    case "AW":   return Key.AW;
    case "FIA":  return Key.FIA;
    case "FIW":  return Key.FIW;
    case "FAW":  return Key.FAW;
    case "IAW":  return Key.IAW;
    case "FIAW": return Key.FIAW;
    
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
