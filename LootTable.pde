//Tables from which random chest loot is derived

class LootTable
{
  Item [][] item;
  
  public LootTable()
  {
    item = new Item[5][5];
    
    item[0][0] = new Item( "Bread", 10 );
    item[0][1] = new Item( "Bread", 10 );
    item[0][2] = new Item( "Bread", 10 );
    item[0][3] = new Item( "Health Potion", 12 );
    item[0][4] = new Item( "Salt Pork", 20 );
    
    //item[1][0] = new Equipment("Knife",2,true,1,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST,Job.MAGE);
    //item[1][1] = new Equipment("Robe",3,false,1,true);
    //item[1][2] = new Equipment("Staff",4,true,2,Job.PRIEST,Job.PRIEST);
    //item[1][3] = new Equipment("Robe",3,false,1,true);
    //item[1][4] = new Equipment("Wood Sword",4,true,3,Job.KNIGHT,Job.BARBARIAN );
    
    //item[2][0] = new Equipment( "Dagger", 4, true, 3, Job.KNIGHT, Job.THIEF );
    //item[2][1] = new Equipment( "Axe", 6, true, 4, Job.KNIGHT, Job.BARBARIAN  );
    //item[2][2] = new Equipment( "Boiled Leather", 3, false, 2, Job.KNIGHT, Job.BARBARIAN, Job.THIEF );
    //item[2][3] = new Equipment( "Darkwood Staff", 3, true, 3, Job.PRIEST, Job.MAGE );
    //item[2][4] = new Equipment( "Wool Robe", 3, false, 2, Job.KARATE, Job.PRIEST, Job.MAGE );
  }
  
  public String breadName()
  {
    switch( int(random(21)) )
    {
      case 0: return "Stale Bread";
      case 1: return "Wheat Bread";
      case 2: return "Barley Loaf";
      case 3: return "Honey Bread";
      case 4: return "Fresh Bread";
      case 5: return "Baguette";
      case 6: return "Croissant";
      case 7: return "Bagel";
      case 8: return "Flatbread";
      case 9: return "Biscotti";
      case 10: return "Biscuits";
      case 11: return "Brioche";
      case 12: return "Cornbread";
      case 13: return "Ciabatta";
      case 14: return "Focaccia";
      case 15: return "Hardtack";
      case 16: return "Pita";
      case 17: return "Rye";
      case 18: return "Pumpernickel";
      case 19: return "Scone";
      case 20: return "Sourdough";
      default: return "Bread";
    }
  }
}
