//This class will handle the monsters that appear in the game.
//Bosses are created along with the map, but their moves are
//handled here. These objects are reused, so they should be
//copied via constructors instead of referenced.

class Beastiary
{
  Monster [][] list;
  Monster [] boss;
  int bossIndex = 0;
  int addBossIndex = 0;
  //[danger level][creature number]
  
  public Beastiary()
  {
    boss = new Monster[bossCount]; //TEMPORARY
    list = new Monster[5][5]; //first array size is temporary
    
    //Name, Image, Health, Str, Dex, Con, Mag, Wil, Spd, Gold, Weakness
    list[0][0] = new Monster("Error Rat","019.png",1,1,1,1,0,1,1,0,AttackType.NONE);
    list[0][1] = new Monster();
    list[0][2] = new Monster();
    list[0][3] = new Monster();
    list[0][4] = new Monster();
    
    list[1][0] = new Monster("Rat", "BrownRat.png",  4, 3, 2, 1, 0, 1, 2, 0, AttackType.FIRE);
      list[1][0].attacks[0] = new Attack("squeaks.");
      list[1][0].attacks[1] = new Attack("scurries.");
      list[1][0].attacks[2] = new Attack("bites.", 30, false);
      list[1][0].attacks[3] = new Attack("bites.", 30, false);
      list[1][0].attacks[4] = new Attack("bites.", 30, false);
    list[1][1] = new Monster("Tiny Rat", "GreyRat.png",  1, 1, 1, 1, 0, 1, 4, 0, AttackType.FIRE);
      list[1][1].attacks[0] = new Attack("squeaks.");
      list[1][1].attacks[1] = new Attack("scurries.");
      list[1][1].attacks[2] = new Attack("bites.", 20, false);
      list[1][1].attacks[3] = new Attack("bites.", 20, false);
      list[1][1].attacks[4] = new Attack("bites.", 20, false);
    list[1][2] = new Monster("Large Rat", "DarkRat.png",  7, 4, 2, 1, 0, 1, 1, 0, AttackType.FIRE);
      list[1][2].attacks[0] = new Attack("squeaks.");
      list[1][2].attacks[1] = new Attack("scurries.");
      list[1][2].attacks[2] = new Attack("bites.", 35, false);
      list[1][2].attacks[3] = new Attack("bites.", 35, false);
      list[1][2].attacks[4] = new Attack("bites.", 35, false);
    list[1][3] = new Monster();
    list[1][4] = new Monster();
    
    /*
    list[1][0] = new Monster("GreenDragon",  "GreenDragon.png",  10,5,2,3,5,2,2,10,AttackType.NONE);
      list[1][0].attacks[0] = new Attack("rubbs its tummy.");
      list[1][0].attacks[1] = new Attack("rubbs its tummy.");
      list[1][0].attacks[2] = new Attack("claws at you.", 35, false);
      list[1][0].attacks[3] = new Attack("breathes fire.", 40, true, false, AttackType.FIRE);
      list[1][0].attacks[4] = new Attack("breathes fire.", 40, true, false, AttackType.FIRE);
    list[1][1] = new Monster("StoneGargoyle","StoneGargoyle.png",12,4,4,3,0,1,2,0,AttackType.HOLY);
      list[1][1].attacks[0] = new Attack("is still.");
      list[1][1].attacks[1] = new Attack("inches closer.");
      list[1][1].attacks[2] = new Attack("bites.", 40, false);
      list[1][1].attacks[3] = new Attack("claws at you.", 35, false);
      list[1][1].attacks[4] = new Attack("throws a stone.", 35,  false);
    list[1][2] = new Monster("Green Squid",  "GreenSquid.png",    8,2,6,2,0,1,3,0,AttackType.NONE);
      list[1][2].attacks[0] = new Attack("wriggles and writhes.");
      list[1][2].attacks[1] = new Attack("gazes at you.");
      list[1][2].attacks[2] = new Attack("bites.", 40, false);
      list[1][2].attacks[3] = new Attack("lashes at you.", 35, false);
      list[1][2].attacks[4] = new Attack("shoots ink.", 20, false, false, AttackStat.MAG);
    list[1][3] = new Monster();
    list[1][4] = new Monster();
    */
  }
  
  public void addBossToList( Monster m )
  {
    boss[addBossIndex] = m;
    addBossIndex++;
  }
  
  public Monster monsterByDanger( int d )
  {
    return list[int(d-48)][int(random(0,5))];
  }
}
