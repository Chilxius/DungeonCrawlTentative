//Only one instance of this class will be used.
//Handles the battle until one side is dead.

class Battle
{
  Initiative [] list = new Initiative[6];
  int turn = -1; //whose turn it is once their initiative triggers
  int initiativeTicker = 0; //which fighter's initiative is ticking up
  boolean waitingForText = false;
  
  //For standard attacks (one charcter damaging one character)
  int attackerIndex, defenderIndex;
  
  int enemyAttackIndex = 0;
  
  boolean battleDelayed = false;
  DelayType delayType = DelayType.NONE;
  int battleDelayCounter = 0; //used for timed events in battle
  
  String [] startBattleMessage = {
  "Monsters approach!", "Prepare for battle!", "Danger!", "Wild monsters appear!",
  "To arms!", "Get ready to fight!", "To battle!", "It's time to fight!",
  "Monsters!", "Foes approach!", "Here they come!", "To battle!",
  "Let battle be joined!", "They are relentless!", "Peace was never an option." };
  
  boolean battleOver = false; //triggers end-of-battle report
  EndStage end = EndStage.NONE;
  int heroExpCheck = 0; //which hero's exp is being checked for level up
  
  int exp = 0;
  int gold = 0;
  
  public Battle( Hero [] h, int danger, int bossIndex ) //bossIndex will be -1 unless it is a boss fight
  {                                                     //in that situation, danger level does not matter
    if(currentBoss == -1) //bosses have their own message, handled in bonkText
      displayTextLine( randomMessage() );
      
    for(int i = 0; i < 3; i++)
    {
      if(party.hero[i].maxMp==0)
        party.hero[i].energy = party.hero[i].level/5 + 1;
      if(party.hero[i].job == Job.KARATE )
        party.hero[i].energize( party.hero[i].level/5 + 1 );
    }
       
    list[0] = new Initiative(h[0].name,0,h[0].spd,h[0].alive);
    list[1] = new Initiative(h[1].name,1,h[1].spd,h[1].alive);
    list[2] = new Initiative(h[2].name,2,h[2].spd,h[1].alive);
    
    battleMonsters[0] = battleMonsters[1] = battleMonsters[2] = new Monster(); //zero out old monsters
    
    if(currentBoss == -1) //regular encounter
    {
      battleMonsters[0] = new Monster( zoo.monsterByDanger(danger) );
      while(battleMonsters[1].name.equals("EMPTY")) //can't have empty group
        battleMonsters[1] = new Monster( zoo.monsterByDanger(danger) );
      battleMonsters[2] = new Monster( zoo.monsterByDanger(danger) );
    }
    else
    {
      battleMonsters[1] = zoo.boss[currentBoss];
      if(multiBoss)
      {
        multiBoss = false;
        battleMonsters[0] = new Monster( zoo.boss[currentBoss] );
        battleMonsters[2] = new Monster( zoo.boss[currentBoss] );
      }
    }
      
    list[3] = new Initiative(battleMonsters[0],3);
    list[4] = new Initiative(battleMonsters[1],4);
    list[5] = new Initiative(battleMonsters[2],5);
    
    party.hero[0].defending = party.hero[1].defending = party.hero[2].defending = false;
  }
  
  public void resumeInitiativeTick()
  {
    turn = -1;
  }
      //FIX PROBLEM: battle not ending when monsters all dead
  public boolean runBattle() //true if battle still running
  {
    if(!battleDelayed) //these commands will run once the battle delay timer ends
    {
      if( end != EndStage.NONE ) //if battle is over and exp/gold are being given out  OR  game over
      {
          switch( end )
          {
            case EXP:  //checking for levelups
              if(heroExpCheck >=3) //done with levelup check
                end = EndStage.GOLD;
              else if( !list[heroExpCheck].active ) //hero dead
                heroExpCheck++; //ready for next hero
              else
              {
                if( party.hero[heroExpCheck].gainExp(exp) ) //gain exp and return true if leveled up
                {
                  displayTextLine( list[heroExpCheck].name + " is now level " + party.hero[heroExpCheck].level );
                  setBattleDelay();
                }
                heroExpCheck++; //ready for next hero
                return true;
              }
              break;
              
            case GOLD:  //party gains gold
              if( gold > 0 )
              {
                party.gold += gold;
                displayTextLine( "Party loots " + gold + " coins." );
                setBattleDelay();
              }
              end = EndStage.DONE;
              break;
              
            case DONE: //battle fully over
              if(currentBoss!=-1)
              {
                m[party.floor].tiles[bossSwitches[currentBoss].X][bossSwitches[currentBoss].Y].removeBoss();
                bossSwitches[currentBoss].active=false;
                currentBoss = -1; //switch off boss mode
              }
              return false;
          }
      }
      else if(turn == -1 && !waitingForText) //No one's turn and not waiting for text to advance
      {
        //println(list[initiativeTick].name + " ticked up to " + list[initiativeTick].counter);
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
      else if(delayType == DelayType.ATTACK) //someone is attacking (or using a skill)
      {
        if(attackerIndex<3) //hero //<>//
        {
          if( skillSelection == -1 ) //normal attack
          {
            if( party.hero[attackerIndex].resolveAttack(defenderIndex-3) )
            {
              displayTextLine( list[defenderIndex].name + " is vanquished!");
              list[defenderIndex].active = false;
            }
            //add energy
            if( turn < 3 && party.hero[turn].maxMp == 0 )
              party.hero[turn].energize(1);
          }
          else  //skill
          {
            if(party.hero[turn].skill[skillSelection].healing) //is a healing skill
            {
              if( party.hero[turn].skill[skillSelection].targetAll ) //<>//
              {
                party.hero[turn].resolveHeal(0);
                party.hero[turn].resolveHeal(1);
                party.hero[turn].resolveHeal(2);
              }
              else
              {
                party.hero[turn].resolveHeal(defenderIndex);
              }
              //battle.setBattleDelay();
              //battle.resumeInitiative();
              //skillSelection = -1;
            }
            else //is an attack ( multi-attack handled in Hero.resolveAttack() )
            {
              if( party.hero[turn].resolveAttack(defenderIndex-3) )
              {
                displayTextLine( list[defenderIndex].name + " is vanquished!");
                list[defenderIndex].active = false;
              }
            }
          }
          battle.setBattleDelay();
          battle.resumeInitiative();
          skillSelection = -1;
        }
        else if(attackerIndex>2) //monster
        {
          battleMonsters[attackerIndex-3].resolveAttack(defenderIndex);
        }
        attackerIndex = defenderIndex = 0;
      }
      
      //Monster chooses target and attacks (might need to go somewhere else)
      if( turn > 2 && !gameover)
      {
        int targetChoice;
        do
        {
          targetChoice = int(random(3));
        }
        while( !party.hero[targetChoice].alive );
        
        beginAttack(turn, targetChoice );
      }
    }
    else
    {
      if( millis() > battleDelayCounter )
        battleDelayed = false;
    }
    
    
    if( !battleOver && ( party.partyDead() || monstersDead() ) )
    {
      if( party.partyDead() )
      {
        displayTextLine("Your heroes have fallen in battle.");
      }
      //displayTextLine(victoryLine(exp));    //NOT WORKING
      else
      {
        displayTextLine("Victory!          EXP: " + exp);
        setBattleDelay(2);
        party.hero[0].energy = party.hero[1].energy = party.hero[2].energy = 0;
        end = EndStage.EXP;
        battleOver = true;
      }
    }
    return true;
  }
  
  private String victoryLine( int xp )
  {
    String returnValue = "";
    returnValue += "Victory!";
    while( returnValue.length() < (39 - 5 - Integer.toString(xp).length()) ) //39 is the size of messages lines
      returnValue+=' ';
    returnValue += "EXP: " + xp;
    println(returnValue);
    return returnValue;
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
    
    if( skillSelection != -1 && party.hero[turn].skill[skillSelection].healing ) //switch index to heroes for healing skills
      defenderIndex-=3;
    
    if(turn<3) //hero attack
    {
      if( skillSelection == -1 )
        displayTextLine(list[attackerIndex].name + " attacks " + list[defenderIndex].name + "!");
      else
      {
        party.hero[attackerIndex].payForSkill(skillSelection);
        party.hero[attackerIndex].handleSkillEffect(skillSelection);
        displayTextLine(list[attackerIndex].name + " uses " + party.hero[attackerIndex].skill[skillSelection].description + "!");
      }
    }
    else
    {
      enemyAttackIndex = int(random(5)); //choose random attack for monster to use
      displayTextLine(list[attackerIndex].name + " " + battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].description );
    }
    setBattleDelay();
    battleDelayed = true;
    waitingForText = true;
    delayType = DelayType.ATTACK;
    input = Input.NONE;
  }
  
  public void setBattleDelay() //delays by a number of seconds equal to battleSpeed
  {
    setBattleDelay( battleTextSpeed );
  }
  
  public void setBattleDelay( int delay ) //delays by a number of seconds equal to delay
  {
    battleDelayCounter = millis() + (delay*1000);
    battleDelayed = true;
  }
  
  private String randomMessage()
  {
    return startBattleMessage[int(random(startBattleMessage.length))];
  }
  
  public int isCrit( int attackerDex, int defenderDex, boolean heroAttack ) //1 for normal hit, 2 for crit
  {
    int chance = 2;
    chance += (max(0,attackerDex-defenderDex));
    
    if( int( random(100) ) <= chance )
    {
      if(heroAttack)
      {
        vanGogh.startScreenShake(40,true);
        if(party.hero[attackerIndex].maxMp==0)
          party.hero[attackerIndex].energize(1);
        if(party.hero[attackerIndex].job==Job.THIEF)
          party.hero[attackerIndex].energize(4);
      }
      else
        vanGogh.startScreenShake(40,false);
      return 2;
    }
    return 1;
  }
  
  public int calculateDamage( int level, int crit, int wepPower, int attackStr, int defense ) //enemies can't get type advantage
  {
    return calculateDamage(level, crit, wepPower, attackStr, defense, AttackType.NONE, AttackType.NONE );
  }
  
  public int calculateDamage( int level, int crit, int wepPower, int attackStr, int defense, AttackType aType, AttackType dType )
  {
    int type =1;
    if(aType==dType && aType!=AttackType.NONE)
      type = 2;
    int random = (int)random(217,255);
    return (int)((((((2.0*level*crit)/5.0)+2.0)*wepPower*attackStr/max(0,defense))/50.0)+2.0)*type*random/255;
  }
}
  
public enum DelayType
{
  ATTACK, NONE
}

public enum EndStage
{
  NONE, EXP, GOLD, DONE
}

//Calculate Damage Example:
/*
//level 50 flareon using tackle against an abra

float damage;
float level = 50;
float crit = 1;
float power = 35;
float attack = 40;
float defense = 17;
float type = 1;
float random;

float highest = 0, lowest = 10000;

for(int i = 0; i < 20; i++)
{
  random = (int)random(217,255);
  damage = ((((((2.0*level*crit)/5.0)+2.0)*power*attack/defense)/50.0)+2.0)*type*random/255;
  print(damage + " ");
  if( damage > highest)
    highest = damage;
  if( damage < lowest )
    lowest = damage;
}

println( "Highest: " + highest + "     Lowest: " + lowest );
*/
