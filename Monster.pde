class Monster
{
  PImage pic;
  String name;
  String imageName;
  
  int maxHp, hp;
  int str, dex, con, mag, wil, spd;
  boolean alive;
   
  boolean poisoned, weakened, paralyzed, asleep, cursed;
  
  int target; //target of attack in battle
  

  public Monster()
  {
    this("EMPTY", "016.png", 1,0,1,1,1,1,1);
    alive = false;
  }
  
  public Monster( String n, String image, int health, int s, int d, int c, int m, int w, int sp)
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
   
   alive=true;
   
   poisoned=weakened=paralyzed=asleep=cursed=false;
  }
  
  public void makeAttack()
  {
    
    target = int(random(3)); //shouldn't get here if party is dead
    
    while( !party.hero[target].alive )
      target = int(random(3));
    
    displayTextLine( name + " attacks " + party.hero[target].name + "!");
    battle.waitingForText = true;
    battle.setBattleDelay(1);
  }
  
  public void resolveAttack()
  {
    battle.waitingForText = false;
    party.hero[target].takeDamage(str);
    battle.setBattleDelay(1);
    battle.resumeInitiative();
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
    hp -= damage;
    if(hp <= 0)
    {
      hp = 0;
      alive = false;
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
