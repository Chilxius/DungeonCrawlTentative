//This object will be responsible for the game's
//illustrations. Mostly this is to keep the main
//program clean (Processing can't collapse methods)

//Battle animations class in this tab

//Loading images function in this tab

class Artist
{
  float animationStage;
  float animationStep;
  
  color rand1, rand2, rand3, rand4;
  boolean battleWindowOpening = false;
  
  float savePointFloat;
  float savePointStep;
  
  float textPromptStep;
  float textPromptStage;
  
  float noteStage;
  float noteStep;
  color noteColor[] = {color(200,100,100),color(200,200,100),color(100,100,200),color(200,100,200),color(200,150,100),
                        color(100,200,100),color(200,100,150),color(100,200,200),color(200,200,200),color(100,100,100),};
  
  boolean resting = false;
  boolean restFadeIn = true;
  int restOpacity = 0;
  
  int screenShakeAmountX = 0;
  int screenShakeAmountY = 0;
  boolean screenShaking = false;
  boolean shakeLeft = true;
  boolean shakeUp = true;
  
  float gameoverOpacity = 0;
  
  String locationTitleCard = "";
  float titleCardDuration = 0;
  PImage skillIcon[][] = new PImage[9][8];
  PImage skillButton[] = new PImage[9];
  PImage blackVanguard;
  
  boolean fastAnimation = false; //for half-delay skills (ex: flash punch)
  
  public Artist()
  {
    animationStage = 0;
    animationStep = 0.3;
    savePointFloat = 0;
    savePointStep = .05;
    textPromptStage = 0;
    textPromptStep = 1;
    noteStage = 0;
    noteStep = .01;
    rand1 = color(random(255),random(255),random(255));
    rand2 = color(random(255),random(255),random(255));
    rand3 = color(random(255),random(255),random(255));
    rand4 = color(random(255),random(255),random(255));
    loadSkillIcons();
  }
  
  public void animate()
  {
    animationStage+=animationStep;
    if(animationStage < 0 || animationStage>159)
      animationStage = 0;
    savePointFloat += savePointStep;
    if(savePointFloat <= 0 || savePointFloat > 5)
      savePointStep *=-1;
    textPromptStage+=textPromptStep;
    if(textPromptStage <=0 || textPromptStage > 50)
      textPromptStep*=-1;
    noteStage+=noteStep;
    if(noteStage >= TWO_PI)
      noteStage-=TWO_PI;
    
    //Battle animations
    for(int i = animations.size()-1; i >= 0; i--)
    {
      animations.get(i).run();
      if( animations.get(i).stage > animations.get(i).endStage )
        animations.remove(i);
    }
  }
  
  public void addAnimation( int type, int u, int target )
  {
    animations.add( new Animation( type, u, target ) );
  }
  
  public void addAnimation( String name, int u, int target )
  {
    if( name == null )
    {
      if(debugMode) println("Null Attack");
      return;
    }
    
    int typeIndex = -1;
    
    switch( name )
    {
      case "block":     typeIndex = 1; break;
      case "slash":
      case "S":         typeIndex = 2; break;
      case "punch":
      case "B":         typeIndex = 3; break;
      case "heal":
      case "H":         typeIndex = 4; break;
      case " Flame":    typeIndex = 5; break;
      case "n Ice":     typeIndex = 6; break;
      case "n Acid":    typeIndex = 7; break;
      case " Thunder":  typeIndex = 8; break;
      case "pierce":
      case "P":         typeIndex = 9; break;
      case "bite":
      case "T":/*teeth*/typeIndex = 10; break;
      
      case " ": typeIndex = 0; break;
      
      default: typeIndex = 0;
    }
    
    addAnimation( typeIndex, u, target );
  }
  
  void runSkillAnimation( Job j, int index, Attack skill, int user, int target )
  {
    int jobIndex = jobToNumber(j);
    if( skill.targetAll ) //Run animation for all alive monsters
    {
      //Check if it targets friendlies
      if( skill.type == AttackType.BUFF || skill.healing )
      {
        for(int i = 0; i < 3; i++)
          if( skill.healing || battle.list[i].active ) //If hero is alive or skill heals
            animations.add( new Animation( jobIndex, index, user, target ) );
            //vanGogh.addAnimation( skill.animationType, user, i );
      }
      else //Targets baddies
      {
        for( int i = 0; i < 3; i++ )
          if( battle.list[3+i].active )
            animations.add( new Animation( jobIndex, index, user, 3+i ) );
            //vanGogh.addAnimation( skill.animationType, user, 3+i );
      }
    }
    else //Single target
    {
      if( skill.type == AttackType.BUFF || skill.healing )
        animations.add( new Animation( jobIndex, index, user, target-3 ) );
        //vanGogh.addAnimation( skill.animationType, user, target-3 );
      else
        animations.add( new Animation( jobIndex, index, user, target ) );
        //vanGogh.addAnimation( skill.animationType, user, target );
    }
  }
  
  public float stage()
  {
    return animationStage;
  }
  
  public void randomizeColors()
  {
    rand1 = color(random(255),random(255),random(255));
    rand2 = color(random(255),random(255),random(255));
    rand3 = color(random(255),random(255),random(255));
    rand4 = color(random(255),random(255),random(255));
  }
  
  public void drawLocationTitleCard()
  {
    titleCardDuration--;
    textSize(35*fontScale);
    textAlign(CENTER);
    fill(255,255*(titleCardDuration/100.0));
    text(locationTitleCard,350,185);
  }
  
  public void startLocationTitleCard( String title )
  {
    locationTitleCard = title;
    titleCardDuration = 255;
    if(zoneNumber != getZone(title))
    {
      zoneNumber = getZone(title);
      //Start new music track                  <- NEW MUSIC TRACKS START HERE
      //crossFade(zoneNumber);
      //changeTrack(zoneNumber);
    }
  }
  
  public void checkLocationForTitleCard( int f, int x, int y ) //For non-door switches
  {
    if( f == 2 )
    {
      if( x == 53 && ( y == 47 || y == 48 ) && zoneNumber != 5 )
        startLocationTitleCard( "Baron's Field" );
        
      if( x == 68 && ( y == 47 || y == 48 ) && zoneNumber != 4 )
        startLocationTitleCard( "Irohill" );
    }
    if( f == 4 )
    {
      if( x == 66 && ( y == 82 || y == 83 || y == 84 ) && zoneNumber != 4 )
        startLocationTitleCard( "Gullhaven" );
      if( (x == 72 || x == 73 || x == 74 ) && y == 78 && zoneNumber != 12 )
        startLocationTitleCard( "Waraka Sea Road" );
      if( (x == 38 || x == 39 ) && y == 66  && zoneNumber != 3 )
        startLocationTitleCard( "Honeydell" );
      if( ((x == 9 && y == 48) || ( (x == 8 || x == 9 || x == 10) && y == 72) ) && zoneNumber != 3 )
        startLocationTitleCard( "Looted Village" );
    }
  }
  
  public void drawMainMenu()
  {
    noFill();
    stroke(255);
    strokeWeight(6);
    rectMode(CENTER);
    rect(frameWidth/2,frameHeight/2,frameWidth-frameWidth/5,frameHeight-frameHeight/5,20);

    //Scroll
    noStroke();
    rectMode(CENTER);
    fill(195,175,135);
    rect(frameWidth/2,frameHeight/4-20,460,70);
    fill(90,70,30);
    rect(frameWidth/2,frameHeight/4-20-32,480,6);
    rect(frameWidth/2,frameHeight/4-20+32,480,6);
    fill(180,160,120);
    rect(frameWidth/2,frameHeight/4-20-32,470,14,5);
    rect(frameWidth/2,frameHeight/4-20+32,470,14,5);
    
    textSize(45*fontScale);
    fill(127);
    textAlign(CENTER);
    text("The Riddle of Iron",frameWidth/2,frameHeight/4-5);
    
    textSize(20*fontScale);
    fill(255);
    text("Enter the name of your game file.",frameWidth/2,frameHeight/2-10);
    text("If no file with that name exists,",frameWidth/2,frameHeight/2+30);
    text("a new file will be created.",frameWidth/2,frameHeight/2+70);
  }
  
  public void drawKeys( Key keys[] )
  {
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    rect(100,100,frameWidth-200,frameHeight-200,20);
    
    fill(200); textAlign(LEFT); textSize(25*fontScale);
    text("Keys you have collected:",120,130);
    textSize(20*fontScale);
    for(int i = 0,j = 0; i < keys.length; i++)
      if(keys[i]!=Key.NONE)
      { 
        text(keyName(keys[i]),120+(250*int(j/15)),(130+30*(j+1))-(450*int(j/15)));
        j++;
      }
  }
  
  public void drawItems( Item [] items ) //add gold in side window and loot sack
  {      
    if(party.gold > 0)
      drawGoldBox();
    if(party.reagents > 0)
      drawReagentBox();
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    //rect(10,height-320,110,200,20); //loot box
    rect(100,100,frameWidth-200,frameHeight-200,20); //main window
    
    fill(200); textAlign(LEFT); textSize(25*fontScale);
    text("Your Inventory:",120,130);
    textAlign(RIGHT); textSize(10*fontScale);
    text("press (s) to sort",580,115);
    textSize(20*fontScale); textAlign(LEFT);
    for(int i = 0; i < items.length; i++)
      if(items[i].value!=0)
      {
        textAlign(LEFT);
        text(items[i].toString(),130+(230*int(i/15)),(130+30*(i+1))-(450*int(i/15)));
        textAlign(RIGHT);
        text(items[i].value,330+(240*int(i/15)),(130+30*(i+1))-(450*int(i/15)));
      }
      else
      {
        textAlign(LEFT);
        text("__________",120+(230*int(i/15)),(130+30*(i+1))-(450*int(i/15)));
        //println((130+30*(i+1))-(450*int(1/15)));
      }

  }
  
  public void drawFoodMenu( Item [] items )
  {
    fill(255,127);
    rect(215,195,305,35);
    rect(215,275,305,35);
    int breadCount=0,porkCount=0,fruitCount=0,crabCount=0;
    
    for( Item i : items )
      if( i.value == 10 )
        breadCount++;
      else if( i.value == 20 )
        porkCount++;
      else if( i.value == 30 )
        fruitCount++;
      else if( i.value == 40 )
        crabCount++;
    
    drawFoodSynergyBox(breadCount,porkCount,fruitCount,crabCount);
        
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(100,100,frameWidth-200,frameHeight-200,20);
    
    noStroke(); textAlign(LEFT); textSize(20*fontScale); imageMode(CENTER);
    if(breadCount>0) { checkMouseInFoodBox(0); fill(#F2CE69,50); rect(205,185,385,45,20); image(tileImage[82],230,510); fill(255); text(":"+breadCount,250,515); }
    if(porkCount>0)  { checkMouseInFoodBox(1); fill(#B46C31,50); rect(205,265,385,45,20); image(tileImage[83],330,510); fill(255); text(":"+porkCount, 350,515); }
    if(fruitCount>0) { checkMouseInFoodBox(2); fill(#00FF28,50); rect(205,345,385,45,20); image(tileImage[84],430,510); fill(255); text(":"+fruitCount,450,515); }
    if(crabCount>0)  { checkMouseInFoodBox(3); fill(#FF0032,50); rect(205,425,385,45,20); image(tileImage[85],530,510); fill(255); text(":"+crabCount, 550,515); }
    
    fill(200); textAlign(CENTER); textSize(40*fontScale);
    text("Select Meal",frameWidth/2,150);
    
    noStroke();
    //Fork
    fill(180);
    rect(145,250,20,130,10);
    rect(140,350,30,180,20);
    rect(175,175,10,80,5);
    rect(125,175,10,80,5);
    rect(150,175,10,80,5);
    rect(125,245,60,10);
    /*
    //Knife
    fill(180);
    rect(530,390,30,180,20);
    beginShape();
    vertex(560,145);
    vertex(560,390);
    vertex(530,390);
    bezierVertex(530,390,530,115,560,145);
    endShape();
    */  
    fill(200); textAlign(LEFT); textSize(35*fontScale);
    if(breadCount>0)
      text("1 - "+party.nextFoodName(0),210,220);
    if(porkCount>0)
      text("2 - "+party.nextFoodName(1),210,300);
    if(fruitCount>0)
      text("3 - "+party.nextFoodName(2),210,380);
    if(crabCount>0)
      text("4 - "+party.nextFoodName(3),210,460);
      
    fill(200); textAlign(CENTER); textSize(25*fontScale);
    text("Select by number or",frameWidth/2,560);
    text("press space to cancel.",frameWidth/2,580);
    
    //Draw clickable cancel arrow
    image( mouseUXImage[9], 650,550);
  }
  
  public void checkMouseInFoodBox( int index ) //highlights food options when moused over
  {
    if( mouseX > 230 && mouseX < 615 )
    {
      if( mouseY > 210+(index*80) && mouseY < 255+(index*80) )
      {
        stroke(200);
        strokeWeight(2);
      }
      else
      {
        noStroke();
      }
    }
    else
    {
      noStroke();
    }
  }
  
  public void drawPotionMenu( Item [] items )
  {
    int healthPots=0,manaPots=0,vapors=0,elixers=0;
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    rect(100,100,frameWidth-200,frameHeight-200,20);
        
    fill(200); textAlign(CENTER); textSize(40*fontScale);
    text("Select Potion",frameWidth/2,150);
    
    //drawPotion(150,200,1,rand1);
    //drawPotion(150,400,1,rand2);
    //drawPotion(530,200,1,rand3);
    //drawPotion(530,400,1,rand4);
    push();
    imageMode(CENTER);
    image( tileImage[93], 150, 200 );
    image( tileImage[91], 150, 325 );
    image( tileImage[92], 150, 450 );
    image( tileImage[90], 530, 200 );
    image( tileImage[132], 530, 325 );
    image( tileImage[133], 530, 450 );
    pop();
        
    for( Item i : items )
      if( i.value == 12 )
        healthPots++;
      else if( i.value == 24 )
        manaPots++;
      else if( i.value == 36 )
        vapors++;
      else if( i.value == 48 )
        elixers++;
    
    fill(200); textAlign(LEFT); textSize(35*fontScale);
    if(healthPots>0)
      text("1 - Health: "+healthPots,210,220);
    if(manaPots>0)
      text("2 - Mana: "+manaPots,210,300);
    if(vapors>0)
      text("3 - Vapor: "+vapors,210,380);
    if(elixers>0)
      text("4 - Elixer: "+elixers,210,460);
      
    fill(200); textAlign(CENTER); textSize(25*fontScale);
    text("Select by number or",frameWidth/2,560);
    text("press space to cancel.",frameWidth/2,580);
    
    //Draw clickable cancel arrow
    imageMode(CENTER);
    image( mouseUXImage[9], 650,550);
  }
  
  public void loadSkillIcons()
  {
    //Knight
    skillButton[0] = loadImage("KnightSkill.png");    skillButton[0].resize(60,0);
    skillIcon[0][0] = loadImage("DefenseStrike.png"); skillIcon[0][0].resize(60,0);
    skillIcon[0][1] = loadImage("ArmorBreak.png");    skillIcon[0][1].resize(60,0);
    skillIcon[0][2] = loadImage("divineGrace.png");   skillIcon[0][2].resize(60,0);
    skillIcon[0][3] = loadImage("YellowSlime.png");   skillIcon[0][3].resize(60,0);
    skillIcon[0][4] = loadImage("YellowSlime.png");   skillIcon[0][4].resize(60,0);
    skillIcon[0][5] = loadImage("YellowSlime.png");   skillIcon[0][5].resize(60,0);
    skillIcon[0][6] = loadImage("YellowSlime.png");   skillIcon[0][6].resize(60,0);
    skillIcon[0][7] = loadImage("YellowSlime.png");   skillIcon[0][7].resize(60,0);
    //Barbarian
    skillButton[1] = loadImage("BarbSkill.png");      skillButton[1].resize(60,0);
    skillIcon[1][0] = loadImage("BloodStrike.png");   skillIcon[1][0].resize(60,0);
    skillIcon[1][1] = loadImage("Cleave.png");        skillIcon[1][1].resize(60,0);
    skillIcon[1][2] = loadImage("bloodRage.png");     skillIcon[1][2].resize(60,0);
    skillIcon[1][3] = loadImage("YellowSlime.png");   skillIcon[1][3].resize(60,0);
    skillIcon[1][4] = loadImage("YellowSlime.png");   skillIcon[1][4].resize(60,0);
    skillIcon[1][5] = loadImage("YellowSlime.png");   skillIcon[1][5].resize(60,0);
    skillIcon[1][6] = loadImage("YellowSlime.png");   skillIcon[1][6].resize(60,0);
    skillIcon[1][7] = loadImage("YellowSlime.png");   skillIcon[1][7].resize(60,0);
    //Karate
    skillButton[2] = loadImage("ThiefSkill.png");     skillButton[2].resize(60,0);
    skillIcon[2][0] = loadImage("StoneFist.png");     skillIcon[2][0].resize(60,0);
    skillIcon[2][1] = loadImage("FlashPunch.png");    skillIcon[2][1].resize(60,0);
    skillIcon[2][2] = loadImage("hurricaneKick.png"); skillIcon[2][2].resize(60,0);
    skillIcon[2][3] = loadImage("YellowSlime.png");   skillIcon[2][3].resize(60,0);
    skillIcon[2][4] = loadImage("YellowSlime.png");   skillIcon[2][4].resize(60,0);
    skillIcon[2][5] = loadImage("YellowSlime.png");   skillIcon[2][5].resize(60,0);
    skillIcon[2][6] = loadImage("YellowSlime.png");   skillIcon[2][6].resize(60,0);
    skillIcon[2][7] = loadImage("YellowSlime.png");   skillIcon[2][7].resize(60,0);
    //Thief
    skillButton[3] = loadImage("MonkSkill.png");      skillButton[3].resize(60,0);
    skillIcon[3][0] = loadImage("Knives.png");        skillIcon[3][0].resize(60,0);
    skillIcon[3][1] = loadImage("Toxin.png");         skillIcon[3][1].resize(60,0);
    skillIcon[3][2] = loadImage("razor.png");         skillIcon[3][2].resize(60,0);
    skillIcon[3][3] = loadImage("YellowSlime.png");   skillIcon[3][3].resize(60,0);
    skillIcon[3][4] = loadImage("YellowSlime.png");   skillIcon[3][4].resize(60,0);
    skillIcon[3][5] = loadImage("YellowSlime.png");   skillIcon[3][5].resize(60,0);
    skillIcon[3][6] = loadImage("YellowSlime.png");   skillIcon[3][6].resize(60,0);
    skillIcon[3][7] = loadImage("YellowSlime.png");   skillIcon[3][7].resize(60,0);
    //Priest
    skillIcon[4][0] = loadImage("HolyLight.png");     skillIcon[4][0].resize(60,0);
    skillIcon[4][1] = loadImage("DivineComfort.png"); skillIcon[4][1].resize(60,0);
    skillIcon[4][2] = loadImage("blessing.png");      skillIcon[4][2].resize(60,0);
    skillIcon[4][3] = loadImage("YellowSlime.png");   skillIcon[4][3].resize(60,0);
    skillIcon[4][4] = loadImage("YellowSlime.png");   skillIcon[4][4].resize(60,0);
    skillIcon[4][5] = loadImage("YellowSlime.png");   skillIcon[4][5].resize(60,0);
    skillIcon[4][6] = loadImage("YellowSlime.png");   skillIcon[4][6].resize(60,0);
    skillIcon[4][7] = loadImage("YellowSlime.png");   skillIcon[4][7].resize(60,0);
    //Mage    
    skillIcon[5][0] = loadImage("FireBall.png");      skillIcon[5][0].resize(60,0);
    skillIcon[5][1] = loadImage("Icicle.png");        skillIcon[5][1].resize(60,0);
    skillIcon[5][2] = loadImage("quake.png");         skillIcon[5][2].resize(60,0);
    skillIcon[5][3] = loadImage("YellowSlime.png");   skillIcon[5][3].resize(60,0);
    skillIcon[5][4] = loadImage("YellowSlime.png");   skillIcon[5][4].resize(60,0);
    skillIcon[5][5] = loadImage("YellowSlime.png");   skillIcon[5][5].resize(60,0);
    skillIcon[5][6] = loadImage("YellowSlime.png");   skillIcon[5][6].resize(60,0);
    skillIcon[5][7] = loadImage("YellowSlime.png");   skillIcon[5][7].resize(60,0);
    //Saurian
    skillButton[6] = loadImage("eye5.png");           skillButton[6].resize(60,0);
    skillIcon[6][0] = loadImage("rend.png");          skillIcon[6][0].resize(60,0);
    skillIcon[6][1] = loadImage("prey.png");          skillIcon[6][1].resize(60,0);
    skillIcon[6][2] = loadImage("acid.png");          skillIcon[6][2].resize(60,0);
    skillIcon[6][3] = loadImage("YellowSlime.png");   skillIcon[6][3].resize(60,0);
    skillIcon[6][4] = loadImage("YellowSlime.png");   skillIcon[6][4].resize(60,0);
    skillIcon[6][5] = loadImage("YellowSlime.png");   skillIcon[6][5].resize(60,0);
    skillIcon[6][6] = loadImage("YellowSlime.png");   skillIcon[6][6].resize(60,0);
    skillIcon[6][7] = loadImage("YellowSlime.png");   skillIcon[6][7].resize(60,0);
    //Bard
    skillButton[7] = loadImage("lute3.png");          skillButton[7].resize(60,0);
    skillIcon[7][0] = loadImage("note1.png");         skillIcon[7][0].resize(60,0);
    skillIcon[7][1] = loadImage("note2.png");         skillIcon[7][1].resize(60,0);
    skillIcon[7][2] = loadImage("note3.png");         skillIcon[7][2].resize(60,0);
    skillIcon[7][3] = loadImage("YellowSlime.png");   skillIcon[7][3].resize(60,0);
    skillIcon[7][4] = loadImage("YellowSlime.png");   skillIcon[7][4].resize(60,0);
    skillIcon[7][5] = loadImage("YellowSlime.png");   skillIcon[7][5].resize(60,0);
    skillIcon[7][6] = loadImage("YellowSlime.png");   skillIcon[7][6].resize(60,0);
    skillIcon[7][7] = loadImage("YellowSlime.png");   skillIcon[7][7].resize(60,0);
    //Bard
    skillButton[8] = loadImage("acorns3.png");        skillButton[8].resize(60,0);
    skillIcon[8][0] = loadImage("wolf.png");          skillIcon[8][0].resize(60,0);
    skillIcon[8][1] = loadImage("gale.png");          skillIcon[8][1].resize(60,0);
    skillIcon[8][2] = loadImage("broodOfVipers.png"); skillIcon[8][2].resize(60,0);
    skillIcon[8][3] = loadImage("YellowSlime.png");   skillIcon[8][3].resize(60,0);
    skillIcon[8][4] = loadImage("YellowSlime.png");   skillIcon[8][4].resize(60,0);
    skillIcon[8][5] = loadImage("YellowSlime.png");   skillIcon[8][5].resize(60,0);
    skillIcon[8][6] = loadImage("YellowSlime.png");   skillIcon[8][6].resize(60,0);
    skillIcon[8][7] = loadImage("YellowSlime.png");   skillIcon[8][7].resize(60,0);
  }
  
  public void drawHeroSkills( int h )
  {
    float baseX = party.heroX(h);
    
    strokeWeight(5); fill(0);
    stroke(200); textSize(18*fontScale); textAlign(CENTER);
    rectMode(CORNER); rect(40,160,620,340,20); rectMode(CENTER);
    /*level 1 skill*/             noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],140,280); rect(140,280,70,70,20); fill(200); text(party.hero[h].skill[0].description,140,240); text("Cost: "+(party.hero[h].skill[0].cost+party.hero[h].bardBonus),140,335); text("Q",165,305);
    if(party.hero[h].level>=5 ) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][1],280,280); rect(280,280,70,70,20); fill(200); text(party.hero[h].skill[1].description,280,240); text("Cost: "+party.hero[h].skill[1].cost,280,335); text("W",305,305); }
    if(party.hero[h].level>=10) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][2],420,280); rect(420,280,70,70,20); fill(200); text(party.hero[h].skill[2].description,420,240); text("Cost: "+party.hero[h].skill[2].cost,420,335); text("E",445,305); }
    if(party.hero[h].level>=15) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][3],560,280); rect(560,280,70,70,20); fill(200); text(party.hero[h].skill[3].description,560,240); text("Cost: "+party.hero[h].skill[3].cost,560,335); text("R",585,305); }
    if(party.hero[h].level>=20) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][4],140,430); rect(140,430,70,70,20); fill(200); text(party.hero[h].skill[4].description,140,390); text("Cost: "+party.hero[h].skill[4].cost,140,485); text("A",165,455); }
    if(party.hero[h].level>=25) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][5],280,430); rect(280,430,70,70,20); fill(200); text(party.hero[h].skill[5].description,280,390); text("Cost: "+party.hero[h].skill[5].cost,280,485); text("S",305,455); }
    if(party.hero[h].level>=30) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][6],420,430); rect(420,430,70,70,20); fill(200); text(party.hero[h].skill[6].description,420,390); text("Cost: "+party.hero[h].skill[6].cost,420,485); text("D",445,455); }
    if(party.hero[h].level>=35) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][7],560,430); rect(560,430,70,70,20); fill(200); text(party.hero[h].skill[7].description,560,390); text("Cost: "+party.hero[h].skill[7].cost,560,485); text("F",585,455); }
    
    textSize(20*fontScale);
    for(int i = 0; i < 4; i++) //Display full description
    {
      if(mouseInBox(140+i*140,280) && party.hero[h].level >= i*5 )
        text(party.hero[h].skill[i].fullDescription,350,200);
      if(mouseInBox(140+i*140,430) && party.hero[h].level >= (i+4)*5 )
        text(party.hero[h].skill[i+4].fullDescription,350,200);
    }
    
    fill(0); rect(baseX+75,545,70,70,20);drawCancelIcon(baseX+75,545);
  }
  
  public int jobToInt(Job j)
  {
    switch(j)
    {
      case KNIGHT: return 0;
      case BARBARIAN: return 1;
      case KARATE: return 2;
      case THIEF: return 3;
      case PRIEST: return 4;
      case MAGE: return 5;
      case SAURIAN: return 6;
      case BARD: return 7;
      default: return 8;
    }
  }
  
  public void drawBattleItems( int h, Item [] items, Key [] keys )
  {
    int healthPots=0,manaPots=0,vapors=0,elixirs=0;
    boolean [] element = {false,false,false,false};
    float baseX = party.heroX(h);
    
    //Get number of potion types
    for( Item i : items )if( i.value == 12 )healthPots++;else if( i.value == 24 )manaPots++;else if( i.value == 36 )vapors++;else if( i.value == 48 )elixirs++;
    for( Key k : keys )if( isBombKit(k) ){getActiveBombs(k,element);break;}
    rectMode(CENTER); strokeWeight(5);
    stroke(200); fill(0,200);
            rect(140,350,70,70,20);rect(280,350,70,70,20);rect(420,350,70,70,20);rect(560,350,70,70,20);
    if(element[0]||element[1]||element[2]||element[3])
      {rect(70,450,70,70,20);rect(210,450,70,70,20);rect(350,450,70,70,20);rect(490,450,70,70,20);rect(630,450,70,70,20);}
    rect(baseX+75,545,70,70,20);
    
    textAlign(CENTER); textSize(10*fontScale); fill(200);
    if(healthPots>0){text("Health: "+healthPots,140,327); text("A",165,377);}
    if(manaPots>0)  {text("Mana: "  +manaPots,  280,327); text("S",305,377);}
    if(vapors>0)    {text("Vapor: " +vapors,    420,327); text("D",445,377);}
    if(elixirs>0)   {text("Elixir: "+elixirs,   560,327); text("F",585,377);}
    if(element[0]||element[1]||element[2]||element[3]){
                     text("Reagents:",           70,427);
                     text(party.reagents,        90,437);}
                     
    if(element[0])  {text("Flame",  210,427); text("H",235,477); if(party.reagents<1) fill(200,0,0); text("Cost: 1",210,435); fill(255); }
    if(element[1])  {text("Ice",    350,427); text("J",375,477); if(party.reagents<2) fill(200,0,0); text("Cost: 2",350,435); fill(255); }
    if(element[2])  {text("Acid",   490,427); text("K",515,477); if(party.reagents<3) fill(200,0,0); text("Cost: 3",490,435); fill(255); }
    if(element[3])  {text("Thunder",630,427); text("L",655,477); if(party.reagents<5) fill(200,0,0); text("Cost: 5",630,435); fill(255); }
    
    drawCancelIcon(baseX+75,545);
    if(healthPots>0) image(tileImage[90], 140,356); //drawPotion( 135,360,.5,#00FF0A);
    if(manaPots>0)   image(tileImage[91], 280,356); // drawPotion( 275,360,.5,#0063FF);
    if(vapors>0)     image(tileImage[92], 420,356); // drawPotion( 415,360,.5,#FF6FF1);
    if(elixirs>0)    image(tileImage[93], 560,356); // drawPotion( 555,360,.5,#FFD500);
    if(element[0]||element[1]||element[2]||element[3])image(tileImage[128],70,453);
    push();
    //if(party.reagents<=0) tint(50);
    if(element[0]) { if(party.reagents<1) tint(50); image(tileImage[127],210,458);}
    if(element[1]) { if(party.reagents<2) tint(50); image(tileImage[129],350,459);}
    if(element[2]) { if(party.reagents<3) tint(50); image(tileImage[130],490,460);}
    if(element[3]) { if(party.reagents<5) tint(50); image(tileImage[131],630,458);}
    pop();
  }
  
  public void drawHeroData( int h )
  {
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(210,170,285,410,20);
    drawHeroByType(party.hero[h],454,212,1,false);
    fill(200); textAlign(LEFT,TOP); textSize(40*fontScale);
    text(party.hero[h].name,225,175);
    textSize(25*fontScale);
    text("Level " + party.hero[h].level + " " + party.hero[h].jobToString(),225,220);
    if(party.hero[h].inDanger())fill(255,0,0); text("Health: " + party.hero[h].hp + "/" + party.hero[h].maxHp,225,260); fill(200);
    if(party.hero[h].maxMp>0)
      text("Magic: " + party.hero[h].mp + "/" + party.hero[h].maxMp,225,290);
      
    if(party.hero[h].totalStat(0) < party.hero[h].str) fill(250,0,0); else if(party.hero[h].totalStat(0) > party.hero[h].str) fill(0,250,0);
    text("Strength:",225,320);     text(party.hero[h].totalStat(0),400,320); fill(200);
    
    if(party.hero[h].totalStat(1) < party.hero[h].dex) fill(250,0,0); else if(party.hero[h].totalStat(1) > party.hero[h].dex) fill(0,250,0);
    text("Dexterity:",225,350);    text(party.hero[h].totalStat(1),400,350); fill(200);
    
    if(party.hero[h].totalStat(2) < party.hero[h].con) fill(250,0,0); else if(party.hero[h].totalStat(2) > party.hero[h].con) fill(0,250,0);
    text("Constitution:",225,380); text(party.hero[h].totalStat(2),400,380); fill(200);
    
    if(party.hero[h].totalStat(3) < party.hero[h].mag) fill(250,0,0); else if(party.hero[h].totalStat(3) > party.hero[h].mag) fill(0,250,0);
    text("Magic Power:",225,410);  text(party.hero[h].totalStat(3),400,410); fill(200);
    
    if(party.hero[h].totalStat(4) < party.hero[h].wil) fill(250,0,0); else if(party.hero[h].totalStat(4) > party.hero[h].wil) fill(0,250,0);
    text("Willpower:",225,440);    text(party.hero[h].totalStat(4),400,440); fill(200);
    
    if(party.hero[h].totalStat(5) < party.hero[h].spd) fill(250,0,0); else if(party.hero[h].totalStat(5) > party.hero[h].spd) fill(0,250,0);
    text("Speed:",225,470);        text(party.hero[h].totalStat(5),400,470); fill(200);
    
    text("Experience: " + party.hero[h].exp,225,510);
    text("Next Level: " + party.hero[h].nextLevel,225,540);
    
    fill(0); rectMode(CORNER); imageMode(CENTER);
    stroke(200); strokeWeight(5);
    rect(85,170,100,100,20);
    image(party.hero[h].weapon.pic,135,220);
    rect(85,290,100,100,20);
    image(party.hero[h].armor.pic,135,340);
    textSize(10*fontScale); fill(200); textAlign(CENTER);
    text("WEAPON",135,185);
    text("ARMOR",135,305);
    
    textAlign(LEFT,TOP);
    text(party.hero[h].weapon.toString(),95,255);
    text(party.hero[h].weapon.getPower(),165,245);
    text(party.hero[h].armor.toString(),95,375);
    text(party.hero[h].armor.getPower(),165,365);
    
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(520,170,100,310,20);
    textSize(10*fontScale); fill(200); textAlign(CENTER);
    text("CONDITION",570,185);
    
    //Hero is fine (NOT(!) REMOVED FOR TESTING)
    if(!party.hero[h].inDanger()      && !party.hero[h].hasCondition(0) 
    && !party.hero[h].hasCondition(1) && !party.hero[h].hasCondition(2)
    && !party.hero[h].hasCondition(3) && !party.hero[h].hasCondition(4) )
    {
      textSize(15*fontScale); fill(255); textAlign(CENTER);
      text("HEALTHY",570,210);
      textSize(12*fontScale);
      text("Ready for",570,225);
      text("adventure!",570,235);
    }
    
    //Low health
    if(party.hero[h].inDanger())
    {
      textSize(15*fontScale); fill(150,0,0); textAlign(CENTER);
      text("IN DANGER",570,210);
      textSize(12*fontScale);
      text("Find healing",570,223);
      text("soon!",570,235);
    }
    
    //Poisoned
    if(party.hero[h].hasCondition(0))
    {
      textSize(15*fontScale); fill(0,150,0); textAlign(CENTER);
      text("POISONED",570,255);
      textSize(12*fontScale);
      text(party.hero[h].name + " is",570,268);
      text(party.hero[h].poisonString(),570,280);
    }
    
    //Asleep
    if(party.hero[h].hasCondition(1))
    {
      textSize(15*fontScale); fill(150,150,150); textAlign(CENTER);
      text("ASLEEP",570,300);
      textSize(12*fontScale);
      text("This is not",570,312);
      text("the time!",570,325);
    }
    
    //Paralyzed
    if(party.hero[h].hasCondition(2))
    {
      textSize(15*fontScale); fill(150,150,0); textAlign(CENTER);
      text("PARALYZED",570,345);
      textSize(12*fontScale);
      text("Can't move",570,358);
      text("a muscle.",570,370);
    }
    
    //Weakened
    if(party.hero[h].hasCondition(3))
    {
      textSize(15*fontScale); fill(120); textAlign(CENTER);
      text("WEAKENED",570,390);
      textSize(12*fontScale);
      text("Your muscles",570,403);
      text("have atrophied.",570,415);
    }
    
    //Cursed
    if(party.hero[h].hasCondition(4))
    {
      textSize(15*fontScale); fill(150,0,150); textAlign(CENTER);
      text("CURSED",570,435);
      textSize(12*fontScale);
      text("Your magic and",570,448);
      text("willpower are",570,460);
      text("sealed.",570,472);
    }
  }
  
  public void drawFoodSynergyBox( int b, int m, int f, int c )
  {
    int types=0, amount;
    if(b>0)types++;if(m>0)types++;if(f>0)types++;if(c>0)types++;
    if(types<2)return;
    
    switch(types)
    {
      case 1:  amount =  0; break;
      case 2:  amount = 10; break;
      case 3:  amount = 25; break;
      case 4:  amount = 50; break;
      default: amount =  0; break;
    }
    fill(255); textAlign(CENTER);
    textSize(15*fontScale); text("SYNERGY",645,220);
    textSize(((types-1)*5 + 15)*fontScale); text(amount+"%",645,265);
    noStroke();

    stroke(150,150,50); strokeWeight(1);

    noFill(); rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(580,200,110,103,20); //box
  }
  
  public void drawGoldBox()
  {
    fill(200,200,0); textAlign(CENTER);
    textSize(15*fontScale); text("GOLD",645,220);
    textSize(12*fontScale); text(party.gold,645,235);
    noStroke();
    if( party.gold > 100 ) rect(615,260,20,41);
    if( party.gold > 500 ) rect(635,250,20,51);
    if( party.gold > 0   ) rect(660,280,20,21);
    stroke(150,150,50); strokeWeight(1);
    
    if( party.gold > 100 ) //Left stack
    {
      arc(625,295,19,10,0,PI); arc(625,290,19,10,0,PI);
      arc(625,285,19,10,0,PI); arc(625,280,19,10,0,PI);
      arc(625,275,19,10,0,PI); arc(625,270,19,10,0,PI);
      arc(625,265,19,10,0,PI); ellipse(625,260,19,10);
    }
    
    if( party.gold > 500 ) //Center stack
    {
      arc(645,295,19,10,0,PI); arc(645,290,19,10,0,PI);
      arc(645,285,19,10,0,PI); arc(645,280,19,10,0,PI);
      arc(645,275,19,10,0,PI); arc(645,270,19,10,0,PI);
      arc(645,265,19,10,0,PI); arc(645,260,19,10,0,PI);
      arc(645,255,19,10,0,PI); ellipse(645,250,19,10);
    }
    
    if( party.gold > 0 ) //Right stack
    {
      arc(670,295,19,10,0,PI); arc(670,290,19,10,0,PI);
      arc(670,285,19,10,0,PI); ellipse(670,280,19,10);
    }
    noFill(); rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(580,200,110,103,20); //box
  }
  
  public void drawReagentBox()
  {
    fill(255); textAlign(CENTER);
    textSize(15*fontScale); text("REAGENTS",645,420);
    textSize(12*fontScale); text(party.reagents,645,435);
    noFill(); rectMode(CORNER);
    image(tileImage[128],615,440);
    stroke(200); strokeWeight(5);
    rect(580,400,110,103,20); //box
  }
  
  public void drawBardNotes()
  {
    for( int i = 0; i < 3; i++ )
    {
      if(party.hero[i].bardBonus>0)
      {
        push();
        translate(140+210*i,500);
        for(int j = 0; j < party.hero[i].bardBonus; j++)
        {
          push();
          rotate((TWO_PI/party.hero[i].bardBonus)*j+noteStage);
          push();
          translate(0,50);
          rotate(-((TWO_PI/party.hero[i].bardBonus)*j)-noteStage);
          tint(noteColor[j]);
          image(effectImage[0],0,0);
          pop();
          pop();
        }
        pop();
      }
    }
  }
  
  public void drawPotion( int xPos, int yPos, float scale, color c )
  {          //draws from the top left corner of neck
    fill(c); stroke(200); strokeWeight(5*scale);
    beginShape();    //x-150, y-300
    vertex(xPos,yPos);
    vertex(xPos,yPos+50*scale);
    bezierVertex(xPos-50*scale,yPos+70*scale,xPos-30*scale,yPos+100*scale,xPos+10*scale,yPos+100*scale);
    bezierVertex(xPos+50*scale,yPos+100*scale,xPos+70*scale,yPos+70*scale,xPos+20*scale,yPos+50*scale);
    vertex(xPos+20*scale,yPos);
    endShape();
  }
  
  public void drawHelpMenuScreen()
  {
    //Scroll
    noStroke();
    rectMode(CENTER);
    fill(195,175,135);
    rect(frameWidth/2,375,490,400);
    fill(90,70,30);
    rect(frameWidth/2,170,510,6);
    rect(frameWidth/2,575,510,6);
    fill(180,160,120);
    rect(frameWidth/2,170,500,14,5);
    rect(frameWidth/2,575,500,14,5);
    
    //fill(0);  rectMode(CORNER);
    //stroke(200);
    //strokeWeight(5);
    //rect(100,175,width-200,400,20);
    textSize(25*fontScale); fill(50); textAlign(CORNER);
    text("Keyboard Commands:",110,205);
    textSize(20*fontScale);
    text("(w)(a)(s)(d) - Move party around map",110,235);
    text("(E) - Eat food",110,260); text("(D) - Drink potion",350,260);
    text("(S) - Save at a Legend Gem",110,285);
    text("(R) - Rest at an inn or camp",110,310);
    text("(B) - Bargain with a vendor",110,335);
    text("(o) - Open door",110,360);
    text("(>) - Use a staircase or entrance",110,385);
    text("(space) - Open chest / Search current space",110,410);
    text("Hold (i) - View inventory",110,435);
    text("Hold (k) - View keys",110,460);
    text("Hold (h) - View help menu",110,485);
    textSize(15*fontScale);
    text(" Battle inputs are shown. The (space) key can usually be used to",110,515);
    text(" cancel. (1)(2)(3) are interchangable with (a)(s)(d) when selecting",110,535);
    text(" heroes or targets. Click hero boxes for detailed information.",110,555);
  }
  
  public void drawCredits()
  {
    
  }
  
  public void drawHeroSelectScreen()
  {
    //This will change the window for equipping
    int equipOffset = 0; if( display == Display.EQUIP ) equipOffset = 50;
    
    fill(0);  rectMode(CORNER); imageMode(CENTER);
    stroke(200);
    strokeWeight(5);
    rect(100,200,frameWidth-200,frameHeight-400+equipOffset,20);
    
    fill(200); textSize(40*fontScale);
    if( display == Display.EQUIP ) { textAlign(CORNER); text(newEquip.name,350-(9*newEquip.name.length()),250); image(newEquip.pic,320-(9*newEquip.name.length()),240); }
    else                           { textAlign(CENTER); text("Select Hero",frameWidth/2,250); }
    
    
    
    textAlign(CENTER);
    fill(party.hero[0].getColor()); drawHeroByType(party.hero[0],150,320,1,true); //ellipse(150,320,75,75);
    textSize(20*fontScale); fill(200); text(1,150,275);
    
    fill(party.hero[1].getColor()); drawHeroByType(party.hero[1],350,320,1,true); //ellipse(350,320,75,75);
    textSize(20*fontScale); fill(200); text(2,350,275);
    
    fill(party.hero[2].getColor()); drawHeroByType(party.hero[2],550,320,1,true); //ellipse(550,320,75,75);
    textSize(20*fontScale); fill(200); text(3,550,275);
      
    if( display == Display.EQUIP )
    {
      if(newEquip.isWeapon)
      {
        image(party.hero[0].weapon.pic,150,400);
        image(party.hero[1].weapon.pic,350,400);
        image(party.hero[2].weapon.pic,550,400);
      }
      else
      {
        image(party.hero[0].armor.pic,150,400);
        image(party.hero[1].armor.pic,350,400);
        image(party.hero[2].armor.pic,550,400);
      }
      //use textPromptStage for color animation
      showStatComparison( 0, newEquip, 150, 470 );
      showStatComparison( 1, newEquip, 350, 470 );
      showStatComparison( 2, newEquip, 550, 470 );
    }
      
    fill(200); textAlign(CENTER);// textSize(25);
    if( display != Display.EQUIP )
    {
      textSize(40*fontScale);
      if(      dist( mouseX,mouseY, 175,345)<37.5)
        text(party.hero[0].name,frameWidth/2,410);
      else if( dist( mouseX,mouseY, 375,345)<37.5)
        text(party.hero[1].name,frameWidth/2,410);
      else if( dist( mouseX,mouseY, 575,345)<37.5)
        text(party.hero[2].name,frameWidth/2,410);
      textSize(25*fontScale);
      text("Select by number or",frameWidth/2,460);
      text("press space to cancel.",frameWidth/2,480);
    }
    else
    {
      textSize(40*fontScale);
      if(      dist( mouseX,mouseY, 175,345)<37.5)
        text(party.hero[0].name,frameWidth/2,530);
      else if( dist( mouseX,mouseY, 375,345)<37.5)
        text(party.hero[1].name,frameWidth/2,530);
      else if( dist( mouseX,mouseY, 575,345)<37.5)
        text(party.hero[2].name,frameWidth/2,530);
      else
      {
        textSize(25*fontScale);
        text("Equip by number or press", frameWidth/2,510);
        text("capital (X) to put aisde for sale.",frameWidth/2,540);
      }
    }
    
    //Draw clickable cancel arrow
    imageMode(CENTER);
    image( mouseUXImage[9], 650,450);
  }
  
  public void beginGameoverAnimation()
  {
    gameoverOpacity = 0;
    gameover = true;
    blackVanguard=loadImage("BlackGargoyle.png");
  }
  
  public void runGameoverAnimation()
  {
    drawBattleWindow();
    imageMode(CENTER);
    gameoverOpacity+=0.5;
    push();
    tint(255,gameoverOpacity);
    image(blackVanguard,350,300);
    pop();
    fill(0,gameoverOpacity);
    noStroke();
    ellipse(350,542.5,700,315);
    fill(0,0,150,gameoverOpacity);
    textAlign(CENTER);
    textSize(75*fontScale);
    text("GAME OVER",frameWidth/2,542.5);
  }
  
  public void showStatComparison( int heroIndex, Equipment thing, float xPos, float yPos )
  {
    textSize(30*fontScale);
    if( !thing.usableBy( party.hero[heroIndex].job ) ) //can't use
      fill(200); //non-flashing gray
    else if( thing.isWeapon && party.hero[heroIndex].weapon.power < thing.power ||
            !thing.isWeapon && party.hero[heroIndex].armor.power  < thing.power) //new equipment is better
    {  fill(0,100+textPromptStage*3,0); stroke(0,100+textPromptStage*3,0); }//flash green
    else if( thing.isWeapon && party.hero[heroIndex].weapon.power > thing.power ||
            !thing.isWeapon && party.hero[heroIndex].armor.power  > thing.power) //new equipment is worse 
    {  fill(150+textPromptStage*1.5,0,0); stroke(100+textPromptStage*1.5,0,0); }//flash red
    else //new equipment has same power as old
    {  fill(200); stroke(200); } //non-flashing gray
      
    //Display comparison
    if( !thing.usableBy( party.hero[heroIndex].job ) ) //hero can't use
    {
      textSize(25*fontScale);
      text("Can't", xPos, yPos-10);
      text("use.", xPos, yPos+10);
    }
    else //hero can use
    {
      //display old power
      if( thing.isWeapon) text( party.hero[heroIndex].weapon.getPower(), xPos-25, yPos );
      else                text( party.hero[heroIndex].armor.getPower(), xPos-25, yPos );
      text( thing.getPower(), xPos+25, yPos ); //display new power
      strokeWeight(2);
      line(xPos-5,yPos-12,xPos+5,yPos-12);
      line(xPos+2,yPos-9,xPos+5,yPos-12);
      line(xPos+2,yPos-15,xPos+5,yPos-12);
    }
  }
  
  void drawAndCleanupFloatingNumbers()
  {
    for( int i = 0; i < floatingNumbers.size(); i++)
    {
      floatingNumbers.get(i).moveAndDrawNumber();
      if( !floatingNumbers.get(i).active )
      {
        floatingNumbers.remove(i);
        i--;
      }
    }
  }
  
  public void drawObject( Object o, int xPos, int yPos )
  {
    if( o == Object.STALAGMITE )// && safeColor == color(0) ) //draw water under objects
      image(tileImage[int(4+vanGogh.stage()/10)],xPos,yPos);
    switch(o)
    {
      case CHEST:
        image(tileImage[30],xPos,yPos);
        break;
      case CHEST_GOLD:
        image(tileImage[61],xPos,yPos);
        break;
      case CHEST_DARK:
        image(tileImage[62],xPos,yPos);
        break;
      case CHEST_BONE:
        image(tileImage[79],xPos,yPos);
        break;
      case CHEST_HONEY:
        image(tileImage[121],xPos,yPos);
        break;
      case SIGN:
        image(tileImage[37],xPos,yPos);
        break;
      case SIGN_E:
        image(tileImage[63],xPos,yPos);
        break;
      case SIGN_F:
        image(tileImage[64],xPos,yPos);
        break;
      case SIGN_D:
        image(tileImage[65],xPos,yPos);
        break;
      case SIGN_I:
        image(tileImage[66],xPos,yPos);
        break;
      case SAVEPOINT:
        if(animationStage<8)
          image(tileImage[int(20+animationStage)],xPos-5,yPos-5-savePointFloat);
        else
          image(tileImage[20],xPos-5,yPos-5-savePointFloat);
        break;
      case FAKE_SAVE:
        image(tileImage[20],xPos-5,yPos-5-savePointFloat);
        break;
      case BARREL:
        image(tileImage[28],xPos,yPos);
        break;
      case BARREL2:
        image(tileImage[29],xPos,yPos);
        break;
      case BARREL_H:
        image(tileImage[112],xPos,yPos);
        break;
      case CRATE_OBJ:
        image(tileImage[89],xPos,yPos);
        break;
      case FENCE_CORNER:
        image(tileImage[101],xPos,yPos);
        break;
      case FENCE_CORNER2:
        image(tileImage[104],xPos,yPos);
        break;
      case FENCE_HORIZONTAL:
        image(tileImage[102],xPos,yPos);
        break;
      case FENCE_VERTICAL:
        image(tileImage[103],xPos,yPos);
        break;
      case GRAVE:
        image(tileImage[42],xPos,yPos);
        break;
      case RUBBLE:
        image(tileImage[67],xPos,yPos);
        break;
      case TENT:
        image(tileImage[55],xPos,yPos);
        break;
      case BED:
        image(tileImage[77],xPos,yPos);
        break;
      case GARGOYLE:
        image(tileImage[51],xPos,yPos);
        break;
      case BROKE_GLASS:
        image(tileImage[81],xPos-60,yPos-60);
        break;
      case STALAGMITE:
        image(tileImage[125],xPos-10,yPos-10);
        break;
    }
  }
  
  public void drawAdvanceTextPrompt()
  {
    noStroke(); fill(50+textPromptStage*2);  //prompt will flash
    textSize(10*fontScale); textAlign(RIGHT);
    text("push SPACE to continue",frameWidth-15,frameHeight-6-textPromptStage/8); //prompt will move to get player's attention
    //triangle(width-130-textPromptStage/8,height-9,  width-140-textPromptStage/8,height-12, width-140-textPromptStage/8,height-6);
    triangle(frameWidth-75,frameHeight-115+textPromptStage/8, frameWidth-45,frameHeight-130+textPromptStage/8, frameWidth-105,frameHeight-130+textPromptStage/8);
  }
  
  //For entire hero customization screen
  public void drawCustomizeScreen( float r, float g, float b, float r2, float g2, float b2, int h, float s )
  {
    //Words
    fill(200); textSize(30); textAlign(CENTER);
    text("Primary", 225, 50);
    text("Secondary", 225, 235);
    text("Hair", 225, 425);
    text("Skin", 225, 525);
    textSize(50);
    text(tempName,550,60);
    textSize(35);
    text(jobToString(tempJob),550,100);
    //Color bars
    for(int i = 0; i < 250; i++)
    {
      stroke(i,0,0);
      line(100+i,63,100+i,86);
      line(100+i,248,100+i,271);
      stroke(0,i,0);
      line(100+i,113,100+i,136);
      line(100+i,298,100+i,321);
      stroke(0,0,i);
      line(100+i,163,100+i,186);
      line(100+i,348,100+i,371);
    }
    //Skin Color Bar
    for(int i = 0; i < 300; i++)
    {
      stroke(55+0.67*i,30+0.67*i,20+0.63*i);
      line(75+i,551,75+i,574);
    }
    
    //Boxes around color bars
    stroke(200); noFill(); strokeWeight(3); rectMode(CORNER);
    rect(99,62.5,252,26);  rect(99,112.5,252,26); rect(99,162.5,252,26);
    rect(99,247.5,252,26); rect(99,297.5,252,26); rect(99,347.5,252,26);
    rect(74,550.5,300,26);
    
    //Sliders / selection circle
    stroke(150); noFill(); strokeWeight(5);
    rect(100+r,64,5,22);    rect(100+g,114,5,22);    rect(100+b,164,5,22);
    rect(100+r2,249,5,22);  rect(100+g2,299,5,22);   rect(100+b2,349,5,22);
    rect(75+s,552,5,22);  circle(37.5+75*h,462.5,40);
    if(slider[0]) { tempRed    = (mouseX-frameX)-100; tempRed    = max( 0, min(250,tempRed));    }
    if(slider[1]) { tempGreen  = (mouseX-frameX)-100; tempGreen  = max( 0, min(250,tempGreen));  }
    if(slider[2]) { tempBlue   = (mouseX-frameX)-100; tempBlue   = max( 0, min(250,tempBlue));   }
    if(slider[3]) { tempRed2   = (mouseX-frameX)-100; tempRed2   = max( 0, min(250,tempRed2));   }
    if(slider[4]) { tempGreen2 = (mouseX-frameX)-100; tempGreen2 = max( 0, min(250,tempGreen2)); }
    if(slider[5]) { tempBlue2  = (mouseX-frameX)-100; tempBlue2  = max( 0, min(250,tempBlue2));  }
    if(slider[6]) { tempSkin   = (mouseX-frameX)-75;  tempSkin   = max( 0, min(300,tempSkin));   }
    
    strokeWeight(2); stroke(200);
    //Hair Buttons
    for(int i = 0; i < 6; i++)
    {
      fill( hairTone[i] );
      circle(37.5+75*i,462.5,26);
    }
    
    //Confirm Button
    rectMode(CENTER);
    fill(200); noStroke();
    rect(550,450,100,100);
    fill(r,g,b);
    stroke(r2,g2,b2); strokeWeight(8);
    rect(550,450,81,81);
    drawSkillSymbol(550,450,color(r,g,b),color(r2,g2,b2),tempJob);
    fill(200); textAlign(CENTER); textSize(20*fontScale);
    text("CLICK HERE\nTO CONFIRM",550,525);
    drawHero(550,245, 3.5, color(r,g,b), color(r2,g2,b2), tempHair, tempSkin, false, tempJob);
    
    //Back Button
    fill(150); stroke(200); strokeWeight(4);
    circle(40,40,50);
    fill(230); strokeWeight(3);
    triangle(25,40, 50,27, 50,53);
    if( dist(mouseX-frameX,mouseY-frameY,40,40) < 27 )
      text("BACK",40,85);
  }

  public void drawJobChoices( int hero )
  {
    noStroke(); fill(150); //will be icons later
    drawKnight(210,160,1.7,200,50,tempHair,150,true);  drawBarbarian(350,160,1.7,200,50,tempHair,150,true); drawSaurian(490,160,1.7,color(200,200,200),color(50,50,50),tempHair,150,true);
    drawKarate(210,300,1.7,200,50,tempHair,150,true);  drawBard(350,300,1.7,200,50,tempHair,150,true);      drawThief(490,300,1.7,200,50,tempHair,150,true);
    drawDruid(210,440,1.7,200,50,tempHair,150,true);   drawPriest(350,440,1.7,200,50,tempHair,150,true);    drawMage(490,440,1.7,200,50,tempHair,150,true);
  
    //Class descriptions
    fill(200); textAlign(CENTER); textSize(30*fontScale);
    if( dist(mouseX,mouseY,235,185)<62 ){ text("KNIGHT",frameWidth/2,35);         textSize(20*fontScale); text("A stalwart combatant that can use most equipment.",frameWidth/2,60);             text("Gains energy when blocking attacks.",frameWidth/2,85);        drawStatBars(1); }
    if( dist(mouseX,mouseY,375,185)<62 ){ text("BARBARIAN",frameWidth/2,35);      textSize(20*fontScale); text("A powerful warrior that relishes battle.",frameWidth/2,60);                      text("Gains energy when taking damage.",frameWidth/2,85);           drawStatBars(2); }
    if( dist(mouseX,mouseY,515,185)<62 ){ text("SAURIAN",frameWidth/2,35);        textSize(20*fontScale); text("A mighty creature that prefers simple strength.",frameWidth/2,60);               text("Gains more energy when attacking.",frameWidth/2,85);          drawStatBars(7); }
    if( dist(mouseX,mouseY,235,325)<62 ){ text("MARTIAL ARTIST",frameWidth/2,35); textSize(20*fontScale); text("A martial artist who cannot use most equipment.",frameWidth/2,60);               text("Always begins combat with extra energy.",frameWidth/2,85);    drawStatBars(3); }
    if( dist(mouseX,mouseY,375,325)<62 ){ text("BARD",frameWidth/2,35);           textSize(20*fontScale); text("A versitile performer that inspires allies.",frameWidth/2,60);                   text("Gains energy with the rhythm of combat.",frameWidth/2,85);    drawStatBars(8); }
    if( dist(mouseX,mouseY,515,325)<62 ){ text("THIEF",frameWidth/2,35);          textSize(20*fontScale); text("An agile trickster that uses light equipment.",frameWidth/2,60);                 text("Gains energy when scoring critical hits.",frameWidth/2,85);   drawStatBars(4); }
    if( dist(mouseX,mouseY,235,465)<62 ){ text("DRUID",frameWidth/2,35);          textSize(20*fontScale); text("A mystic caster who calls upon the power of nature.",frameWidth/2,60);           text("Casts spells and transforms into beasts.",frameWidth/2,85);   drawStatBars(9); }
    if( dist(mouseX,mouseY,375,465)<62 ){ text("PRIEST",frameWidth/2,35);         textSize(20*fontScale); text("A pious caster who can use some heavy armor.",frameWidth/2,60);                  text("Casts holy magic that can smite or heal.",frameWidth/2,85);   drawStatBars(5); }
    if( dist(mouseX,mouseY,515,465)<62 ){ text("MAGE",frameWidth/2,35);           textSize(20*fontScale); text("An arcane caster unsuited to physical combat.",frameWidth/2,60);                 text("Casts elemental magic of tremendous power.",frameWidth/2,85); drawStatBars(6); }
    
    textAlign(CENTER);
    textSize(12*fontScale);
    fill(200);
    text("HEALTH",87.5,590);
    text("STRENGTH",175,590);
    text("DEXTERITY",262.5,590);
    text("CONSITUTION",350,590);
    text("MAGIC",437.5,590);
    text("WILLPOWER",525,590);
    text("SPEED",612.5,590);
    for(float i = 87.5; i < 700; i+=87.5)
    {
      stroke(255);
      strokeWeight(1);
      line(i-30,570,i+30,570);
    }
    //Back Button
    fill(150); stroke(200); strokeWeight(4);
    circle(40,40,50);
    fill(230); strokeWeight(3);
    triangle(25,40, 50,27, 50,53);
    textSize(20*fontScale);
    if( dist(mouseX-frameX,mouseY-frameY,40,40) < 27 )
      text("BACK",40,85);
  }
  
  void drawStatBars( int heroType )
  {
    int h,s,d,c,m,w,q;
    switch(heroType)
    {
      case 1:  h = 30; s = 12; d = 10; c = 13; m = 5;  w = 10; q = 10; break;
      case 2:  h = 35; s = 15; d = 11; c = 10; m = 0;  w = 7;  q = 12; break;
      case 3:  h = 40; s = 12; d = 12; c = 12; m = 5;  w = 12; q = 14; break;
      case 4:  h = 25; s = 9;  d = 14; c = 9;  m = 0;  w = 9;  q = 15; break;
      case 5:  h = 20; s = 6;  d = 8;  c = 8;  m = 10; w = 15; q = 8;  break;
      case 6:  h = 15; s = 5;  d = 7;  c = 5;  m = 15; w = 10; q = 9;  break;
      case 7:  h = 42; s = 16; d = 7;  c = 12; m = 0;  w = 6;  q = 7;  break;
      case 8:  h = 22; s = 8;  d = 12; c = 9;  m = 7;  w = 10; q = 13; break;
      case 9:  h = 25; s = 8;  d = 9;  c = 10; m = 9;  w = 13; q = 11; break;
      default: h = 1; s = 1;  d = 1;  c = 1;  m = 1; w = 1; q = 1;  break;
    }
    rectMode(CORNER);
    noStroke();
    fill(200,200,0);
    rect(87.5-20,570,40,-h*3);
    fill(150,0,0);
    rect(175-20,570,40,-s*5);
    fill(0,150,0);
    rect(262.5-20,570,40,-d*5);
    fill(120,175,220);
    rect(350-20,570,40,-c*5);
    fill(200,0,200);
    rect(437.5-20,570,40,-m*5);
    fill(0,250,250);
    rect(525-20,570,40,-w*5);
    fill(220,200,180);
    rect(612.5-20,570,40,-q*5);
  }

  void drawCondition( int c, int h )
  {
    switch(c)
    {
      case 0: //poison
        fill(0,150,0); noStroke();
        ellipse(30+h*248,140,12,12);
        ellipse(22+h*248,130,9,9);
        ellipse(34+h*248,125,7,7); break;
      case 1: //asleep
        fill(120,120,120); textAlign(CENTER); textSize(15*fontScale);
        text('Z',40+20+h*248,145); textSize(13*fontScale);
        text('Z',40+30+h*248,135); textSize(11*fontScale);
        text('Z',40+40+h*248,130); break;
      case 2: //paralyzed
        fill(150,150,0);
        beginShape(); vertex(100+h*248,120);vertex(105+h*248,127);vertex(100+h*248,130);vertex(115+h*248,145);vertex(110+h*248,133);vertex(115+h*248,130);vertex(110+h*248,120);vertex(100+h*248,120);endShape();
        break;
      case 3: //weakened
        stroke(225); strokeWeight(1);
        line(150+h*248,123,127+h*248,143);
        noStroke(); fill(200,150);
        beginShape();vertex(150+h*248,123);bezierVertex(147+h*248,120,121+h*248,134,129+h*248,141);bezierVertex(138+h*248,150,155+h*248,126,151+h*248,123);endShape();
        break;
      case 4: //cursed
        stroke(200,0,0);noFill();strokeWeight(2);
        beginShape();vertex(175+h*248,120);vertex(167+h*248,141);vertex(187+h*248,128);vertex(163+h*248,128);vertex(183+h*248,141);endShape(CLOSE);
        break;
    }
  }
  
  void drawHeroBoxes( Hero[] h )
  {
    for(int i = 0; i < h.length; i++)
    {
      noFill(); strokeWeight(5);
      if(h[i].isCreated())
      {
        stroke(h[i].getColor());
        rect(4+i*248,4,196,146,20);
        stroke(200);
        rect(2+i*248,2,200,150,20);
        fill(200); textAlign(LEFT); textSize(30*fontScale);
        text(h[i].toString(),12+i*248,40);
        textSize(23*fontScale);
        text(h[i].jobToString(),12+i*248,65);
        text("HP:",12+i*248,90);
        if(h[i].getMaxMp()>0)text("MP:",12+i*248,115);
        textAlign(RIGHT); 
        text(h[i].getLevel(),190+i*250,65);
        if(h[i].inDanger())fill(250,0,0);
        text(h[i].getHp()+"/"+h[i].getMaxHp(),190+250*i,90);
        fill(200);
        if(h[i].getMaxMp()>0)text(h[i].getMp()+"/"+h[i].getMaxMp(),190+250*i,115);
      }
    }
    if(display==Display.BATTLE)
      drawEnergyBoxes();
    
    //for testing
    //drawMage(150,350,2,h[0].getColor(),h[0].getInvColor());
    //drawMage(350,350,2,h[1].getColor(),h[1].getInvColor());
    //drawMage(550,350,2,h[2].getColor(),h[2].getInvColor());
  }
  
  void drawEnergyBoxes()
  {  
    for(int i = 0; i < 3; i++)
    {
      //if( party.hero[i].energy > 0 )
      if(party.hero[i].maxMp == 0)
      {
        fill(200); textAlign(LEFT);
        if( party.hero[i].job == Job.BARBARIAN )
          text("ANGER:",12+i*248,115);
        else
          text("POWER:",12+i*248,115);
        strokeWeight(1);
        stroke(party.hero[i].favColor);
        fill(party.hero[i].inverseColor);
        int e = party.hero[i].energy;
        int k = 0;
        while(e >= 5)
        {
          rect(95+i*248+8*k,95,7,24);
          k++;
          e-=5;
        }
        stroke(party.hero[i].inverseColor);
        fill(party.hero[i].favColor);
        while( e > 0 )
        {
          rect(95+i*248+8*k,97,7,19);
          k++;
          e--;
        }
        /*
        for(int k = 0; k < min(13,party.hero[i].energy); k++ )
          rect(100+i*248+7*k,95,7,13);
        for(int k = 0; k < min(13,party.hero[i].energy-13); k++ )
          rect(100+i*248+7*k,110,7,13);
        for(int k = 0; k < min(24,party.hero[i].energy-26); k++ )
          rect(16+i*248+7*k,125,7,13);
        */
      }
    }
  }

  void drawTextBoxes( Input in, String tb, String tl1, String tl2 ) //Draws large text box and small input box if applicable
  {
    if(in == Input.TYPING)
    {
      stroke(200);
      fill(0);
      rectMode(CENTER);
      rect(frameWidth/2,frameHeight-150,250,50,20);
      
      fill(255);
      textSize(30*fontScale);
      textAlign(CENTER);
      text(tb,frameWidth/2,frameHeight-140);
      rectMode(CORNER);
    }
    
    if(display != Display.MAIN_MENU)
    {
      noFill();  rectMode(CORNER);
      stroke(200);
      strokeWeight(5);
      rect(2,frameHeight-100,frameWidth-5,98,20);
      
      fill(255);
      textSize(30*fontScale);
      textAlign(LEFT);
      text(tl1,10,frameHeight-60);
      text(tl2,10,frameHeight-20);
    }
  }
  
  void beginBattleAnimation()
  {
    animationStage = 0;
    animationStep = 1;
    battleWindowOpening = true;
  }
  
  void beginRestFadeout()
  {
    restOpacity = 0;
    resting = true;
    restFadeIn = true;
    displayTextLine( restText() );
  }
  
  void startScreenShake( int amount, boolean up )
  {
    if(!screenShaking)
    {
      if(up)
        screenShakeAmountY = amount;
      else
        screenShakeAmountX = amount;
    }
    screenShaking = true;
  }
  
  void shakeScreen()
  {
    if( screenShakeAmountX > 0 )
      if( !shakeLeft )
        surface.setLocation(windowX+screenShakeAmountX,windowY);
      else
        surface.setLocation(windowX-screenShakeAmountX,windowY);
      
    if( screenShakeAmountY > 0 )
      if( !shakeUp )
        surface.setLocation(windowX,windowY+screenShakeAmountY);
      else
        surface.setLocation(windowX,windowY-screenShakeAmountY);
    
    screenShakeAmountX *= .9;
    screenShakeAmountY *= .9;
    shakeLeft = !shakeLeft;
    shakeUp = !shakeUp;
    if(screenShakeAmountX <=0 && screenShakeAmountY <= 0)
      screenShaking = false;
  }
  
  String restText()
  {
    switch( int(random(35) ) )
    {
      case 0: return party.hero[0].name + " pulls out a lyre and soothes the group with song.";
      case 1: return party.hero[0].name + " pulls out a lyre and rocks the night away.";
      case 2: return party.hero[0].name + ", pass the ale.";
      case 3: return party.hero[0].name + " is exhausted after a long day.";
      case 4: return "Where did " + party.hero[0].name + " find chocolate? Who cares!? ";
      case 5: return party.hero[0].name + " practices using the " + party.hero[0].weapon.name.toLowerCase() + ".";
      
      case 6: return "A cat keeps " + party.hero[1].name + " awake for hours.";
      case 7: return party.hero[1].name + " brews some tea.";
      case 8: return party.hero[1].name + " falls asleep immediately.";
      case 9: return party.hero[1].name + " hits the pillow hard.";
      case 10: return party.hero[1].name + " volunteers to mend the holes in everyone's socks.";
      case 11: return "A cat is meowing in the distance. It keeps " + party.hero[1].name + " awake for hours.";
      
      case 12: return party.hero[2].name + "'s book is missing. Everyone empty your packs. Yes, now!";
      case 13: return party.hero[2].name + " stays up reading \"Dragon Island\".";
      case 14: return party.hero[2].name + " stays up reading \"Dragon Island\".";
      case 15: return party.hero[2].name + " stays up reading \"Dragon Island\".";
      case 16: return party.hero[2].name + " stays up reading \"Dragon Island 2: Return of the Revenge\".";
      case 17: return "Oh no, " + party.hero[2].name + " is snoring again.";
      
      case 18: return "ZZZZzzzz....";
      case 19: return "Time for a long rest.";
      case 20: return "Break out the rations.";
      case 21: return "A warm bed is just what we need right now.";
      case 22: return "The warm fire brings life back to your weary bones.";
      case 23: return "Ahhhhhh. Pass the marshmallows.";
      case 24: return "Sweet dreams. ";
      case 25: return "You feel safe, at least for the night.";
      case 26: return "A quiet night and your energy is restored.";
      case 27: return "You clean your armor and empty the rocks from your shoes.";
      case 28: return "You clean your weapons and massage your sore muscles.";
      default: return "Good Night.";
    }
  }
  
  void drawRestFadeout()
  {
    if(restFadeIn)
      restOpacity+=2;
    else
      restOpacity-=5;
      
    fill(0,restOpacity); noStroke();
    rect(0,160,700,440);
    
    if(restOpacity > 300)
    {
      restFadeIn=false;
      party.healAll();
      party.reagents = party.hero[1].level;
    }
    if(restOpacity <= 0)
    {
      resting = false;
      input = Input.EXPLORING;
    }
  }
  
  void drawBattleWindow()
  {
    //println("1: "+party.hero[0].poison+ "  2: "+party.hero[1].poison+"  3: "+party.hero[2].poison);
    strokeWeight(5);
    stroke(200);
    fill(0);
    if(battleWindowOpening)
    {
      rectMode(CENTER);
      rect(frameWidth/2,377+25,14*animationStage,8.7*animationStage,20);
      //println(14*animationStage + " " + 8.7*animationStage );
      if(animationStage==49)
        battleWindowOpening=false;
    }
    else
    {
      rectMode(CORNER);
      rect(3,159,frameWidth-7,frameHeight-266,20);
      
      drawBattleBack();
      drawMonsters();
      drawProgressBars();
      drawHeroesInBattle();
      drawDefenseIcons();
        
      if(!battle.waitingForText)
      {
        if(input == Input.BATTLE_ITEM)
          drawBattleItems(battle.turn,party.inventory,party.keyInventory);
        else if(input == Input.BATTLE_SKILL)
          drawHeroSkills(battle.turn);
        else if(input == Input.BATTLE_ITEM_HERO_CHOICE) //choosing who to use item on
          drawHeroSelectScreen();
        else if(input == Input.BATTLE_ATTACK_TARGET || input == Input.BATTLE_SKILL_TARGET || input == Input.BATTLE_ITEM_TARGET )
          drawAttackTargetArrows( battle.turn, true );
        else if(input == Input.BATTLE_HEAL_TARGET)
          drawAttackTargetArrows( battle.turn, false );
        else if(battle.turn==0||battle.turn==1||battle.turn==2)
          drawBattleIcons(battle.turn);
      }
        //drawBattleItems(0,party.inventory); //for testing
    }
    
    if(debugMode)
    {
      //TESTING
      push();
      textSize(40);
      textAlign(CENTER);
      text(party.hero[2].bardBonus,650,650);
      pop();
    }
  }
  
  void drawBattleBack()
  {                      //1-Cathedral  2-Cellar  3-Forest  4-City  5-Graveyard  6-TEMPLE OF RITISU
    push();              //7-Inside(scary,stone)  8-Inside(scary,wood)  9-Boat  10-Cave  11-Hive
    imageMode(CENTER);   //12-Hilly forest
    switch(zoneNumber)
    {
      case 1: case 2: case 7:
        image(battleBack[1],frameWidth/2,250); //Stone wall
        break;
      case 3:
        image(battleBack[0],frameWidth/2,250); //Trees
        break;
      case 5:
        image(battleBack[2],frameWidth/2,252); //Graveyard
        break;
      case 6:
        image(battleBack[7],frameWidth/2,250); //Stone wall with window
        break;
      case 10:
        image(battleBack[3],frameWidth/2,252); //Cave
        break;
      case 8: case 9:
        image(battleBack[4],frameWidth/2,252); //Wooden wall 4
        break;
      case 11:
        image(battleBack[5],frameWidth/2,252); //Honey cave
        break;
      case 12:
        image(battleBack[6],frameWidth/2,250); //Trees and mountains
        break;
      case 13:
        image(battleBack[8],frameWidth/2,252); //Underground River
        break;
    }
    pop();
  }
  
  void drawDefenseIcons()
  {
    for(int i = 0; i < 3; i++)
      if(party.hero[i].defending)
        drawDefendIcon(100+250*i,155,party.hero[i].favColor,party.hero[i].inverseColor,party.hero[i].job,false);
  }
  
  void drawShield( float x, float y, int heroIndex ) //defunct?
  {
    push();
    tint(party.hero[heroIndex].favColor);
    image(iconImage[3],x,y);
    tint(party.hero[heroIndex].inverseColor);
    image(iconImage[4],x,y);
    noTint();
    image(iconImage[2],x,y);
    pop();
    /*
    stroke(200);
    strokeWeight(3);
    fill(party.hero[heroIndex].favColor);
    beginShape();
    vertex(x-15,y-15);
    vertex(x+15,y-15);
    vertex(x+15,y+10);
    vertex(x,y+15);
    vertex(x-15,y+10);
    vertex(x-15,y-15);
    endShape();*/
  }
  
  void drawProgressBars()
  {
    int total = 20*party.averageLevel()+100; //adding 100 to normalize speeds
    for(int i = 0; i < 3; i++)
    {
      strokeWeight(1); stroke(150);
      if(battle.list[i].active){ fill(party.hero[i].inverseColor); rect(100+210*i,578, min(80,(battle.list[i].counter/total)*80) ,10); }
      if(party.hero[i].buff[4].active)
      { strokeWeight(2); stroke(120+textPromptStage*2,100,0); }
      noFill(); if(battle.list[i].active) rect(100+210*i,578,80,10);
    }
  }
  
  void drawAttackTargetArrows( int h, boolean attack )
  {
    noStroke(); textAlign(CENTER);
    fill( party.hero[h].inverseColor );  //Arrow Outline
    if(attack)
    {
      if(battle.list[3].active) triangle(140,378, 115,400, 165,400);
      if(battle.list[4].active) triangle(350,378, 325,400, 375,400);
      if(battle.list[5].active) triangle(560,378, 535,400, 585,400);
    }
    else
    {
      triangle(140,447, 115,425, 165,425);
      triangle(350,447, 325,425, 375,425);
      triangle(560,447, 535,425, 585,425);
    }
    
    fill( party.hero[h].favColor );      //Arrow Main
    if( attack )
    {
      if(battle.list[3].active) triangle(140,380, 115,400, 165,400);
      if(battle.list[4].active) triangle(350,380, 325,400, 375,400);
      if(battle.list[5].active) triangle(560,380, 535,400, 585,400);
    }
    else
    {
      triangle(140,445, 115,425, 165,425);
      triangle(350,445, 325,425, 375,425);
      triangle(560,445, 535,425, 585,425);
    }
    
    fill(0);                             //Arrow's cut-out
    if( attack )
    {
      if(battle.list[3].active) triangle(140,390, 115,400, 165,400);
      if(battle.list[4].active) triangle(350,390, 325,400, 375,400);
      if(battle.list[5].active) triangle(560,390, 535,400, 585,400);
    }
    else
    {
      triangle(140,435, 115,425, 165,425);
      triangle(350,435, 325,425, 375,425);
      triangle(560,435, 535,425, 585,425);
    }
    
    if(attack)
    {
      fill( party.hero[h].favColor );textSize(24*fontScale); //Letter Backing
      if(battle.list[3].active) text("A",140,420);
      if(battle.list[4].active) text("S",350,420);
      if(battle.list[5].active) text("D",560,420);
      fill( party.hero[h].inverseColor );textSize(25*fontScale); //Letter
      if(battle.list[3].active) text("A",140,420);
      if(battle.list[4].active) text("S",350,420); 
      if(battle.list[5].active) text("D",560,420);
    }
    else
    {
      fill( party.hero[h].favColor );textSize(24*fontScale); //Letter Backing
      text("A",140,420); text("S",350,420); text("D",560,420);
      fill( party.hero[h].inverseColor );textSize(25*fontScale); //Letter
      text("A",140,420); text("S",350,420); text("D",560,420);
    }
     
    rectMode(CENTER); strokeWeight(5);
    stroke(200); fill(0);
    rect(party.heroX(h)+75,545,70,70,20);
    drawCancelIcon(party.heroX(h)+75,545);
  }
  
  void drawBattleIcons( int h )
  {
    float baseX = party.heroX(h);

    textAlign(CENTER);
    rectMode(CENTER); strokeWeight(5);
    stroke(200); fill(0);
    rect(baseX-75,455,70,70,20);rect(baseX+75,455,70,70,20);
    rect(baseX-75,545,70,70,20);rect(baseX+75,545,70,70,20);
    
    drawAttackIcon(baseX-75,455,party.hero[h].favColor,party.hero[h].inverseColor,party.hero[h].weapon.pic,h);
    drawDefendIcon(baseX+75,455,party.hero[h].favColor,party.hero[h].inverseColor,party.hero[h].job,true);
    drawSkillIcon(baseX-75,545,party.hero[h].favColor,party.hero[h].inverseColor,party.hero[h].job);
    drawItemIcon(baseX+75,545,party.hero[h].favColor);

    rectMode(CENTER); strokeWeight(3);
    stroke(party.hero[h].favColor); noFill();
    rect(baseX-75,455,67,67,20);rect(baseX+75,455,67,67,20);
    rect(baseX-75,545,67,67,20);rect(baseX+75,545,67,67,20);

    //drawAttackIcon(baseX-75,455,party.hero[h].inverseColor);
    //drawHeroByType(party.hero[0],width/5,500,2,0,false);
    //drawHeroByType(party.hero[1],width/2,500,2,1,false);
    //drawHeroByType(party.hero[2],int(width*.8),500,2,2,false);
  }
  
  void drawAttackIcon( float x, float y, color c, color i, PImage p, int h)
  {
    if( party.hero[h].job == Job.KARATE )
    {
      int skin = party.hero[h].skinColor;
      push();
      tint(color(55+0.67*skin,30+0.67*skin,20+0.63*skin));
      image(iconImage[7],x,y);
      pop();
    }
    else
      image(p,x,y);
    /*
    if( j ==Job.KNIGHT || j == Job.THIEF)//sword/dagger
    {
      noStroke();
      rectMode(CENTER);
      fill(200);
      rect(x,y+20,13,30);
      stroke(150); strokeWeight(1);
      line(x,y+3,x,y+32);
      fill(90,70,30); noStroke();
      rect(x,y-9,10,20);
      fill(#FFC13B);
      rect(x,y+3,30,7,5);
      rect(x,y-22,12,3);
      fill(c);
      rect(x,y-19,11,3);
    }
    else if( j == Job.MAGE || j == Job.PRIEST ) //staff
    {
      strokeWeight(10); stroke(90,70,30);
      line(x-25,y+25,x+15,y-15);
      strokeWeight(4); fill(i);
      circle(x+11,y-11,20);
    }
    else if( j == Job.BARBARIAN ) //axe
    {
      
    }
    else if( j == Job.KARATE ) //fist
    {
      
    }
    */
    
    fill(200); textSize(10*fontScale);
    text("A",x+25,y+27);
  }
  
  void drawDefendIcon( float x, float y, color c, color i, Job j, boolean drawD )
  {
    push();
    imageMode(CENTER);
    
    if( j == Job.KNIGHT || j == Job.PRIEST ) //heater
    {
      tint(c);
      image(iconImage[3],x,y);
      tint(i);
      image(iconImage[4],x,y);
      noTint();
      image(iconImage[2],x,y);
      /*
      //top right color
      noStroke(); fill(i);
      beginShape();
      vertex(x,y-30);
      bezierVertex(x,y-23,x+20,y-20,x+20,y-23);
      vertex(x+20,y-7);
      vertex(x,y-7);
      endShape();
      
      //top left color
      noStroke(); fill(c);
      beginShape();
      vertex(x,y-30);
      bezierVertex(x,y-23,x-20,y-20,x-20,y-23);
      vertex(x-20,y-7);
      vertex(x,y-7);
      endShape();
      
      //bottom right color
      noStroke(); fill(c);
      beginShape();
      vertex(x,y-7);
      vertex(x+20,y-7);
      bezierVertex(x+20,y+8,x,y+27,x,y+27);
      endShape();
      
      //bottom left color
      noStroke(); fill(i);
      beginShape();
      vertex(x,y-7);
      vertex(x-20,y-7);
      bezierVertex(x-20,y+8,x,y+27,x,y+27);
      endShape();
      
      //outline
      noFill(); stroke(200); 
      strokeWeight(3);
      beginShape();
      vertex(x,y+27);  //x: 65, y: 545
      bezierVertex(x,y+27,x-20,y+8,x-20,y-7);
      vertex(x-20,y-23);
      bezierVertex(x-20,y-20,x,y-23,x,y-30);
      bezierVertex(x,y-23,x+20,y-20,x+20,y-23);
      vertex(x+20,y-7);
      bezierVertex(x+20,y+8,x,y+27,x,y+27);
      endShape();
      */
    }
    else if( j == Job.SAURIAN )
    {
      tint(c);
      image(iconImage[5],x,y);
      tint(i);
      image(iconImage[6],x,y);
    }
    else  //targe with cross
    {
      image(iconImage[0],x,y);
      tint(c);
      image(iconImage[1],x,y);
      /*
      noStroke(); fill(90,70,30);
      circle(x,y,50);
      rectMode(CENTER); fill(c,150);
      rect(x,y,49,7); rect(x,y,7,49);
      stroke(200); strokeWeight(2);
      fill(180);  circle(x,y,15);
      stroke(190); strokeWeight(3);
      noFill(); circle(x,y,51);
      */
    }
    
    if( drawD )
    {
      fill(200); textSize(10*fontScale);
      text("D",x+25,y+27);
    }
    
    pop();
  }
  
  void drawSkillIcon( float x, float y, color c, color i, Job j)
  {
    fill(c, 30); noStroke();
    for(int k = 0; k < 10; k++) circle(x,y,3*k+45);
    
    if( j == Job.KNIGHT )
    {
      image(skillButton[0],x,y);
    }
    else if( j == Job.BARBARIAN )
    {
      image(skillButton[1],x,y);
    }
    else if( j == Job.THIEF )
    {
      image(skillButton[2],x,y);
    }
    else if( j == Job.KARATE )
    {
      image(skillButton[3],x,y);
    }
    else if( j == Job.SAURIAN )
    {
      image(skillButton[6],x,y);
    }
    else if( j == Job.BARD )
    {
      image(skillButton[7],x,y);
    }
    else if( j == Job.DRUID )
    {
      image(skillButton[8],x,y);
    }
    else if( j == Job.PRIEST ) //cross
    {
      fill(250); stroke(i); strokeWeight(1.5);
      beginShape(); strokeJoin(BEVEL);
      vertex(x-26,y-13);
      bezierVertex(x-26,y,x-4,y-4,x-4,y-4);
      bezierVertex(x-4,y-4,x,y-26,x-13,y-26);
      vertex(x+13,y-26);
      bezierVertex(x,y-26,x+4,y-4,x+4,y-4);
      bezierVertex(x+4,y-4,x+26,y,x+26,y-13);
      vertex(x+26,y+13);
      bezierVertex(x+26,y,x+4,y+4,x+4,y+4);
      bezierVertex(x+4,y+4,x,y+26,x+13,y+26);
      vertex(x-13,y+26);
      bezierVertex(x,y+26,x-4,y+4,x-4,y+4);
      bezierVertex(x-4,y+4,x-26,y,x-26,y+13);
      vertex(x-26,y-13);
      endShape(); strokeJoin(MITER);
    }
    else if( j == Job.MAGE ) //spellbook
    {
      rectMode(CORNER);
      //fill(255);
      //rect(0,0,500,500);
      fill(0);stroke(0);
      strokeWeight(3);
      quad(x-23,y-25,x-19,y-29,x-19,y+20,x-23,y+24);
      strokeWeight(2);
      rect(x-17,y-30,40,50);
      strokeWeight(.7);
      stroke(200);
      rect(x-19,y-28,40,50);
      rect(x-20,y-27,40,50);
      rect(x-21,y-26,40,50);
      strokeWeight(2); stroke(0);
      fill(190,170,130);
      rect(x-23,y-24,40,50);
      line(x-23,y-18,x+15,y-18);
      line(x-23,y+20,x+15,y+20);
      line(x+11,y-23,x+11,y+26);
      line(x-18,y-23,x-18,y+26);
      noStroke(); fill(c);
      beginShape();
      vertex(x-3,y-11);
      vertex(x-11,y+12);  //x:120  y:98
      vertex(x+9,y-3);
      vertex(x-15,y-3);
      vertex(x+5,y+12);
      endShape();
      fill(i);
      circle(x-9,y-8,4);
      circle(x+3,y-8,4);
      circle(x+7,y+4,4);
      circle(x-13,y+4,4);
      circle(x-3,y+12,4);
    }
    
    fill(200); textSize(10*fontScale);
    text("S",x+25,y+27);
  }
  
  void drawItemIcon( float x, float y, color c )
  {
    /*
    rectMode(CENTER);
    fill(140,120,80); noStroke();
    circle(x,y+5,40);
    quad(x+8,y-15,x+15,y-25,x-15,y-25,x-8,y-15);
    fill(80,60,20);
    rect(x,y-15,20,5);
    */
    
    imageMode(CENTER);
    image(tileImage[68],x,y);
    
    fill(200); textSize(10*fontScale);
    text("X",x+25,y+27);
  }
  
  void drawCancelIcon( float x, float y )
  {
    stroke(127); strokeWeight(10);
    line(x-20,y-20,x+20,y+20);
    line(x-20,y+20,x+20,y-20);
    stroke(200,0,0); strokeWeight(7);
    line(x-19,y-19,x+19,y+19);
    line(x-19,y+19,x+19,y-19);
    
    fill(200); textSize(10*fontScale);
    textAlign(CENTER);
    text("X",x+25,y+27);
  }
  
  //Mostly for character customization screen
  void drawSkillSymbol( float x, float y, color c, color i, Job j )
  {
    imageMode(CENTER);
    if( j == Job.KNIGHT )
    {
      image(skillButton[0],x,y);
    }
    else if( j == Job.BARBARIAN )
    {
      image(skillButton[1],x,y);
    }
    else if( j == Job.THIEF )
    {
      image(skillButton[2],x,y);
    }
    else if( j == Job.KARATE )
    {
      image(skillButton[3],x,y);
    }
    else if( j == Job.SAURIAN )
    {
      image(skillButton[6],x,y);
    }
    else if( j == Job.BARD )
    {
      image(skillButton[7],x,y);
    }
    else if( j == Job.DRUID )
    {
      image(skillButton[8],x,y);
    }
    else if( j == Job.PRIEST ) //cross
    {
      fill(250); stroke(i); strokeWeight(1.5);
      beginShape(); strokeJoin(BEVEL);
      vertex(x-26,y-13);
      bezierVertex(x-26,y,x-4,y-4,x-4,y-4);
      bezierVertex(x-4,y-4,x,y-26,x-13,y-26);
      vertex(x+13,y-26);
      bezierVertex(x,y-26,x+4,y-4,x+4,y-4);
      bezierVertex(x+4,y-4,x+26,y,x+26,y-13);
      vertex(x+26,y+13);
      bezierVertex(x+26,y,x+4,y+4,x+4,y+4);
      bezierVertex(x+4,y+4,x,y+26,x+13,y+26);
      vertex(x-13,y+26);
      bezierVertex(x,y+26,x-4,y+4,x-4,y+4);
      bezierVertex(x-4,y+4,x-26,y,x-26,y+13);
      vertex(x-26,y-13);
      endShape(); strokeJoin(MITER);
    }
    else if( j == Job.MAGE ) //spellbook
    {
      rectMode(CORNER);
      fill(0);stroke(0);
      strokeWeight(3);
      quad(x-23,y-25,x-19,y-29,x-19,y+20,x-23,y+24);
      strokeWeight(2);
      rect(x-17,y-30,40,50);
      strokeWeight(.7);
      stroke(200);
      rect(x-19,y-28,40,50);
      rect(x-20,y-27,40,50);
      rect(x-21,y-26,40,50);
      strokeWeight(2); stroke(0);
      fill(190,170,130);
      rect(x-23,y-24,40,50);
      line(x-23,y-18,x+15,y-18);
      line(x-23,y+20,x+15,y+20);
      line(x+11,y-23,x+11,y+26);
      line(x-18,y-23,x-18,y+26);
      noStroke(); fill(c);
      beginShape();
      vertex(x-3,y-11);
      vertex(x-11,y+12);  //x:120  y:98
      vertex(x+9,y-3);
      vertex(x-15,y-3);
      vertex(x+5,y+12);
      endShape();
      fill(i);
      circle(x-9,y-8,4);
      circle(x+3,y-8,4);
      circle(x+7,y+4,4);
      circle(x-13,y+4,4);
      circle(x-3,y+12,4);
    }
  }
    
  //Redundant with method in Attack class, needed for coloring skills changed by weapon type
  public color appropriateColor( AttackType type )
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
  
  void drawHero(int x, int y, float scale, color c1, color c2, int hair, int skin, boolean initial, Job j)
  {
    switch(j)
    {
      case KNIGHT:
        drawKnight( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case BARBARIAN:
        drawBarbarian( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case SAURIAN:
        drawSaurian( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case KARATE:
        drawKarate( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case BARD:
        drawBard( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case THIEF:
        drawThief( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case DRUID:
        drawDruid( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      case PRIEST:
        drawPriest( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
      default:
        drawMage( x,  y,  scale,  c1,  c2, hair, skin,  initial);
        break;
    }
  }
  
  void drawKnight(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    color skin;
    color hair;
    hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
    strokeWeight(0.5);
    //Sword
    fill(195,200,205);
    push();
    translate(x+6*scale,y+8*scale);
    rotate(PI/4);
    beginShape();
    vertex(3*scale,0);
    vertex(4*scale,-33*scale);
    vertex(0,-37.5*scale);
    vertex(-4*scale,-33*scale);
    vertex(-3*scale,0);
    endShape();
    line(0,0,0,-34*scale);
    pop();
  
    //Circle
    noFill();
    stroke(255);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //Hair - color based on which hero (brown, blonde, black)
    //if(heroNumber==0)
    //  fill(90,70,30);
    //else if(heroNumber==1)
    //  fill(210,190,70);
    //else
    //  fill(10,10,5);
    fill(hairTone[h]);
    stroke(255);
    strokeWeight(0.5);
    ellipse(x,y-12*scale,scale*25,scale*25);
  
    //Cape
    fill(c1);
    //stroke(0);
    beginShape();
    vertex(x-14*scale, y+1*scale);
    bezierVertex(x-14*scale,y+1*scale, x-14*scale, y-3*scale, x-10*scale,y-5*scale);
    bezierVertex(x-10*scale,y-2*scale, x+10*scale,y-2*scale, x+10*scale,y-5*scale);
    bezierVertex(x+10*scale,y-3*scale, x+14*scale, y-3*scale, x+14*scale,y+1*scale);
    vertex(x+14*scale, y+1*scale);
    vertex(x+21*scale, y+30*scale);
    bezierVertex(x+15*scale, y+37*scale, x-15*scale, y+37*scale, x-21*scale, y+30*scale);
    vertex(x-14*scale, y+1*scale );
    endShape();
    //Flap
    beginShape();
    vertex(x-6.5*scale,y+10*scale);
    vertex(x-10*scale,y+35*scale);
    bezierVertex(x-10*scale,y+38*scale, x+10*scale,y+38*scale, x+10*scale,y+35*scale);
    vertex(x+6.5*scale,y+10*scale);
    endShape();
  
    //Braid
    //if(heroNumber==0)
    //  fill(90,70,30);
    //else if(heroNumber==1)
    //  fill(210,190,70);
    //else
    //  fill(10,10,5);
    fill(hair);
    //Braided section
    noStroke();
    quad(x-3*scale,y-7*scale,  x+3*scale,y-7*scale,  x+1*scale,y+11.25*scale,  x-1*scale,y+11.25*scale);
    //Bottom tuft
    beginShape();
    vertex(x+0*scale,y+16*scale);
    bezierVertex(x+4.5*scale,y+10*scale, x-4.5*scale,y+10*scale, x+0*scale,y+16*scale);
    endShape();
    //Tie
    stroke(c2);
    strokeWeight(scale);
    line(x-1*scale,y+11.15*scale,  x+1*scale,y+11.15*scale);
    //Braid lines
    stroke(0);
    strokeWeight(0.1*scale);
    line(x-1.2*scale,y+9.4*scale, x+1.0*scale,y+10.5*scale);
    line(x+1.2*scale,y+8.7*scale, x-0.6*scale,y+9.6*scale);
    line(x-1.4*scale,y+7.7*scale, x+0.7*scale,y+8.9*scale);
    line(x+1.4*scale,y+6.7*scale, x-0.7*scale,y+8.0*scale);
    line(x-1.6*scale,y+5.7*scale, x+0.8*scale,y+7.1*scale);
    line(x+1.6*scale,y+4.7*scale, x-0.8*scale,y+6.2*scale);
    line(x-1.8*scale,y+3.7*scale, x+0.8*scale,y+5.2*scale);
    line(x+1.8*scale,y+2.7*scale, x-0.9*scale,y+4.2*scale);
    line(x-2.0*scale,y+1.7*scale, x+0.9*scale,y+3.2*scale);
    line(x+2.0*scale,y+0.7*scale, x-0.9*scale,y+2.2*scale);
    line(x-2.3*scale,y-0.7*scale, x+1.0*scale,y+1.2*scale);
    line(x+2.3*scale,y-1.7*scale, x-0.9*scale,y+0.0*scale);
    line(x-2.5*scale,y-2.7*scale, x+0.8*scale,y-0.9*scale);
    line(x+2.7*scale,y-4.2*scale, x-1.1*scale,y-2.1*scale);
    line(x-2.8*scale,y-5.3*scale, x+0.8*scale,y-3.2*scale);
    line(x+3.0*scale,y-7.0*scale, x-1.6*scale,y-4.7*scale);
   
    //Helmet
    stroke(255);
    fill(195,200,205);
    beginShape();
    vertex(x+10*scale,y-4*scale);
    bezierVertex(x+10*scale,y-7*scale,x-10*scale,y-7*scale,x-10*scale,y-4*scale);
    bezierVertex(x-23*scale,y-32*scale, x+23*scale,y-32*scale, x+10*scale,y-4*scale);
    endShape();
    fill(c2);
    beginShape();
    vertex(x+11*scale,y-4.2*scale);
    bezierVertex(x+10*scale,y-9*scale,x-10*scale,y-9*scale,x-11*scale,y-4.2*scale);
    bezierVertex(x-23*scale,y-32*scale, x+23*scale,y-32*scale, x+11*scale,y-4.2*scale);
    endShape();
    //Frills
    fill(c1);
    beginShape();
    vertex(x,y-11*scale);
    bezierVertex(x+6*scale,y-33*scale, x-6*scale,y-33*scale, x,y-11*scale);
    endShape();
    beginShape();
    vertex(x+10*scale,y-13*scale);
    bezierVertex(x+17*scale,y-27*scale, x+10*scale,y-27*scale, x+10*scale,y-13*scale);
    endShape();
    beginShape();
    vertex(x-10*scale,y-13*scale);
    bezierVertex(x-17*scale,y-27*scale, x-10*scale,y-27*scale, x-10*scale,y-13*scale);
    endShape();
     
    //Pauldrons
    fill(195,200,205);
    beginShape();
    vertex(x-6.25*scale,y-5.2*scale);
    vertex(x-6.25*scale,y-.5*scale);
    bezierVertex(x-8.5*scale,y-0*scale, x-8.5*scale,y-0*scale,  x-9*scale,y+2.5*scale);
    vertex(x-19.5*scale,y+4.5*scale);
    bezierVertex(x-19*scale,y-4*scale, x-19*scale,y-4*scale, x-9.25*scale,y-5.2*scale);
    endShape();
    beginShape();
    vertex(x+6.25*scale,y-5.2*scale);
    vertex(x+6.25*scale,y-.5*scale);
    bezierVertex(x+8.5*scale,y-0*scale, x+8.5*scale,y-0*scale,  x+9*scale,y+2.5*scale);
    vertex(x+19.5*scale,y+4.5*scale);
    bezierVertex(x+19*scale,y-4*scale, x+19*scale,y-4*scale, x+9.25*scale,y-5.2*scale);
    endShape();
    
    fill(c2);
    beginShape();
    vertex(x-7.25*scale,y-5.2*scale);
    vertex(x-7.25*scale,y-1.5*scale);
    bezierVertex(x-9.5*scale,y-1*scale, x-9.5*scale,y-1*scale,  x-10*scale,y+1.5*scale);
    vertex(x-19.5*scale,y+3.5*scale);
    bezierVertex(x-19*scale,y-4*scale, x-19*scale,y-4*scale, x-9.25*scale,y-5.2*scale);
    endShape();
    beginShape();
    vertex(x+7.25*scale,y-5.2*scale);
    vertex(x+7.25*scale,y-1.5*scale);
    bezierVertex(x+9.5*scale,y-0*scale, x+9.5*scale,y-0*scale,  x+10*scale,y+1.5*scale);
    vertex(x+19.5*scale,y+3.5*scale);
    bezierVertex(x+19*scale,y-4*scale, x+19*scale,y-4*scale, x+9.25*scale,y-5.2*scale);
    endShape();
  }
  
  void drawBarbarian(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  { 
    color skin;
    color hair;
    //Circle
    noFill();
    strokeWeight(0.5);
    stroke(255);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //if(heroNumber==0)
    //{
    //  hair = color(90,70,30);
    //  skin = color(#C68642);
    //}
    //else if(heroNumber==1)
    //{
    //  hair = color(210,190,70);
    //  skin = color(#F1C27D);
    //}
    //else
    //{
    //  hair = color(10,10,5);
    //  skin = color(#FFDBAC);
    //}
    hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
    
    //Upper Body
    fill(skin);
    beginShape();
    vertex(x-1.4*scale,y-7.6*scale);
    bezierVertex(x-3.4*scale,y-7.6*scale, x-22.0*scale,y-15.0*scale, x-22.0*scale,y-2*scale);
    bezierVertex(x-23.0*scale,y-0*scale, x-23.0*scale,y+4.4*scale, x-21.0*scale,y+8.4*scale);
    bezierVertex(x-21.6*scale,y+10.4*scale, x-16.5*scale,y+15.4*scale, x-16.5*scale,y+15.4*scale);
    vertex(x-12.4*scale,y+12*scale);
    bezierVertex(x-12.2*scale,y+11.6*scale, x-14*scale,y+7.4*scale, x-15.2*scale,y+6.4*scale);
    bezierVertex(x-13.2*scale,y+6.4*scale, x-13.4*scale,y-1*scale, x-15.4*scale,y-1*scale);
    bezierVertex(x-15.4*scale,y-1*scale, x-15.4*scale,y-1*scale, x-9.4*scale,y+7.8*scale);
    bezierVertex(x-9.4*scale,y+7.8*scale, x-9.4*scale,y+7.8*scale, x-9.4*scale,y+11.8*scale);
    vertex(x+9.6*scale,y+11.8*scale);
    endShape();
    beginShape();
    vertex(x+1.4*scale,y-7.6*scale);
    bezierVertex(x+3.4*scale,y-7.6*scale, x+22.0*scale,y-15.0*scale, x+22.0*scale,y-2*scale);
    bezierVertex(x+23.0*scale,y-0*scale, x+23.0*scale,y+4.4*scale, x+21.0*scale,y+8.4*scale);
    bezierVertex(x+21.6*scale,y+10.4*scale, x+16.5*scale,y+15.4*scale, x+16.5*scale,y+15.4*scale);
    vertex(x+12.4*scale,y+12*scale);
    bezierVertex(x+12.2*scale,y+11.6*scale, x+14*scale,y+7.4*scale, x+15.2*scale,y+6.4*scale);
    bezierVertex(x+13.2*scale,y+6.4*scale, x+13.4*scale,y-1*scale, x+15.4*scale,y-1*scale);
    bezierVertex(x+15.4*scale,y-1*scale, x+15.4*scale,y-1*scale, x+9.4*scale,y+7.8*scale);
    bezierVertex(x+9.4*scale,y+7.8*scale, x+9.4*scale,y+7.8*scale, x+9.4*scale,y+11.8*scale);
    vertex(x-9.6*scale,y+11.8*scale);
    endShape();
    
    /*
    //Scar/Tattoo
    fill(c1);
    beginShape();
    vertex(x-17*scale,y-7*scale);
    vertex(x-8*scale,y+2.5*scale);
    bezierVertex(x-12*scale,y-2.8*scale, x-15*scale,y-6*scale, x-17*scale,y-7*scale);
    endShape();
    */
    
    //Weapon & Hands
    rectMode(CORNER);
    fill(110,90,50);
    rect(x-20*scale,y+14*scale,50*scale,2*scale);
    fill(skin);
    ellipse(x-13.2*scale,y+15*scale,7*scale,7*scale);
    ellipse(x+13.2*scale,y+15*scale,7*scale,7*scale);
    fill(195,200,205);
    beginShape();
    vertex(x+27.25*scale,y+16.5*scale);
    bezierVertex(x+27.25*scale,y+17*scale, x+27.25*scale,y+20*scale, x+31*scale,y+21*scale);
    bezierVertex(x+31*scale,y+23*scale, x+21*scale,y+23*scale, x+18*scale,y+21*scale);
    bezierVertex(x+24.75*scale,y+21*scale, x+24.75*scale,y+16.5*scale, x+24.75*scale,y+16.5*scale);
    endShape();
    rect(x+24.5*scale,y+13.5*scale,3*scale,3*scale);
    
    //Harness
    fill(120,100,60);
    beginShape();
    vertex(x-9.4*scale,y+8.4*scale);
    vertex(x+9.8*scale,y+9*scale);
    vertex(x+15.4*scale,y-0.2*scale);
    vertex(x+13.2*scale,y-10*scale);
    vertex(x+9.4*scale,y-10*scale);
    vertex(x-15.2*scale,y-0.4*scale);
    endShape();
    
    //Legs
    fill(skin);
    beginShape();
    vertex(x-9.4*scale,y+13*scale);
    bezierVertex(x-10.6*scale,y+13*scale, x-10.4*scale,y+24.2*scale, x-9.4*scale,y+24.2*scale);
    vertex(x-9.4*scale,y+33.2*scale);
    bezierVertex(x-9.4*scale,y+36.2*scale, x-3.2*scale,y+36.2*scale, x-3.2*scale,y+33.2*scale);
    vertex(x-3.2*scale,y+24.2*scale);
    vertex(x-0*scale,y+15*scale);
    endShape();
    beginShape();
    vertex(x+9.4*scale,y+13*scale);
    bezierVertex(x+10.6*scale,y+13*scale, x+10.4*scale,y+24.2*scale, x+9.4*scale,y+24.2*scale);
    vertex(x+9.4*scale,y+33.2*scale);
    bezierVertex(x+9.4*scale,y+36.2*scale, x+3.2*scale,y+36.2*scale, x+3.2*scale,y+33.2*scale);
    vertex(x+3.2*scale,y+24.2*scale);
    vertex(x+0*scale,y+15*scale);
    endShape();
    //Boots
    fill(120,100,60);
    beginShape();
    vertex(x-8.4*scale,y+35.0*scale);
    vertex(x-11.6*scale,y+32.4*scale);
    bezierVertex(x-11.6*scale,y+30.4*scale, x-8.8*scale,y+31.2*scale, x-6.8*scale,y+31.2*scale);
    endShape();
    noStroke();
    ellipse(x-6.2*scale,y+33.4*scale,6*scale,4.1*scale);
    rect(x-9.4*scale,y+29*scale,6.3*scale,5.0*scale);
    
    fill(120,100,60);
    stroke(255);
    beginShape();
    vertex(x+8.4*scale,y+35.0*scale);
    vertex(x+11.6*scale,y+32.4*scale);
    bezierVertex(x+11.6*scale,y+30.4*scale, x+8.8*scale,y+31.2*scale, x+6.8*scale,y+31.2*scale);
    endShape();
    noStroke();
    ellipse(x+6.2*scale,y+33.4*scale,6*scale,4.1*scale);
    rect(x+3.2*scale,y+29*scale,6.3*scale,5.0*scale);
    
    //Hair
    fill(hair);
    stroke(255);
    strokeWeight(0.5);
    ellipse(x,y-18*scale,scale*25,scale*25);
    beginShape();
    vertex(x-12.4*scale,y-16.0*scale);
    vertex(x-14.8*scale,y-8.8*scale);
    vertex(x-10.8*scale,y-9.8*scale);
    vertex(x-11.0*scale,y-4.0*scale);
    vertex(x-7.6*scale,y-7.2*scale);
    vertex(x-6.4*scale,y-1.4*scale);
    vertex(x-2.6*scale,y-4.6*scale);
    vertex(x-0.2*scale,y-0.6*scale);
    vertex(x+2.8*scale,y-4.6*scale);
    vertex(x+6.0*scale,y-1.6*scale);
    vertex(x+8.6*scale,y-7.2*scale);
    vertex(x+11.8*scale,y-4.4*scale);
    vertex(x+12.0*scale,y-10.8*scale);
    vertex(x+15.8*scale,y-9.8*scale);
    vertex(x+12*scale,y-16.4*scale);
    endShape();
    
    //Helmet
    fill(c1);
    beginShape();
    vertex(x-13*scale,y-18*scale);
    bezierVertex(x-13*scale,y-16*scale, x+13*scale,y-16*scale, x+13*scale,y-18*scale);
    bezierVertex(x+13*scale,y-36*scale, x-13*scale,y-36*scale, x-13*scale,y-18*scale);
    endShape();
    stroke(c2);
    strokeWeight(scale*3);
    noFill();
    curve(x-13*scale,y-26*scale, x-13*scale,y-18*scale, x+13*scale,y-18*scale, x+13*scale,y-26*scale);
    strokeWeight(0.5);
    //Horns
    fill(200);
    stroke(255);
    beginShape();
    vertex(x+9*scale,y-28*scale);
    bezierVertex(x+11*scale,y-28*scale, x+14*scale,y-31*scale, x+14*scale,y-33*scale);
    bezierVertex(x+16*scale,y-33*scale, x+13.4*scale,y-24.6*scale, x+11.4*scale,y-24.6*scale);
    endShape();
    beginShape();
    vertex(x-9*scale,y-28*scale);
    bezierVertex(x-11*scale,y-28*scale, x-14*scale,y-31*scale, x-14*scale,y-33*scale);
    bezierVertex(x-16*scale,y-33*scale, x-13.4*scale,y-24.6*scale, x-11.4*scale,y-24.6*scale);
    endShape();
    
    //Cloth
    fill(c1);
    beginShape();
    vertex(x-10*scale,y+12*scale);
    vertex(x+10*scale,y+12*scale);
    vertex(x+7.5*scale,y+24*scale);
    vertex(x-7.5*scale,y+24*scale);
    vertex(x-10*scale,y+12*scale);
    //bezierVertex(x+10*scale,y+25*scale, x-10*scale,y+25*scale, x-10*scale,y+10*scale);
    endShape();
    fill(120,100,60); //brown
    rect(x-10*scale,y+11*scale,20*scale,2*scale);
  }
  
  void drawSaurian(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    //Circle
    noFill();
    strokeWeight(0.5);
    stroke(255);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
      
    //Embiggen
    scale*=1.2;
    push();
    translate(0,-5*scale);
    
    color skin = color(red(c1)/1.5,green(c1)/1.5,blue(c1)/1.5);
    color ridge = c2;
    
    //Upper Body
    fill(skin);
    beginShape();
    vertex(x-1.12*scale,y-7.6*scale);
    bezierVertex(x-2.72*scale,y-7.6*scale, x-17.6*scale,y-13.0*scale, x-17.6*scale,y-2*scale);
    bezierVertex(x-18.4*scale,y-0*scale, x-18.4*scale,y+4.4*scale, x-16.8*scale,y+8.4*scale);
    bezierVertex(x-17.28*scale,y+10.4*scale, x-14*scale,y+15.4*scale, x-14*scale,y+15.4*scale);
    vertex(x-11*scale,y+14*scale);
    bezierVertex(x-9.76*scale,y+11.6*scale, x-11.2*scale,y+7.4*scale, x-12.16*scale,y+6.4*scale);
    bezierVertex(x-10.56*scale,y+6.4*scale, x-10.56*scale,y-1*scale, x-12*scale,y-1*scale);
    bezierVertex(x-12*scale,y-1*scale, x-12*scale,y-1*scale, x-7.52*scale,y+7.8*scale);
    bezierVertex(x-7.52*scale,y+7.8*scale, x-7.52*scale,y+7.8*scale, x-7.52*scale,y+11.8*scale);
    vertex(x+7.68*scale,y+11.8*scale);
    endShape();
    
    beginShape();
    vertex(x+1.12*scale,y-7.6*scale);
    bezierVertex(x+2.72*scale,y-7.6*scale, x+17.6*scale,y-13.0*scale, x+17.6*scale,y-2*scale);
    bezierVertex(x+18.4*scale,y-0*scale, x+18.4*scale,y+4.4*scale, x+16.8*scale,y+8.4*scale);
    bezierVertex(x+17.28*scale,y+10.4*scale, x+14*scale,y+15.4*scale, x+14*scale,y+15.4*scale);
    vertex(x+11*scale,y+14*scale);
    bezierVertex(x+9.76*scale,y+11.6*scale, x+11.2*scale,y+7.4*scale, x+12.16*scale,y+6.4*scale);
    bezierVertex(x+10.56*scale,y+6.4*scale, x+10.72*scale,y-1*scale, x+12.32*scale,y-1*scale);
    bezierVertex(x+12.32*scale,y-1*scale, x+12.32*scale,y-1*scale, x+7.52*scale,y+7.8*scale);
    bezierVertex(x+7.52*scale,y+7.8*scale, x+7.52*scale,y+7.8*scale, x+7.52*scale,y+11.8*scale);
    vertex(x-7.68*scale,y+11.8*scale);
    endShape();
    
    //Claws
    beginShape();
    vertex(x-13.85*scale,y+15*scale);
    bezierVertex(x-14.85*scale,y+15.2*scale, x-12.25*scale,y+19.5*scale, x-11.25*scale,y+19.5*scale);
    bezierVertex(x-12.25*scale,y+19.5*scale, x-13.6*scale,y+14.5*scale, x-12.6*scale,y+14.5*scale);
    bezierVertex(x-13.6*scale,y+14.5*scale, x-11.25*scale,y+18.25*scale, x-10.25*scale,y+18.25*scale);
    bezierVertex(x-11.25*scale,y+18.25*scale, x-12.125*scale,y+13.9*scale, x-11.125*scale,y+13.9*scale);
    bezierVertex(x-12.125*scale,y+13.9*scale, x-10.25*scale,y+17.25*scale, x-9.25*scale,y+17.25*scale);
    bezierVertex(x-10.25*scale,y+17.25*scale, x-10.85*scale,y+13.3*scale, x-10.85*scale,y+13*scale);
    bezierVertex(x-10.85*scale,y+12.5*scale, x-8.85*scale,y+14.3*scale, x-8.85*scale,y+14.8*scale);
    bezierVertex(x-8.85*scale,y+13.8*scale, x-10.75*scale,y+11.75*scale, x-10.57*scale,y+11.75*scale);
    endShape();
    beginShape();
    vertex(x+13.85*scale,y+15*scale);
    bezierVertex(x+14.85*scale,y+15.2*scale, x+12.25*scale,y+19.5*scale, x+11.25*scale,y+19.5*scale);
    bezierVertex(x+12.25*scale,y+19.5*scale, x+13.6*scale,y+14.5*scale, x+12.6*scale,y+14.5*scale);
    bezierVertex(x+13.6*scale,y+14.5*scale, x+11.25*scale,y+18.25*scale, x+10.25*scale,y+18.25*scale);
    bezierVertex(x+11.25*scale,y+18.25*scale, x+12.125*scale,y+13.9*scale, x+11.125*scale,y+13.9*scale);
    bezierVertex(x+12.125*scale,y+13.9*scale, x+10.25*scale,y+17.25*scale, x+9.25*scale,y+17.25*scale);
    bezierVertex(x+10.25*scale,y+17.25*scale, x+10.85*scale,y+13.3*scale, x+10.85*scale,y+13*scale);
    bezierVertex(x+10.85*scale,y+12.5*scale, x+8.85*scale,y+14.3*scale, x+8.85*scale,y+14.8*scale);
    bezierVertex(x+8.85*scale,y+13.8*scale, x+10.75*scale,y+11.75*scale, x+10.57*scale,y+11.75*scale);
    endShape();
    
    //Legs
    fill(skin);
    beginShape();
    vertex(x-7.5*scale,y+11*scale);
    bezierVertex(x-8*scale,y+11*scale, x-9.4*scale,y+20*scale, x-9.4*scale,y+20*scale);
    vertex(x-9.4*scale,y+33.2*scale);
    bezierVertex(x-9.4*scale,y+36.2*scale, x-3.2*scale,y+36.2*scale, x-3.2*scale,y+33.2*scale);
    vertex(x-3.2*scale,y+24.2*scale);
    vertex(x+2*scale,y+11*scale);
    endShape();
    
    beginShape();
    vertex(x+7.5*scale,y+11*scale);
    bezierVertex(x+8*scale,y+11*scale, x+9.4*scale,y+20*scale, x+9.4*scale,y+20*scale);
    vertex(x+9.4*scale,y+33.2*scale);
    bezierVertex(x+9.4*scale,y+36.2*scale, x+3.2*scale,y+36.2*scale, x+3.2*scale,y+33.2*scale);
    vertex(x+3.2*scale,y+24.2*scale);
    vertex(x-2*scale,y+11*scale);
    endShape();
    
    //Feet
    rectMode(CORNER);
    beginShape();
    vertex(x-8*scale,y+35*scale);
    bezierVertex(x-9*scale,y+35.0*scale, x-12*scale,y+31*scale, x-12*scale,y+31*scale);
    vertex(x-10*scale,y+31*scale);
    vertex(x-11*scale,y+30*scale);
    vertex(x-5.5*scale,y+31*scale);
    endShape();
    noStroke();
    ellipse(x-6.2*scale,y+33.4*scale,6*scale,4.1*scale);
    rect(x-9.4*scale,y+29*scale,6.3*scale,5.0*scale);
    
    stroke(255);
    beginShape();
    vertex(x+8*scale,y+35*scale);
    bezierVertex(x+9*scale,y+35.0*scale, x+12*scale,y+31*scale, x+12*scale,y+31*scale);
    vertex(x+10*scale,y+31*scale);
    vertex(x+11*scale,y+30*scale);
    vertex(x+5.5*scale,y+31*scale);
    endShape();
    noStroke();
    ellipse(x+6.2*scale,y+33.4*scale,6*scale,4.1*scale);
    rect(x+3.2*scale,y+29*scale,6.1*scale,5.0*scale);
    
    //Thagomizer
    stroke(255);
    fill(ridge);
    triangle(x+11.25*scale,y+34.75*scale,  x+13.5*scale,y+34*scale,  x+12.625*scale,y+35*scale);
    
    //Tail
    fill(skin);
    beginShape();
    vertex(x-5*scale,y+10*scale);
    bezierVertex(x-4*scale,y+10*scale, x-10*scale,y+38*scale, x+13*scale,y+35*scale);
    bezierVertex(x-3*scale,y+30*scale, x+4*scale,y+10*scale, x+5*scale,y+10*scale);
    endShape();
    
    //Head
    beginShape();
    vertex(x+0*scale,y-5*scale);
    bezierVertex(x-15*scale,y-5*scale, x-7*scale,y-17.5*scale, x-12*scale,y-21.5*scale); //left jowel
    bezierVertex(x-9*scale,y-21.5*scale, x-3*scale,y-17.5*scale, x-7*scale,y-20.5*scale); //left ridge
    bezierVertex(x-1*scale,y-23*scale, x+1*scale,y-23*scale, x+7*scale,y-20.5*scale); //center ridge
    bezierVertex(x+3*scale,y-17.5*scale, x+9*scale,y-21.5*scale, x+12*scale,y-21.5*scale); //right ridge
    bezierVertex(x+7*scale,y-17.5*scale, x+15*scale,y-5*scale, x+0*scale,y-5*scale); //right jowel
    endShape();
    
    //Neck
    noStroke();
    ellipse(x+0*scale,y-4.5*scale,8*scale,8*scale);
    stroke(255);
    
    //Ridges
    fill(ridge);
    ellipse(x+0*scale,y-17*scale,1.5*scale,4*scale);
    ellipse(x+0*scale,y-10*scale,1.5*scale,4*scale);
    ellipse(x+0*scale,y-3*scale,2*scale,4.2*scale);
    ellipse(x+0*scale,y+4*scale,2*scale,4.2*scale);
    push();translate(x-0.5*scale,y+12*scale);rotate(0.05*PI);
    ellipse(0,0,1.5*scale,4*scale); pop();
    ellipse(x-1*scale,y+19*scale,1.2*scale,4*scale);
    push();translate(x+0.375*scale,y+26*scale);rotate(-0.1*PI);
    ellipse(0,0,1*scale,4*scale); pop();
    push();translate(x+5.25*scale,y+32*scale);rotate(-0.3*PI);
    ellipse(0,0,1*scale,4*scale); pop();
    
    pop();
  }
  
  void drawKarate(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    color skin;
    color hair;
    //if(heroNumber==0)
    //{
    //  hair = color(90,70,30);
    //  skin = color(#C68642);
    //}
    //else if(heroNumber==1)
    //{
    //  hair = color(210,190,70);
    //  skin = color(#F1C27D);
    //}
    //else
    //{
    //  hair = color(10,10,5);
    //  skin = color(#FFDBAC);
    //}
    hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
      
    stroke(255);
    strokeWeight(0.5);
    //Circle
    noFill();
    strokeWeight(0.5);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //Head
    fill(c2);
    ellipse(x,y-12*scale,scale*25,scale*25);
    //Headband
    fill(hair);
    arc(x,y-12*scale,scale*25,scale*25,PI*1.08,PI*1.92,CHORD);
    arc(x,y-12*scale,scale*25,scale*25,0,PI,CHORD);
    //ellipse(x,y-14.5*scale,scale*8,scale*8);
    fill(skin);
    arc(x,y-12*scale,scale*25,scale*25,PI*0.1,PI*0.9,CHORD);
    
    //Hands and Feet
    fill(skin);
    ellipse(x-17.2*scale,y+17*scale,5*scale,5*scale);
    ellipse(x+17.2*scale,y+17*scale,5*scale,5*scale);
    ellipse(x-5.5*scale,y+35.4*scale,6*scale,3*scale);
    ellipse(x+5.5*scale,y+35.4*scale,6*scale,3*scale);
    
    //Gi - lower
    fill(c1);
    beginShape();
    vertex(x-8*scale,y+18*scale);
    vertex(x-9.3*scale,y+36*scale);
    bezierVertex(x-9.3*scale,y+36.5*scale, x-2*scale,y+36.5*scale, x-2*scale,y+36*scale);
    vertex(x+0*scale,y+23.5*scale);
    vertex(x+2*scale,y+36*scale);
    bezierVertex(x+2*scale,y+36.5*scale, x+9.3*scale,y+36.5*scale, x+9.3*scale,y+36*scale);
    vertex(x+8*scale,y+18*scale);
    endShape();
    
    //Gi - upper
    rectMode(CORNER);
    fill(c1);
    beginShape();
    vertex(x-9.5*scale,y+22*scale);
    vertex(x-8*scale, y+18*scale);
    vertex(x-8.5*scale, y+6.3*scale);
    vertex(x-12*scale, y+18*scale);
    vertex(x-20*scale, y+16*scale);
    bezierVertex(x-20*scale, y+16*scale, x-16*scale, y+5*scale, x-15*scale, y+5*scale);
    bezierVertex(x-14*scale, y+0*scale, x-9.5*scale, y-0.3*scale, x-9.5*scale, y-0.3*scale);
    bezierVertex(x-9.5*scale, y-0*scale, x+9.5*scale, y-0*scale, x+9.5*scale, y-0.3*scale);
    bezierVertex(x+9.5*scale, y-0.3*scale, x+14*scale, y+0*scale, x+15*scale, y+5*scale);
    bezierVertex(x+16*scale, y+5*scale, x+20*scale, y+16*scale, x+20*scale, y+16*scale);
    vertex(x+12*scale, y+18*scale);
    vertex(x+8.5*scale, y+6.3*scale);
    vertex(x+8*scale, y+18*scale);
    vertex(x+9.5*scale,y+22*scale);
    vertex(x-9.5*scale,y+22*scale);
    endShape();
    fill(c2);
    rect(x-8.1*scale,y+15*scale,16.2*scale,3*scale);
    
    //Ponytail
    fill(hair);
    beginShape();
    vertex(x-2.8*scale,y-14*scale);
    bezierVertex(x-2.8*scale,y-22*scale, x+2.8*scale,y-22*scale, x+2.8*scale,y-14*scale);
    vertex(x+1.7*scale,y-5*scale);
    vertex(x,y+5*scale);
    vertex(x-1.7*scale,y-5*scale);
    vertex(x-2.8*scale,y-14*scale);
    endShape();
  }
  
  void drawBard(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    color hair;
    color skin;
    //if (heroNumber==0)
    //  skin = color(#C68642);
    //else if (heroNumber==1)
    //  skin = color(#F1C27D);
    //else
    //  skin = color(#FFDBAC);
    hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
    
    //Circle
    noFill();
    stroke(255);
    strokeWeight(0.5);
    if (initial)
      ellipse(x, y, 75*scale, 75*scale);
  
    //Lute
    fill(190,170,130);
    beginShape();
    vertex(x+11*scale, y+11*scale);
    vertex(x+25*scale, y-3*scale);
    vertex(x+29*scale, y+1*scale);
    vertex(x+28*scale, y+2.5*scale);
    vertex(x+25.5*scale, y+0.5*scale);
    vertex(x+13*scale, y+14.5*scale);
    endShape();
  
    //Hand
    fill(skin);
    ellipse(x+15*scale, y+9.5*scale, 5*scale, 5*scale);
  
    //Cape
    fill(c1);
    //stroke(0);
    beginShape();
    vertex(x-13.5*scale, y+1*scale);
    bezierVertex(x-14*scale, y+1*scale, x-14*scale, y-3*scale, x-10*scale, y-5*scale);
    bezierVertex(x-10*scale, y-2*scale, x+10*scale, y-2*scale, x+10*scale, y-5*scale);
    bezierVertex(x+10*scale, y-3*scale, x+14*scale, y-3*scale, x+14*scale, y+1*scale);
    //vertex(x+14*scale, y+1*scale);
    bezierVertex(x+13*scale, y+1*scale, x+20*scale, y+30*scale, x+21*scale, y+30*scale);
    bezierVertex(x+15*scale, y+37.5*scale, x-15*scale, y+37.5*scale, x-21*scale, y+30*scale);
    bezierVertex(x-20*scale, y+30*scale, x-12*scale, y+1*scale, x-14*scale, y+1*scale);
    endShape();
    //Flaps
    beginShape();
    vertex(x-9*scale, y+6.5*scale);
    vertex(x-13.5*scale, y+34.75*scale);
    bezierVertex(x-13.5*scale, y+36*scale, x+-4.75*scale, y+37.5*scale, x-4.75*scale, y+35.75*scale);
    vertex(x-3.5*scale, y+5*scale);
    endShape();
    beginShape();
    vertex(x+9*scale, y+6.5*scale);
    vertex(x+13.5*scale, y+34.75*scale);
    bezierVertex(x+13.5*scale, y+36*scale, x+4.75*scale, y+37.5*scale, x+4.75*scale, y+35.75*scale);
    vertex(x+3.5*scale, y+5*scale);
    endShape();
      
    ////Hair - color based on which hero (brown, blonde, black)
    //if(heroNumber==0)
    //  fill(90,70,30);
    //else if(heroNumber==1)
    //  fill(210,190,70);
    //else
    //  fill(10,10,5);
    fill(hair);
    stroke(255);
    strokeWeight(0.5);
    
    //Hair
    ellipse(x,y-12*scale,scale*25,scale*25);
    beginShape();
    vertex(x-11*scale,y-8*scale);
    bezierVertex(x-9*scale,y-8*scale, x-13*scale,y+6*scale, x-13*scale,y+6*scale);
    bezierVertex(x-16*scale,y+12*scale, x+13*scale,y+4*scale, x+13*scale,y+6*scale);
    bezierVertex(x+13*scale,y+6*scale, x+10*scale,y-8*scale, x+12*scale,y-8*scale);
    endShape();
    
    //Hat Band
    fill(c2);
    beginShape();
    vertex(x+14*scale,y-15*scale);
    vertex(x+13*scale,y-9*scale);
    bezierVertex(x+13*scale,y-6*scale, x-13*scale,y-6*scale, x-13*scale,y-9*scale);
    vertex(x-14*scale,y-15*scale);
    endShape();
    
    //Feather
    stroke(c2);
    strokeWeight(scale/2);
    curve(x+16*scale,y-20*scale, x+16*scale,y-20*scale, x+27*scale,y-20*scale, x+27*scale,y-14*scale);
    strokeWeight(scale/4);
    for(float i = 17, j = 2; i < 27.5; i+=0.5, j+=0.1)
      line(x+i*scale, y-(21.2+j/5)*scale, x+(i+0.5)*scale, y-(20-j)*scale);
    
    //Hat
    fill(c1);
    stroke(255);
    strokeWeight(0.5);
    beginShape();
    vertex(x+0*scale,y-9*scale);
    bezierVertex(x+0*scale,y-5*scale, x-22*scale,y-5*scale, x-22*scale,y-10*scale);
    bezierVertex(x-22*scale,y-15*scale, x-1*scale,y-30*scale, x-1*scale,y-25*scale);
    bezierVertex(x-1*scale,y-30*scale, x+16*scale,y-25*scale, x+17*scale,y-21*scale);
    bezierVertex(x+17*scale,y-10*scale, x+0*scale,y-4*scale, x+0*scale,y-9*scale);
    endShape();
  }

  void drawThief(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    //color hair;
    color skin;
    //if(heroNumber==0)
    //  skin = color(#C68642);
    //else if(heroNumber==1)
    //  skin = color(#F1C27D);
    //else
    //  skin = color(#FFDBAC);
    //hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
      
    //Circle
    noFill();
    stroke(255);
    strokeWeight(0.5);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //Knife
    fill(195,200,205);
    push();
    translate(x+16.5*scale,y+8.2*scale);
    rotate(0.5);
    triangle(1*scale,0, -1*scale,0, 0,-8*scale);
    pop();
    
    //Hand
    fill(skin);
    ellipse(x+15*scale,y+9.5*scale,5*scale,5*scale);
    
    //Cape
    fill(c1);
    //stroke(0);
    beginShape();
    vertex(x-14*scale, y+1*scale);
    bezierVertex(x-14*scale,y+1*scale, x-14*scale, y-3*scale, x-10*scale,y-5*scale);
    bezierVertex(x-10*scale,y-2*scale, x+10*scale,y-2*scale, x+10*scale,y-5*scale);
    bezierVertex(x+10*scale,y-3*scale, x+14*scale, y-3*scale, x+14*scale,y+1*scale);
    vertex(x+14*scale, y+1*scale);
    vertex(x+21*scale, y+30*scale);
    bezierVertex(x+15*scale, y+37*scale, x-15*scale, y+37*scale, x-21*scale, y+30*scale);
    vertex(x-14*scale, y+1*scale );
    endShape();
    //Flap
    beginShape();
    vertex(x-6.5*scale,y+10*scale);
    vertex(x-10*scale,y+35*scale);
    bezierVertex(x-10*scale,y+38*scale, x+10*scale,y+38*scale, x+10*scale,y+35*scale);
    vertex(x+6.5*scale,y+10*scale);
    endShape();
    
    //Cowl
    fill(c1);
    beginShape();
    vertex(x-14.5*scale,y-6*scale);
    bezierVertex(x-14.5*scale,y+1*scale, x+13*scale,y+1*scale, x+14.5*scale,y-6*scale);
    bezierVertex(x+14.5*scale,y-3*scale, x+13*scale,y-30*scale, x,y-32*scale);
    bezierVertex(x-13*scale,y-30*scale, x-14.5*scale,y-4*scale, x-14.5*scale,y-6*scale);
    endShape();
    curve(x-4.5*scale,y-55.5*scale, x-4.5*scale,y-21.5*scale, x+4.5*scale,y-21.5*scale, x+4.5*scale,y-55.5*scale);
  }
  
    void drawDruid(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    color skin;
    color hair;
    color pelt;
    //if(heroNumber==0)
    //{
    //  hair = color(90,70,30);
    //  skin = color(#C68642);
    //  pelt = color(150);
    //}
    //else if(heroNumber==1)
    //{
    //  hair = color(210,190,70);
    //  skin = color(#F1C27D);
      pelt = color(#BEAA82);
    //}
    //else
    //{
    //  hair = color(10,10,5);
    //  skin = color(#FFDBAC);
    //  pelt = color(250);
    //}
    hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
      
    stroke(255);
    strokeWeight(0.5);
    //Circle
    noFill();
    strokeWeight(0.5);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //Staff
    push();
    strokeWeight(scale*1.3);
    stroke(110,90,50);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    noFill();
    beginShape();
    vertex(x+9.5*scale,y+35*scale);
    vertex(x+23*scale,y+2*scale);
    bezierVertex(x+20*scale,y-12*scale, x+35*scale,y-0*scale, x+26.5*scale,y-1*scale);
    endShape();
    pop();
    
    //Head
    fill(skin);
    ellipse(x,y-12*scale,scale*25,scale*25);
    fill(hair);
    arc(x,y-12*scale,scale*25,scale*25,PI*0.8,PI*2.2);
    
    //Hands and Feet
    fill(skin);
    ellipse(x-17.2*scale,y+17*scale,5*scale,5*scale);
    ellipse(x+17.2*scale,y+17*scale,5*scale,5*scale);
    ellipse(x-5.5*scale,y+35.4*scale,5*scale,3*scale);
    ellipse(x+5.5*scale,y+35.4*scale,5*scale,3*scale);
    
    //Skirt
    fill(c2);
    beginShape();
    vertex(x-7*scale,y+18*scale);
    vertex(x-10.3*scale,y+35*scale);
    //bezierVertex(x-9.3*scale,y+36.5*scale, x-2*scale,y+36.5*scale, x-2*scale,y+36*scale);
    //vertex(x+0*scale,y+23.5*scale);
    //vertex(x+2*scale,y+36*scale);
    bezierVertex(x-10.3*scale,y+36*scale, x+10.3*scale,y+36*scale, x+10.3*scale,y+35*scale);
    vertex(x+7*scale,y+18*scale);
    endShape();
    
    //Tunic
    rectMode(CORNER);
    fill(c1);
    beginShape();
    vertex(x-8.5*scale,y+22*scale);
    vertex(x-7.9*scale, y+18*scale);
    vertex(x-8.5*scale, y+7.3*scale);
    vertex(x-14*scale, y+18*scale);
    vertex(x-20*scale, y+16*scale);
    vertex(x-14*scale, y+5*scale);
    bezierVertex(x-14*scale, y+5*scale, x-11.5*scale, y-0.3*scale, x-9.5*scale, y-0.3*scale);
    bezierVertex(x-9.5*scale, y-0*scale, x+9.5*scale, y-0*scale, x+9.5*scale, y-0.3*scale);
    bezierVertex(x+11.5*scale, y-0.3*scale, x+14*scale, y+5*scale, x+14*scale, y+5*scale);
    vertex(x+20*scale, y+16*scale);
    vertex(x+14*scale, y+18*scale);
    vertex(x+8.5*scale, y+7.3*scale);
    vertex(x+7.9*scale, y+18*scale);
    vertex(x+9.5*scale,y+25*scale);
    vertex(x-8.5*scale,y+22*scale);
    endShape();
    fill(c2);
    rect(x-8.1*scale,y+16*scale,16.2*scale,2*scale);
    
    //Headdress
    fill(pelt);
    beginShape();
    vertex(x-13*scale,y-13*scale);
    bezierVertex(x-13*scale,y-30*scale, x+13*scale,y-30*scale, x+13*scale,y-13*scale);
    bezierVertex(x+12*scale,y-13*scale, x+3.5*scale,y+7.25*scale, x+5*scale,y+8.25*scale);
    bezierVertex(x+4.5*scale,y+6.25*scale, x-4.5*scale,y+8.25*scale, x-5*scale,y+8.25*scale);
    bezierVertex(x-3.5*scale,y+7.25*scale, x-12*scale,y-13*scale, x-13*scale,y-13*scale);
    endShape();
    //Antlers
    push();
    strokeCap(SQUARE);
    strokeWeight(scale);
    stroke(90,70,30);
    line(x-8.25*scale,y-23.5*scale, x-12.75*scale,y-28*scale);
    line(x-12.75*scale,y-28*scale, x-15*scale,y-33*scale);
    line(x-12.75*scale,y-28*scale, x-23*scale,y-26*scale);
    line(x-18.5*scale,y-26.6*scale, x-24*scale,y-31*scale);
    
    line(x+8.25*scale,y-23.5*scale, x+12.75*scale,y-28*scale);
    line(x+12.75*scale,y-28*scale, x+15*scale,y-33*scale);
    line(x+12.75*scale,y-28*scale, x+23*scale,y-26*scale);
    line(x+18.5*scale,y-26.6*scale, x+24*scale,y-31*scale);
    pop();
    //Ears
    beginShape();
    vertex(x-6*scale,y-24*scale);
    vertex(x-14*scale,y-26*scale);
    bezierVertex(x-13*scale,y-25*scale, x-10*scale,y-19*scale, x-11*scale,y-19*scale);
    endShape();
    beginShape();
    vertex(x+6*scale,y-24*scale);
    vertex(x+14*scale,y-26*scale);
    bezierVertex(x+13*scale,y-25*scale, x+10*scale,y-19*scale, x+11*scale,y-19*scale);
    endShape();
  }
  
  void drawPriest(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    //Staff
    noStroke();
    fill(110,90,50);
    pushMatrix();
    translate(x+17.5*scale, y+6.5*scale);
    rotate(-1.2);
    rectMode(CORNERS);
    rect(-22*scale, -1.5*scale, 22*scale, 1.5*scale);
    popMatrix();
    ellipse(x+25.5*scale,y-14*scale,8*scale, 8*scale);
    
    stroke(255);
    strokeWeight(0.5);
    fill(c2);
    ellipse(x+25.5*scale,y-14*scale,5*scale, 5*scale);
    
    //Circle
    noFill();
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //Hair - color based on which hero (brown, blonde, black)
    //if(heroNumber==0)
    //  fill(90,70,30);
    //else if(heroNumber==1)
    //  fill(210,190,70);
    //else
    //  fill(10,10,5);
    color hair = color(hairTone[h]);
    color skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
    
    fill(hair);
      
    stroke(255);
    strokeWeight(0.5);
    ellipse(x,y-12*scale,scale*25,scale*25);
    
    //Skirt/Robe 
    fill(c1);
    //stroke(0);
    beginShape();
    vertex(x-14*scale, y+1*scale);
    bezierVertex(x-14*scale,y+1*scale, x-14*scale, y-3*scale, x-10*scale,y-3*scale);
    vertex(x+10*scale,y-3*scale);
    bezierVertex(x+10*scale,y-3*scale, x+14*scale, y-3*scale, x+14*scale,y+1*scale);
    vertex(x+14*scale, y+1*scale);
    vertex(x+18*scale, y+33*scale);
    bezierVertex(x+7.5*scale, y+39*scale, x-7.5*scale, y+39*scale, x-18*scale, y+33*scale);
    vertex(x-14*scale, y+1*scale );
    endShape();
    
    //Emblem
    fill(c2);
    noStroke();
    rectMode(CENTER);
    rect(x,y+17*scale,4*scale,40*scale);
    ellipse(x,y+12*scale,scale*12,scale*12);
    fill(c1);
    ellipse(x,y+12*scale,scale*5,scale*5);
    
    //Mitre (outer)
    stroke(255);
    fill(c1);
    beginShape();
    vertex(x-16*scale, y-28*scale);
    vertex(x+16*scale, y-28*scale);
    vertex(x+15*scale, y-13*scale);
    bezierVertex(x+15*scale, y-13*scale, x,y-5*scale ,x-15*scale, y-13*scale);
    vertex(x-16*scale, y-28*scale);
    endShape();
    
    //Mitre (stripe)
    noStroke();
    fill(c2);
    rectMode(CENTER);
    rect(x,y-18*scale,4*scale,17*scale);
    
    //Mitre (inside)
    stroke(255);
    beginShape();
    vertex(x-16*scale,y-28*scale);
    bezierVertex(x-16*scale,y-28*scale, x,y-33*scale, x+16*scale,y-28*scale);
    bezierVertex(x+16*scale,y-28*scale, x,y-23*scale, x-16*scale,y-28*scale);
    endShape();
    
    /*
    //Mullet
    if(heroNumber==0)
      fill(90,70,30);
    else if(heroNumber==1)
      fill(210,190,70);
    else
      fill(10,10,5);
    beginShape();
    vertex(x-12*scale,y-10*scale);
    vertex(x-13*scale,y-2*scale);
    bezierVertex(x-12.5*scale,y-3*scale,  x+12.5*scale,y-3*scale,  x+13*scale,y-2*scale);
    vertex(x+12*scale,y-10*scale);
    endShape();
    */
  }
  
  void drawMage(int x, int y, float scale, color c1, color c2, int h, int s, boolean initial)
  {
    //Staff
    noStroke();
    fill(110,90,50);
    pushMatrix();
    translate(x+17.5*scale, y+6.5*scale);
    rotate(-1.2);
    rectMode(CORNERS);
    rect(-22*scale, -1*scale, 22*scale, 1*scale);
    popMatrix();
  
    stroke(255);
    strokeWeight(0.5);
    fill(c2);
    ellipse(x+25.5*scale,y-14*scale,7.5*scale, 7.5*scale);
    
    //Circle
    fill(c1);
    noFill();
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
  
    //Skirt/Robe 
    fill(c1);
    //stroke(0);
    beginShape();
    vertex(x-9*scale, y+0*scale);
    vertex(x+9*scale, y+0*scale);
    vertex(x+18*scale, y+33*scale);
    bezierVertex(x+7.5*scale, y+39*scale, x-7.5*scale, y+39*scale, x-18*scale, y+33*scale);
    vertex(x-9*scale, y+0*scale );
    endShape();
  
    //Trim
    stroke(c2);
    strokeWeight(3);
    noFill();
    curve(x+30*scale, y-3*scale,x+17*scale, y+31*scale, x-17*scale, y+31*scale, x-30*scale, y-3*scale);

    //Hair - color based on which hero (brown, blonde, black)
    //if(heroNumber==0)
    //  fill(90,70,30);
    //else if(heroNumber==1)
    //  fill(210,190,70);
    //else
    //  fill(10,10,5);
    color hair;
    color skin;
    hair = color(hairTone[h]);
    skin = color(55+0.67*s,30+0.67*s,20+0.63*s);
    
    fill(hair);
    
    stroke(255);
    strokeWeight(0.5);
    beginShape();
    vertex(x-9*scale, y-19*scale);
    bezierVertex(x-17.0*scale, y-16.5*scale, x-16.5*scale, y+6.0*scale, x-22.5*scale, y+12.0*scale);
    bezierVertex(x-4.5*scale, y+4.5*scale, x+4.5*scale, y+14.5*scale, x+22.5*scale, y+11.5*scale);
    bezierVertex(x+16.5*scale, y-4.0*scale, x+19.5*scale, y-16.5*scale, x+10.0*scale, y-21.0*scale);
    endShape();
    
    //Brim
    noStroke();
    stroke(255);
    fill(c1);
    ellipse(x,y-18*scale,45*scale, 12*scale);
    
    //Cone w/ Flap
    //stroke(0);    //375
    beginShape();
    vertex(x-9.5*scale, y-19.5*scale);
    vertex(x+0.0*scale, y-37.5*scale);
    vertex(x+5.5*scale, y-34.5*scale);
    vertex(x+2.5*scale, y-33.5*scale);
    vertex(x+9.5*scale, y-19.5*scale);
    endShape();
  }
  
  void drawIncomplete(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
  {
    //Staff
    //noStroke();
    //fill(110,90,50);
    //pushMatrix();
    //translate(x+17.5*scale, y+6.5*scale);
    //rotate(-1.2);
    //rectMode(CORNERS);
    //rect(-22*scale, -1.5*scale, 22*scale, 1.5*scale);
    //popMatrix();
    //ellipse(x+25.5*scale,y-14*scale,8*scale, 8*scale);
    
    stroke(255);
    strokeWeight(0.5);
    //fill(c2);
    //ellipse(x+25.5*scale,y-14*scale,5*scale, 5*scale);
    
    //Circle
    noFill();
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    //Hair - color based on which hero (brown, blonde, black)
    if(heroNumber==0)
      fill(90,70,30);
    else if(heroNumber==1)
      fill(210,190,70);
    else
      fill(10,10,5);
    stroke(255);
    strokeWeight(0.5);
    ellipse(x,y-12*scale,scale*25,scale*25);
    
    //Skirt/Robe 
    fill(c1);
    //stroke(0);
    beginShape();
    vertex(x-14*scale, y+1*scale);
    bezierVertex(x-14*scale,y+1*scale, x-14*scale, y-3*scale, x-10*scale,y-3*scale);
    vertex(x+10*scale,y-3*scale);
    bezierVertex(x+10*scale,y-3*scale, x+14*scale, y-3*scale, x+14*scale,y+1*scale);
    vertex(x+14*scale, y+1*scale);
    vertex(x+18*scale, y+33*scale);
    bezierVertex(x+7.5*scale, y+39*scale, x-7.5*scale, y+39*scale, x-18*scale, y+33*scale);
    vertex(x-14*scale, y+1*scale );
    endShape();
    
    //Emblem
    //fill(c2);
    //noStroke();
    //rectMode(CENTER);
    //rect(x,y+17*scale,4*scale,40*scale);
    //ellipse(x,y+12*scale,scale*12,scale*12);
    //fill(c1);
    //ellipse(x,y+12*scale,scale*5,scale*5);
    
    //Mitre (outer)
    //stroke(255);
    //fill(c1);
    //beginShape();
    //vertex(x-16*scale, y-28*scale);
    //vertex(x+16*scale, y-28*scale);
    //vertex(x+15*scale, y-13*scale);
    //bezierVertex(x+15*scale, y-13*scale, x,y-5*scale ,x-15*scale, y-13*scale);
    //vertex(x-16*scale, y-28*scale);
    //endShape();
    
    //Mitre (stripe)
    //noStroke();
    //fill(c2);
    //rectMode(CENTER);
    //rect(x,y-18*scale,4*scale,17*scale);
    
    //Mitre (inside)
    //stroke(255);
    //beginShape();
    //vertex(x-16*scale,y-28*scale);
    //bezierVertex(x-16*scale,y-28*scale, x,y-33*scale, x+16*scale,y-28*scale);
    //bezierVertex(x+16*scale,y-28*scale, x,y-23*scale, x-16*scale,y-28*scale);
    //endShape();
  }
  
  void drawHeroByType( Hero h, int x, int y, float scale, boolean circle )
  {
    if( h.getJob() == Job.KNIGHT )
      drawKnight(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.BARBARIAN )
      drawBarbarian(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.SAURIAN )
      drawSaurian(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.KARATE )
      drawKarate(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.BARD )
      drawBard(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.THIEF )
      drawThief(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.DRUID )
      drawDruid(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.PRIEST )
      drawPriest(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
    if( h.getJob() == Job.MAGE )
      drawMage(x,y,scale,h.favColor,h.inverseColor,h.hairColor,h.skinColor,circle);
  }
  
  void drawHeroesInBattle()
  {
    for(int i = 0; i < 3; i++)
    {
      int r=0,g=0,b=0;
      if(party.hero[i].buff[0].active) r = 250; //str
      if(party.hero[i].buff[1].active) b = 250; //dex
      if(party.hero[i].buff[2].active) g = 250; //con
      noStroke();
      fill(r,g,b,5);
      for(int j = 0; j < 15; j++) //Circle for str,dex,con boost
        circle(140+210*i,500,100+7*j);
    }
    if(party.hero[0].isAlive())
      drawHeroByType(party.hero[0],frameWidth/5,500,2,false);
    if(party.hero[1].isAlive())
      drawHeroByType(party.hero[1],frameWidth/2,500,2,false);
    if(party.hero[2].isAlive())
      drawHeroByType(party.hero[2],int(frameWidth*.8),500,2,false);
    
    drawBardNotes();
  }
  
  void drawMonsters( )
  {
    imageMode(CENTER);
    if(battleMonsters[0].alive)
      image(battleMonsters[0].pic,frameWidth/5,275);
    if(battleMonsters[1].alive)
      image(battleMonsters[1].pic,frameWidth/2,275);
    if(battleMonsters[2].alive)
      image(battleMonsters[2].pic,frameWidth*.8,275);
    if( input == Input.BATTLE_SKILL_TARGET || input == Input.BATTLE_ATTACK_TARGET || input == Input.BATTLE_ITEM_TARGET )
    {
      textAlign(CENTER); fill(255);
      if( battleMonsters[0].alive && mouseX > 40+frameX  && mouseX < 240+frameX && mouseY > 180+frameY && mouseY < 380+frameY )
        drawBoxedText( battleMonsters[0].name, frameWidth/5, 200 );
      if( battleMonsters[1].alive && mouseX > 250+frameX && mouseX < 450+frameX && mouseY > 180+frameY && mouseY < 380+frameY )
        drawBoxedText( battleMonsters[1].name, frameWidth/2, 200 );     
      if( battleMonsters[2].alive && mouseX > 460+frameX && mouseX < 660+frameX && mouseY > 180+frameY && mouseY < 380+frameY )
        drawBoxedText( battleMonsters[2].name, frameWidth*.8, 200 );     
    }
  }
  
  void drawBoxedText( String text, float x, int y )
  {
    push();
    fill(0);
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(30);
    stroke(200);
    strokeWeight(5);
    rect( x, y-9, text.length()*15+30, 40, 15 );
    fill(255);
    text( text, x, y );
    pop();
  }
  
  private color handColor( int hero )
  {
    if( party.hero[hero].job == Job.SAURIAN )
      return color(red(party.hero[hero].favColor)/1.5,green(party.hero[hero].favColor)/1.5,blue(party.hero[hero].favColor)/1.5);
      
    return color(55+0.67*party.hero[hero].skinColor,30+0.67*party.hero[hero].skinColor,20+0.63*party.hero[hero].skinColor);
  }
  
  public void drawMouseUXOverlay()
  {
    push();
    imageMode(CENTER);
    if( showUX )
    {
       tint(255,175);
       image(mouseUXImage[0],350,190);
       image(mouseUXImage[1],170,370);
       image(mouseUXImage[2],350,550);
       image(mouseUXImage[3],530,370);
       noTint();
       image(mouseUXImage[5],77.5,230);
       image(mouseUXImage[6],77.5,370);
       image( mouseUXImage[7],77.5,510);
       image(mouseUXImage[4],622.5,510);
       image( mouseUXImage[8],622.5,370);
       push();tint(handColor(handIndex));image( mouseUXImage[10],622.5,230);pop();
    }
    else
      switch( mouseInZone() )
      {
        //Move
        case 2: image(mouseUXImage[0],350,190); break;
        case 3: image(mouseUXImage[1],170,370); break;
        case 4: image(mouseUXImage[2],350,550); break;
        case 5: image(mouseUXImage[3],530,370); break;
        //Food
        case 6: image(mouseUXImage[5],77.5,230); break;
        //Potion
        case 7: image(mouseUXImage[6],77.5,370); break;
        //Key
        case 8: image( mouseUXImage[7],77.5,510); break;
        //Use
        case 10:
          push(); tint(handColor(handIndex));
          image( mouseUXImage[10],622.5,230); pop(); break;
        //Door/entrance
        case 9: image( mouseUXImage[8],622.5,370); break;
        //UI On/Off
        case 1: image(mouseUXImage[4],622.5,510); break;
      }
    pop();
  }
  

}

//********************************************************//
//Controls animations for battle effects
class Animation
{
  int index;
  int target; // 0-hero1  1-hero2  2-hero3  3-enemy1  4-enemy2  5-enemy3  6-allHeroes 7-allEnemies
  int user;   // same as target
  int stage;  //ends after stage 3 - stage > 3 will not display and will trigger cleanup
  int endStage; //for non-standard animations that break above rule
  int timer;  //for each stage
  int speed = 100;  //for animations that play at different speeds
  int frames = 3;   //3 for most standard animations
  
  float xPos, yPos;
  
  HeroSkill skill = HeroSkill.NONE;
  
  public Animation( int type, int u, int tar )
  {
    user = u;
    index = findIndexByType( type );
    adjustSpeed( type );
    target = tar;
    adjustPositions( target );
    stage = -1;  //start blank
    endStage = 3; //standard
    timer = millis() + int(battleTextSpeed*1000) - (speed*endStage); //three frames before damage appears
  }
  
  public Animation( int type, int u, int tar, float delay ) //For different battleTextSpeeds (primarily for block)
  {
    this(type, u, tar);
    timer = millis() + int(delay*1000) - (speed*endStage);
  }
  
  public Animation( int j, int s, int u, int t )
  {
    this( 0, u, t );
    skill = skillArray[j*8+s];
    adjust(skill);
  }
  
  private void adjustPositions(int t)
  {
    if( t % 3 == 0 ) xPos = frameWidth/5;
    else if(t%3==1 ) xPos = frameWidth/2;
    else             xPos = frameWidth*0.8;
    
    if( t < 3 ) yPos = 500;
    else        yPos = 275;
  }
  
  //For non-standard animations
  private void adjust( HeroSkill s )
  {
    switch(s)
    {
      case BR_2: //cleave
        endStage = 6;
        speed = 75;
        break;
      case BR_3: //blood rage
        target = user;
        adjustPositions(target);
        break;
      case MA_1: //stone ist
        endStage = 4;
        break;
      case MA_2: //flash punch
        endStage = 2;
        speed = 50;
        vanGogh.fastAnimation = true;
        //println("DELAY: " + battle.battleDelayCounter);
        //battle.battleDelayCounter -= battleTextSpeed/2;
        //battle.setBattleDelay( battleTextSpeed/2 );
        timer = millis() + int(battleTextSpeed/2*1000) - (speed*endStage);
        return;
      case MA_3: //hurricane kick
        endStage = 8;
        speed = 100;
        break;
      case TH_1: //knives
        endStage = 10;
        break;
      case TH_2: //toxin
        endStage = 7;
        break;
      case TH_3: //razor
        endStage = 5;
        speed = 200;
        break;
      case PR_1: //light
        endStage = 4;
        break;
      case PR_2: //comfort
        endStage = 6;
        break;
      case PR_3: //bless
        endStage = 4;
        break;
    }
    
    timer = millis() + int(battleTextSpeed*1000) - (speed*endStage);
  }
  
  private void adjustSpeed(int t) //Should always end at the same time
  {
    switch(t)
    {
      case 1:  speed = 50;   break;//block
      case 10: speed = 150; break;//bite
    }
  }
  
  public void run()
  {
    //No image
    if( index < -1 || stage == endStage )
    {
      stage = endStage; //Ready to end
      return;
    }
    
    //Run active animation
    if( stage >= 0 )
    {
      if( skill == HeroSkill.NONE )
      {
        image( effectImage[index+stage], xPos, yPos );
      }
      else
      {
        switch( skill ) //Hope there's a cleaner way to do this
        {
          //KNIGHT
          case KN_1:  //Shield Bash
            if( stage == 0 || stage == 1 )
            {
              //tint(party.hero[battle.turn].favColor);     image( iconImage[3], xPos, yPos+(25-25*stage), 150-(stage*50), 150-(stage*50) );
              //tint(party.hero[battle.turn].inverseColor); image( iconImage[4], xPos, yPos+(25-25*stage), 150-(stage*50), 150-(stage*50) );
              noTint(); image( effectImage[57], xPos, yPos+(25-25*stage), 150-(stage*50), 150-(stage*50) );
            }
            else
              image( effectImage[12], xPos, yPos );
            break;
          case KN_2:  //Armor Break
            if( stage == 0 ) image( effectImage[34], xPos, yPos );
            if( stage == 1 ) image( effectImage[35], xPos, yPos );
            if( stage == 2 ) image( effectImage[36], xPos, yPos );
            break;
          case KN_3:  //Divine Grace
            if( stage == 0 ) image( effectImage[37], frameWidth/2, 500 );
            if( stage == 1 ) image( effectImage[38], frameWidth/2, 500 );
            if( stage == 2 ) image( effectImage[39], frameWidth/2, 500 );
            break;
          case KN_4:  //
            break;
          case KN_5:  //
            break;
          case KN_6:  //
            break;
          case KN_7:  //
            break;
          case KN_8:  //
            break;
            
          //BARBARIAN
          case BR_1:  //BLOOD STRIKE
            image( effectImage[78+stage], xPos, yPos );
            break;
          case BR_2:  //CLEAVE
            image( effectImage[81+stage], frameWidth/2, 275 );
            break;
          case BR_3:  //RAGE
            image( effectImage[87+stage], xPos, yPos );
            break;
          case BR_4:  //
            break;
          case BR_5:  //
            break;
          case BR_6:  //
            break;
          case BR_7:  //
            break;
          case BR_8:  //
            break;
            
          //SAURIAN
          case SR_1:  //REND
            image( effectImage[98+stage], xPos, yPos );
            break;
          case SR_2:  //PREY
            image( effectImage[101+stage], xPos, yPos );
            break;
          case SR_3:  //
            break;
          case SR_4:  //
            break;
          case SR_5:  //
            break;
          case SR_6:  //
            break;
          case SR_7:  //
            break;
          case SR_8:  //
            break;
            
          //MARTIAL ARTIST
          case MA_1:  //STONE FIST
            if( stage == 0 ) image( effectImage[10], xPos, yPos );
            if( stage == 1 ) image( effectImage[11], xPos, yPos );
            if( stage == 2 ) image( effectImage[90], xPos, yPos );
            if( stage == 3 ) image( effectImage[91], xPos, yPos );
            break;
          case MA_2:  //FLASH PUNCH
            image( effectImage[92+stage], xPos, yPos );
            break;
          case MA_3:  //HURRICANE KICK
            image( effectImage[94+stage%3], frameWidth/2, 275 );
            //image( effectImage[97],         frameWidth/2 + (stage*stage*5*(pow(-1,stage))), 275 );
            image( effectImage[97],         frameWidth/4 + ((stage-1)*frameWidth*(3.0/4/8)), 275 );
            break;
          case MA_4:  //
            break;
          case MA_5:  //
            break;
          case MA_6:  //
            break;
          case MA_7:  //
            break;
          case MA_8:  //
            break;
            
          //BARD
          case BD_1:  //
            break;
          case BD_2:  //
            break;
          case BD_3:  //
            break;
          case BD_4:  //
            break;
          case BD_5:  //
            break;
          case BD_6:  //
            break;
          case BD_7:  //
            break;
          case BD_8:  //
            break;
            
          //THIEF
          case TH_1:  //KNIVES
            image( effectImage[40+stage], frameWidth/2, 275 );
            break;
          case TH_2:  //TOXIN
            image( effectImage[50+stage], xPos, yPos );
            break;
          case TH_3:  //RAZOR
            image( effectImage[58+stage], xPos, yPos );
            break;
          case TH_4:  //
            break;
          case TH_5:  //
            break;
          case TH_6:  //
            break;
          case TH_7:  //
            break;
          case TH_8:  //
            break;
            
          //DRUID
          case DR_1:  //
            break;
          case DR_2:  //
            break;
          case DR_3:  //
            break;
          case DR_4:  //
            break;
          case DR_5:  //
            break;
          case DR_6:  //
            break;
          case DR_7:  //
            break;
          case DR_8:  //
            break;
            
          //MAGE
          case MG_1:  //
            break;
          case MG_2:  //
            break;
          case MG_3:  //
            break;
          case MG_4:  //
            break;
          case MG_5:  //
            break;
          case MG_6:  //
            break;
          case MG_7:  //
            break;
          case MG_8:  //
            break;
            
          //PRIEST
          case PR_1:  //DIVINE LIGHT
            image( effectImage[64+stage], xPos, yPos );
            break;
          case PR_2:  //DIVINE COMFORT
            image( effectImage[68+stage], xPos, yPos );
            break;
          case PR_3:  //BLESSING
            image( effectImage[74+stage], frameWidth/2, 500 );
            break;
          case PR_4:  //
            break;
          case PR_5:  //
            break;
          case PR_6:  //
            break;
          case PR_7:  //
            break;
          case PR_8:  //
            break;
        }
      }
    }
      
    if( millis() > timer )
    {
      timer += speed;
      stage++;
    }
  }
  
  private int findIndexByType( int i )
  {
    switch( i )
    {
      case 0: return 1;   //test circle animation
      case 1: return 4;   //block animation
      case 2: return 7;   //slash animation
      case 3: return 10;  //punch animation
      case 4: return 13;  //heal animation
      case 5: return 16;  //fire bomb animation
      case 6: return 19;  //ice bomb animation
      case 7: return 22;  //acid bomb animation
      case 8: return 25;  //thunder bomb animation
      case 9: return 28;  //pierce animation
      case 10: return 31; //bite animation
      default: return -1; //not in list
    }
  }
}

public enum HeroSkill
{
  KN_1, KN_2, KN_3, KN_4, KN_5, KN_6, KN_7, KN_8,
  BR_1, BR_2, BR_3, BR_4, BR_5, BR_6, BR_7, BR_8,
  SR_1, SR_2, SR_3, SR_4, SR_5, SR_6, SR_7, SR_8,
  MA_1, MA_2, MA_3, MA_4, MA_5, MA_6, MA_7, MA_8,
  BD_1, BD_2, BD_3, BD_4, BD_5, BD_6, BD_7, BD_8,
  TH_1, TH_2, TH_3, TH_4, TH_5, TH_6, TH_7, TH_8,
  DR_1, DR_2, DR_3, DR_4, DR_5, DR_6, DR_7, DR_8,
  MG_1, MG_2, MG_3, MG_4, MG_5, MG_6, MG_7, MG_8,
  PR_1, PR_2, PR_3, PR_4, PR_5, PR_6, PR_7, PR_8,
  
  NONE
}

HeroSkill skillArray[] =
{ HeroSkill.KN_1, HeroSkill.KN_2, HeroSkill.KN_3, HeroSkill.KN_4, HeroSkill.KN_5, HeroSkill.KN_6, HeroSkill.KN_7, HeroSkill.KN_8,
  HeroSkill.BR_1, HeroSkill.BR_2, HeroSkill.BR_3, HeroSkill.BR_4, HeroSkill.BR_5, HeroSkill.BR_6, HeroSkill.BR_7, HeroSkill.BR_8,
  HeroSkill.SR_1, HeroSkill.SR_2, HeroSkill.SR_3, HeroSkill.SR_4, HeroSkill.SR_5, HeroSkill.SR_6, HeroSkill.SR_7, HeroSkill.SR_8,
  HeroSkill.MA_1, HeroSkill.MA_2, HeroSkill.MA_3, HeroSkill.MA_4, HeroSkill.MA_5, HeroSkill.MA_6, HeroSkill.MA_7, HeroSkill.MA_8,
  HeroSkill.BD_1, HeroSkill.BD_2, HeroSkill.BD_3, HeroSkill.BD_4, HeroSkill.BD_5, HeroSkill.BD_6, HeroSkill.BD_7, HeroSkill.BD_8,
  HeroSkill.TH_1, HeroSkill.TH_2, HeroSkill.TH_3, HeroSkill.TH_4, HeroSkill.TH_5, HeroSkill.TH_6, HeroSkill.TH_7, HeroSkill.TH_8,
  HeroSkill.DR_1, HeroSkill.DR_2, HeroSkill.DR_3, HeroSkill.DR_4, HeroSkill.DR_5, HeroSkill.DR_6, HeroSkill.DR_7, HeroSkill.DR_8,
  HeroSkill.MG_1, HeroSkill.MG_2, HeroSkill.MG_3, HeroSkill.MG_4, HeroSkill.MG_5, HeroSkill.MG_6, HeroSkill.MG_7, HeroSkill.MG_8,
  HeroSkill.PR_1, HeroSkill.PR_2, HeroSkill.PR_3, HeroSkill.PR_4, HeroSkill.PR_5, HeroSkill.PR_6, HeroSkill.PR_7, HeroSkill.PR_8 };

//********************************************************//
void loadImages()
{
  tileImage[0] = loadImage("wall.png"); tileImage[0].resize(30,0);
  tileImage[1] = loadImage("tree.png"); tileImage[1].resize(40,40);
  tileImage[2] = loadImage("darkTree.png"); tileImage[2].resize(40,40);
  tileImage[3] = loadImage("flower.png"); tileImage[3].resize(30,0);
  for(int i = 1; i <= 16; i++)
  { tileImage[3+i] = loadImage("water"+i+".png"); tileImage[3+i].resize(30,0); }
  for(int i = 1; i <= 8; i++)
  { tileImage[19+i] = loadImage("save"+i+".png"); tileImage[19+i].resize(40,0); }
  tileImage[28] = loadImage("barrel.png"); tileImage[28].resize(30,0);
  tileImage[29] = loadImage("barrelEmpty.png"); tileImage[29].resize(30,0);
  tileImage[30] = loadImage("chest.png"); tileImage[30].resize(30,0);
  tileImage[31] = loadImage("chestBone.png"); tileImage[31].resize(30,0);
  tileImage[32] = loadImage("chestDark.png"); tileImage[32].resize(30,0);
  tileImage[33] = loadImage("chestGold.png"); tileImage[33].resize(30,0);
  tileImage[34] = loadImage("chestSilver.png"); tileImage[34].resize(30,0);
  tileImage[35] = loadImage("chestSnow.png"); tileImage[35].resize(30,0);
  tileImage[36] = loadImage("sign.png"); tileImage[36].resize(30,0);
  tileImage[37] = loadImage("signUsed.png"); tileImage[37].resize(30,0);
  tileImage[38] = loadImage("door.png"); tileImage[38].resize(30,0);
  tileImage[39] = loadImage("doorDouble.png"); tileImage[39].resize(30,0);
  tileImage[40] = loadImage("portcullis.png"); tileImage[40].resize(30,0);
  tileImage[41] = loadImage("gateCemetery.png"); tileImage[41].resize(30,0);
  tileImage[42] = loadImage("grave.png"); tileImage[42].resize(30,0);
  tileImage[43] = loadImage("stainedGlass.png"); tileImage[43].resize(30,0);
  tileImage[44] = loadImage("treeDead.png"); tileImage[44].resize(45,40);
  tileImage[45] = loadImage("wallDark.png"); tileImage[45].resize(30,0);
  tileImage[46] = loadImage("wallSand.png"); tileImage[46].resize(30,0);
  tileImage[47] = loadImage("treePath.png"); tileImage[47].resize(40,40);
  tileImage[48] = loadImage("merchant.png"); tileImage[48].resize(30,0);
  tileImage[49] = loadImage("wallDark.png"); tileImage[49].resize(30,0);
  tileImage[50] = loadImage("wallSand.png"); tileImage[50].resize(30,0);
  tileImage[51] = loadImage("StoneGargoyle.png"); tileImage[51].resize(30,0);
  tileImage[52] = loadImage("BlackGargoyle.png"); tileImage[52].resize(30,0);
  tileImage[53] = loadImage("JadeGargoyle.png"); tileImage[53].resize(30,0);
  tileImage[54] = loadImage("portcullis.png"); tileImage[54].resize(30,0);
  tileImage[55] = loadImage("tent.png"); tileImage[55].resize(30,0);
  tileImage[56] = loadImage("stairs.png"); tileImage[56].resize(30,0);
  tileImage[57] = loadImage("wood.png"); tileImage[57].resize(30,0);
  tileImage[58] = loadImage("woodDark.png"); tileImage[58].resize(30,0);
  tileImage[59] = loadImage("woodLight.png"); tileImage[59].resize(30,0);
  tileImage[60] = loadImage("WhiteWerewolf.png"); tileImage[60].resize(30,0);
  tileImage[61] = loadImage("chestGold.png"); tileImage[61].resize(30,0);
  tileImage[62] = loadImage("chestDark.png"); tileImage[62].resize(30,0);
  tileImage[63] = loadImage("SignEquipment.png"); tileImage[63].resize(30,0);
  tileImage[64] = loadImage("SignFood.png"); tileImage[64].resize(30,0);
  tileImage[65] = loadImage("SignPotion.png"); tileImage[65].resize(30,0);
  tileImage[66] = loadImage("SignInn.png"); tileImage[66].resize(30,0);
  tileImage[67] = loadImage("rubble.png"); tileImage[67].resize(30,0);
  tileImage[68] = loadImage("Sack.png"); tileImage[68].resize(50,0);
  tileImage[69] = loadImage("caveBrown3.png"); tileImage[69].resize(30,0);
  tileImage[70] = loadImage("cave3.png"); tileImage[70].resize(30,0);
  //tileImage[70] = loadImage("caveYellow.png"); tileImage[70].resize(30,0);
  tileImage[71] = loadImage("treeDead4.png"); tileImage[71].resize(45,40);
  tileImage[72] = loadImage("TileRoof3.png"); tileImage[72].resize(30,34);
  tileImage[73] = loadImage("crops.png"); tileImage[73].resize(30,30);
  tileImage[74] = loadImage("TileRoofBlue.png"); tileImage[74].resize(30,34);
  tileImage[75] = loadImage("bookshelf2.png"); tileImage[75].resize(30,30);
  tileImage[76] = loadImage("bookshelfEmpty.png"); tileImage[76].resize(30,30);
  tileImage[77] = loadImage("bed2.png"); tileImage[77].resize(30,30);
  tileImage[78] = loadImage("blackBook.png"); tileImage[78].resize(20,0);
  tileImage[79] = loadImage("chestBone.png"); tileImage[79].resize(30,0);
  tileImage[80] = loadImage("blueBook.png"); tileImage[80].resize(20,0);
  tileImage[81] = loadImage("brokenGlass.png"); tileImage[81].resize(90,0);
  tileImage[82] = loadImage("Bread.png"); tileImage[82].resize(30,0);
  tileImage[83] = loadImage("Meat.png"); tileImage[83].resize(30,0);
  tileImage[84] = loadImage("Fruit.png"); tileImage[84].resize(30,0);
  tileImage[85] = loadImage("Crab.png"); tileImage[85].resize(30,0);
  tileImage[86] = loadImage("wallDarkCracked.png"); tileImage[86].resize(30,0);
  tileImage[87] = loadImage("stairsWood.png");   tileImage[87].resize(30,0);
  tileImage[88] = loadImage("crate2.png");       tileImage[88].resize(30,0);
  tileImage[89] = loadImage("crate.png");        tileImage[89].resize(30,0);
  tileImage[90] = loadImage("potionGreen.png");  tileImage[90].resize(56,0);
  tileImage[91] = loadImage("potionBlue.png");   tileImage[91].resize(56,0);
  tileImage[92] = loadImage("potionYellow.png"); tileImage[92].resize(56,0);
  tileImage[93] = loadImage("potionRed.png");    tileImage[93].resize(56,0);
  tileImage[94] = loadImage("chain.png");        tileImage[94].resize(0,30);
  tileImage[95] = loadImage("fatRat.png");       tileImage[95].resize(0,30);
  tileImage[96] = loadImage("chain_hole.png");   tileImage[96].resize(0,30);
  tileImage[97] = loadImage("caveYellow.png");   tileImage[97].resize(0,30);
  tileImage[98] = loadImage("mountain2.png");    tileImage[98].resize(40,40);
  tileImage[99] = loadImage("mountainCave.png"); tileImage[99].resize(40,40);
  tileImage[100]= loadImage("tile3.png");        tileImage[100].resize(30,0);
  tileImage[101]= loadImage("fenceC.png");       tileImage[101].resize(30,0);
  tileImage[102]= loadImage("fenceH.png");       tileImage[102].resize(30,0);
  tileImage[103]= loadImage("fenceV.png");       tileImage[103].resize(30,0);
  tileImage[104]= loadImage("fenceC2.png");      tileImage[104].resize(30,0);
  tileImage[105]= loadImage("flowerBlue.png");   tileImage[105].resize(30,0);
  tileImage[106]= loadImage("curtain.png");      tileImage[106].resize(30,0);
  tileImage[107]= loadImage("gameBoard.png");    tileImage[107].resize(30,0);
  tileImage[108]= loadImage("curtainHalf.png");  tileImage[108].resize(30,0);
  tileImage[109]= loadImage("stoneSlab.png");    tileImage[109].resize(30,0);
  tileImage[110]= loadImage("curtainRed.png");   tileImage[110].resize(30,0);
  tileImage[111]= loadImage("curtainHalfRed.png");tileImage[111].resize(30,0);
  tileImage[112]= loadImage("barrelHoney.png");  tileImage[112].resize(30,0);
  tileImage[113]= loadImage("caveDoor.png");     tileImage[113].resize(30,0);
  tileImage[114]= loadImage("caveHole.png");     tileImage[114].resize(30,0);
  tileImage[115]= loadImage("doorFrame.png");    tileImage[115].resize(30,0);
  tileImage[116]= loadImage("gateFrame.png");    tileImage[116].resize(30,0);
  tileImage[117]= loadImage("combHalf.png");     tileImage[117].resize(30,0);
  tileImage[118]= loadImage("combFull.png");     tileImage[118].resize(30,0);
  tileImage[119]= loadImage("caveOverlay.png");  tileImage[119].resize(30,0);
  tileImage[120]= loadImage("caveBrownOverlay.png");tileImage[120].resize(30,0);
  tileImage[121]= loadImage("chestGoopy.png");   tileImage[121].resize(30,0);
  tileImage[122]= loadImage("woodCracked.png");  tileImage[122].resize(30,0);
  tileImage[123]= loadImage("wallCracked.png");  tileImage[123].resize(30,0);
  tileImage[124]= loadImage("tent_outer.png");   tileImage[124].resize(30,0);
  tileImage[125]= loadImage("stalagmite.png");   tileImage[125].resize(40,0);
  tileImage[126]= loadImage("stalagmite2.png");  tileImage[126].resize(40,0);
  tileImage[127]= loadImage("fireBomb.png");     tileImage[127].resize(45,0);
  tileImage[128]= loadImage("reagents.png");     tileImage[128].resize(56,0);
  tileImage[129]= loadImage("iceBomb.png");      tileImage[129].resize(45,0);
  tileImage[130]= loadImage("acidBomb.png");     tileImage[130].resize(45,0);
  tileImage[131]= loadImage("thunderBomb3.png"); tileImage[131].resize(45,0);
  tileImage[132]= loadImage("potionOrange.png"); tileImage[132].resize(56,0);
  tileImage[133]= loadImage("potionPurple.png"); tileImage[133].resize(56,0);
  
  iconImage[0] = loadImage("buckler_main.png");     iconImage[0].resize(56,0);
  iconImage[1] = loadImage("buckler_color.png");    iconImage[1].resize(58,0);
  iconImage[2] = loadImage("heater_main2.png");     iconImage[2].resize(56,0);
  iconImage[3] = loadImage("heater_primary.png");   iconImage[3].resize(58,0);
  iconImage[4] = loadImage("heater_secondary.png"); iconImage[4].resize(58,0);
  iconImage[5] = loadImage("scale_primary.png");    iconImage[5].resize(56,0);
  iconImage[6] = loadImage("scale_secondary.png");  iconImage[6].resize(56,0);
  iconImage[7] = loadImage("fist_hue_light.png");   iconImage[7].resize(56,0);
  
  mouseUXImage[0] = loadImage("moveU.png");       mouseUXImage[0].resize(150,0);
  mouseUXImage[1] = loadImage("moveL.png");       mouseUXImage[1].resize(150,0);
  mouseUXImage[2] = loadImage("moveD.png");       mouseUXImage[2].resize(150,0);
  mouseUXImage[3] = loadImage("moveR.png");       mouseUXImage[3].resize(150,0);
  mouseUXImage[4] = loadImage("lookEye.png");     mouseUXImage[4].resize(100,0);
  mouseUXImage[5] = loadImage("Bread.png");       mouseUXImage[5].resize(100,0);
  mouseUXImage[6] = loadImage("potionGreen.png"); mouseUXImage[6].resize(100,0);
  mouseUXImage[7] = loadImage("key.png");         mouseUXImage[7].resize(100,0);
  mouseUXImage[8] = loadImage("enter.png");       mouseUXImage[8].resize(100,0);
  mouseUXImage[9] = loadImage("greenArrow.png");  mouseUXImage[9].resize(80,0);
  mouseUXImage[10] = loadImage("handIcon.png");   mouseUXImage[10].resize(100,0);
  
  //670x180
  battleBack[0] = loadImage("forest5.png"); //resize?esize(56,0);
  battleBack[1] = loadImage("stoneWall.png"); //resize?
  battleBack[2] = loadImage("graveyard4.png"); //resize?
  battleBack[3] = loadImage("cave.png"); //resize?
  battleBack[4] = loadImage("woodWall.png");
  battleBack[5] = loadImage("beeCave2.png"); battleBack[5].resize(670,0);
  battleBack[6] = loadImage("testBack2.png");
  battleBack[7] = loadImage("stoneWallWindow.png");battleBack[7].resize(670,0);
  battleBack[8] = loadImage("waterCave9.png");     battleBack[8].resize(670,0);
  
  effectImage[0] = loadImage("bardBonus.png");  effectImage[0].resize(30,0);
  
  border = loadImage("stoneBorder.png");            border.resize(750,750);
  
  //TEST - TYPE: 0
  effectImage[1] = loadImage("testRing1.png");  effectImage[1].resize(200,0);
  effectImage[2] = loadImage("testRing2.png");  effectImage[2].resize(200,0);
  effectImage[3] = loadImage("testRing3.png");  effectImage[3].resize(200,0);
  //BLOCK - TYPE: 1
  effectImage[4] = loadImage("shield1.png");    effectImage[4].resize(200,0);
  effectImage[5] = loadImage("shield2.png");    effectImage[5].resize(200,0);
  effectImage[6] = loadImage("shield2.png");    effectImage[6].resize(200,0);
  //SLASH - TYPE: 2
  effectImage[7] = loadImage("slash1.png");     effectImage[7].resize(200,0);
  effectImage[8] = loadImage("slash2.png");     effectImage[8].resize(200,0);
  effectImage[9] = loadImage("slash3.png");     effectImage[9].resize(200,0);
  //PUNCH - TYPE: 3
  effectImage[10] = loadImage("punch1.png");    effectImage[10].resize(200,0);
  effectImage[11] = loadImage("punch2.png");    effectImage[11].resize(200,0);
  effectImage[12] = loadImage("punch3.png");    effectImage[12].resize(200,0);
  //HEAL - TYPE: 4
  effectImage[13] = loadImage("heal1.png");     effectImage[13].resize(200,0);
  effectImage[14] = loadImage("heal2.png");     effectImage[14].resize(200,0);
  effectImage[15] = loadImage("heal3.png");     effectImage[15].resize(200,0);
  //FIRE BOMB - TYPE: 5
  effectImage[16] = loadImage("fireBomb1.png");    effectImage[16].resize(125,0);
  effectImage[17] = loadImage("fireBomb2.png");    effectImage[17].resize(135,0);
  effectImage[18] = loadImage("fireBomb3.png");    effectImage[18].resize(145,0);
  //FIRE BOMB - TYPE: 6
  effectImage[19] = loadImage("iceBomb1.png");    effectImage[19].resize(125,0);
  effectImage[20] = loadImage("iceBomb2.png");    effectImage[20].resize(135,0);
  effectImage[21] = loadImage("iceBomb3.png");    effectImage[21].resize(145,0);
  //ACID BOMB - TYPE: 7
  effectImage[22] = loadImage("acidBomb1.png");    effectImage[22].resize(125,0);
  effectImage[23] = loadImage("acidBomb2.png");    effectImage[23].resize(160,0);
  effectImage[24] = loadImage("acidBomb3.png");    effectImage[24].resize(150,0);
  //THUNDER BOMB - TYPE: 8
  //effectImage[25] = loadImage("thunderBomb1.png");    effectImage[25].resize(125,0);
  //effectImage[26] = loadImage("thunderBomb2.png");    effectImage[26].resize(160,0);
  //effectImage[27] = loadImage("thunderBomb3.png");    effectImage[27].resize(150,0);
  //PIERCE - TYPE: 9
  effectImage[28] = loadImage("pierce1.png");    effectImage[28].resize(200,0);
  effectImage[29] = loadImage("pierce2.png");    effectImage[29].resize(200,0);
  effectImage[30] = loadImage("pierce3.png");    effectImage[30].resize(200,0);
  //BITE - TYPE: 10
  effectImage[31] = loadImage("bite1.png");    effectImage[31].resize(170,0);
  effectImage[32] = loadImage("bite2.png");    effectImage[32].resize(200,0);
  effectImage[33] = loadImage("bite3.png");    effectImage[33].resize(190,0);
  //ARMOR BREAK - TYPE: 11
  effectImage[34] = loadImage("split1.png");    effectImage[34].resize(200,0);
  effectImage[35] = loadImage("split2.png");    effectImage[35].resize(200,0);
  effectImage[36] = loadImage("split3.png");    effectImage[36].resize(200,0);
  //DIVINE GRACE - TYPE: 12
  effectImage[37] = loadImage("grace1.png");    effectImage[37].resize(0,200);
  effectImage[38] = loadImage("grace2.png");    effectImage[38].resize(0,200);
  effectImage[39] = loadImage("grace3.png");    effectImage[39].resize(0,200);
  //KNIVES - TYPE: 13
  effectImage[40] = loadImage("knife1.png");    effectImage[40].resize(0,200);
  effectImage[41] = loadImage("knife2.png");    effectImage[41].resize(0,200);
  effectImage[42] = loadImage("knife3.png");    effectImage[42].resize(0,200);
  effectImage[43] = loadImage("knife4.png");    effectImage[43].resize(0,200);
  effectImage[44] = loadImage("knife5.png");    effectImage[44].resize(0,200);
  effectImage[45] = loadImage("knife6.png");    effectImage[45].resize(0,200);
  effectImage[46] = loadImage("knife7.png");    effectImage[46].resize(0,200);
  effectImage[47] = loadImage("knife8.png");    effectImage[47].resize(0,200);
  effectImage[48] = loadImage("knife9.png");    effectImage[48].resize(0,200);
  effectImage[49] = loadImage("knife10.png");   effectImage[49].resize(0,200);
  //TOXIN - TYPE: 14
  effectImage[50] = loadImage("toxin1.png");    effectImage[50].resize(0,120);
  effectImage[51] = loadImage("toxin2.png");    effectImage[51].resize(0,120);
  effectImage[52] = loadImage("toxin3.png");    effectImage[52].resize(0,120);
  effectImage[53] = loadImage("toxin4.png");    effectImage[53].resize(0,120);
  effectImage[54] = loadImage("toxin5.png");    effectImage[54].resize(0,120);
  effectImage[55] = loadImage("toxin6.png");    effectImage[55].resize(0,130);
  effectImage[56] = loadImage("toxin7.png");    effectImage[56].resize(0,140);
  //SHIELD BASH
  effectImage[57] = loadImage("shieldBack.png");effectImage[57].resize(0,200);
  //RAZOR
  effectImage[58] = loadImage("razor1.png");    effectImage[58].resize(0,160);
  effectImage[59] = loadImage("razor2.png");    effectImage[59].resize(0,160);
  effectImage[60] = loadImage("razor3.png");    effectImage[60].resize(0,160);
  effectImage[61] = loadImage("razor4.png");    effectImage[61].resize(0,160);
  effectImage[62] = loadImage("razor5.png");    effectImage[62].resize(0,160);
  effectImage[63] = loadImage("razor6.png");    effectImage[63].resize(0,160);
  //DIVINE LIGHT
  effectImage[64] = loadImage("light1.png");    effectImage[64].resize(0,180);
  effectImage[65] = loadImage("light2.png");    effectImage[65].resize(0,180);
  effectImage[66] = loadImage("light3.png");    effectImage[66].resize(0,180);
  effectImage[67] = loadImage("light4.png");    effectImage[67].resize(0,180);
  //DIVINE COMFORT
  effectImage[68] = loadImage("comfort1.png");  effectImage[68].resize(0,160);
  effectImage[69] = loadImage("comfort2.png");  effectImage[69].resize(0,160);
  effectImage[70] = loadImage("comfort3.png");  effectImage[70].resize(0,160);
  effectImage[71] = loadImage("comfort4.png");  effectImage[71].resize(0,160);
  effectImage[72] = loadImage("comfort5.png");  effectImage[72].resize(0,160);
  effectImage[73] = loadImage("comfort6.png");  effectImage[73].resize(0,160);
  //BLESSING
  effectImage[74] = loadImage("bless1.png");    effectImage[74].resize(0,180);
  effectImage[75] = loadImage("bless2.png");    effectImage[75].resize(0,180);
  effectImage[76] = loadImage("bless3.png");    effectImage[76].resize(0,180);
  effectImage[77] = loadImage("bless4.png");    effectImage[77].resize(0,180);
  //BLOOD STRIKE
  effectImage[78] = loadImage("strike1.png");  effectImage[78].resize(0,200);
  effectImage[79] = loadImage("strike2.png");  effectImage[79].resize(0,200);
  effectImage[80] = loadImage("strike3.png");  effectImage[80].resize(0,200);
  //CLEAVE
  effectImage[81] = loadImage("cleave1.png");    effectImage[81].resize(frameWidth,0);
  effectImage[82] = loadImage("cleave2.png");    effectImage[82].resize(frameWidth,0);
  effectImage[83] = loadImage("cleave3.png");    effectImage[83].resize(frameWidth,0);
  effectImage[84] = loadImage("cleave4.png");    effectImage[84].resize(frameWidth,0);
  effectImage[85] = loadImage("cleave5.png");    effectImage[85].resize(frameWidth,0);
  effectImage[86] = loadImage("cleave6.png");    effectImage[86].resize(frameWidth,0);
  //BLOOD RAGE
  effectImage[87] = loadImage("rage1.png");    effectImage[87].resize(0,200);
  effectImage[88] = loadImage("rage2.png");    effectImage[88].resize(0,200);
  effectImage[89] = loadImage("rage3.png");    effectImage[89].resize(0,200);
  //STONE FIST
  effectImage[90] = loadImage("stoneFist1.png");   effectImage[90].resize(0,200);
  effectImage[91] = loadImage("stoneFist_2.png");  effectImage[91].resize(0,200);
  //FLASH PUNCH
  effectImage[92] = loadImage("flash1.png");    effectImage[92].resize(200,0);
  effectImage[93] = loadImage("flash2.png");    effectImage[93].resize(200,0);
  //WIND
  effectImage[94] = loadImage("tornado1.png");    effectImage[94].resize(0,200);
  effectImage[95] = loadImage("tornado2.png");    effectImage[95].resize(0,200);
  effectImage[96] = loadImage("tornado3.png");    effectImage[96].resize(0,200);
  //KICK
  effectImage[97] = loadImage("kick.png");    effectImage[97].resize(160,0);
  //REND
  effectImage[98] = loadImage("rend1.png");   effectImage[98].resize(0,200);
  effectImage[99] = loadImage("rend2.png");   effectImage[99].resize(0,200);
  effectImage[100] = loadImage("rend3.png");  effectImage[100].resize(0,200);
  //PREY
  effectImage[101] = loadImage("prey1.png");    effectImage[101].resize(200,0);
  effectImage[102] = loadImage("prey2.png");    effectImage[102].resize(200,0);
  effectImage[103] = loadImage("prey3.png");    effectImage[103].resize(200,0);
}
