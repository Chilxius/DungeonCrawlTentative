class Party
{
  Hero [] hero = new Hero[3];
  
  protected int X, Y, floor; //dungeon level
  Key [] keyInventory = new Key[10];
  Item [] inventory = new Item[30];
  
  public Party()
  {
    
  }
  
  public Party( Hero h0, Hero h1, Hero h2 )
  {
    hero[0] = h0;
    hero[1] = h1;
    hero[2] = h2;
    
    X = 0;
    Y = 0;
    floor = 0;
  }
  
  public void setPosition( int xPos, int yPos )
  {
    X = xPos;
    Y = yPos;
    floor = 0;
  }
  
  public void setPosition( SavePoint s )
  {
    X = s.X;
    Y = s.Y;
    floor = s.floor;
  }
  
  public Hero hero( int x )
  {
    return hero[x];
  }
  
  public boolean addToInventory( Item item )
  {
    if( item.keyType != Key.NONE )
    {
      addToKeys(item.keyType);
      return true;
    }
    for(int i = 0; i < inventory.length; i++)
      if( inventory[i].value == 0 )
      {
        inventory[i] = item;
        advanceText("You recieve " + indefArticle(item.name) + " " + item );
        return true;
      }
      
    advanceText("Your inventory is full.");
    return false;
  }
  
  public void addToKeys(Key k)
  {
    for(int i = 0;i<keyInventory.length;i++)
      if(keyInventory[i]==Key.NONE)
      {
        advanceText("You find a " + keyName(k));
        keyInventory[i] = k;
        break;
      }
  }
  
  public void sortInventory() //bubble sorts inventory by price
  {
    Item placeholder;
    for(int i = 0; i < inventory.length-1; i++)
      for(int j = i; j < inventory.length; j++)
        if(inventory[i].value < inventory[j].value)
        {
          placeholder = inventory[i];
          inventory[i] = inventory[j];
          inventory[j] = placeholder;
        }
  }
  
  public boolean hasFood()
  {
    for( Item i : inventory )
      if( i.isFood() )
        return true;
    return false;
  }
  
  public boolean hasFood( int i ) //checks for specific type of food
  {
    for( int j = 0; j < inventory.length; j++ )
      if( inventory[j].value == i*10 )
        return true;
    return false;
  }
  
  public boolean consume( int type, int heroChoice )
  {
    for( Item i : inventory )
      if( i.value==type )
      {
        if( i.value%10==0) //food
        {
          hero[heroChoice].heal(type);
          advanceText(hero[heroChoice].name + " is healed for " + type + ".");
        }
        else //potions
        {
          //to be finished
        }
        i.value=0;
        return true;
      }
      
    return false;
  }
  
  public boolean hasPotion()
  {
    for( Item i : inventory )
      if( i.isPotion() )
        return true;
    return false;
  }
    
  public boolean hasPotion( int i )
  {
    for( int j = 0; j < inventory.length; j++ ) //<>//
      if( inventory[j].value == i*12 )
        return true;
    return false;
  }
}
