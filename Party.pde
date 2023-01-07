class Party
{
  Hero [] hero = new Hero[3];
  
  protected int X, Y, floor; //dungeon level
  Key [] keyInventory = new Key[10];
  Item [] inventory = new Item[30];
  int gold;
  
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
    
    gold = 0;
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
  
  public boolean addToInventory( Item item ) //for normal item pickups/buys
  {
    return addToInventory( item, false );
  }
  
  public boolean addToInventory( Item item, boolean loadingFile) //for loading save files
  {
    if( item.keyType != Key.NONE )
    {
      addToKeys(item.keyType);
      return true;
    }
    for(int i = 0; i < inventory.length; i++)
      if( inventory[i].value == 0 )
      {
        if(item.value == 10) item.name = theStuff.breadName();
        if(item instanceof Item) inventory[i] = new Item( item );    //don't like this, but it seems to work
        if(item instanceof Equipment) inventory[i] = new Equipment( (Equipment)item );
        advanceText("You recieve " + indefArticle(item.name) + " " + item );
        if( !loadingFile && inventory[i] instanceof Equipment ) //Checks if the item is a weapon or armor
        {                                                       //Should not trigger during file load
          newEquip = (Equipment)item; //Should be able to safely assume that item is an instance of Equipment
          display = Display.EQUIP; //Set display to equip mode
          newEquipIndex = i;
        }
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
  
  public float heroX( int h )
  {
    if( h ==0 )
      return width/5;
    if( h == 1 )
      return width/2;
    if( h == 2 )
    return width * 0.8;

    println("ERROR IN HERO X METHOD");
    return 0;
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
        }
        else if( i.value%12==0) //potion
        {
          int amount = 0;
          if( type == 12 ) //health potion heals 50% of max hp
          {
            amount = hero[heroChoice].maxHp/2;
            hero[heroChoice].heal(amount);
          }
          else if( type == 24 ) //mana potion recovers 40% of max mp and 10% hp
          {
            amount = int(hero[heroChoice].maxMp*0.4);
            hero[heroChoice].heal(hero[heroChoice].maxHp/10);
            hero[heroChoice].healMana(amount);
          }
          else if( type == 36 ) //vapor potion recovers 40% hp for each hero
          {
            hero[0].heal(int(hero[0].maxHp*0.4),true);
            hero[1].heal(int(hero[1].maxHp*0.4),true);
            hero[2].heal(int(hero[2].maxHp*0.4),true);
          }
          else if( type == 48 )
          {
            hero[heroChoice].heal(hero[heroChoice].maxHp);
            hero[heroChoice].healMana(hero[heroChoice].maxMp);
          }
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
  
  public void healAll()
  {
    hero[0].fullHeal();
    hero[1].fullHeal();
    hero[2].fullHeal();
  }
}
