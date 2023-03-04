class Party
{
  Hero [] hero = new Hero[3];
  
  //String [] name = {"null","null","null"};
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
  
  public void setPosition( int f, int xPos, int yPos )
  {
    X = xPos;
    Y = yPos;
    floor = f;
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
        if(item.value == 10 && !loadingFile) item.name = theStuff.breadName();
        if(item.value == 20 && !loadingFile) item.name = theStuff.meatName();
        if(item.value == 30 && !loadingFile) item.name = theStuff.fruitName();
        if(item.value == 40 && !loadingFile) item.name = theStuff.crabName();
        if(item instanceof Item) inventory[i] = new Item( item );    //don't like this, but it seems to work
        if(item instanceof Equipment) inventory[i] = new Equipment( (Equipment)item );
        advanceText("You recieve " + indefArticle(item.name) + " " + item );
        if( !loadingFile && inventory[i] instanceof Equipment ) //Checks if the item is a weapon or armor
        {                                                       //Should not trigger during file load
          newEquip = (Equipment)item; //Should be able to safely assume that item is an instance of Equipment
          display = Display.EQUIP; //Set display to equip mode
          input = Input.HERO_SELECT;
          newEquipIndex = i;
        }
        return true;
      }
      
    advanceText("Your inventory is full.");
    return false;
  }
  
  public String nextFoodName( int type )
  {
    for(int i = 0; i< inventory.length; i++)
    {
      if( inventory[i].value == 10 && type == 0 )
        return inventory[i].name;
      if( inventory[i].value == 20 && type == 1 )
        return inventory[i].name;
      if( inventory[i].value == 30 && type == 2 )
        return inventory[i].name;
      if( inventory[i].value == 40 && type == 3 )
        return inventory[i].name;
    }
    return "ERROR";
  }
  
  public void addToKeys(Key k)
  {
    for(int i = 0;i<keyInventory.length;i++)
      if(keyInventory[i]==Key.NONE)
      {
        if(k!=Key.CHARIS)
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
  
  public float foodSynergy()
  {
    int foodTypes = 0;
    for(int i = 1; i <= 4; i++)
      if( hasFood(i) )
        foodTypes++;
    switch(foodTypes)
    {
      case 2:  return 1.1;
      case 3:  return 1.25;
      case 4:  return 1.5;
      default: return 1;
    }
  }
  
  public boolean consume( int type, int heroChoice )
  {
    for( Item i : inventory )
      if( i.value==type )
      {
        if( i.value%10==0) //food
        {
          hero[heroChoice].heal(int(type*foodSynergy()));
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
  
  public boolean needsRest()
  {
    if( hero[0].hp < hero[0].maxHp
     || hero[1].hp < hero[1].maxHp
     || hero[2].hp < hero[2].maxHp
     || hero[0].mp < hero[0].maxMp
     || hero[1].mp < hero[1].maxMp
     || hero[2].mp < hero[2].maxMp )
      return true;
    return false;
  }
  
  int averageLevel()
  {
    return (hero[0].level + hero[0].level + hero[0].level)/3;
  }
  
  void tickDownPoisons()
  {
    for(Hero h: hero)
      if(h.poisoned && h.hp > 1)
      {
        h.hp--;
        h.poison--;
        if(h.poison==0)
          h.poisoned=false;
      }
  }
  
  int sellItems() //sells all non-consumables and returns the total gold value
  {
    int result = 0;
    for( int i = 0; i < inventory.length; i++ )
    {
      if( inventory[i].isSellable() )
      {
        result += inventory[i].value;
        inventory[i] = new Item();
      }
    }
    return result;
  }
  
  boolean partyDead()
  {
    if( !hero[0].alive && !hero[1].alive && !hero[2].alive )
      return true;
    return false;
  }
}
