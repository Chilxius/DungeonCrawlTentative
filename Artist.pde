//This object will be responsible for the game's
//illustrations. Mostly this is to keep the main
//program clean (Processing can't collapse methods)

class Artist
{
  int animationStage;
  int animationStep;
  color rand1, rand2, rand3, rand4;
  boolean battleWindowOpening = false;
  
  public Artist()
  {
    animationStage = 0;
    animationStep = 1;
    rand1 = color(random(255),random(255),random(255));
    rand2 = color(random(255),random(255),random(255));
    rand3 = color(random(255),random(255),random(255));
    rand4 = color(random(255),random(255),random(255));
  }
  
  public void animate()
  {
    animationStage+=animationStep;
    if(animationStage < 0 || animationStage>50)
      animationStep*=-1;
  }
  
  public int stage()
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
    
    textSize(40);
    fill(60,40,0);
    textAlign(CENTER);
    text("Ritchie's Dungon Crawl",width/2,height/4-5);
    
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
  
  public void drawItems( Item [] items )
  {
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    rect(100,100,width-200,height-200,20);
    
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
        println((130+30*(i+1))-(450*int(1/15)));
      }
  }
  
  public void drawFoodMenu( Item [] items )
  {
    int breadCount=0,porkCount=0,fruitCount=0,crabCount=0;
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(100,100,width-200,height-200,20);
    
    fill(200); textAlign(CENTER); textSize(40);
    text("Select Meal",width/2,150);
    
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
    
    for( Item i : items )
      if( i.value == 10 )
        breadCount++;
      else if( i.value == 20 )
        porkCount++;
      else if( i.value == 30 )
        fruitCount++;
      else if( i.value == 40 )
        crabCount++;
        
    fill(200); textAlign(LEFT); textSize(35);
    if(breadCount>0)
      text("1 - Fresh Bread: "+breadCount,210,220);
    if(porkCount>0)
      text("2 - Salt Pork: "+porkCount,210,300);
    if(fruitCount>0)
      text("3 - Sunfruit: "+fruitCount,210,380);
    if(crabCount>0)
      text("4 - King Crab: "+crabCount,210,460);
      
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
    
    drawPotion(150,200,rand1);
    drawPotion(150,400,rand2);
    drawPotion(530,200,rand3);
    drawPotion(530,400,rand4);
        
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
    
    fill(0);  rectMode(CORNER);
    stroke(200); strokeWeight(5);
    rect(85,170,100,100,20);
    rect(85,290,100,100,20);
    textSize(10); fill(200); textAlign(CENTER);
    text("WEAPON",135,185);
    text("ARMOR",135,305);
    
    textAlign(LEFT,TOP);
    text(party.hero[h].weapon.toString(),95,255);
    text(party.hero[h].armor.toString(),95,375);
    
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
  
  public void drawPotion( int xPos, int yPos, color c )
  {          //draws from the top left corner of neck
    fill(c);
    beginShape();    //x-150, y-300
    vertex(xPos,yPos);
    vertex(xPos,yPos+50);
    bezierVertex(xPos-50,yPos+70,xPos-30,yPos+100,xPos+10,yPos+100);
    bezierVertex(xPos+50,yPos+100,xPos+70,yPos+70,xPos+20,yPos+50);
    vertex(xPos+20,yPos);
    endShape();
  }
  
  public void drawHeroSelectScreen()
  {
    fill(0);  rectMode(CORNER);
    stroke(200);
    strokeWeight(5);
    rect(100,200,width-200,height-400,20);
    
    fill(200); textAlign(CENTER); textSize(40);
    text("Select Hero",width/2,250);
    
    fill(party.hero[0].getColor()); drawHeroByType(party.hero[0],150,320,1,0,true); //ellipse(150,320,75,75);
    fill(200); text(1,150,333);
    if( dist( mouseX,mouseY, 150,320)<37.5)
      text(party.hero[0].name,width/2,400);
    
    fill(party.hero[1].getColor()); drawHeroByType(party.hero[1],350,320,1,1,true); //ellipse(350,320,75,75);
    fill(200); text(2,350,333);
    if( dist( mouseX,mouseY, 350,320)<37.5)
      text(party.hero[1].name,width/2,400);
    
    fill(party.hero[2].getColor()); drawHeroByType(party.hero[2],550,320,1,2,true); //ellipse(550,320,75,75);
    fill(200); text(3,550,333);
    if( dist( mouseX,mouseY, 550,320)<37.5)
      text(party.hero[2].name,width/2,400);
      
    fill(200); textAlign(CENTER); textSize(25);
    text("Select by number or",width/2,460);
    text("press space to cancel.",width/2,480);
  }
  
  public void drawObject( Object o, int xPos, int yPos )
  {
    switch(o)
    {
      case CHEST:
        fill(90,70,30);
        rect(xPos+13,yPos+13,15,15,3);
        fill(255,225,0);
        rect(xPos+13,yPos+17,15,2);
        rect(xPos+18,yPos+17,4,4);
        break;
      case SIGN:
        fill(90,70,30);
        rect(xPos+5,yPos+5,20,15);
        rect(xPos+14,yPos+5,2,20);
        break;
      case SAVEPOINT:
        fill(animationStage*2.5,animationStage*2.5,255);
        beginShape();
        vertex(xPos+15,yPos+5);
        vertex(xPos+23,yPos+15);
        vertex(xPos+15,yPos+25);
        vertex(xPos+7,yPos+15);
        vertex(xPos+15,yPos+5);
        endShape();
        break;
    }
  }
  
  public void drawAdvanceTextPrompt()
  {
    fill(100+animationStage*2);  //prompt will flash
    textSize(10); textAlign(RIGHT);
    text("push SPACE to continue",width-15,height-6-animationStage/9); //prompt will move to get player's attention
  }
  
  public void drawColorBars( float r, float g, float b )
  {  //Boxes for color selectors
    stroke(200); noFill(); strokeWeight(3); rectMode(CORNER);
    rect(99,189,501,21); rect(99,239,501,21); rect(99,289,501,21);
    noStroke();
    for(int i = 0; i < 250; i++) //color bars
    {
      fill(i,0,0);
      rect(100+i*2,190,2,20);
      fill(0,i,0);
      rect(100+i*2,240,2,20);
      fill(0,0,i);
      rect(100+i*2,290,2,20);
    }
    stroke(200); noFill(); strokeWeight(2);
    rect(100+r*2,189,5,21);
    rect(100+g*2,239,5,21);
    rect(100+b*2,289,5,21);
    fill(r,g,b);
    rectMode(CENTER);
    rect(width/2,400,100,75);
    fill(200); textAlign(CENTER); textSize(20);
    text("CLICK HERE TO SELECT",width/2,470);
  }

  public void drawJobChoices( int hero )
  {
    noStroke(); fill(150); //will be icons later
    drawIncomplete(150,200,2,255,0,hero,true);drawIncomplete(350,200,2,255,0,hero,true);drawIncomplete(550,200,2,255,0,hero,true);
    drawIncomplete(150,400,2,255,0,hero,true);drawPriest(350,400,2,255,0,hero,true);drawMage(550,400,2,255,0,hero,true);
  
    fill(200); textAlign(CENTER); textSize(30);
    if( dist(mouseX,mouseY,150,200)<75 )text("KNIGHT",width/2,height-150);
    if( dist(mouseX,mouseY,350,200)<75 )text("BARBARIAN",width/2,height-150);
    if( dist(mouseX,mouseY,550,200)<75 )text("MARTIAL ARTIST",width/2,height-150);
    if( dist(mouseX,mouseY,150,400)<75 )text("THIEF",width/2,height-150);
    if( dist(mouseX,mouseY,350,400)<75 )text("PRIEST",width/2,height-150);
    if( dist(mouseX,mouseY,550,400)<75 )text("MAGE",width/2,height-150);
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
    
    //for testing
    //drawMage(150,350,2,h[0].getColor(),h[0].getInvColor());
    //drawMage(350,350,2,h[1].getColor(),h[1].getInvColor());
    //drawMage(550,350,2,h[2].getColor(),h[2].getInvColor());
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
  
  void drawBattleWindow()
  {
    strokeWeight(5);
    stroke(200);
    fill(0);
    if(battleWindowOpening)
    {
      rectMode(CENTER);
      rect(width/2,377,14*animationStage,8.7*animationStage,20);
      println(14*animationStage + " " + 8.7*animationStage );
      if(animationStage==49)
        battleWindowOpening=false;
    }
    else
    {
      rectMode(CORNER);
      rect(3,159,width-7,height-266,20);
      
      drawHeroesInBattle();
      if(!battle.waitingForText && 
          battle.turn==0||battle.turn==1||battle.turn==2)
        drawBattleIcons(battle.turn);
      drawMonsters();
    }
  }
  
  void drawBattleIcons( int h )
  {
    float baseX;
    if(h == 0)
      baseX = width/5;
    else if(h == 1)
      baseX = width/2;
    else
      baseX = width*0.8;

    rectMode(CENTER); strokeWeight(5);
    stroke(200); fill(0);
    rect(baseX-75,455,70,70,20);rect(baseX+75,455,70,70,20);
    rect(baseX-75,545,70,70,20);rect(baseX+75,545,70,70,20);
    
    drawAttackIcon(baseX-75,455,party.hero[h].favColor,party.hero[h].inverseColor,party.hero[h].job);
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
  
  void drawAttackIcon( float x, float y, color c, color i, Job j )
  {
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
    
    fill(c); textSize(10);
    text("A",x+27,y+27);
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
    
    fill(c); textSize(10);
    text("D",x+27,y+27);
  }
  
  void drawSkillIcon( float x, float y, color c, color i, Job j)
  {
    fill(c, 30); noStroke();
    for(int k = 0; k < 10; k++) circle(x,y,3*k+45);
    
    if( j == Job.KNIGHT || j == Job.BARBARIAN || j == Job.KARATE || j == Job.THIEF )
    {
      
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
    text("S",x+27,y+27);
  }
  
  void drawItemIcon( float x, float y, color c )
  {
    rectMode(CENTER);
    fill(140,120,80); noStroke();
    circle(x,y+5,40);
    quad(x+8,y-15,x+15,y-25,x-15,y-25,x-8,y-15);
    fill(80,60,20);
    rect(x,y-15,20,5);
    
    fill(c); textSize(10);
    text("X",x+27,y+27);
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
      drawIncomplete(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.BARBARIAN )
      drawIncomplete(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.KARATE )
      drawIncomplete(x,y,scale,h.favColor,h.inverseColor,hair,circle);
    if( h.getJob() == Job.THIEF )
      drawIncomplete(x,y,scale,h.favColor,h.inverseColor,hair,circle);
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
