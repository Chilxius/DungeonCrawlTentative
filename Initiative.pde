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
    speed = s;
    counter = 0;
    active = a;
  }
  
  public boolean tick()
  {
    if(active)
      counter += speed;
    if(counter >= 20*party.averageLevel())
      return true;
    return false;
  }
}
