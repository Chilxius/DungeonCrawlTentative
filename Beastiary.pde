//This class will handle the monsters that appear in the game.
//Bosses are created along with the map.
//These objects are reused, so they should be
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
    list = new Monster[10][5]; //first array size is temporary
    
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
      list[dangerZone][0].attacks[2] = new Attack("bites your foot.", 5, false, Debuff.POISON);
      list[dangerZone][0].attacks[3] = new Attack("bites your arm.", 5, false, Debuff.POISON);
      list[dangerZone][0].attacks[4] = new Attack("bites your leg.", 5, false, Debuff.POISON);
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
      list[dangerZone][0].attacks[2] = new Attack("bites your foot.", 5, false, Debuff.POISON);
      list[dangerZone][0].attacks[3] = new Attack("bites your arm.", 5, false, Debuff.POISON);
      list[dangerZone][0].attacks[4] = new Attack("bites your leg.", 5, false, Debuff.POISON);
    list[dangerZone][1] = new Monster("Spider",  "GreenSpider.png",  10, 6, 13, 2, 0, 2, 3, 0, AttackType.NONE);
      list[dangerZone][1].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][1].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][1].attacks[2] = new Attack("bites your foot.", 5, false, Debuff.POISON);
      list[dangerZone][1].attacks[3] = new Attack("bites your arm.", 5, false, Debuff.POISON);
      list[dangerZone][1].attacks[4] = new Attack("bites your leg.", 5, false, Debuff.POISON);
    list[dangerZone][2] = new Monster("Spider",  "GreenSpider.png",  9, 5, 13, 2, 0, 2, 4, 0, AttackType.NONE);
      list[dangerZone][2].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][2].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][2].attacks[2] = new Attack("bites your foot.", 5, false, Debuff.POISON);
      list[dangerZone][2].attacks[3] = new Attack("bites your arm.", 5, false, Debuff.POISON);
      list[dangerZone][2].attacks[4] = new Attack("bites your leg.", 5, false, Debuff.POISON);
    list[dangerZone][3] = new Monster("Spider",  "GreenSpider.png",  10, 6, 13, 2, 0, 2, 3, 0, AttackType.NONE);
      list[dangerZone][3].attacks[0] = new Attack("scratches.", 35, false);
      list[dangerZone][3].attacks[1] = new Attack("scratches.", 35, false);
      list[dangerZone][3].attacks[2] = new Attack("bites your foot.", 5, false, Debuff.POISON);
      list[dangerZone][3].attacks[3] = new Attack("bites your arm.", 5, false, Debuff.POISON);
      list[dangerZone][3].attacks[4] = new Attack("bites your leg.", 5, false, Debuff.POISON);
    list[dangerZone][4] = new Monster();
    
    //4 - Graveyard (first)
    dangerZone++;
    list[dangerZone][0] = new Monster("Fragile Skeleton",  "WeakSkeleton2.png",  20, 10, 20, 2, 0, 3, 7, 0, AttackType.HOLY);
      list[dangerZone][0].attacks[0] = new Attack("crumbles as it moves.");
      list[dangerZone][0].attacks[1] = new Attack("scratches.", 40, false);
      list[dangerZone][0].attacks[2] = new Attack("lunges forward.", 45, false);
      list[dangerZone][0].attacks[3] = new Attack("bites.", 50, false);
      list[dangerZone][0].attacks[4] = new Attack("flails wildly.", 30, true);
    list[dangerZone][1] = new Monster("Sturdy Skeleton",  "WeakSkeleton3.png",  30, 15, 10, 3, 0, 2, 5, 0, AttackType.HOLY);
      list[dangerZone][1].attacks[0] = new Attack("rattles.");
      list[dangerZone][1].attacks[1] = new Attack("bashes.", 45, false);
      list[dangerZone][1].attacks[2] = new Attack("bashes with a rock.", 50, false);
      list[dangerZone][1].attacks[3] = new Attack("slams its body.", 55, false);
      list[dangerZone][1].attacks[4] = new Attack("strikes with a bone spur.", 50, false);
    list[dangerZone][2] = new Monster();
    list[dangerZone][3] = new Monster();
    list[dangerZone][4] = new Monster();
    
    //5 - Graveyard (second)
    dangerZone++;
    list[dangerZone][0] = new Monster("Fragile Skeleton",  "WeakSkeleton.png",  20, 14, 20, 3, 0, 4, 8, 0, AttackType.HOLY);
      list[dangerZone][0].attacks[0] = new Attack("crumbles as it moves.");
      list[dangerZone][0].attacks[1] = new Attack("cuts.", 40, false);
      list[dangerZone][0].attacks[2] = new Attack("lunges forward.", 45, false);
      list[dangerZone][0].attacks[3] = new Attack("bites.", 50, false);
      list[dangerZone][0].attacks[4] = new Attack("flails wildly.", 30, true);
    list[dangerZone][1] = new Monster("Sturdy Skeleton",  "WeakSkeleton4.png",  35, 17, 10, 4, 0, 3, 7, 0, AttackType.HOLY);
      list[dangerZone][1].attacks[0] = new Attack("rattles.");
      list[dangerZone][1].attacks[1] = new Attack("bashes.", 45, false);
      list[dangerZone][1].attacks[2] = new Attack("bashes with a rock.", 50, false);
      list[dangerZone][1].attacks[3] = new Attack("slams its axe.", 55, false);
      list[dangerZone][1].attacks[4] = new Attack("strikes with a bone spur.", 50, false);
    list[dangerZone][2] = new Monster("Blackened Skeleton",  "DarkSkeleton.png",  45, 19, 5, 7, 0, 4, 6, 0, AttackType.HOLY);
      list[dangerZone][2].attacks[0] = new Attack("laughs.");
      list[dangerZone][2].attacks[1] = new Attack("strikes with its knee.", 45, false);
      list[dangerZone][2].attacks[2] = new Attack("strikes your chest.", 55, false);
      list[dangerZone][2].attacks[3] = new Attack("slams with its arm.", 55, false);
      list[dangerZone][2].attacks[4] = new Attack("gives an icy stare.", 30, true, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][3] = new Monster();
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
  
  public void checkForMooks( String name ) //for adding mooks to boss battles (monsters different from the boss)
  {
    switch( name )
    {
      case "Body of Necromancer":
        battleMonsters[0] = new Monster("Skeletal Guard",  "ScimitarSkeleton.png",  30, 20, 5, 6, 0, 4, 6, 0, AttackType.HOLY);
          battleMonsters[0].attacks[0] = new Attack("protects its master.");
          battleMonsters[0].attacks[1] = new Attack("slices.", 50, false);
          battleMonsters[0].attacks[2] = new Attack("cuts upward.", 50, false);
          battleMonsters[0].attacks[3] = new Attack("strikes downward.", 50, false);
          battleMonsters[0].attacks[4] = new Attack("delivers a mighty blow!", 60, false );
        battleMonsters[2] = new Monster("Skeletal Guard",  "ScimitarSkeleton.png",  30, 18, 5, 6, 0, 4, 6, 0, AttackType.HOLY);
          battleMonsters[2].attacks[0] = new Attack("protects its master.");
          battleMonsters[2].attacks[1] = new Attack("whirls its sword.", 40, true);
          battleMonsters[2].attacks[2] = new Attack("whirls its sword.", 40, true);
          battleMonsters[2].attacks[3] = new Attack("stabs quickly.", 50, false);
          battleMonsters[2].attacks[4] = new Attack("strikes a weak point!", 60, false);
      break;
    }
  }
}
