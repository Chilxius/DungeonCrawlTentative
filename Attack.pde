class Attack
{
  int power;
  
  boolean targetAll;
  boolean healing;
  
  AttackType type;
  AttackStat stat;
  
  String description;
  
  public Attack( Attack a ) //for copying attacks
  {
    description = a.description;
    power = a.power;
    targetAll = a.targetAll;
    healing = a.healing;
    stat = a.stat;
    type = a.type;
  }
  
  public Attack( String d ) //for turn wasteing moves
  {
    description = d;
    power = 0;
    targetAll = false;
    healing = false;
    stat = AttackStat.STR;
    type = AttackType.WASTE;
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
    this(d,p,all,AttackStat.STR,AttackType.NONE);
  }
  
  public Attack( String d, int p, boolean all, AttackStat s ) //attacks that use different stats but have no type
  {
    this(d,p,all,s,AttackType.NONE);
  }
  
  public Attack( String d, int p, boolean all, AttackType t ) //attacks that use str stats but have an attack type
  {
    this(d,p,all,AttackStat.STR,t);
  }

  public Attack( String d, int p, boolean all, AttackStat s, AttackType t ) //description, power, does it hit all, used stat, attack type
  {
    description = d;
    power = p;
    targetAll = all;
    healing = false;
    stat = s;
    type = t;
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
  STR, DEX, MAG
}

public enum AttackType
{
  NONE, FIRE, ICE, WIND, EARTH, HOLY, WASTE
}
