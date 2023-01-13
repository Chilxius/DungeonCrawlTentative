class Attack
{
  int power;
  
  boolean targetAll;
  
  AttackType type;
  AttackStat stat;
  
  String description;
  
  public Attack( Attack a )
  {
    description = a.description;
    power = a.power;
    targetAll = a.targetAll;
    stat = a.stat;
    type = a.type;
  }
  
  public Attack( String d )
  {
    description = d;
    power = 0;
    targetAll = false;
    stat = AttackStat.STR;
    type = AttackType.WASTE;
  }
  
  public Attack( String d, int p, boolean all, AttackStat s )
  {
    this(d,p,all,s,AttackType.NONE);
  }

  public Attack( String d, int p, boolean all, AttackStat s, AttackType t )
  {
    description = d;
    power = p;
    targetAll = all;
    stat = stat;
    type = t;
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
