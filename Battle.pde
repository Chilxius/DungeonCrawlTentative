class Battle
{
  Initiative [] list = new Initiative[6];
  int turn = -1; //whose turn it is once their initiative triggers
  int initiativeTicker = 0; //which fighter's initiative is ticking up
  boolean waitingForText = false;
  
  boolean battleDelayed = false;
  int battleDelayCounter = 0; //used for timed events in battle
  
  public Battle( Hero [] h, int danger )
  {
    list[0] = new Initiative(h[0].name,0,h[0].spd);
    list[1] = new Initiative(h[1].name,1,h[1].spd);
    list[2] = new Initiative(h[2].name,2,h[2].spd);
    
    battleMonsters[0] = zoo.monsterByDanger(danger);
    while(battleMonsters[1].name.equals("EMPTY")) //can't have empty group
      battleMonsters[1] = zoo.monsterByDanger(danger);
    battleMonsters[2] = zoo.monsterByDanger(danger);
    
    list[3] = new Initiative(battleMonsters[0],3);
    list[4] = new Initiative(battleMonsters[1],4);
    list[5] = new Initiative(battleMonsters[2],5);
  }
  
  public void resumeInitiativeTick()
  {
    turn = -1;
  }
  
  public boolean runBattle() //true if battle still running
  {
    if(!battleDelayed)
    {
      //No one's turn and not waiting for text to advance
      if(turn == -1 && !waitingForText)
      {
        //println(list[initiativeTick].name + " ticked up to " + list[initiativeTick].counter); //<>//
        if(list[initiativeTicker].tick())
        {
          turn = initiativeTicker;
          println("TURN: " + list[turn].name);
          if(turn<3) //Set input to allow battle commands
            input = Input.BATTLE_MENU;
        }
        else
          initiativeTicker++;
        if(initiativeTicker>=list.length)
          initiativeTicker = 0;
      }
      
        
      if( turn >= 3 ) //Monster's turn
      {
        battleMonsters[turn-3].makeAttack();
      }
      
      //if( turn < 3 && turn > -1) //Hero turn
      //{
      //  input = Input.BATTLE_MENU;
      //}
    }
    else
    {
      if( millis() > battleDelayCounter )
        battleDelayed = false;
    }
    
    
    if( playersDead() || monstersDead() )
      return false;
    return true;
  }
  
  public void resumeInitiative()
  {
    if( turn < 3 && !party.hero[turn].alive
     || turn > 2 && !battleMonsters[turn-3].alive )
      list[turn].active = false;

    list[turn].counter = 0;
    turn = -1;
  }
  
  public boolean playersDead()
  {
    if( !list[0].active && !list[1].active && !list[2].active )
       return true;
    return false;
  }
  
  public boolean monstersDead()
  {
    if( !list[3].active && !list[4].active && !list[5].active )
      return true;
    return false;
  }
  
  public void setBattleDelay( int time )
  {
    battleDelayCounter = millis() + (time*1000);
    battleDelayed = true;
  }
}
