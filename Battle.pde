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
  float battleDelayCounter = 0; //used for timed events in battle
  
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
      if(party.hero[i].job == Job.BARD )
        party.hero[i].bardBonus += party.hero[i].level/10;
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
      else
      {
        zoo.checkForMooks( battleMonsters[1].name );
      }
    }
      
    addSubscripts();
    
    list[3] = new Initiative(battleMonsters[0],3);
    list[4] = new Initiative(battleMonsters[1],4);
    list[5] = new Initiative(battleMonsters[2],5);
    
    party.hero[0].defending = party.hero[1].defending = party.hero[2].defending = false;
  }
  
  //Assign A, B, C to monster names
  void addSubscripts()
  {
    //Monsters that don't get subscripts
    if( battleMonsters[0].name == "Spirit Light" )
      return;
      
    if( battleMonsters[0].name == battleMonsters[1].name && battleMonsters[1].name == battleMonsters[2].name )
    {
      battleMonsters[0].name += " A";
      battleMonsters[1].name += " B";
      battleMonsters[2].name += " C";
    }
    if( battleMonsters[0].name == battleMonsters[1].name )
    {
      battleMonsters[0].name += " A";
      battleMonsters[1].name += " B";
    }
    if( battleMonsters[0].name == battleMonsters[2].name )
    {
      battleMonsters[0].name += " A";
      battleMonsters[2].name += " B";
    }
    if( battleMonsters[1].name == battleMonsters[2].name )
    {
      battleMonsters[1].name += " A";
      battleMonsters[2].name += " B";
    }
  }
  
  public void resumeInitiativeTick()
  {
    turn = -1;
  }

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
              //Hand icon color changes after each battle
              handIndex = (handIndex+1)%3;
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
          //println("TURN: " + list[turn].name);
          if(turn<3) //Set input to allow battle commands
          {
            if(party.hero[turn].poisoned && party.hero[turn].takePoisonDamage(turn)) //died of poison
            {
              list[turn].counter = 0;
              turn = -1;
              delayType = DelayType.NONE; //<>// //<>//
              //resumeInitiativeTick();
            }
            else
            {
              displayTextLine( party.hero[turn].name + "'s turn. What will you do?" );
              input = Input.BATTLE_MENU;
              party.hero[turn].defending = false;
            }
          }
          else //I hope this is where monster poison should go - could cause poblems
          {
            if(battleMonsters[turn-3].poisoned && battleMonsters[turn-3].takePoisonDamage(turn-3)) //died of poison
            {
              list[turn].counter = 0;
              turn = -1;
              delayType = DelayType.NONE;
              //resumeInitiativeTick();
            }
          }
        }
        else
          initiativeTicker++;
        if(initiativeTicker>=list.length)
          initiativeTicker = 0;
      }
      else if(delayType == DelayType.ATTACK) //someone is attacking (or using a skill)
      {
        if(attackerIndex<3) //hero
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
            {
              party.hero[turn].energize(1);
              if( party.hero[turn].job == Job.SAURIAN )
                party.hero[turn].energize(1);
            }
          }
          else if( skillSelection > 7 ) //bomb attack
          {
            if( party.hero[attackerIndex].resolveAttack(defenderIndex-3) )
            {
              displayTextLine( list[defenderIndex].name + " is vanquished!");
              list[defenderIndex].active = false;
            }
          //  //add energy
          //  if( turn < 3 && party.hero[turn].maxMp == 0 )
          //  {
          //    party.hero[turn].energize(1);
          //    if( party.hero[turn].job == Job.SAURIAN )
          //      party.hero[turn].energize(1);
          //  }
          }
          else  //skill
          {
            addEnergyToBard(turn);
            if(party.hero[turn].skill[skillSelection].healing) //is a healing skill
            {
              if( party.hero[turn].skill[skillSelection].targetAll )
              {
                party.hero[turn].resolveHeal(0);
                party.hero[turn].resolveHeal(1);
                party.hero[turn].resolveHeal(2);
              }
              else
              {
                party.hero[turn].resolveHeal(defenderIndex);
              }
            }
            else if(party.hero[turn].skill[skillSelection].type == AttackType.BUFF ) //is a buffing skill
            {
              //SKIPPING THE RESOLVEATTACK() PHASE - HOPE THIS WORKS OUT
              battle.waitingForText = false; //  <- first thing that was handled in resolveAttack()
            }
            else //is an attack ( multi-attack handled in Hero.resolveAttack() )
            {
              if( party.hero[turn].resolveAttack(defenderIndex-3) )
              {
                //displayTextLine( list[defenderIndex].name + " is vanquished!"); //was displaying for already dead monsters
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
        displayTextLine("The Veil draws near.");
      }
      //displayTextLine(victoryLine(exp));    //NOT WORKING
      else
      {
        displayTextLine("Victory!          EXP: " + exp);
        setBattleDelay(2);
        party.hero[0].energy    = party.hero[1].energy    = party.hero[2].energy = 0;
        party.hero[0].bardBonus = party.hero[1].bardBonus = party.hero[2].bardBonus = 0;
        for(Hero h: party.hero) for(Buff b: h.buff) b.deactivate();
        end = EndStage.EXP;
        checkAllForActive(); // <- should keep dead characters from gaining exp, and ensure alive characters get exp
        battleOver = true;
      }
    }
    return true;
  }
  
  private void addEnergyToBard( int index )
  {
    if( index != 0 && party.hero[0].job == Job.BARD )
      party.hero[0].energize(1);
    if( index != 1 && party.hero[1].job == Job.BARD )
      party.hero[1].energize(1);
    if( index != 2 && party.hero[2].job == Job.BARD )
      party.hero[2].energize(1);
  }
  
  private String victoryLine( int xp )
  {
    String returnValue = "";
    returnValue += "Victory!";
    while( returnValue.length() < (39 - 5 - Integer.toString(xp).length()) ) //39 is the size of messages lines
      returnValue+=' ';
    returnValue += "EXP: " + xp;
    //println(returnValue);
    return returnValue;
  }
  
  public void resumeInitiative() //also contains end-of-attack effects
  {
    //This may be redundant now
    if( ( turn < 3 && !party.hero[turn].alive )
     || ( turn > 2 && !battleMonsters[turn-3].alive ) )
      list[turn].active = false;

    list[turn].counter = 0;
    if(attackerIndex<3)
    {
      party.hero[attackerIndex].handleSkillEffect(false,skillSelection);  //handle after-attack effects
      party.hero[attackerIndex].reduceBuffs();
    }
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
  
  public void checkAllForActive()
  {
    for(int i = 0; i < 3; i++)
      list[i].active = party.hero[i].alive;
  }
  
  public void beginAttack( int a, int d )
  {
    attackerIndex = a;
    defenderIndex = d;
    
    if( skillSelection != -1 && party.hero[turn].skill[skillSelection].healing ) //switch index to heroes for healing skills
      defenderIndex-=3;
    
    if(turn<3) //hero attack
    {
      if( skillSelection == -1 ) //not a skill
      {
        displayTextLine(list[attackerIndex].name + " attacks " + list[defenderIndex].name + "!");
        vanGogh.addAnimation( party.hero[turn].weapon.animationType, attackerIndex, defenderIndex);
      }
      else
      {
        //Animation or skills
        vanGogh.runSkillAnimation( party.hero[turn].job, skillSelection, party.hero[attackerIndex].skill[skillSelection], attackerIndex, d );
        
        //if( party.hero[attackerIndex].skill[skillSelection].targetAll ) //Run animation for all alive monsters
        //{
        //  for( int i = 0; i < 3; i++ )
        //    if( list[3+i].active )
        //      vanGogh.addAnimation( party.hero[attackerIndex].skill[skillSelection].animationType, 3+i );
        //}
        //else
        //  vanGogh.addAnimation( party.hero[attackerIndex].skill[skillSelection].animationType, defenderIndex );
        
        party.hero[attackerIndex].payForSkill(skillSelection);
        party.hero[attackerIndex].handleSkillEffect(true,skillSelection);
        String outputText = list[attackerIndex].name + " uses "+ party.hero[attackerIndex].skill[skillSelection].description + "!";
        if(outputText.length() < 40) //+ party.hero[attackerIndex].skill[skillSelection].description + "!"
          displayTextLine(outputText);
        else
        {
          displayTextLine(list[attackerIndex].name + " attacks with "); //+ party.hero[attackerIndex].skill[skillSelection].description + "!");
          displayTextLine(party.hero[attackerIndex].skill[skillSelection].description + "!");
        }
      }
    }
    else
    {
      enemyAttackIndex = int(random(5)); //choose random attack for monster to use
      
      if( battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].targetAll ) //Multi-target animation
      {
        for( int i = 0; i < 3; i++ )
          if( list[i].active )
            vanGogh.addAnimation( battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].animationType, attackerIndex, i );
      }
      else //Single-target
        vanGogh.addAnimation( battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].animationType, attackerIndex, defenderIndex );
      
      String outputText = list[attackerIndex].name + " " + battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].description;
      if(outputText.length() < 40)
        displayTextLine(list[attackerIndex].name + " " + battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].description );
      else
      {
        displayTextLine(list[attackerIndex].name);
        displayTextLine(battleMonsters[attackerIndex-3].attacks[enemyAttackIndex].description );
      }
    }
    setBattleDelay();
    battleDelayed = true;
    waitingForText = true;
    delayType = DelayType.ATTACK;
    input = Input.NONE;
  }
  
  public void throwBomb( int a, int d )
  {
    attackerIndex = a;
    defenderIndex = d;
    
    //party.hero[attackerIndex].payForSkill(skillSelection);
    //println( "POTION TYPE: " + potionType );
    //if( potionType == 8 )
    //  party.reagents -= 5;
    //else
    //  party.reagents -= potionType-4;
    party.reagents -= bombCost(potionType);
    
    //party.hero[attackerIndex].handleSkillEffect(true,skillSelection);
    String outputText = list[attackerIndex].name + " throws a" + bombName(potionType) + " bomb!";
    displayTextLine(outputText);
    
    vanGogh.addAnimation( bombName(potionType), a, d );
    setBattleDelay();
    battleDelayed = true;
    waitingForText = true;
    delayType = DelayType.ATTACK;
    input = Input.NONE;
  }
  
  public void setBattleDelay() //delays by a number of seconds equal to battleSpeed
  {
    if( vanGogh.fastAnimation )
    {
      vanGogh.fastAnimation = false;
      setBattleDelay( battleTextSpeed/2 );
    }
    else
      setBattleDelay( battleTextSpeed );
  }
  
  public void setBattleDelay( float delay ) //delays by a number of seconds equal to delay
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
    float type =1;
    if(aType==dType && aType!=AttackType.NONE)
      type = 1.5;
    int random = (int)random(217,255);
    //println("ATTACK:\nWeapon: "+wepPower+"\nPower: "+attackStr+"\nDefense: "+defense);
    return (int)(((((((2.0*level*crit)/5.0)+2.0)*wepPower*attackStr/max(1,defense))/50.0)+2.0)*type*random/255);
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
