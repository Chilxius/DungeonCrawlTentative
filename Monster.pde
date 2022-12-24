class Monster
{
  PImage pic;
  String name;
  String imageName;
  
  int maxHp, hp;
  int str, dex, con, mag, wil, spd;
  boolean alive;
  int gold;
   
  boolean poisoned, weakened, paralyzed, asleep, cursed;
  
  int target; //target of attack in battle
  

  public Monster()
  {
    this("EMPTY", "016.png", 1,0,1,1,1,1,1,0);
    alive = false;
  }
  
  public Monster( Monster m )
  {
    this( m.name, m.imageName, m.hp, m.str, m.dex, m.con, m.mag, m.wil, m.spd, m.gold );
    alive = m.alive;
  }
  
  public Monster( String n, String image, int health, int s, int d, int c, int m, int w, int sp, int g )
  {
   name = n;
   imageName = image;
   pic = loadImage(imageName);
   pic.resize(200,0);
  
   hp = maxHp = health;
   str=s;
   dex=d;
   con=c;
   mag=m;
   wil=w;
   spd=sp;
   
   gold = g;
   
   alive=true;
   
   poisoned=weakened=paralyzed=asleep=cursed=false;
  }
  
  /*
  public void makeAttack() //outdated
  {
    
    target = int(random(3)); //shouldn't get here if party is dead
    
    while( !party.hero[target].alive )
      target = int(random(3));
    
    displayTextLine( name + " attacks " + party.hero[target].name + "!");
    battle.waitingForText = true;
    battle.setBattleDelay();
  }
  */
  
  public void resolveAttack( int targetHero )
  {
    battle.waitingForText = false;
    party.hero[targetHero].takeDamage(str);
    battle.setBattleDelay();
    battle.resumeInitiative();
  }
  
  public int experiencePoints()
  {
    return (maxHp/10 + str + dex + con + mag + wil + spd)/2;
  }
  
  public boolean hasCondition(int x)
  {
    switch(x)
    {
      case 0: return poisoned;
      case 1: return asleep;
      case 2: return paralyzed;
      case 3: return weakened;
      case 4: return cursed;
    }
    return false;
  }
  
  public String toString()
  {
    return name;
  }
  
  public void takeDamage( int damage )
  {
    println("HP: " + hp + "    DAM: " + damage); //testing
    hp -= damage;
    println("HP: " + hp); //testing
    displayTextLine( name + " takes " + damage + " damage.");
    if(hp <= 0)
    {
      hp = 0;
      alive = false;
      println("EXP: " + experiencePoints() ); //testing
      battle.exp += experiencePoints();
      battle.gold += gold;
    }
  }
  
  public void heal( int amount )
  {
    if(alive)
    {
      hp += amount;
      if(hp > maxHp)
        hp = maxHp;
    }
  }
  
  public boolean inDanger()
  {
    if(hp<=maxHp/10)
      return true;
    return false;
  }
  
  public int getHp()    {return hp;}
  public int getMaxHp() {return maxHp;}
  public int getStr()   {return str;}
  public int getDex()   {return dex;}
  public int getCon()   {return con;}
  public int getMag()   {return mag;}
  public int getWill()  {return wil;}
  public boolean isAlive() {return alive;}
}
