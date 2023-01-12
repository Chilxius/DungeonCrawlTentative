class Hero
{
  String name;
  Job job;
  color favColor, inverseColor;
  
  int maxHp, hp;
  int maxMp, mp;
  int level, nextLevel, exp;
  int str, dex, con, mag, wil, spd;
  boolean alive;
  
  //Equipment stats
  Equipment weapon, armor;
  
  //lose health,  strength reduced,  can't act,  can't act,  mag/will reduced
  boolean poisoned, weakened, paralyzed, asleep, cursed;
  int poison=100; //Damage left. Will dole out based on level.
  
  boolean created;
  
  boolean defending;
  
  public Hero()
  {
    this("Unknown", Job.NONE, color(50), color(200) );
  }
  
  public Hero( boolean b )
  {
    created = b;
  }
  
  public Hero( String n, Job j, color c, color ic )
  {
    name = n;
    job = j;
    favColor = c;
    inverseColor = ic;
    created = true;
    assignBaseStats();
    alive = true;
    defending = false;
    
    //for testing
    weapon = new Equipment("Club",1,true,1);
    armor = new Equipment("Shirt",1,false,1);
  }
  
  public void assignBaseStats()
  {
    /*
    switch(job)
    {                      
      case KNIGHT:   hp=maxHp=30;str=40;dex=3;con=5;mag=0;wil=2;spd=2;break;
      case BARBARIAN:hp=maxHp=40;str=5; dex=3;con=3;mag=0;wil=1;spd=2;break;
      case KARATE:   hp=maxHp=45;str=40;dex=4;con=4;mag=0;wil=4;spd=3;break;
      case THIEF:    hp=maxHp=25;str=30;dex=5;con=3;mag=0;wil=2;spd=3;break;
      case PRIEST:   hp=maxHp=20;str=2; dex=2;con=2;mag=4;wil=5;spd=2;mp=maxMp=20;break;
      case MAGE:     hp=maxHp=15;str=1; dex=2;con=2;mag=5;wil=4;spd=2;mp=maxMp=25;break;
      default:       hp=maxHp=1; str=1; dex=1;con=1;mag=1;wil=1;spd=1;mp=maxMp=1; break;
    }*/
    level = 1;
    exp = 0;
    nextLevel = level*100;
    adjustStats();
    poisoned=weakened=paralyzed=asleep=cursed=false;
  }
  
  public void adjustStats()
  {
    switch(job)
    {
      case KNIGHT:
        maxHp =  int((270/50.0)*(level-1)+30);
        str =    int((116/50.0)*(level-1)+4);
        dex =    int((5097/50.0)*(level-1)+3); //should be 97 - changed for testing purposes
        con =    int((125/50.0)*(level-1)+5);
        mag =    level; 
        wil =    int((98/50.0)*(level-1)+2);
        spd =    int((98/50.0)*(level-1)+2);
        break;
      case BARBARIAN:
        maxHp =  int((320/50.0)*(level-1)+30);
        str =    int((145/50.0)*(level-1)+5);
        dex =    int((107/50.0)*(level-1)+3);
        con =    int((97/50.0)*(level-1)+3);
        mag =    0;
        wil =    int((69/50.0)*(level-1)+1);
        spd =    int((118/50.0)*(level-1)+2);
        break;
      case KARATE:
        maxHp =  int((360/50.0)*(level-1)+40);
        str =    int((116/50.0)*(level-1)+4);
        dex =    int((116/50.0)*(level-1)+4);
        con =    int((116/50.0)*(level-1)+4);
        mag =    level;
        wil =    int((116/50.0)*(level-1)+4);
        spd =    int((136/50.0)*(level-1)+3);
        break;
      case THIEF:
        maxHp =  int((225/50.0)*(level-1)+25);
        str =    int((87/50.0)*(level-1)+3);
        dex =    int((135/50.0)*(level-1)+5);
        con =    int((87/50.0)*(level-1)+3);
        mag =    0;
        wil =    int((88/50.0)*(level-1)+2);
        spd =    int((147/50.0)*(level-1)+3);
        break;
      case PRIEST:
        maxHp =  int((180/50.0)*(level-1)+20);
        str =    int((58/50.0)*(level-1)+2);
        dex =    int((78/50.0)*(level-1)+2);
        con =    int((88/50.0)*(level-1)+2);
        mag =    int((96/50.0)*(level-1)+4);
        wil =    int((145/50.0)*(level-1)+5);
        spd =    int((78/50.0)*(level-1)+2);
        maxMp =  int((180/50.0)*(level-1)+20);
        break;
      case MAGE:
        maxHp =  int((135/50.0)*(level-1)+15);
        str =    int((49/50.0)*(level-1)+1);
        dex =    int((98/50.0)*(level-1)+2);
        con =    int((68/50.0)*(level-1)+2);
        mag =    int((145/50.0)*(level-1)+5);
        wil =    int((96/50.0)*(level-1)+4);
        spd =    int((88/50.0)*(level-1)+2);
        maxMp =  int((225/50.0)*(level-1)+25);
        break;
      
      default:       hp=maxHp=1;str=1;dex=1;con=1;mag=1;wil=1;spd=1;mp=maxMp=1;break;
    }
  }
  
  public boolean gainExp( int amount )
  {
    exp += amount;
    if( exp > nextLevel )
    {
      level++;
      adjustStats();
      exp = 0;
      nextLevel = level*100;
      return true;
    }
    return false;
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
  
  public String poisonString()
  {
    int turnsLeft = poison / max(((level*2)-con),1);
    if(turnsLeft > 15)
      return "badly afflicted!";
    if(turnsLeft > 2)
      return "afflicted.";
    return "recovering.";
  }

  public boolean isCreated()
  {
    return created;
  }
  
  public color getColor()
  {
    return favColor;
  }
  
  public color getInvColor()
  {
    return inverseColor;
  }
  
  public String toString()
  {
    return name;
  }
  
  public Job getJob()
  {
    return job;
  }
  
  public String jobToString()
  {
    switch(job)
    {
      case KNIGHT:    return "Knight";
      case BARBARIAN: return "Barbarian";
      case KARATE:    return "Martial Artist";
      case THIEF:     return "Thief";
      case PRIEST:    return "Priest";
      case MAGE:      return "Mage";
      default: return "Unemployed";
    }
  }
  
  public boolean resolveAttack( int targetMonster ) //true if monster killed
  {
    battle.waitingForText = false;
    //int damage = battleMonsters[targetMonster].takeDamage(str);
    int damage = battle.calculateDamage( level, battle.isCrit(dex,battleMonsters[targetMonster].dex,true), weapon.power, str, battleMonsters[targetMonster].con, AttackType.NONE, battleMonsters[targetMonster].weakness);
    battleMonsters[targetMonster].takeDamage(damage);
    floatingNumbers.add( new GhostNumber( 160+210*targetMonster, 320, color(255), damage) );
    battle.setBattleDelay();
    battle.resumeInitiative();
    if( battleMonsters[targetMonster].alive )
      return false;
    return true;
  }
  
  public int takeDamage( int damage )
  {
    damage -= armor.power;  //subtract armor value
    damage = max(damage,1); //minimum 1 damage
    hp -= damage;
    displayTextLine( name + " takes " + damage + " damage.");
    if(hp <= 0)
    {
      hp = 0;
      alive = false;
      displayTextLine( name + " falls!" );
    }
    return damage;
  }
  
  public void heal( int amount )
  {
    if(alive)
    {
      hp += amount;
      displayTextLine(name + " is healed for " + amount + ".");
      if(hp > maxHp)
        hp = maxHp;
    }
    else
    {
      alive = true;
      hp = level;
    }
  }
  
  public void heal( int amount, boolean vapor ) //for all-group heal
  {
    if(alive)
    {
      hp += amount;
      //pushTextLine(name + " is healed for " + amount + ".");
      if(hp > maxHp)
        hp = maxHp;
    }
    else
    {
      alive = true;
      hp = level;
    }
  }
  
  public void healMana( int amount )
  {
    mp += amount;
    displayTextLine(name + " recovers " + amount + " mana.");
    if(mp > maxMp)
      mp = maxMp;
  }
  
  public void fullHeal()
  {
    hp = maxHp;
    mp = maxMp;
    poison = 0;
    poisoned=weakened=paralyzed=asleep=cursed=false;
  }
  
  public boolean inDanger()
  {
    if(hp<=maxHp/10)
      return true;
    return false;
  }
  
  public int getLevel() {return level;}
  public int getExp()   {return exp;}
  public int getNxtLvl(){return nextLevel;}
  public int getHp()    {return hp;}
  public int getMaxHp() {return maxHp;}
  public int getMp()    {return mp;}
  public int getMaxMp() {return maxMp;}
  public int getStr()   {return str;}
  public int getDex()   {return dex;}
  public int getCon()   {return con;}
  public int getMag()   {return mag;}
  public int getWill()  {return wil;}
  public boolean isAlive() {return alive;}
}
  
enum Job
{
  KNIGHT, BARBARIAN, KARATE, THIEF, PRIEST, MAGE,
  NONE
}

Job stringToJob( String s )
{
  switch(s)
  {
    case "KNIGHT":    return Job.KNIGHT;
    case "BARBARIAN": return Job.BARBARIAN;
    case "KARATE":    return Job.KARATE;
    case "THIEF":     return Job.THIEF;
    case "PRIEST":    return Job.PRIEST;
    default:          return Job.MAGE;
  }
}

/*
Base stats by class:                           At level 50 (MAX) (50 to 200)

Job    HP  Str  Dex  Con  Mag  Will  Spd       HP    Str  Dex  Con  Mag  Will Spd
Kni    30  4    3    5    0    2     2         300   120  100  130  50   100  100
Bar    35  5    3    3    0    1     2         350   150  110  100  0    70   120
Art    40  4    4    4    0    4     3         400   120  120  120  50   120  140
Thf    25  3    5    3    0    2     3         250   90   140  90   0    90   150
Pri  20/20 2    2    2    4    5     2      200/200  60   80   80   100  150  80
Mag  15/25 1    2    2    5    4     2      150/250  50   100  70   150  100  90

Max dex of 150. 150 spd should get 3 turns for every 1 turn of a character with spd 50
Crit chance = 2% + 1% per dex difference

*/

/* Poison
Enemy poison will 'deal' a certain amount, stored in the integer "poison"
Every turn, the hero will suffer an amount of damage equal to (level*2)-con, minimum 1.
That amount will be deducted from "poison" until it is emptied.
"Badly afflicted" means more than 15 turns remaining
"Afflicted" means more than 5 turns remaining
"Recovering" means more than 1 turn remaining
*/

/* Asleep
Wakes if they take damage
Wakes after enough turns/steps, more chance each step
*/

/* Paralyzed
Chance to recover each turn/step, improved by DEX
*/

/* Weakened (reduce str by level)
Chance to recover each turn, longer than sleep/para, improved by STR
*/

/* Cursed (reduce mag and wil by half)
Cannot be cured except by sleeping/powerful magic?
*/
