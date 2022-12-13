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
    switch(job)
    {
      case KNIGHT:   hp=maxHp=30;str=4;dex=3;con=5;mag=0;wil=2;spd=2;break;
      case BARBARIAN:hp=maxHp=40;str=5;dex=3;con=3;mag=0;wil=1;spd=2;break;
      case KARATE:   hp=maxHp=45;str=4;dex=4;con=4;mag=0;wil=4;spd=3;break;
      case THIEF:    hp=maxHp=25;str=3;dex=5;con=3;mag=0;wil=2;spd=3;break;
      case PRIEST:   hp=maxHp=20;str=2;dex=2;con=2;mag=4;wil=5;spd=2;mp=maxMp=20;break;
      case MAGE:     hp=maxHp=15;str=1;dex=2;con=2;mag=5;wil=4;spd=2;mp=maxMp=25;break;
      default:       hp=maxHp=1;str=1;dex=1;con=1;mag=1;wil=1;spd=1;mp=maxMp=1;break;
    }
    level = 1;
    exp = 0;
    nextLevel = 50;
    poisoned=weakened=paralyzed=asleep=cursed=false;
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
  
  public void takeDamage( int damage )
  {
    hp -= (max(damage-armor.power,1));
    displayTextLine( name + " takes " + damage + " damage.");
    if(hp <= 0)
    {
      hp = 0;
      alive = false;
      pushTextLine( name + " falls!" );
    }
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
  KNIGHT, MAGE, THIEF, PRIEST, BARBARIAN, KARATE,
  NONE
}

Job stringToJob( String s )
{
  switch(s)
  {
    case "KNIGHT": return Job.KNIGHT;
    case "BARBARIAN": return Job.BARBARIAN;
    case "KARATE": return Job.KARATE;
    case "THIEF": return Job.THIEF;
    case "PRIEST": return Job.PRIEST;
    default: return Job.MAGE;
  }
}

/*
Base stats by class:

Job    HP  Str  Dex  Con  Mag  Will
Kni    30  4    3    5    1    2
Bar    40  5    3    3    0    1
Art    45  4    4    4    2    4
Thf    25  3    5    3    1    2
Pri    20  2    2    2    4    5
Mag    15  1    2    2    5    4

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
