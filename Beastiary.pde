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
  int dangerZone = 0;
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
    
    //1 - Rat cellar
    dangerZone++;
    list[dangerZone][0] = new Monster("Rat", "SlimyRat.png",  4, 3, 2, 1, 0, 1, 2, 0, AttackType.FIRE);
      list[dangerZone][0].attacks[0] = new Attack("squeaks.");
      list[dangerZone][0].attacks[1] = new Attack("scurries.");
      list[dangerZone][0].attacks[2] = new Attack("bites.", 30, false);
      list[dangerZone][0].attacks[3] = new Attack("bites.", 30, false);
      list[dangerZone][0].attacks[4] = new Attack("bites.", 30, false);
    list[dangerZone][1] = new Monster("Tiny Rat", "GreyRat.png",  1, 1, 1, 1, 0, 1, 4, 0, AttackType.FIRE);
      list[dangerZone][1].attacks[0] = new Attack("squeaks.");
      list[dangerZone][1].attacks[1] = new Attack("scurries.");
      list[dangerZone][1].attacks[2] = new Attack("bites.", 20, false);
      list[dangerZone][1].attacks[3] = new Attack("bites.", 20, false);
      list[dangerZone][1].attacks[4] = new Attack("bites.", 20, false);
    list[dangerZone][2] = new Monster("Large Rat", "DarkRat.png",  7, 4, 2, 1, 0, 1, 2, 0, AttackType.FIRE);
      list[dangerZone][2].attacks[0] = new Attack("squeaks.");
      list[dangerZone][2].attacks[1] = new Attack("scurries.");
      list[dangerZone][2].attacks[2] = new Attack("bites.", 35, false);
      list[dangerZone][2].attacks[3] = new Attack("bites.", 35, false);
      list[dangerZone][2].attacks[4] = new Attack("bites.", 35, false);
    list[dangerZone][3] = new Monster();
    list[dangerZone][4] = new Monster();
    
    //2 - River path (north)
    dangerZone++;
    list[dangerZone][0] = new Monster("Spider",  "GreenSpider.png",  9, 5, 10, 2, 0, 2, 4, 0, AttackType.NONE);
      list[dangerZone][0].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][0].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][0].attacks[2] = new Attack("bites your foot.", 35, false, Debuff.POISON);
      list[dangerZone][0].attacks[3] = new Attack("bites your arm.", 40, false, Debuff.POISON);
      list[dangerZone][0].attacks[4] = new Attack("bites your leg.", 45, false, Debuff.POISON);
    list[dangerZone][1] = new Monster("Large Rat", "DarkRat.png",    7, 4, 2, 1, 0, 1, 2, 0, AttackType.FIRE);
      list[dangerZone][1].attacks[0] = new Attack("squeaks.");
      list[dangerZone][1].attacks[1] = new Attack("scurries.");
      list[dangerZone][1].attacks[2] = new Attack("bites.", 40, false);
      list[dangerZone][1].attacks[3] = new Attack("bites.", 40, false);
      list[dangerZone][1].attacks[4] = new Attack("bites.", 40,  false);
    list[dangerZone][2] = new Monster();
    list[dangerZone][3] = new Monster();
    list[dangerZone][4] = new Monster();
    
    //3 - River path (south)
    dangerZone++;
    list[dangerZone][0] = new Monster("Spider",  "GreenSpider.png",  9, 5, 13, 2, 0, 2, 4, 0, AttackType.NONE);
      list[dangerZone][0].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][0].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][0].attacks[2] = new Attack("bites your foot.", 35, false, Debuff.POISON);
      list[dangerZone][0].attacks[3] = new Attack("bites your arm.", 40, false, Debuff.POISON);
      list[dangerZone][0].attacks[4] = new Attack("bites your leg.", 45, false, Debuff.POISON);
    list[dangerZone][1] = new Monster("Spider",  "GreenSpider.png",  10, 6, 13, 2, 0, 2, 3, 0, AttackType.NONE);
      list[dangerZone][1].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][1].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][1].attacks[2] = new Attack("bites your foot.", 35, false, Debuff.POISON);
      list[dangerZone][1].attacks[3] = new Attack("bites your arm.", 40, false, Debuff.POISON);
      list[dangerZone][1].attacks[4] = new Attack("bites your leg.", 45, false, Debuff.POISON);
    list[dangerZone][2] = new Monster("Spider",  "GreenSpider.png",  9, 5, 13, 2, 0, 2, 4, 0, AttackType.NONE);
      list[dangerZone][2].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][2].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][2].attacks[2] = new Attack("bites your foot.", 35, false, Debuff.POISON);
      list[dangerZone][2].attacks[3] = new Attack("bites your arm.", 40, false, Debuff.POISON);
      list[dangerZone][2].attacks[4] = new Attack("bites your leg.", 45, false, Debuff.POISON);
    list[dangerZone][3] = new Monster("Spider",  "GreenSpider.png",  10, 6, 13, 2, 0, 2, 3, 0, AttackType.NONE);
      list[dangerZone][3].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][3].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][3].attacks[2] = new Attack("bites your foot.", 35, false, Debuff.POISON);
      list[dangerZone][3].attacks[3] = new Attack("bites your arm.", 40, false, Debuff.POISON);
      list[dangerZone][3].attacks[4] = new Attack("bites your leg.", 45, false, Debuff.POISON);
    list[dangerZone][4] = new Monster();
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
