//This class represents the attacks monster use and
//the special attacks the heroes use. Can be given
//elemental types, can be flagged to attack all
//three targets, can be flagged to heal allies (for
//heroes only)

class Attack
{
  int power;
  int cost = 0;
  
  boolean useWeapon;
  boolean targetAll;
  boolean healing;
  boolean pierceArmor = false;
  
  AttackType type;
  AttackStat stat;
  
  String description;
  String secondLine;
  
  Debuff debuff;
  
  public Attack( Attack a ) //for copying attacks
  {
    description = a.description;
    power = a.power;
    useWeapon = a.useWeapon;
    targetAll = a.targetAll;
    healing = a.healing;
    stat = a.stat;
    type = a.type;
    cost = a.cost;
  }
  
  public Attack( String d ) //for turn wasteing moves
  {
    description = d;
    power = 0;
    useWeapon = false;
    targetAll = false;
    healing = false;
    stat = AttackStat.STR;
    type = AttackType.WASTE;
  }
  
  public Attack( String d, String s ) //for buffing moves
  {
    description = d;
    secondLine = s;
    power = 0;
    useWeapon = false;
    targetAll = true;    //avoids the confirmation keypress
    healing = false;
    stat = AttackStat.NONE;
    type = AttackType.BUFF;
  }
  
  public Attack( String d, int p, boolean all, boolean heal ) //healing move
  {
    description = d;
    power = p;
    targetAll = all;
    healing = heal;
    stat = AttackStat.MAG;
    type = AttackType.HOLY;
  }
  
  public Attack( String d, int p, boolean all ) //normal physical attacks
  {
    this(d,p,all,true,AttackStat.STR,AttackType.NONE);
  }
  
  public Attack( String d, int p, boolean all, Debuff bad  ) //normal physical attacks with status ailments
  {
    this(d,p,all,true,AttackStat.STR,AttackType.NONE,bad);
  }
  
  public Attack( String d, int p, boolean all, boolean wep, AttackStat s ) //attacks that use different stats but have no type
  {
    this(d,p,all,wep,s,AttackType.NONE);
  }
  
  public Attack( String d, int p, boolean all, boolean wep, AttackType t ) //attacks that use str stats but have an attack type
  {
    this(d,p,all,wep,AttackStat.STR,t);
  }
  
  public Attack( String d, int p, boolean all, AttackStat s, AttackType t ) //typical monster skill (no weapon)
  {
    this(d,p,all,false,s,t);
  }

  public Attack( String d, int p, boolean all, boolean wep, AttackStat s, AttackType t ) //description, power, does it hit all, used stat, attack type
  {
    this( d, p, all, wep, s, t, Debuff.NONE );
    //description = d;
    //power = p;
    //targetAll = all;
    //useWeapon = wep;
    //healing = false;
    //stat = s;
    //type = t;
  }

  public Attack( String d, int p, boolean all, boolean wep, AttackStat s, AttackType t, Debuff bad ) //description, power, does it hit all, used stat, attack type, debuff type
  {
    description = d;
    power = p;
    targetAll = all;
    useWeapon = wep;
    healing = false;
    stat = s;
    type = t;
    debuff = bad;
  }
  
  public color appropriateColor()
  {
    switch(type)
    {
      case FIRE:
        return color(200,0,0);
      case ICE:
        return color(0,0,200);
      case WIND:
        return color(0,200,0);
      case EARTH:
        return color(200,150,50);
      case HOLY:
        return color(255,255,0);
      default:
        return color(255);
    }
  }
}


public enum AttackStat
{
  NONE, STR, DEX, MAG
}

public enum AttackType
{
  NONE, FIRE, ICE, WIND, EARTH, HOLY, WASTE, BUFF
}

public enum Debuff
{
  NONE, POISON, SLEEP, PARA, WEAK, CURSE
}
