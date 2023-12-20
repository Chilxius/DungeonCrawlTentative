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
    list = new Monster[15][5]; //first array size is temporary
    
    //Name, Image, Health, Str, Dex, Con, Mag, Wil, Spd, Gold, Weakness
    list[0][0] = new Monster("Error Rat","019.png",1,1,1,1,0,1,1,0,AttackType.NONE);
    list[0][1] = new Monster();
    list[0][2] = new Monster();
    list[0][3] = new Monster();
    list[0][4] = new Monster();
    
    //1 - Rat cellar
    dangerZone++;
    list[dangerZone][0] = new Monster("Rat", "SlimyRat.png",  4, 3, 2, 1, 6, 1, 2, 0, AttackType.FIRE);
      list[dangerZone][0].attacks[0] = new Attack("squeaks.");
      list[dangerZone][0].attacks[1] = new Attack("scurries.");
      list[dangerZone][0].attacks[2] = new Attack("bites.", 30, false);
      list[dangerZone][0].attacks[3] = new Attack("bites.", 30, false);
      list[dangerZone][0].attacks[4] = new Attack("bites.", 30, false);
    list[dangerZone][1] = new Monster("Tiny Rat", "GreyRat.png",  1, 1, 1, 1, 6, 1, 4, 0, AttackType.FIRE);
      list[dangerZone][1].attacks[0] = new Attack("squeaks.");
      list[dangerZone][1].attacks[1] = new Attack("scurries.");
      list[dangerZone][1].attacks[2] = new Attack("bites.", 20, false);
      list[dangerZone][1].attacks[3] = new Attack("bites.", 20, false);
      list[dangerZone][1].attacks[4] = new Attack("bites.", 20, false);
    list[dangerZone][2] = new Monster("Large Rat", "DarkRat.png",  7, 4, 2, 1, 6, 1, 2, 0, AttackType.FIRE);
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
    
    //String n, String image, int health, int s, int d, int c, int m, int w, int sp, int g, AttackType weak
    
    //6 - Barracuda Queen (top level)
    dangerZone++;
    list[dangerZone][0] = new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE);
      list[dangerZone][0].attacks[0] = new Attack("coughs up salt water.");
      list[dangerZone][0].attacks[1] = new Attack("scratches.", 40, false);
      list[dangerZone][0].attacks[2] = new Attack("bites.", 55, false);
      list[dangerZone][0].attacks[3] = new Attack("bites.", 55, false);
      list[dangerZone][0].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][1] = new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE);
      list[dangerZone][1].attacks[0] = new Attack("coughs up salt water.");
      list[dangerZone][1].attacks[1] = new Attack("scratches.", 40, false);
      list[dangerZone][1].attacks[2] = new Attack("bites.", 55, false);
      list[dangerZone][1].attacks[3] = new Attack("bites.", 55, false);
      list[dangerZone][1].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][2] = new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE);
      list[dangerZone][2].attacks[0] = new Attack("coughs up salt water.");
      list[dangerZone][2].attacks[1] = new Attack("scratches.", 40, false);
      list[dangerZone][2].attacks[2] = new Attack("bites.", 55, false);
      list[dangerZone][2].attacks[3] = new Attack("bites.", 55, false);
      list[dangerZone][2].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][3] = new Monster();
    list[dangerZone][4] = new Monster();
    
    //7 - Barracuda Queen (lower level)
    dangerZone++;
    list[dangerZone][0] = new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE);
      list[dangerZone][0].attacks[0] = new Attack("coughs up salt water.");
      list[dangerZone][0].attacks[1] = new Attack("scratches.", 40, false);
      list[dangerZone][0].attacks[2] = new Attack("bites.", 55, false);
      list[dangerZone][0].attacks[3] = new Attack("bites.", 55, false);
      list[dangerZone][0].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][1] = new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE);
      list[dangerZone][1].attacks[0] = new Attack("coughs up salt water.");
      list[dangerZone][1].attacks[1] = new Attack("scratches.", 40, false);
      list[dangerZone][1].attacks[2] = new Attack("bites.", 55, false);
      list[dangerZone][1].attacks[3] = new Attack("bites.", 55, false);
      list[dangerZone][1].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][2] = new Monster("Abyss Rat",  "abyssRat.png",  40, 10, 20, 4, 13, 8, 10, 0, AttackType.HOLY);
      list[dangerZone][2].attacks[0] = new Attack("watches you silently.");
      list[dangerZone][2].attacks[1] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
      list[dangerZone][2].attacks[2] = new Attack("bites with an icy fang.", 35, false, AttackStat.MAG, AttackType.ICE);
      list[dangerZone][2].attacks[3] = new Attack("bites with an icy fang.", 35, false, AttackStat.MAG, AttackType.ICE);
      list[dangerZone][2].attacks[4] = new Attack("sprays icy seawater.", 30, false, AttackStat.MAG, AttackType.ICE);
    list[dangerZone][3] = new Monster();
    list[dangerZone][4] = new Monster();
    
    //8 - Bumblewere flowers (outside)
    dangerZone++;
    list[dangerZone][0] = new Monster("Drone", "WaspSmall.png", 45, 20, 30, 4, 1, 5, 20, 0, AttackType.WIND);
      list[dangerZone][0].attacks[0] = new Attack("buzzes around your heads.");
      list[dangerZone][0].attacks[1] = new Attack("bites.", 55, false );
      list[dangerZone][0].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP );
      list[dangerZone][0].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP );
      list[dangerZone][0].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE );
    list[dangerZone][1] = new Monster();
    list[dangerZone][2] = new Monster();
    list[dangerZone][3] = new Monster();
    list[dangerZone][4] = new Monster();
    
    //9 - Bumblewere caves
    dangerZone++;
    list[dangerZone][0] = new Monster("Drone", "WaspSmall.png", 45, 20, 30, 4, 1, 5, 20, 0, AttackType.WIND, 2);
      list[dangerZone][0].attacks[0] = new Attack("buzzes around your heads.");
      list[dangerZone][0].attacks[1] = new Attack("bites.", 55, false );
      list[dangerZone][0].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP );
      list[dangerZone][0].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP );
      list[dangerZone][0].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE );
    list[dangerZone][1] = new Monster("Drone", "WaspSmall.png", 45, 20, 30, 4, 1, 5, 20, 0, AttackType.WIND, 2);
      list[dangerZone][1].attacks[0] = new Attack("buzzes around your heads.");
      list[dangerZone][1].attacks[1] = new Attack("bites.", 55, false );
      list[dangerZone][1].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP );
      list[dangerZone][1].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP );
      list[dangerZone][1].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE );
    list[dangerZone][2] = new Monster("Swarm", "swarm.png", 60, 10, 10, 2, 1, 5, 25, 0, AttackType.WIND, 2);
      list[dangerZone][2].attacks[0] = new Attack("surrounds you.");
      list[dangerZone][2].attacks[1] = new Attack("bites and scratches.", 55, false );
      list[dangerZone][2].attacks[2] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP );
      list[dangerZone][2].attacks[3] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP );
      list[dangerZone][2].attacks[4] = new Attack("descends upon you.", 40, true );
    list[dangerZone][3] = new Monster("Swarm", "swarm.png", 60, 10, 10, 2, 1, 5, 25, 0, AttackType.WIND, 2);
      list[dangerZone][3].attacks[0] = new Attack("surrounds you.");
      list[dangerZone][3].attacks[1] = new Attack("bites and scratches.", 55, false );
      list[dangerZone][3].attacks[2] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP );
      list[dangerZone][3].attacks[3] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP );
      list[dangerZone][3].attacks[4] = new Attack("descends upon you.", 40, true );
    list[dangerZone][4] = new Monster();
    
    //A - Bandits
    dangerZone++;
    list[dangerZone][0] = new Monster("Bandit", "bandit.png", 90, 26, 30, 7, 1, 4, 20, 7, AttackType.NONE, 10);
      list[dangerZone][0].attacks[0] = new Attack("tries to get behind you.");
      list[dangerZone][0].attacks[1] = new Attack("uses a toxin.", 55, false, Debuff.SLEEP );
      list[dangerZone][0].attacks[2] = new Attack("stabs with a knife.", 50, false, AttackStat.DEX, AttackType.NONE );
      list[dangerZone][0].attacks[3] = new Attack("strikes with his sword.", 70, false );
      list[dangerZone][0].attacks[4] = new Attack("flings knives!", 60, true );
    list[dangerZone][1] = new Monster("Bandit Mage", "banditMage.png", 90, 7, 20, 4, 15, 7, 18, 8, AttackType.NONE, 10);
      list[dangerZone][1].attacks[0] = new Attack("begins chanting a spell.");
      list[dangerZone][1].attacks[1] = new Attack("uses a toxin.", 55, false, Debuff.SLEEP );
      list[dangerZone][1].attacks[2] = new Attack("summons a ball of fire.", 50, false, AttackStat.MAG, AttackType.FIRE );
      list[dangerZone][1].attacks[3] = new Attack("summons shards of ice.", 55, false, AttackStat.MAG, AttackType.ICE );
      list[dangerZone][1].attacks[4] = new Attack("conjures a tempest!", 55, true, AttackStat.MAG, AttackType.WIND );
    list[dangerZone][2] = new Monster();
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
      case "Body of Alar":  case "Body of Zan":
      case "Body of Corel": case "Body of Ivy":
      case "Body of Ruath": case "Body of Erar":
        battleMonsters[0] = new Monster("Spirit Light",  "Spirit.png",  20, 20, 20, 1, 7, 30, 8, 0, AttackType.NONE);
          battleMonsters[0].attacks[0] = new Attack("flickers in the shadows.");
          battleMonsters[0].attacks[1] = new Attack("moves through you.", 30, false, false, AttackStat.MAG, AttackType.HOLY, Debuff.SLEEP);
          battleMonsters[0].attacks[2] = new Attack("moves through you.", 30, false, false, AttackStat.MAG, AttackType.HOLY, Debuff.SLEEP);
          battleMonsters[0].attacks[3] = new Attack("whispers: \""+party.hero[0].name+"...\"");
          battleMonsters[0].attacks[4] = new Attack("flares to life!", 30, true, AttackStat.MAG, AttackType.HOLY );
        battleMonsters[2] = new Monster("Spirit Light",  "Spirit.png",  20, 20, 20, 1, 7, 30, 8, 0, AttackType.NONE);
          battleMonsters[2].attacks[0] = new Attack("whispers: \""+party.hero[1].name+"...\"");
          battleMonsters[0].attacks[1] = new Attack("moves through you.", 30, false, false, AttackStat.MAG, AttackType.HOLY, Debuff.SLEEP);
          battleMonsters[0].attacks[2] = new Attack("moves through you.", 30, false, false, AttackStat.MAG, AttackType.HOLY, Debuff.SLEEP);
          battleMonsters[2].attacks[3] = new Attack("whispers: \""+party.hero[2].name+"...\"");
          battleMonsters[2].attacks[4] = new Attack("flares to life!", 30, true, AttackStat.MAG, AttackType.HOLY );
      break;
      
      case "Body of Necromancer":
        battleMonsters[0] = new Monster("Skeletal Guard",  "ScimitarSkeleton.png",  30, 20, 5, 6, 0, 4, 6, 0, AttackType.HOLY);
          battleMonsters[0].attacks[0] = new Attack("protects its master.");
          battleMonsters[0].attacks[1] = new Attack("slices.", 50, false);
          battleMonsters[0].attacks[2] = new Attack("bites.", 55, false);
          battleMonsters[0].attacks[3] = new Attack("bites.", 55, false);
          battleMonsters[0].attacks[4] = new Attack("delivers a mighty blow!", 60, false );
        battleMonsters[2] = new Monster("Skeletal Guard",  "ScimitarSkeleton.png",  30, 18, 5, 6, 0, 4, 6, 0, AttackType.HOLY);
          battleMonsters[2].attacks[0] = new Attack("protects its master.");
          battleMonsters[2].attacks[1] = new Attack("whirls its sword.", 40, true);
          battleMonsters[2].attacks[2] = new Attack("whirls its sword.", 40, true);
          battleMonsters[2].attacks[3] = new Attack("stabs quickly.", 50, false);
          battleMonsters[2].attacks[4] = new Attack("strikes a weak point!", 60, false);
      break;
      
      case "Deep Ratlord":
        battleMonsters[0] = new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE);
          battleMonsters[0].attacks[0] = new Attack("coughs up salt water.");
          battleMonsters[0].attacks[1] = new Attack("scratches.", 40, false);
          battleMonsters[0].attacks[2] = new Attack("cuts upward.", 50, false);
          battleMonsters[0].attacks[3] = new Attack("strikes downward.", 50, false);
          battleMonsters[0].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE);
        battleMonsters[2] = new Monster("Abyss Rat",  "abyssRat.png",  40, 10, 20, 4, 13, 8, 10, 0, AttackType.HOLY);
          battleMonsters[2].attacks[0] = new Attack("watches you silently.");
          battleMonsters[2].attacks[1] = new Attack("sprays icy seawater.", 20, true, AttackStat.MAG, AttackType.ICE);
          battleMonsters[2].attacks[2] = new Attack("bites with an icy fang.", 25, false, AttackStat.MAG, AttackType.ICE);
          battleMonsters[2].attacks[3] = new Attack("bites with an icy fang.", 25, false, AttackStat.MAG, AttackType.ICE);
          battleMonsters[2].attacks[4] = new Attack("sprays icy seawater.", 20, true, AttackStat.MAG, AttackType.ICE);
          
      case "Nectarhunter":
        battleMonsters[0] = new Monster("Swarm", "swarm.png", 60, 10, 10, 2, 1, 5, 25, 0, AttackType.WIND, 2);
          battleMonsters[0].attacks[0] = new Attack("surrounds you.");
          battleMonsters[0].attacks[1] = new Attack("bites and scratches.", 55, false );
          battleMonsters[0].attacks[2] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP );
          battleMonsters[0].attacks[3] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP );
          battleMonsters[0].attacks[4] = new Attack("descends upon you.", 40, true );
          
      case "Bandit":                      //String n, String image,  health, s,  d,  c, m,  w, sp, g, AttackType weak
        battleMonsters[0] = new Monster("Bandit Mage", "banditMage.png", 90, 7, 20, 4, 15, 7, 18, 8, AttackType.NONE, 6);
          battleMonsters[0].attacks[0] = new Attack("summons a ball of fire.", 50, false, AttackStat.MAG, AttackType.FIRE );
          battleMonsters[0].attacks[1] = new Attack("summons shards of ice.", 55, false, AttackStat.MAG, AttackType.ICE );
          battleMonsters[0].attacks[2] = new Attack("conjures a tempest!", 55, true, AttackStat.MAG, AttackType.WIND );
          battleMonsters[0].attacks[3] = new Attack("uses a toxin.", 60, false, Debuff.POISON );
          battleMonsters[0].attacks[4] = new Attack("begins chanting a spell." );
    }
  }
}
