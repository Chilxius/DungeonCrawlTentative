//This object will be responsible for the game's
//illustrations. Mostly this is to keep the main
//program clean (Processing can't collapse methods)

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
  PImage skillIcon[][] = new PImage[6][8];
  PImage skillButton[] = new PImage[4];
  PImage blackVanguard;
  
  public Artist()
  {
    animationStage = 0;
    animationStep = 0.3;
    savePointFloat = 0;
    savePointStep = .05;
    textPromptStage = 0;
    textPromptStep = 1;
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
    textSize(35);
    textAlign(CENTER);
    fill(255,255*(titleCardDuration/100.0));
    text(locationTitleCard,350,185);
  }
  
  public void startLocationTitleCard( String title )
  {
    locationTitleCard = title;
    titleCardDuration = 255;
  }
  
  public void drawMainMenu()
  {
    noFill();
    stroke(255);
    strokeWeight(6);
    rectMode(CENTER);
    rect(width/2,height/2,width-width/5,height-height/5,20);

    //Scroll
    noStroke();
    rectMode(CENTER);
    fill(195,175,135);
    rect(width/2,height/4-20,460,70);
    fill(90,70,30);
    rect(width/2,height/4-20-32,480,6);
    rect(width/2,height/4-20+32,480,6);
    fill(180,160,120);
    rect(width/2,height/4-20-32,470,14,5);
    rect(width/2,height/4-20+32,470,14,5);
    
    textSize(45);
    fill(127);
    textAlign(CENTER);
    text("The Riddle of Iron",width/2,height/4-5);
    
    textSize(20);
    fill(255);
    text("Enter the name of your game file.",width/2,height/2-10);
    text("If no file with that name exists,",width/2,height/2+30);
    text("a new file will be created.",width/2,height/2+70);
  }
  
  public void drawKeys( Key keys[] )
  {
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    rect(100,100,width-200,height-200,20);
    
    fill(200); textAlign(LEFT); textSize(25);
    text("Keys you have collected:",120,130);
    textSize(20);
    for(int i = 0,j = 0; i < keys.length; i++)
      if(keys[i]!=Key.NONE)
      {
        j++;
        text(keyName(keys[i]),120,130+30*j);
      }
  }
  
  public void drawItems( Item [] items ) //add gold in side window and loot sack
  {      
    if(party.gold > 0)
      drawGoldBox();
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    //rect(10,height-320,110,200,20); //loot box
    rect(100,100,width-200,height-200,20); //main window
    
    fill(200); textAlign(LEFT); textSize(25);
    text("Your Inventory:",120,130);
    textAlign(RIGHT); textSize(10);
    text("press (s) to sort",580,115);
    textSize(20); textAlign(LEFT);
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
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(100,100,width-200,height-200,20);
    
    for( Item i : items )
      if( i.value == 10 )
        breadCount++;
      else if( i.value == 20 )
        porkCount++;
      else if( i.value == 30 )
        fruitCount++;
      else if( i.value == 40 )
        crabCount++;
    
    noStroke();
    if(breadCount>0) { fill(#F2CE69,50); rect(205,185,315,45,20); }
    if(porkCount>0)  { fill(#B46C31,50); rect(205,265,315,45,20); }
    if(fruitCount>0) { fill(#00FF28,50); rect(205,345,315,45,20); }
    if(crabCount>0)  { fill(#FF0032,50); rect(205,425,315,45,20); }
    
    fill(200); textAlign(CENTER); textSize(40);
    text("Select Meal",width/2,150);
    
    strokeWeight(5);
    //Fork
    fill(180);
    rect(150,290,20,130,10);
    rect(145,390,30,180,20);
    rect(180,215,10,80,5);
    rect(130,215,10,80,5);
    rect(155,215,10,80,5);
    rect(130,285,60,10);
    
    //Knife
    fill(180);
    rect(530,390,30,180,20);
    beginShape();
    vertex(560,145);
    vertex(560,390);
    vertex(530,390);
    bezierVertex(530,390,530,115,560,145);
    endShape();
        
    fill(200); textAlign(LEFT); textSize(35);
    if(breadCount>0)
      text("1 - "+party.nextFoodName(0)+": "+breadCount,210,220);
    if(porkCount>0)
      text("2 - "+party.nextFoodName(1)+": "+porkCount,210,300);
    if(fruitCount>0)
      text("3 - "+party.nextFoodName(2)+": "+fruitCount,210,380);
    if(crabCount>0)
      text("4 - "+party.nextFoodName(3)+": "+crabCount,210,460);
      
    fill(200); textAlign(CENTER); textSize(25);
    text("Select by number or",width/2,560);
    text("press space to cancel.",width/2,580);
  }
  
  public void drawPotionMenu( Item [] items )
  {
    int healthPots=0,manaPots=0,vapors=0,elixers=0;
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    rect(100,100,width-200,height-200,20);
        
    fill(200); textAlign(CENTER); textSize(40);
    text("Select Potion",width/2,150);
    
    drawPotion(150,200,1,rand1);
    drawPotion(150,400,1,rand2);
    drawPotion(530,200,1,rand3);
    drawPotion(530,400,1,rand4);
        
    for( Item i : items )
      if( i.value == 12 )
        healthPots++;
      else if( i.value == 24 )
        manaPots++;
      else if( i.value == 36 )
        vapors++;
      else if( i.value == 48 )
        elixers++;
    
    fill(200); textAlign(LEFT); textSize(35);
    if(healthPots>0)
      text("1 - Health: "+healthPots,210,220);
    if(manaPots>0)
      text("2 - Mana: "+manaPots,210,300);
    if(vapors>0)
      text("3 - Vapor: "+vapors,210,380);
    if(elixers>0)
      text("4 - Elixer: "+elixers,210,460);
      
    fill(200); textAlign(CENTER); textSize(25);
    text("Select by number or",width/2,560);
    text("press space to cancel.",width/2,580);
  }
  
  public void loadSkillIcons()
  {
    //Knight
    skillButton[0] = loadImage("KnightSkill.png");     skillButton[0].resize(60,0);
    skillIcon[0][0] = loadImage("DefenseStrike.png"); skillIcon[0][0].resize(60,0);
    //Barbarian
    skillButton[1] = loadImage("BarbSkill.png");     skillButton[1].resize(60,0);
    skillIcon[1][0] = loadImage("BloodStrike.png");   skillIcon[1][0].resize(60,0);
    //Karate
    skillButton[2] = loadImage("ThiefSkill.png");     skillButton[2].resize(60,0);
    skillIcon[2][0] = loadImage("StoneFist.png");     skillIcon[2][0].resize(60,0);
    //Thief
    skillButton[3] = loadImage("MonkSkill.png");     skillButton[3].resize(60,0);
    skillIcon[3][0] = loadImage("Knives.png");        skillIcon[3][0].resize(60,0);
    //Priest
    skillIcon[4][0] = loadImage("HolyLight.png");     skillIcon[4][0].resize(60,0);
    //Mage    
    skillIcon[5][0] = loadImage("FireBall.png");          skillIcon[5][0].resize(60,0);
  }
  
  public void drawHeroSkills( int h )
  {
    float baseX = party.heroX(h);
    
    strokeWeight(5); fill(0);
    stroke(200); textSize(18); textAlign(CENTER);
    rectMode(CORNER); rect(40,200,620,300,20); rectMode(CENTER);
    /*level 1 skill*/            noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],140,280); rect(140,280,70,70,20); fill(200); text(party.hero[h].skill[0].description,140,240); text("Cost: "+party.hero[h].skill[0].cost,140,335); text("Q",165,305);
    if(party.hero[h].level>5 ) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],280,280); rect(280,280,70,70,20); fill(200); text(party.hero[h].skill[1].description,280,240); text("Cost: "+party.hero[h].skill[0].cost,280,335); text("W",305,305); }
    if(party.hero[h].level>10) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],420,280); rect(420,280,70,70,20); fill(200); text(party.hero[h].skill[2].description,420,240); text("Cost: "+party.hero[h].skill[0].cost,420,335); text("E",445,305); }
    if(party.hero[h].level>15) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],560,280); rect(560,280,70,70,20); fill(200); text(party.hero[h].skill[3].description,560,240); text("Cost: "+party.hero[h].skill[0].cost,560,335); text("R",585,305); }
    if(party.hero[h].level>20) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],140,430); rect(140,430,70,70,20); fill(200); text(party.hero[h].skill[4].description,140,390); text("Cost: "+party.hero[h].skill[0].cost,140,485); text("A",165,455); }
    if(party.hero[h].level>25) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],280,430); rect(280,430,70,70,20); fill(200); text(party.hero[h].skill[5].description,280,390); text("Cost: "+party.hero[h].skill[0].cost,280,485); text("S",305,455); }
    if(party.hero[h].level>30) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],420,430); rect(420,430,70,70,20); fill(200); text(party.hero[h].skill[6].description,420,390); text("Cost: "+party.hero[h].skill[0].cost,420,485); text("D",445,455); }
    if(party.hero[h].level>35) { noFill(); image(skillIcon[jobToInt(party.hero[h].job)][0],560,430); rect(560,430,70,70,20); fill(200); text(party.hero[h].skill[7].description,560,390); text("Cost: "+party.hero[h].skill[0].cost,560,485); text("F",585,455); }
    
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
      default: return 5;
    }
  }
  
  public void drawBattleItems( int h, Item [] items )
  {
    int healthPots=0,manaPots=0,vapors=0,elixirs=0;
    float baseX = party.heroX(h);
    
    //Get number of potion types
    for( Item i : items )if( i.value == 12 )healthPots++;else if( i.value == 24 )manaPots++;else if( i.value == 36 )vapors++;else if( i.value == 48 )elixirs++;
    
    rectMode(CENTER); strokeWeight(5);
    stroke(200); fill(0);
    rect(140,380,70,70,20);rect(280,380,70,70,20);
    rect(420,380,70,70,20);rect(560,380,70,70,20);
    rect(baseX+75,545,70,70,20);
    
    textAlign(CENTER); textSize(10); fill(200);
    if(healthPots>0){text("Health: "+healthPots,140,357); text("A",165,407);}
    if(manaPots>0)  {text("Mana: "  +manaPots,280,357);   text("S",305,407);}
    if(vapors>0)    {text("Vapor: " +vapors,420,357);     text("D",445,407);}
    if(elixirs>0)   {text("Elixir: "+elixirs,560,357);    text("F",585,407);}
    
    drawCancelIcon(baseX+75,545);
    if(healthPots>0)drawPotion( 135,360,.5,#00FF0A);
    if(manaPots>0)  drawPotion( 275,360,.5,#0063FF);
    if(vapors>0)    drawPotion( 415,360,.5,#FF6FF1);
    if(elixirs>0)   drawPotion( 555,360,.5,#FFD500);
  }
  
  public void drawHeroData( int h )
  {
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(210,170,285,410,20);
    drawHeroByType(party.hero[h],454,212,1,h,false);
    fill(200); textAlign(LEFT,TOP); textSize(40);
    text(party.hero[h].name,225,175);
    textSize(25);
    text("Level " + party.hero[h].level + " " + party.hero[h].jobToString(),225,220);
    if(party.hero[h].inDanger())fill(255,0,0); text("Health: " + party.hero[h].hp + "/" + party.hero[h].maxHp,225,260); fill(200);
    if(party.hero[h].maxMp>0)
      text("Magic: " + party.hero[h].mp + "/" + party.hero[h].maxMp,225,290);
    if(party.hero[h].hasCondition(3)) fill(250,0,0); text("Strength:",225,320); if(party.hero[h].hasCondition(3)) text(party.hero[h].str-party.hero[h].level,400,320); else text(party.hero[h].str,400,320); fill(200);
    text("Dexterity:",225,350);    text(party.hero[h].dex,400,350);
    text("Constitution:",225,380); text(party.hero[h].con,400,380);
    if(party.hero[h].hasCondition(4)) fill(250,0,150); text("Magic Power:",225,410);  if(party.hero[h].hasCondition(3)) text(party.hero[h].mag/2,400,410); else text(party.hero[h].mag,400,410); fill(200);
    if(party.hero[h].hasCondition(4)) fill(250,0,150); text("Willpower:",225,440);    if(party.hero[h].hasCondition(3)) text(party.hero[h].wil/2,400,440); else text(party.hero[h].wil,400,440); fill(200);
    text("Speed:",225,470);        text(party.hero[h].spd,400,470);
    text("Experience: " + party.hero[h].exp,225,510);
    text("Next Level: " + party.hero[h].nextLevel,225,540);
    
    fill(0); rectMode(CORNER); imageMode(CENTER);
    stroke(200); strokeWeight(5);
    rect(85,170,100,100,20);
    image(party.hero[h].weapon.pic,135,220);
    rect(85,290,100,100,20);
    image(party.hero[h].armor.pic,135,340);
    textSize(10); fill(200); textAlign(CENTER);
    text("WEAPON",135,185);
    text("ARMOR",135,305);
    
    textAlign(LEFT,TOP);
    text(party.hero[h].weapon.toString(),95,255);
    text(party.hero[h].weapon.power,165,245);
    text(party.hero[h].armor.toString(),95,375);
    text(party.hero[h].armor.power,165,365);
    
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(520,170,100,310,20);
    textSize(10); fill(200); textAlign(CENTER);
    text("CONDITION",570,185);
    
    //Hero is fine (NOT(!) REMOVED FOR TESTING)
    if(!party.hero[h].inDanger()      && !party.hero[h].hasCondition(0) 
    && !party.hero[h].hasCondition(1) && !party.hero[h].hasCondition(2)
    && !party.hero[h].hasCondition(3) && !party.hero[h].hasCondition(4) )
    {
      textSize(15); fill(255); textAlign(CENTER);
      text("HEALTHY",570,210);
      textSize(12);
      text("Ready for",570,225);
      text("adventure!",570,235);
    }
    
    //Low health
    if(party.hero[h].inDanger())
    {
      textSize(15); fill(150,0,0); textAlign(CENTER);
      text("IN DANGER",570,210);
      textSize(12);
      text("Find healing",570,223);
      text("soon!",570,235);
    }
    
    //Poisoned
    if(party.hero[h].hasCondition(0))
    {
      textSize(15); fill(0,150,0); textAlign(CENTER);
      text("POISONED",570,255);
      textSize(12);
      text(party.hero[h].name + " is",570,268);
      text(party.hero[h].poisonString(),570,280);
    }
    
    //Asleep
    if(party.hero[h].hasCondition(1))
    {
      textSize(15); fill(150,150,150); textAlign(CENTER);
      text("ASLEEP",570,300);
      textSize(12);
      text("This is not",570,312);
      text("the time!",570,325);
    }
    
    //Paralyzed
    if(party.hero[h].hasCondition(2))
    {
      textSize(15); fill(150,150,0); textAlign(CENTER);
      text("PARALYZED",570,345);
      textSize(12);
      text("Can't move",570,358);
      text("a muscle.",570,370);
    }
    
    //Weakened
    if(party.hero[h].hasCondition(3))
    {
      textSize(15); fill(120); textAlign(CENTER);
      text("WEAKENED",570,390);
      textSize(12);
      text("Your muscles",570,403);
      text("have atrophied.",570,415);
    }
    
    //Cursed
    if(party.hero[h].hasCondition(4))
    {
      textSize(15); fill(150,0,150); textAlign(CENTER);
      text("CURSED",570,435);
      textSize(12);
      text("Your magic and",570,448);
      text("willpower are.",570,460);
      text("sealed.",570,472);
    }
  }
  
  public void drawGoldBox()
  {
    fill(200,200,0); textAlign(CENTER);
    textSize(15); text("GOLD",645,220);
    textSize(12); text(party.gold,645,235);
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
    rect(width/2,375,490,400);
    fill(90,70,30);
    rect(width/2,170,510,6);
    rect(width/2,575,510,6);
    fill(180,160,120);
    rect(width/2,170,500,14,5);
    rect(width/2,575,500,14,5);
    
    //fill(0);  rectMode(CORNER);
    //stroke(200);
    //strokeWeight(5);
    //rect(100,175,width-200,400,20);
    textSize(25); fill(50); textAlign(CORNER);
    text("Keyboard Commands:",110,205);
    textSize(20);
    text("(w)(a)(s)(d) - Move party around map",110,235);
    text("(E) - Eat food",110,260); text("(D) - Drink potion",350,260);
    text("(S) - Save at a Legend Gem",110,285);
    text("(R) - Rest at an inn or camp",110,310);
    text("(B) - Bargain with a vendor",110,335);
    text("(o) - Open door",110,360); text("(>) - Use a staircase",350,360);
    text("(space) - Open chest / Search current space",110,385);
    text("Hold (i) - View inventory",110,410);
    text("Hold (k) - View keys",110,435);
    text("Hold (h) - View help menu",110,460);
    textSize(15);
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
    rect(100,200,width-200,height-400+equipOffset,20);
    
    fill(200); textSize(40);
    if( display == Display.EQUIP ) { textAlign(CORNER); text(newEquip.name,350-(9*newEquip.name.length()),250); image(newEquip.pic,320-(9*newEquip.name.length()),240); }
    else                           { textAlign(CENTER); text("Select Hero",width/2,250); }
    
    
    
    textAlign(CENTER);
    fill(party.hero[0].getColor()); drawHeroByType(party.hero[0],150,320,1,0,true); //ellipse(150,320,75,75);
    textSize(20); fill(200); text(1,150,275);
    
    fill(party.hero[1].getColor()); drawHeroByType(party.hero[1],350,320,1,1,true); //ellipse(350,320,75,75);
    textSize(20); fill(200); text(2,350,275);
    
    fill(party.hero[2].getColor()); drawHeroByType(party.hero[2],550,320,1,2,true); //ellipse(550,320,75,75);
    textSize(20); fill(200); text(3,550,275);
      
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
      textSize(40);
      if(      dist( mouseX,mouseY, 150,320)<37.5)
        text(party.hero[0].name,width/2,410);
      else if( dist( mouseX,mouseY, 350,320)<37.5)
        text(party.hero[1].name,width/2,410);
      else if( dist( mouseX,mouseY, 550,320)<37.5)
        text(party.hero[2].name,width/2,410);
      textSize(25);
      text("Select by number or",width/2,460);
      text("press space to cancel.",width/2,480);
    }
    else
    {
      textSize(40);
      if(      dist( mouseX,mouseY, 150,320)<37.5)
        text(party.hero[0].name,width/2,530);
      else if( dist( mouseX,mouseY, 350,320)<37.5)
        text(party.hero[1].name,width/2,530);
      else if( dist( mouseX,mouseY, 550,320)<37.5)
        text(party.hero[2].name,width/2,530);
      else
      {
        textSize(25);
        text("Equip by number or press", width/2,510);
        text("capital (X) to put aisde for sale.",width/2,540);
      }
    }
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
    textSize(75);
    text("GAME OVER",width/2,542.5);
  }
  
  public void showStatComparison( int heroIndex, Equipment thing, float xPos, float yPos )
  {
    textSize(30);
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
      textSize(25);
      text("Can't", xPos, yPos-10);
      text("use.", xPos, yPos+10);
    }
    else //hero can use
    {
      //display old power
      if( thing.isWeapon) text( party.hero[heroIndex].weapon.power, xPos-25, yPos );
      else                text( party.hero[heroIndex].armor.power, xPos-25, yPos );
      text( thing.power, xPos+25, yPos ); //display new power
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
      case SIGN:
        image(tileImage[36],xPos,yPos);
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
      case GRAVE:
        image(tileImage[42],xPos,yPos);
        break;
      case RUBBLE:
        image(tileImage[67],xPos,yPos);
        break;
      case TENT:
        image(tileImage[55],xPos,yPos);
        break;
    }
  }
  
  public void drawAdvanceTextPrompt()
  {
    noStroke(); fill(50+textPromptStage*2);  //prompt will flash
    textSize(10); textAlign(RIGHT);
    text("push SPACE to continue",width-15,height-6-textPromptStage/8); //prompt will move to get player's attention
    //triangle(width-130-textPromptStage/8,height-9,  width-140-textPromptStage/8,height-12, width-140-textPromptStage/8,height-6);
    triangle(width-75,height-115+textPromptStage/8, width-45,height-130+textPromptStage/8, width-105,height-130+textPromptStage/8);
  }
  
  public void drawColorBars( float r, float g, float b )
  {  //Boxes for color selectors
    stroke(200); noFill(); strokeWeight(3); rectMode(CORNER);
    rect(99,289,501,21); rect(99,339,501,21); rect(99,389,501,21);
    noStroke();
    for(int i = 0; i < 250; i++) //color bars
    {
      fill(i,0,0);
      rect(100+i*2,290,2,20);
      fill(0,i,0);
      rect(100+i*2,340,2,20);
      fill(0,0,i);
      rect(100+i*2,390,2,20);
    }
    stroke(200); noFill(); strokeWeight(5);
    rect(100+r*2,289,5,21);
    rect(100+g*2,339,5,21);
    rect(100+b*2,389,5,21);
    rectMode(CENTER);
    fill(200); noStroke();
    rect(width/2,500,115,90);
    fill(r,g,b);
    stroke((255-r)*.65,(255-g)*.65,(255-b)*.65);
    rect(width/2,500,100,75);
    fill(200); textAlign(CENTER); textSize(20);
    text("CLICK HERE TO SELECT",width/2,570);
    drawHero(width/2,170, 3, color(r,g,b), color((255-r)*.65,(255-g)*.65,(255-b)*.65), currentHero, false, tempJob);
    //drawKnight(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
    //textSize(30);
    //text("CHOOSE THE HERO'S PRIMARY COLOR",width/2,50);
    //textSize(20);
    //text("THIS COLOR WILL ALSO DETERMINE THE ACCENT COLOR",width/2,75);
  }

  public void drawJobChoices( int hero )
  {
    noStroke(); fill(150); //will be icons later
    drawKnight(150,200,2,200,50,hero,true);drawBarbarian(350,200,2,200,50,hero,true);drawKarate(550,200,2,200,50,hero,true);
    drawThief(150,400,2,200,50,hero,true);drawPriest(350,400,2,200,50,hero,true);drawMage(550,400,2,200,50,hero,true);
  
    //Class descriptions
    fill(200); textAlign(CENTER); textSize(30);
    if( dist(mouseX,mouseY,150,200)<75 ){ text("KNIGHT",width/2,45);         textSize(20); text("A stalwart combatant that can use most equipment.",width/2,75);             text("Gains energy when blocking attacks.",width/2,100);        drawStatBars(1); }
    if( dist(mouseX,mouseY,350,200)<75 ){ text("BARBARIAN",width/2,45);      textSize(20); text("A powerful warrior that relishes battle.",width/2,75);                      text("Gains energy when taking damage.",width/2,100);           drawStatBars(2); }
    if( dist(mouseX,mouseY,550,200)<75 ){ text("MARTIAL ARTIST",width/2,45); textSize(20); text("A practitioner of martial arts who cannot use most equipment.",width/2,75); text("Always begins combat with extra energy.",width/2,100);    drawStatBars(3); }
    if( dist(mouseX,mouseY,150,400)<75 ){ text("THIEF",width/2,45);          textSize(20); text("An agile trickster that uses light equipment.",width/2,75);                 text("Gains energy when scoring critical hits.",width/2,100);   drawStatBars(4); }
    if( dist(mouseX,mouseY,350,400)<75 ){ text("PRIEST",width/2,45);         textSize(20); text("A pious caster who can use some heavy armor.",width/2,75);                  text("Casts holy magic that can smite or heal.",width/2,100);   drawStatBars(5); }
    if( dist(mouseX,mouseY,550,400)<75 ){ text("MAGE",width/2,45);           textSize(20); text("An arcane caster unsuited to physical combat.",width/2,75);                 text("Casts elemental magic of tremendous power.",width/2,100); drawStatBars(6); }
    
    textAlign(CENTER);
    textSize(12);
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
      default: h = 15; s = 5;  d = 7;  c = 5;  m = 15; w = 10; q = 9;  break;
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
        fill(120,120,120); textAlign(CENTER); textSize(15);
        text('Z',40+20+h*248,145); textSize(13);
        text('Z',40+30+h*248,135); textSize(11);
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
        fill(200); textAlign(LEFT); textSize(30);
        text(h[i].toString(),12+i*248,40);
        textSize(23);
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
        stroke(party.hero[i].inverseColor);
        fill(party.hero[i].favColor);
        for(int k = 0; k < min(13,party.hero[i].energy); k++ )
          rect(100+i*248+7*k,95,7,13);
        for(int k = 0; k < min(13,party.hero[i].energy-13); k++ )
          rect(100+i*248+7*k,110,7,13);
        for(int k = 0; k < min(24,party.hero[i].energy-26); k++ )
          rect(16+i*248+7*k,125,7,13);
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
      rect(width/2,height-150,250,50,20);
      
      fill(255);
      textSize(30);
      textAlign(CENTER);
      text(tb,width/2,height-140);
      rectMode(CORNER);
    }
    
    if(display != Display.MAIN_MENU)
    {
      noFill();  rectMode(CORNER);
      stroke(200);
      strokeWeight(5);
      rect(2,height-100,width-5,98,20);
      
      fill(255);
      textSize(30);
      textAlign(LEFT);
      text(tl1,10,height-60);
      text(tl2,10,height-20);
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
    }
    if(restOpacity <= 0)
    {
      resting = false;
      input = Input.EXPLORING;
    }
  }
  
  void drawBattleWindow()
  {
    println("1: "+party.hero[0].poison+ "  2: "+party.hero[1].poison+"  3: "+party.hero[2].poison);
    strokeWeight(5);
    stroke(200);
    fill(0);
    if(battleWindowOpening)
    {
      rectMode(CENTER);
      rect(width/2,377,14*animationStage,8.7*animationStage,20);
      //println(14*animationStage + " " + 8.7*animationStage );
      if(animationStage==49)
        battleWindowOpening=false;
    }
    else
    {
      rectMode(CORNER);
      rect(3,159,width-7,height-266,20);
      
      drawMonsters();
      drawProgressBars();
      drawHeroesInBattle();
      drawDefenseIcons();
        
      if(!battle.waitingForText)
      {
        if(input == Input.BATTLE_ITEM)
          drawBattleItems(battle.turn,party.inventory);
        else if(input == Input.BATTLE_SKILL)
          drawHeroSkills(battle.turn);
        else if(input == Input.BATTLE_ITEM_HERO_CHOICE) //choosing who to use item on
          drawHeroSelectScreen();
        else if(input == Input.BATTLE_ATTACK_TARGET || input == Input.BATTLE_SKILL_TARGET)
          drawAttackTargetArrows( battle.turn, true );
        else if(input == Input.BATTLE_HEAL_TARGET)
          drawAttackTargetArrows( battle.turn, false );
        else if(battle.turn==0||battle.turn==1||battle.turn==2)
          drawBattleIcons(battle.turn);
      }
        //drawBattleItems(0,party.inventory); //for testing
    }
  }
  
  void drawDefenseIcons()
  {
    for(int i = 0; i < 3; i++)
      if(party.hero[i].defending)
        drawDefendIcon(100+250*i,155,party.hero[i].favColor,1,party.hero[i].job);
  }
  
  void drawShield( float x, float y, int heroIndex )
  {
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
    endShape();
  }
  
  void drawProgressBars()
  {
    int total = 20*party.averageLevel()+100; //adding 100 to normalize speeds
     strokeWeight(1); stroke(150);
    for(int i = 0; i < 3; i++)
    {
      if(battle.list[i].active){ fill(party.hero[i].inverseColor); rect(100+210*i,578, min(80,(battle.list[i].counter/total)*80) ,10); }
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
      fill( party.hero[h].favColor );textSize(24); //Letter Backing
      if(battle.list[3].active) text("A",140,420);
      if(battle.list[4].active) text("S",350,420);
      if(battle.list[5].active) text("D",560,420);
      fill( party.hero[h].inverseColor );textSize(25); //Letter
      if(battle.list[3].active) text("A",140,420);
      if(battle.list[4].active) text("S",350,420); 
      if(battle.list[5].active) text("D",560,420);
    }
    else
    {
      fill( party.hero[h].favColor );textSize(24); //Letter Backing
      text("A",140,420); text("S",350,420); text("D",560,420);
      fill( party.hero[h].inverseColor );textSize(25); //Letter
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
    
    drawAttackIcon(baseX-75,455,party.hero[h].favColor,party.hero[h].inverseColor,party.hero[h].weapon.pic);
    drawDefendIcon(baseX+75,455,party.hero[h].favColor,party.hero[h].inverseColor,party.hero[h].job);
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
  
  void drawAttackIcon( float x, float y, color c, color i, PImage p )
  {
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
    
    fill(c); textSize(10);
    text("A",x+25,y+27);
  }
  
  void drawDefendIcon( float x, float y, color c, color i, Job j )
  {
    if( j == Job.KNIGHT || j == Job.PRIEST ) //heater
    {
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
    }
    else  //targe with cross
    {
      noStroke(); fill(90,70,30);
      circle(x,y,50);
      rectMode(CENTER); fill(c,150);
      rect(x,y,49,7); rect(x,y,7,49);
      stroke(200); strokeWeight(2);
      fill(180);  circle(x,y,15);
      stroke(190); strokeWeight(3);
      noFill(); circle(x,y,51);
    }
    
    if( i != 1 )
    {
      fill(c); textSize(10);
      text("D",x+25,y+27);
    }
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
      stroke(127);
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
    
    fill(c); textSize(10);
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
    
    fill(c); textSize(10);
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
    
    fill(200); textSize(10);
    textAlign(CENTER);
    text("X",x+25,y+27);
  }
  
  void drawHero(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial, Job j)
  {
    switch(j)
    {
      case KNIGHT:
        drawKnight( x,  y,  scale,  c1,  c2,  heroNumber,  initial);
        break;
      case BARBARIAN:
        drawBarbarian( x,  y,  scale,  c1,  c2,  heroNumber,  initial);
        break;
      case KARATE:
        drawKarate( x,  y,  scale,  c1,  c2,  heroNumber,  initial);
        break;
      case THIEF:
        drawThief( x,  y,  scale,  c1,  c2,  heroNumber,  initial);
        break;
      case PRIEST:
        drawPriest( x,  y,  scale,  c1,  c2,  heroNumber,  initial);
        break;
      default:
        drawMage( x,  y,  scale,  c1,  c2,  heroNumber,  initial);
        break;
    }
  }
  
  void drawKnight(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
  {
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
    if(heroNumber==0)
      fill(90,70,30);
    else if(heroNumber==1)
      fill(210,190,70);
    else
      fill(10,10,5);
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
    if(heroNumber==0)
      fill(90,70,30);
    else if(heroNumber==1)
      fill(210,190,70);
    else
      fill(10,10,5);
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
  
  void drawBarbarian(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
  { 
    color skin;
    color hair;
    //Circle
    noFill();
    strokeWeight(0.5);
    stroke(255);
    if(initial)
      ellipse(x,y,75*scale, 75*scale);
    
    if(heroNumber==0)
    {
      hair = color(90,70,30);
      skin = color(#C68642);
    }
    else if(heroNumber==1)
    {
      hair = color(210,190,70);
      skin = color(#F1C27D);
    }
    else
    {
      hair = color(10,10,5);
      skin = color(#FFDBAC);
    }
    
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
    
    //Hair - color based on which hero (brown, blonde, black)
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
  
  void drawKarate(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
  {
    color skin;
    color hair;
    if(heroNumber==0)
    {
      hair = color(90,70,30);
      skin = color(#C68642);
    }
    else if(heroNumber==1)
    {
      hair = color(210,190,70);
      skin = color(#F1C27D);
    }
    else
    {
      hair = color(10,10,5);
      skin = color(#FFDBAC);
    }
      
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
  
  void drawThief(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
  {
    color skin;
    if(heroNumber==0)
      skin = color(#C68642);
    else if(heroNumber==1)
      skin = color(#F1C27D);
    else
      skin = color(#FFDBAC);
      
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
  
  void drawPriest(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
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
  
  void drawMage(int x, int y, float scale, color c1, color c2, int heroNumber, boolean initial)
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
    if(heroNumber==0)
      fill(90,70,30);
    else if(heroNumber==1)
      fill(210,190,70);
    else
      fill(10,10,5);
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
  
  void drawHeroByType( Hero h, int x, int y, float scale, int hair, boolean circle )
  {
    if( h.getJob() == Job.KNIGHT )
      drawKnight(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.BARBARIAN )
      drawBarbarian(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.KARATE )
      drawKarate(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.THIEF )
      drawThief(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.PRIEST )
      drawPriest(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.MAGE )
      drawMage(x,y,scale,h.favColor,h.inverseColor,hair,circle);
  }
  
  void drawHeroesInBattle()
  {
    if(party.hero[0].isAlive())
      drawHeroByType(party.hero[0],width/5,500,2,0,false);
    if(party.hero[1].isAlive())
      drawHeroByType(party.hero[1],width/2,500,2,1,false);
    if(party.hero[2].isAlive())
      drawHeroByType(party.hero[2],int(width*.8),500,2,2,false);
  }
  
  void drawMonsters( )
  {
    imageMode(CENTER);
    if(battleMonsters[0].alive)
      image(battleMonsters[0].pic,width/5,275);
    if(battleMonsters[1].alive)
      image(battleMonsters[1].pic,width/2,275);
    if(battleMonsters[2].alive)
      image(battleMonsters[2].pic,width*.8,275);
  }
}
