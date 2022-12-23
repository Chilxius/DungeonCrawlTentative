class Battle
{
  Initiative [] list = new Initiative[6];
  int turn = -1; //whose turn it is once their initiative triggers
  int initiativeTicker = 0; //which fighter's initiative is ticking up
  boolean waitingForText = false;
  
  int battleSpeed = 1; //speed battle text displays
  
  //For standard attacks (one charcter damaging one character)
  int attackerIndex, defenderIndex;
  
  boolean battleDelayed = false;
  DelayType delayType = DelayType.NONE;
  int battleDelayCounter = 0; //used for timed events in battle
  
  public Battle( Hero [] h, int danger )
  {
    list[0] = new Initiative(h[0].name,0,h[0].spd,h[0].alive);
    list[1] = new Initiative(h[1].name,1,h[1].spd,h[1].alive);
    list[2] = new Initiative(h[2].name,2,h[2].spd,h[1].alive);
    
    battleMonsters[0] = battleMonsters[1] = battleMonsters[2] = new Monster(); //zero out old monsters
    
    battleMonsters[0] = new Monster( zoo.monsterByDanger(danger) );
    while(battleMonsters[1].name.equals("EMPTY")) //can't have empty group
      battleMonsters[1] = new Monster( zoo.monsterByDanger(danger) );
    battleMonsters[2] = new Monster( zoo.monsterByDanger(danger) );
    
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
    if(!battleDelayed) //these commands will run once the battle delay timer ends
    {
      //No one's turn and not waiting for text to advance
      if(turn == -1 && !waitingForText)
      {
        //println(list[initiativeTick].name + " ticked up to " + list[initiativeTick].counter); //<>//
        checkForActive(initiativeTicker); //checks for alive/dead
        if(list[initiativeTicker].tick())
        {
          turn = initiativeTicker;
          println("TURN: " + list[turn].name);
          if(turn<3) //Set input to allow battle commands
          {
            displayTextLine( party.hero[turn].name + "'s turn. What will you do?" );
            input = Input.BATTLE_MENU;
            party.hero[turn].defending = false;
          }
        }
        else
          initiativeTicker++;
        if(initiativeTicker>=list.length)
          initiativeTicker = 0;
      }
      else if(delayType == DelayType.ATTACK) //someone is using basic attack
      {
        if(attackerIndex<3) //hero
        {
          if( party.hero[attackerIndex].resolveAttack(defenderIndex-3) )
          {
            displayTextLine( list[defenderIndex].name + " is vanquished!");
          }
        }
        else if(attackerIndex>2) //monster
        {
          battleMonsters[attackerIndex-3].resolveAttack(defenderIndex);
        }
        attackerIndex = defenderIndex = 0;
      }
      
      //testing
      if( turn > 2 )
      {
        beginAttack(turn, int(random(3)) );
      }
      
      /*
      //old version of monster attack
      if( turn >= 3 ) //Monster's turn
      {
        if(!waitingForText)
          battleMonsters[turn-3].makeAttack();
        else
          battleMonsters[turn-3].resolveAttack();
      }
      */
      
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
    //This may be redundant now
    if( ( turn < 3 && !party.hero[turn].alive )
     || ( turn > 2 && !battleMonsters[turn-3].alive ) )
      list[turn].active = false;

    list[turn].counter = 0;
    turn = -1;
    delayType = DelayType.NONE;
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
  
  public void checkForActive( int index ) //sets ACTIVE status to ALIVE status - dead characters won't get turns
  {
    if( index < 3 )
      list[index].active = party.hero[index].alive;
    else
      list[index].active = battleMonsters[index-3].alive;
  }
  
  public void beginAttack( int a, int d )
  {
    attackerIndex = a;
    defenderIndex = d;
    
    displayTextLine(list[attackerIndex].name + " attacks " + list[defenderIndex].name + "!");
    setBattleDelay();
    battleDelayed = true;
    waitingForText = true;
    delayType = DelayType.ATTACK;
    input = Input.NONE;
  }
  
  public void setBattleDelay() //delays by a number of seconds equal to battleSpeed
  {
    setBattleDelay( battleSpeed );
  }
  
  public void setBattleDelay( int delay ) //delays by a number of seconds equal to delay
  {
    battleDelayCounter = millis() + (delay*1000);
    battleDelayed = true;
  }
}
  
public enum DelayType
{
  ATTACK, NONE
}
