class Initiative
{
  String name;
  int index; //0-2 will be heroes, 3-5 will be enemies
  int speed;
  float counter;
  boolean active;
  
  public Initiative( int i )
  {
    name = "NONE";
    index = i;
    speed = 0;
    counter = 0;
    active = false;
  }
  
  public Initiative( Monster m, int i )
  {
    this(m.name, i, m.spd, m.alive);
  }
  
  public Initiative( String n, int i, int s, boolean a )
  {
    name = n;
    index = i;
    speed = s+10;
    counter = random((20*party.averageLevel() + 100)*0.8);
    active = a;
  }
  
  public boolean tick()
  {
    if(active)
      counter += speed;
    if(counter >= 20*party.averageLevel() + 100) //Wait time adjusts with party level, the +100 normalizes speeds so thief doesn't go too often
      return true;
    return false;
  }
}
