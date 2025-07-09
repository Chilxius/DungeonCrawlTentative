//This class represents the attacks monsters use and
//the special attacks the heroes use. Can be given
//elemental types, can be flagged to attack all
//three targets, can be flagged to heal allies (for
//heroes only)

class Attack
{
  int power;
  int cost = 0;
  
  boolean useWeapon;
  boolean nonElemental;
  boolean targetAll;
  boolean healing;
  boolean pierceArmor = false;
  
  AttackType type;
  AttackStat stat;
  
  String description;
  String secondLine;
  
  String fullDescription = "NO DATA";
  String animationType;
  
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
    animationType = a.animationType;
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
    animationType = "H";
  }
  
  public Attack( String d, int p, boolean all, boolean heal ) //healing move
  {
    description = d;
    power = p;
    targetAll = all;
    healing = heal;
    stat = AttackStat.MAG;
    type = AttackType.HOLY;
    animationType = "H";
  }
  
  public Attack( String d, int p, boolean all, String ani ) //normal physical attacks
  {
    this(d,p,all,true,AttackStat.STR,AttackType.NONE,ani);
  }
  
  public Attack( String d, int p, boolean all, Debuff bad, String ani  ) //normal physical attacks with status ailments
  {
    this(d,p,all,true,AttackStat.STR,AttackType.NONE,bad,ani);
  }
  
  public Attack( String d, int p, boolean all, boolean wep, AttackStat s, String ani ) //attacks that use different stats but have no type
  {
    this(d,p,all,wep,s,AttackType.NONE,ani);
  }
  
  public Attack( String d, int p, boolean all, boolean wep, AttackType t, String ani ) //attacks that use str stats but have an attack type
  {
    this(d,p,all,wep,AttackStat.STR,t,ani);
  }
  
  public Attack( String d, int p, boolean all, AttackStat s, AttackType t, String ani ) //typical monster skill (no weapon)
  {
    this(d,p,all,false,s,t,ani);
  }

  public Attack( String d, int p, boolean all, boolean wep, AttackStat s, AttackType t, String ani ) //description, power, does it hit all, used stat, attack type
  {
    this( d, p, all, wep, s, t, Debuff.NONE, ani );
    //description = d;
    //power = p;
    //targetAll = all;
    //useWeapon = wep;
    //healing = false;
    //stat = s;
    //type = t;
  }

  public Attack( String d, int p, boolean all, boolean wep, AttackStat s, AttackType t, Debuff bad, String ani ) //description, power, does it hit all, used stat, attack type, debuff type
  {
    description = d;
    power = p;
    targetAll = all;
    useWeapon = wep;
    healing = false;
    stat = s;
    type = t;
    debuff = bad;
    animationType = ani;
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
  NONE, STR, DEX, MAG, WIL
}

public enum AttackType
{
  NONE, FIRE, ICE, WIND, EARTH, HOLY, WASTE, BUFF
}

public enum Debuff
{
  NONE, POISON, SLEEP, PARA, WEAK, CURSE
}
