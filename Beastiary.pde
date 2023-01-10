class Beastiary
{
  Monster [][] list;
  Monster [] boss;
  int bossIndex = 0;
  int addBossIndex = 0;
  //[danger level][creature number]
  
  public Beastiary()
  {
    list = new Monster[5][5];
    
    //Name, Image, Health, Str, Dex, Con, Mag, Wil, Spd
    list[0][0] = new Monster("Error Rat","019.png",1,1,1,1,0,1,1,0,AttackType.NONE);
    list[0][1] = new Monster();
    list[0][2] = new Monster();
    list[0][3] = new Monster();
    list[0][4] = new Monster();
    
    list[1][0] = new Monster("GreenDragon",  "GreenDragon.png",  10,3,5,3,0,1,1,10,AttackType.NONE);
    list[1][1] = new Monster("StoneGargoyle","StoneGargoyle.png",12,4,4,3,0,1,2,0,AttackType.NONE);
    list[1][2] = new Monster("Green Squid",  "GreenSquid.png",    8,2,6,2,0,1,3,0,AttackType.NONE);
    list[1][3] = new Monster();
    list[1][4] = new Monster();
    
    boss = new Monster[10]; //TEMPORARY
    
    //boss[0] = new Monster("TEST BOSS", "GreenDragon.png", 1, 1, 1, 1, 1, 1, 1, 1, AttackType.NONE);
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
