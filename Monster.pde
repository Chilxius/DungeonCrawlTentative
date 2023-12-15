class Monster
{
  PImage pic;
  String name;
  String imageName;
  
  int maxHp, hp;
  int str, dex, con, mag, wil, spd;
  boolean alive;
  int gold;
  int bonusExp;
  
  AttackType weakness = AttackType.NONE;
   
  boolean poisoned, weakened, paralyzed, asleep, cursed;
  int poison = 0;
  int sleep = 0;
  int paralysis = 0;
  
  int target; //target of attack in battle
  
  Attack [] attacks = new Attack[5];

  public Monster()
  {
    this("EMPTY", "016.png", 1,0,1,1,1,1,1,0,AttackType.NONE);
    alive = false;
  }
  
  public Monster( Monster m )
  {
    this( m.name, m.imageName, m.hp, m.str, m.dex, m.con, m.mag, m.wil, m.spd, m.gold, m.weakness );
    alive = m.alive;
    attacks[0] = m.attacks[0];
    attacks[1] = m.attacks[1];
    attacks[2] = m.attacks[2];
    attacks[3] = m.attacks[3];
    attacks[4] = m.attacks[4];
  }
  
  public Monster( String n, String image, int health, int s, int d, int c, int m, int w, int sp, int g, AttackType weak)
  {
    this(n, image, health, s, d, c, m, w, sp, g, weak, 0);
  }
  
  public Monster( String n, String image, int health, int s, int d, int c, int m, int w, int sp, int g, AttackType weak, int bonus)
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
   
   weakness = weak;
   
   gold = g;
   bonusExp = bonus;
   
   alive=true;
   
   poisoned=weakened=paralyzed=asleep=cursed=false;
   
   attacks[0]=attacks[1]=attacks[2]=attacks[3]=attacks[4]=new Attack("does nothing.");
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
    //int damage = party.hero[targetHero].takeDamage(str);
    int damage = 0;
    
    if( attacks[battle.enemyAttackIndex].type != AttackType.WASTE )
    {
      if( attacks[battle.enemyAttackIndex].targetAll ) //multi-target attack
      {
        if( party.hero[0].alive )
        {
          damage = battle.calculateDamage( party.averageLevel(), 1, attacks[battle.enemyAttackIndex].power, appropriateStat(attacks[battle.enemyAttackIndex]), party.hero[0].appropriateDefense(attacks[battle.enemyAttackIndex]) );
          party.hero[0].takeDamage( damage, false );
          floatingNumbers.add( new GhostNumber( 150, 550, attacks[battle.enemyAttackIndex].appropriateColor(), damage ) );
        }
        if( party.hero[1].alive )
        {
          damage = battle.calculateDamage( party.averageLevel(), 1, attacks[battle.enemyAttackIndex].power, appropriateStat(attacks[battle.enemyAttackIndex]), party.hero[1].appropriateDefense(attacks[battle.enemyAttackIndex]) );
          party.hero[1].takeDamage( damage, false );
          floatingNumbers.add( new GhostNumber( 360, 550, attacks[battle.enemyAttackIndex].appropriateColor(), damage ) );
        }
        if( party.hero[2].alive )
        {
          damage = battle.calculateDamage( party.averageLevel(), 1, attacks[battle.enemyAttackIndex].power, appropriateStat(attacks[battle.enemyAttackIndex]), party.hero[2].appropriateDefense(attacks[battle.enemyAttackIndex]) );
          party.hero[2].takeDamage( damage, false );
          floatingNumbers.add( new GhostNumber( 570, 550, attacks[battle.enemyAttackIndex].appropriateColor(), damage ) );
        }
      }
      else
      {
        damage = battle.calculateDamage( party.averageLevel(), battle.isCrit(dex,party.hero[targetHero].totalStat(1),false), attacks[battle.enemyAttackIndex].power, appropriateStat(attacks[battle.enemyAttackIndex]), party.hero[targetHero].appropriateDefense(attacks[battle.enemyAttackIndex]));
        party.hero[targetHero].takeDamage(damage,true);
        floatingNumbers.add( new GhostNumber( 150+210*targetHero, 550, attacks[battle.enemyAttackIndex].appropriateColor(), damage) );
      }
      
      //Resolve status attacks
      if(attacks[battle.enemyAttackIndex].debuff!=Debuff.NONE)
      {
        float largeRandom;
        float smallRandom;
        switch(attacks[battle.enemyAttackIndex].debuff)
        {
          case POISON:  //25% plus damage minus dex
            largeRandom = random(100);
            smallRandom = 25; //this doesn't need to be random
            if( largeRandom < max(1,smallRandom+damage-party.hero[targetHero].totalStat(2)) )
              party.hero[targetHero].poison(max(str,con),targetHero);
            break;
          case SLEEP:  //25% plus damage minus con
            largeRandom = random(100);
            smallRandom = 25;
            if( largeRandom < max(1,smallRandom+damage-party.hero[targetHero].totalStat(2)) )
              party.hero[targetHero].putToSleep(max(wil,mag),targetHero);
            break;
          case PARA:  //25% plus damage minus dex
            largeRandom = random(100);
            smallRandom = 25;
            if( largeRandom < max(1,smallRandom+damage-party.hero[targetHero].totalStat(1)) )
              party.hero[targetHero].paralyze(max(str,mag),targetHero);
            break;
        }
      }
    }
    if(party.partyDead())
    {
      input = input.NONE; //<>// //<>//
      vanGogh.beginGameoverAnimation();
    }
    battle.setBattleDelay();
    battle.resumeInitiative();
  }
  
  public void poison( int amount, int x )
  {
    floatingNumbers.add( new GhostNumber( 150+210*x, 270, color(100,100,0), "POISON") );
    poisoned = true;
    poison += amount;
  }
  public void putToSleep( int amount, int x )
  {
    floatingNumbers.add( new GhostNumber( 150+210*x, 270, color(200,250,250), "ASLEEP") );
    asleep = true;
    sleep += amount*4;
  }
  public void paralyze( int amount, int x )
  {
    floatingNumbers.add( new GhostNumber( 150+210*x, 270, color(200,200,100), "PARALYZED") );
    paralyzed = true;
    paralysis += max(1,amount-dex)*4; //subtract dex
  }
  
  public boolean takePoisonDamage( int pos ) //true if monster dies
  {
    println("TAKING POISON DAMAGE"); //<>// //<>//
    if(poison<=0)
      return false;
    int poisonDamage = max(poison/2,1); //minimum 1 damage
    poison -= poisonDamage;
    hp -= poisonDamage;
    floatingNumbers.add( new GhostNumber( 150+210*pos, 320, color(255), poisonDamage) );
    if(hp <= 0)
    {
      hp = 0;
      alive = false;
      poison = 0;
      battle.exp += experiencePoints();
      battle.gold += gold;
      displayTextLine( name + " collapses!" );
      return true;
    }
    if(poison<=0)
    {
      poison = 0;
      poisoned = false;
    }
    return false;
  }
  
  public boolean wake()
  {
    sleep--;
    if(sleep<=0)
    {
      sleep=0;
      asleep=false;
      return true;
    }
    return false;
  }
  
  public String wakeMessage()
  {
    return name + " wakes up!";
  }
  
  public boolean limber()
  {
    paralysis--;
    if(paralysis<=0)
    {
      paralysis=0;
      paralyzed = false;
      return true;
    }
    return false;
  }
  
  public String limberMessage()
  {
    return name + " can move!";
  }
  
  int appropriateStat( Attack a )
  {
    if( a.stat == AttackStat.DEX )
      return dex;
    if( a.stat == AttackStat.MAG )
      return mag;
    else
      return str;
  }
  
  int appropriateDefense( Attack a )
  {
    if( a.stat == AttackStat.DEX || a.stat == AttackStat.STR )
    {
      if( a.pierceArmor )
        return con/2;
      return con;
    }
    else
      return wil;
  }
  
  public int experiencePoints()
  {
    return (maxHp/10 + str + dex + con + mag + wil + spd)/3;
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
  
  public int takeDamage( int damage )
  {
    println("HP: " + hp + "    DAM: " + damage); //testing
    hp -= damage;
    println("HP: " + hp); //testing
    if(hp <= 0)
    {
      hp = 0;
      alive = false;
      println("EXP: " + experiencePoints() ); //testing
      battle.exp += experiencePoints();
      battle.gold += gold;
    }
    else
    {
      if( (name + " is " + damageMessage() + " wounded.").length() < 40 )
        displayTextLine( name + " is " + damageMessage() + " wounded.");
      else
      {
        displayTextLine( name + " is " );
        displayTextLine( damageMessage() + " wounded.");
      }
    }
    if( asleep )
    {
      sleep = 0;
      asleep = false;
    }
    return damage;
  }
  
  public String damageMessage()
  {
    if( hp > maxHp*.60 )
      return "slightly";
    else if( hp > maxHp*.25)
      return "moderately";
    else if( hp > maxHp*.10)
      return "severely";
    else
      return "critically";
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
