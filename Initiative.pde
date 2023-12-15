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
    {
      if( index < 3 ) //Handle stopped-initiative conditions for party
      {
        if( party.hero[index].asleep ) //try to wake up
        {
          println( "Sleep left: " + party.hero[index].sleep );
          if( party.hero[index].wake() )
          {
            battle.setBattleDelay();
            displayTextLine( party.hero[index].wakeMessage() );
          }
          return false;
        }
        else if( party.hero[index].paralyzed ) //try to limber up
        {
          if( party.hero[index].limber() )
          {
            battle.setBattleDelay();
            displayTextLine( party.hero[index].limberMessage() );
          }
          return false;
        }
      }
      else if( index > 2 ) //for monsters
      {
        if( battleMonsters[index-3].asleep ) //if asleep
        {
          if( battleMonsters[index-3].wake() ) //try to wake up
          {
            battle.setBattleDelay();  //pause and anounce waking up
            displayTextLine( battleMonsters[index-3].wakeMessage() );
          }
          return false; //either way, do not advance initiative
        }
        if( battleMonsters[index-3].paralyzed  ) //as above
        {
          if( battleMonsters[index-3].limber() )
          {
            battle.setBattleDelay();
            displayTextLine( battleMonsters[index-3].limberMessage() );
          }
          return false;
        }
      }
      
      counter += speed;
      if( index < 3 && party.hero[index].buff[4].active ) //if is a hero with speed boost
        counter += party.hero[index].buff[4].amount;
    }
    if(counter >= 20*party.averageLevel() + 100) //Wait time adjusts with party level, the +100 normalizes speeds so thief doesn't go too often
      return true;
    return false;
  }
}
