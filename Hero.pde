class Hero
{
  String name;
  Job job;
  color favColor, inverseColor;
  
  int maxHp, hp;
  int maxMp, mp;
  int level, nextLevel, exp;
  int str, dex, con, mag, wil, spd;
  boolean alive;
  
  //Equipment stats
  Equipment weapon, armor;
  
  //lose health,  strength reduced,  can't act,  can't act,  mag/will reduced
  boolean poisoned, weakened, paralyzed, asleep, cursed;
  int poison=0; //Damage left.
  
  boolean created;
  
  //In-battle data
  boolean defending;
  int energy;
  
  //buff data
  Buff extraStr = new Buff();
  Buff extraDex = new Buff();
  Buff extraCon = new Buff();
  Buff extraSpd = new Buff();
  
  Attack skill[] = new Attack[8];
  
  public Hero()
  {
    this("Unknown", Job.NONE, color(50), color(200) );
  }
  
  public Hero( boolean b )
  {
    created = b;
  }
  
  public Hero( String n, Job j, color c, color ic )
  {
    name = n;
    //if(name.equals(""))
    //  name = randomName();
    println( j );
    job = j;
    favColor = c;
    inverseColor = ic;
    created = true;
    assignBaseStats();
    alive = true;
    defending = false;
    
    //for testing
    weapon = new Equipment("Fist","Fist.png",0,true,3);
    if(j==Job.KARATE)
    {
      weapon = new Equipment("Fist","Fist.png",0,true,20);
      adjustFistPower();
    }
    armor = new Equipment("Shirt","BrownShirt.png",0,false,1);
    if(j==Job.SAURIAN)
    {
      armor = new Equipment("Scales","Scales.png",0,false,20);
      adjustScalePower();
    }
    
    assignSkills();
  }
  
  public void assignBaseStats()
  {
    level = 1;
    exp = 0;
    nextLevel = level*100;
    adjustStats(true);
    hp = maxHp; mp = maxMp;
    poisoned=weakened=paralyzed=asleep=cursed=false;
  }
  
  public void adjustStats( boolean first )
  {
    switch(job)
    {
      case KNIGHT:
        maxHp =  int((275/50.0)*(level-1)+25);  //25 -> 300
        str =    int((116/50.0)*(level-1)+4);
        dex =    int((97/50.0)*(level-1)+3);
        con =    int((125/50.0)*(level-1)+5);
        mag =    level; 
        wil =    int((98/50.0)*(level-1)+2);
        spd =    int((98/50.0)*(level-1)+2);
        maxMp = 0;
        break;
      case BARBARIAN:
        maxHp =  int((325/50.0)*(level-1)+25); //25 -> 350
        str =    int((145/50.0)*(level-1)+5);
        dex =    int((107/50.0)*(level-1)+3);
        con =    int((97/50.0)*(level-1)+3);
        mag =    0;
        wil =    int((69/50.0)*(level-1)+1);
        spd =    int((118/50.0)*(level-1)+2);
        maxMp = 0;
        break;
      case SAURIAN:
        maxHp =  int((385/50.0)*(level-1)+35); //35 -> 420
        str =    int((154/50.0)*(level-1)+6);
        dex =    int((69/50.0)*(level-1)+1);
        con =    int((116/50.0)*(level-1)+4);
        mag =    0;
        wil =    int((59/50.0)*(level-1)+1);
        spd =    int((69/50.0)*(level-1)+1);
        maxMp = 0;
        break;
      case KARATE:
        maxHp =  int((370/50.0)*(level-1)+30); //30 -> 400
        str =    int((116/50.0)*(level-1)+4);
        dex =    int((116/50.0)*(level-1)+4);
        con =    int((116/50.0)*(level-1)+4);
        mag =    level;
        wil =    int((116/50.0)*(level-1)+4);
        spd =    int((136/50.0)*(level-1)+3);
        maxMp = 0;
        break;
      case BARD:
        maxHp =  int((205/50.0)*(level-1)+20); //20 -> 225
        str =    int((77/50.0)*(level-1)+3);
        dex =    int((135/50.0)*(level-1)+3);
        con =    int((87/50.0)*(level-1)+2);
        mag =    int((74/50.0)*(level-1)+1);
        wil =    int((98/50.0)*(level-1)+2);
        spd =    int((127/50.0)*(level-1)+3);
        maxMp =  0;
        break;
      case THIEF:
        maxHp =  int((230/50.0)*(level-1)+20); //20 -> 250
        str =    int((87/50.0)*(level-1)+3);
        dex =    int((135/50.0)*(level-1)+5);
        con =    int((87/50.0)*(level-1)+3);
        mag =    0;
        wil =    int((88/50.0)*(level-1)+2);
        spd =    int((147/50.0)*(level-1)+3);
        maxMp = 0;
        break;
      case DRUID:
        maxHp =  int((232/50.0)*(level-1)+18); //18 -> 225
        str =    int((78/50.0)*(level-1)+2);
        dex =    int((88/50.0)*(level-1)+2);
        con =    int((98/50.0)*(level-1)+2);
        mag =    int((87/50.0)*(level-1)+3);
        wil =    int((126/50.0)*(level-1)+4);
        spd =    int((108/50.0)*(level-1)+2);
        maxMp =  int((140/50.0)*(level-1)+10); //10 -> 150
        break;
      case PRIEST:
        maxHp =  int((185/50.0)*(level-1)+15); //15 -> 200
        str =    int((58/50.0)*(level-1)+2);
        dex =    int((78/50.0)*(level-1)+2);
        con =    int((88/50.0)*(level-1)+2);
        mag =    int((96/50.0)*(level-1)+4);
        wil =    int((145/50.0)*(level-1)+5);
        spd =    int((78/50.0)*(level-1)+2);
        maxMp =  int((185/50.0)*(level-1)+15); //15 -> 200
        break;
      case MAGE:
        maxHp =  int((135/50.0)*(level-1)+15); //15 -> 150
        str =    int((49/50.0)*(level-1)+1);
        dex =    int((98/50.0)*(level-1)+2);
        con =    int((68/50.0)*(level-1)+2);
        mag =    int((145/50.0)*(level-1)+5);
        wil =    int((96/50.0)*(level-1)+4);
        spd =    int((88/50.0)*(level-1)+2);
        maxMp =  int((230/50.0)*(level-1)+20); //20 -> 250
        if( level >=5 ) //Adjust cost of FIRE spell
          skill[0].cost = 2;
        if( level >=10 ) //Adjust cost of RIME spell
          skill[1].cost = 2;
        break;
      
      default:       hp=maxHp=1;str=1;dex=1;con=1;mag=1;wil=1;spd=1;mp=maxMp=1;break;
    }
    if(!first)
      assignSkills(); //reset skill data related to stats/equipment
  }
  
  public void assignSkills()
  {
    switch( job )
    {
      case KNIGHT:
        skill[0] = new Attack("Defensive Strike", con/2, false, true, AttackStat.STR ); skill[0].cost = 2; //Puts knight into defense, adds con/2 to damage
        skill[1] = new Attack("Armor Break", str/2, false, true, AttackStat.STR ); skill[1].cost = 4;      //Cut through armor, add half strength
          skill[1].pierceArmor = true;
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", mag*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case BARBARIAN:
        skill[0] = new Attack("Blood Strike", str, false, true, AttackStat.STR ); skill[0].cost = 2;  //Loses str/5 hp, add str again
        skill[1] = new Attack("Cleave", 15, true, true, AttackStat.STR ); skill[1].cost = 4;          //Attack all enemies, +15 power
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );                                    //Group heal
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case SAURIAN:
        skill[0] = new Attack("Rend", str*2, false, false, AttackStat.STR ); skill[0].cost = 2;         //No weapon, add 2x str again
        skill[1] = new Attack("Prey", int(str*1.5), false, false, AttackStat.STR ); skill[1].cost = 4;  //No weapon, add 1.5 str, heal some of damage dealt
        skill[2] = new Attack("Bile", dex, true, false, AttackStat.STR );                               //Add dex, hit all, poison
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case KARATE:
        skill[0] = new Attack("Stone Fist", int(weapon.power*0.6), false, true, AttackStat.STR, AttackType.EARTH );  skill[0].cost = 2; //1.6x fist strength, adds earth element
        skill[1] = new Attack("Flash Punch", max(20,dex), false, true, AttackStat.STR ); skill[1].cost = 3;    //add dex, initiative goes to ~80%
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case BARD: //ayre, ballad, bossa nova, fugue, minuet, nocturne, opera, prelude, psalm, requiem, rhapsody, rondo, sonata, samba
        skill[0] = new Attack("Prelude", level/3, true, true );  skill[0].cost = 2; //Minor heal to all, restores one energy or 2mp to allies
        skill[1] = new Attack("Psalm", mag, true, false, AttackStat.MAG, AttackType.HOLY ); skill[1].cost = 4;  //add half dex, deal LEVEL poison
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case THIEF:
        skill[0] = new Attack("Knives", 5, true, true, AttackStat.STR );  skill[0].cost = 2; //Attacks all enemies
        skill[1] = new Attack("Toxin", dex/2, false, true, AttackStat.STR, AttackType.NONE, Debuff.POISON ); skill[1].cost = 4;  //add half dex, deal LEVEL poison
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case DRUID:
        skill[0] = new Attack("Divine Light", 50, false, false, AttackStat.MAG, AttackType.HOLY ); skill[0].cost = 2; //single-target holy attack
        //skill[0] = new Attack("Heal", 30, true, true ); //healing move for testing
        skill[1] = new Attack("Divine Comfort", 30, false, true ); skill[1].cost = 3; //single-target heal
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      case PRIEST:
        skill[0] = new Attack("Divine Light", 50, false, false, AttackStat.MAG, AttackType.HOLY ); skill[0].cost = 2; //single-target holy attack
        //skill[0] = new Attack("Heal", 30, true, true ); //healing move for testing
        skill[1] = new Attack("Divine Comfort", 30, false, true ); skill[1].cost = 3; //single-target heal
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
      default:
        skill[0] = new Attack("Fire", 50, false, false, AttackStat.MAG, AttackType.FIRE ); skill[0].cost = 3; if(level>4) skill[0].cost=2; //single-target fire attack
        skill[1] = new Attack("Icicle", 55, false, false, AttackStat.MAG, AttackType.ICE ); skill[1].cost = 3; if(level>9) skill[1].cost=2; //single-target ice attack
        skill[2] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[3] = new Attack("Divine Grace", str*2, true, true );
        skill[4] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[5] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[6] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        skill[7] = new Attack("Forceful Strike", str*2, false, true, AttackStat.STR );
        break;
        
        //String d, int p, boolean all, AttackStat s, AttackType t
    }
  }
  
  public boolean canAffordSkill( int index )
  {
    if( maxMp > 0 ) //is a caster
    {
      if( skill[index].cost > mp )
      {
        displayTextLine("Not enough mana.");
        return false;
      }
    }
    else  //not a caster
    {
      if( skill[index].cost > energy )
      {
        displayTextLine("Not enough energy.");
        return false;
      }
      else if( job == Job.BARBARIAN && hp <= str/5 && index==0 ) //can't afford blood strike
      {
        displayTextLine("That would kill you.");
        return false;
      }
    }
    return true;
  }
  
  public void payForSkill( int skillIndex )
  {
    if( maxMp > 0 )
      mp -= skill[skillIndex].cost;
    else
      energy -= skill[skillIndex].cost;
  }
  
  public void adjustFistPower()
  {
    weapon.power = int((70/50.0)*(level-1)+20);
  }
  
  public void adjustScalePower()
  {
    armor.power = int((70/50.0)*(level-1)+20);
  }
  
  public void energize( int amount )
  {
    energy += amount;
    if( energy > max(2,level) )
      energy = max(2,level);
  }
  
  public boolean gainExp( int amount )
  {
    exp += amount;
    if( exp > nextLevel )
    {
      level++;
      adjustStats(false);
      if( job == Job.KARATE )
        adjustFistPower();
      if( job == Job.SAURIAN )
        adjustScalePower();
      exp = 0;
      nextLevel = level*100;
      return true;
    }
    return false;
  }
  
  public boolean hasCondition(int x)
  {
    switch(x)
    {
      case 0: return poisoned;
      case 1: return asleep;
      case 2: return paralyzed;
      case 3: return weakened;
      case 4: return cursed;
    }
    return false;
  }
  
  public String poisonString()
  {
    int turnsLeft = poison / max(((level*2)-con),1);
    if(turnsLeft > 15)
      return "badly afflicted!";
    if(turnsLeft > 2)
      return "afflicted.";
    return "recovering.";
  }

  public boolean isCreated()
  {
    return created;
  }
  
  public color getColor()
  {
    return favColor;
  }
  
  public color getInvColor()
  {
    return inverseColor;
  }
  
  public String toString()
  {
    return name;
  }
  
  public Job getJob()
  {
    return job;
  }
  
  public String jobToString()
  {
    switch(job)
    {
      case KNIGHT:    return "Knight";
      case BARBARIAN: return "Barbarian";
      case SAURIAN:   return "Saurian";
      case KARATE:    return "Martial Artist";
      case BARD:      return "Bard";
      case THIEF:     return "Thief";
      case DRUID:     return "Druid";
      case PRIEST:    return "Priest";
      case MAGE:      return "Mage";
      default: return "Unemployed";
    }
  }
  
  public boolean resolveAttack( int targetMonster ) //true if monster killed
  {
    int damage = 0;
    int weaponPower = 0;
    if(skillSelection != -1 && skill[skillSelection].useWeapon) //is a skill that uses weapon's power
      weaponPower = int(weapon.power);
    battle.waitingForText = false;
    if( skillSelection == -1 ) //normal attack
    {
      damage = battle.calculateDamage( level, battle.isCrit(dex+extraDex.amount,battleMonsters[targetMonster].dex,true), weapon.getPower(), str, battleMonsters[targetMonster].con, weapon.element, battleMonsters[targetMonster].weakness);
      battleMonsters[targetMonster].takeDamage(damage);
      floatingNumbers.add( new GhostNumber( 150+210*targetMonster, 320, appropriateColor(weapon.element), damage) );
      
      //Resolve status attack (status weapon)
      switch(weapon.status)
      {
        case NONE:
          break;
        case POISON:
          float largeRandom = random(100);  //25% chance
          float smallChance = 25;
          if( largeRandom < max(1,smallChance+damage-battleMonsters[targetMonster].con) )
            battleMonsters[targetMonster].poison((int)(weapon.power/7.5),targetMonster);
      }
    }
    else //skill
    {
      //converting non-elemental attacks to weapon's type
      AttackType skillType = skill[skillSelection].type; 
      if( skillType == AttackType.NONE && !skill[skillSelection].healing && skill[skillSelection].useWeapon )
        skillType = weapon.element;
      
      if( skill[skillSelection].targetAll )
      {
        for(int i = 0; i < 3; i++)
          if(battleMonsters[i].alive)
          {
            damage = battle.calculateDamage( level, 1, weaponPower+skill[skillSelection].power, appropriateStat( skill[skillSelection] ), battleMonsters[i].appropriateDefense( skill[skillSelection] ), skillType, battleMonsters[i].weakness );
            battleMonsters[i].takeDamage(damage);
            floatingNumbers.add( new GhostNumber( 150+210*i, 320, appropriateColor(skillType), damage) );
            if( !battleMonsters[i].alive )
              battle.list[i+3].active = false;
          }
      }
      else
      {
        damage = battle.calculateDamage( level, battle.isCrit(dex+extraDex.amount,battleMonsters[targetMonster].dex,true), weaponPower+skill[skillSelection].power, appropriateStat( skill[skillSelection] ), battleMonsters[targetMonster].appropriateDefense( skill[skillSelection] ), skillType, battleMonsters[targetMonster].weakness );
        battleMonsters[targetMonster].takeDamage(damage);
        floatingNumbers.add( new GhostNumber( 150+210*targetMonster, 320, appropriateColor(skillType), damage) );
      }
      
      //Resolve status skill (need another for normal attacks with status weapons)
      if(skill[skillSelection].debuff!=Debuff.NONE)
      {
        switch(skill[skillSelection].debuff)
        {
          case POISON:  //skills always poison successfully
            //float largeRandom = random(100);
            //float smallRandom = 25; //this doesn't need to be random
            //if( largeRandom < max(1,smallRandom+damage-battleMonsters[targetMonster].con) )
            battleMonsters[targetMonster].poison(level,targetMonster);
        }
      }
    }
    
    //calculateDamage( int level, int crit, int wepPower, int attackStr, int defense, AttackType aType, AttackType dType )
    
    //battle.setBattleDelay();
    //battle.resumeInitiative();
    //skillSelection = -1;
    if( battleMonsters[targetMonster].alive )
      return false;
    return true;
  }
  
  void handleSkillEffect( boolean beforeAttack, int skillIndex )
  {
    println("Turn: " + battle.turn);
    //println("Attacker: " + battle.attackerIndex );
    //println("Defender: " + battle.defenderIndex );
    if( beforeAttack )
    {
      switch( job )
      {
        case KNIGHT:
          if(skillIndex==0) //defensive strike
            defending = true;
          break;
          
        case BARBARIAN:
          if(skillIndex==0) //blood strike
            takeDamage(str/5,false); //take 20% of str as damage
          break;
         
      }
    }
    else
    {
      switch( job )
      {
        case SAURIAN:
          if(skillIndex==1) //prey
          {
            heal( battleMonsters[battle.defenderIndex-3].con );
            floatingNumbers.add( new GhostNumber( 150+210*battle.attackerIndex, 550, color(0,200,0), battleMonsters[battle.defenderIndex-3].con ) );
          }
          break;
        
        case BARD:
          if(skillIndex == 0 ) //Prelude
          {
            for(int i = 0; i < 3; i++)
              if( battle.turn != i )
              {
                party.hero[i].energize(1);
                party.hero[i].healMana(1);
              }
          }
          break;
        
        case KARATE:
          if(skillIndex == 1 ) //flash punch
            battle.list[battle.turn].counter = 15*party.averageLevel() + 100;
          break; 
      }
    }
  }
  
  public void resolveHeal( int target )
  {
    battle.waitingForText = false;
    int amount = battle.calculateDamage( level, 1, skill[skillSelection].power, mag, 1);
    party.hero[target].heal(amount);
    floatingNumbers.add( new GhostNumber( 150+210*target, 550, color(100,255,100), amount) );
    //battle.setBattleDelay();
    //battle.resumeInitiative();
    //skillSelection = -1;
  }
  
  public int takeDamage( int damage, boolean displayText )
  {
    damage = max(damage,1); //minimum 1 damage
    hp -= damage;
    if(displayText)
      displayTextLine( name + " takes " + damage + " damage.");
    if(job == Job.BARBARIAN && display == Display.BATTLE && skillSelection !=0) //shouldn't energize from self-infliction
      energize(1);
    if(job == Job.KNIGHT && display == Display.BATTLE && defending)
      energize(2);
    if(hp <= 0)
    {
      hp = 0;
      energy = 0;
      alive = false;
      poison = 0;
      poisoned = asleep = paralyzed = weakened = cursed = false;
      defending = false;
      displayTextLine( name + " falls!" );
    }
    return damage;
  }
  
  int appropriateStat( Attack a )
  {
    if( a.stat == AttackStat.DEX )
      return dex+extraDex.amount;
    if( a.stat == AttackStat.MAG )
      return mag;
    else
      return str;
  }
  
  int appropriateDefense( Attack a )
  {
    if( a.stat == AttackStat.DEX || a.stat == AttackStat.STR )
    {
      if( defending )
        return (con + int(armor.power)/2)*2;
      else
        return con + int(armor.power)/2;
    }
    else
      return wil;
  }
  
  public void heal( int amount )
  {
    if(alive)
    {
      hp += amount;
      displayTextLine(name + " is healed for " + amount + ".");
      if(hp > maxHp)
        hp = maxHp;
    }
    else
    {
      alive = true;
      hp = min(amount,maxHp/10); //revivie with 10% or amount healed, whichever is lower
      if( maxMp == 0 )
        energy = 1 + level/5;
    }
  }
  
  public void heal( int amount, boolean vapor ) //for all-group heal
  {
    if(alive)
    {
      hp += amount;
      //pushTextLine(name + " is healed for " + amount + ".");
      if(hp > maxHp)
        hp = maxHp;
    }
    else
    {
      alive = true;
      hp = level;
    }
  }
  
  //I may have existing poison logic I forgot about
  public void poison( int amount, int x )
  {
    floatingNumbers.add( new GhostNumber( 150+210*x, 500, color(100,100,0), "POISON") );
    poisoned = true;
    poison += max(1,amount-con);
  }
  
  public boolean takePoisonDamage( int heroPos ) //true if hero dies
  {
    if(poison<=0)
      return false;
    int poisonDamage = max(poison/3,1); //minimum 1 damage
    poison -= poisonDamage;
    hp -= poisonDamage;
    if(hp > 0)
      displayTextLine( name + " suffers " + poisonDamage + " poison damage.");
    floatingNumbers.add( new GhostNumber( 150+210*heroPos, 550, color(100,100,0), poisonDamage) );
    if(hp <= 0)
    {
      hp = 0;
      energy = 0;
      alive = false;
      poison = 0;
      poisoned = asleep = paralyzed = weakened = cursed = false;
      defending = false;
      displayTextLine( name + "collapses!" );
      return true;
    }
    if(poison<=0)
    {
      poison = 0;
      poisoned = false;
    }
    return false;
  }
  
  public void healMana( int amount )
  {
    mp += amount;
    displayTextLine(name + " recovers " + amount + " mana.");
    if(mp > maxMp)
      mp = maxMp;
  }
  
  public void fullHeal()
  {
    hp = maxHp;
    mp = maxMp;
    poison = 0;
    poisoned=weakened=paralyzed=asleep=cursed=false;
    alive = true;
  }
  
  public boolean inDanger()
  {
    if(hp<=maxHp/10)
      return true;
    return false;
  }
  
  public int getLevel() {return level;}
  public int getExp()   {return exp;}
  public int getNxtLvl(){return nextLevel;}
  public int getHp()    {return hp;}
  public int getMaxHp() {return maxHp;}
  public int getMp()    {return mp;}
  public int getMaxMp() {return maxMp;}
  public int getStr()   {return str;}
  public int getDex()   {return dex;}
  public int getCon()   {return con;}
  public int getMag()   {return mag;}
  public int getWill()  {return wil;}
  public boolean isAlive() {return alive;}
}
  
enum Job
{
  KNIGHT, BARBARIAN, SAURIAN,  KARATE, BARD, THIEF,  DRUID, PRIEST, MAGE,
  NONE
}

Job stringToJob( String s )
{
  switch(s)
  {
    case "KNIGHT":    return Job.KNIGHT;
    case "BARBARIAN": return Job.BARBARIAN;
    case "SAURIAN":   return Job.SAURIAN;
    case "KARATE":    return Job.KARATE;
    case "BARD":      return Job.BARD;
    case "THIEF":     return Job.THIEF;
    case "DRUID":     return Job.DRUID;
    case "PRIEST":    return Job.PRIEST;
    default:          return Job.MAGE;
  }
}

/*
Base stats by class:                           At level 50 (MAX) (50 to 150)

Job    HP  Str  Dex  Con  Mag  Will  Spd       HP    Str  Dex  Con  Mag  Will Spd
Kni    30  4    3    5    0    2     2         300   120  100  130  50   100  100     25
Bar    35  5    3    3    0    1     2         350   150  110  100  0    70   120     25
Sar    35  6    1    4    0    1     1         420   160  70   120  0    60   70      35
Art    40  4    4    4    0    4     3         400   120  120  120  50   120  140     30
Brd    20  3    3    2    1    2     3         225   80   120  90   75   100  130     20
Thf    25  3    5    3    0    2     3         250   90   140  90   0    90   150     20
Drd    18  2    2    2    3    4     2      250/150  80   90   100  90   130  110     18/10
Pri  20/20 2    2    2    4    5     2      200/200  60   80   80   100  150  80      15/15
Mag  15/25 1    2    2    5    4     2      150/250  50   100  70   150  100  90      15/20

Max dex of 150. 150 spd should get 3 turns for every 1 turn of a character with spd 50
Crit chance = 2% + 1% per dex difference

*/

/*

Abilities:
Priest and Mage use MP to power abilities
Others use Power, which charges by one per turn (max of lvl, caps out at 48)
Start with 1 + level/10 power?
Martial Artists starts with twice as much as others (more)
Knight gets +2 when hit while defending
Barbarian gains +1 when damaged
Thief gains +5 on crits instead of +1
Saurian gains +1 when attacking
Bard gains +1 when allies use abilities/spells

Abilties cost 2*level energy to use. (2,4,6,8,10,12,14,16) (with exceptions)
Spells have various costs

Knight
  Defensive Strike (turn on defense)
  Armor Break (attack that ignores part of enemy CON)
  
  Divine Grace (heal all)
Barbarian
  Blood Strike (spend str/5 HP to increase damage)
  Cleave       (attack all)
Saurian
  Rend
  Prey
  Bile
Artist
  Stone Fist   (earth element attack)
  Flash Punch (adds dex, initiative bar goes to 80% full)
Bard
  Prelude (minor heal plus one energy)
  
Thief
  Knives       (attack all)
  Toxin        (poisons target)
Druid
  Wolf Form    (physical damage to single target)
  Healing Wind (light heal to all)
  
Priest
  Smite        (holy element attack)
  Heal         (single-target heal

Mage
  Fire         (fire element attack)
  Icicle       (ice element attack)
  
*/

/* Druid Transformations
Druid's odd numbered spells will transform it into an animal
When transformed, cannot use items and spell list is replaced with REVERT option
Forms will increase stats or add element/status to attacks

NO, DECIDED AGAINST THIS. Too complicated to integrate to existing system
Transformations will deliver a single attack

Turtle - adds con
Viper - adds poison
Bear - adds strength
Tiger/Lion  Wolf  Panther
*/

/* Poison
Enemy poison will 'deal' a certain amount, stored in the integer "poison"
Every turn, the hero will suffer an amount of damage equal to (level*3)-con, minimum 1.
That amount will be deducted from "poison" until it is emptied.
"Badly afflicted" means more than 15 turns remaining
"Afflicted" means more than 5 turns remaining
"Recovering" means more than 1 turn remaining
*/

/* Asleep
Wakes if they take damage
Wakes after enough turns/steps, more chance each step
*/

/* Paralyzed
Chance to recover each turn/step, improved by DEX
*/

/* Weakened (reduce str by level)
Chance to recover each turn, longer than sleep/para, improved by STR
*/

/* Cursed (reduce mag and wil by half)
Cannot be cured except by sleeping/powerful magic?
*/


//------------//
class Buff //for improving abilties during battle
{
  int amount;
  int duration;
  boolean active;
  
  public Buff()
  {
    amount = 0;
    duration = 0;
    active = false;
  }
  
  public boolean tick() //one round is removed from duration, return true if finished
  {
    duration --;
    if(duration <= 0)
    {
      duration = 0;
      amount = 0;
      return true;
    }
    return false;
  }
}
