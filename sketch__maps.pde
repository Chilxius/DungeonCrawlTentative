color chilxius = color(0,200);
color sunitaColor   = color(150, 250, 250);
color clericColor   = color(150, 150, 250);
color initiateColor = color (150, 150, 200);
color secretTeacherColor = color(200, 150, 200);
color ritisuColor   = color(0,112,175), lesserRitisu = color(75,180,243);
color dummyColor    = color(190, 170, 130);
color garrison = color(160);
color governor      = color(125,110,10);
color male          = color(165,150,50),  mYoung     = color(250,230,0);
color female        = color(150,50,165),  fYoung     = color(230,150,250);
color raskColor     = color(250, 100, 50), coryColor = color(100,100,200);
color katColor      = color(250,0,170);
color sailor        = color(150,100,100), captain    = color(200,100,100);
color ghostColor    = color(255,150);

//The following data needs to be shared between the createFloor methods, so I made it global
//*****************************************************************************************
String mapStrings[] = new String[mapCount]; //10 is temporary
String dangerStrs[] = new String[mapCount];

//These should always ++ themselves when used
int savePointIndex = 0;
int lootIndex = 0;

//This should be ++'d when the boss is made, then used for its attacks
int bossIndex = 0;

int mapIndex = 0;
int dangerMapIndex = 0;

//setupMaps() needs to be broken up because of the 65535 byte limit to methods
void setupMaps()
{ 
  //******************************************
  //Zeros out loot tables with worthless keys at 0,0
  for(int i = 0; i < lootList.length; i++)
    for(int j = 0; j < lootList[0].length; j++)
      lootList[i][j] = new Loot(0,0,Key.NONE);
      
  //******************************************
  //Set up danger maps
  for(int i = 0; i < dangerStrs.length; i++)
  {
    mapStrings[i] = " ";
    dangerStrs[i] = "";
    for(int j = 0; j < 9999; j++)
      mapStrings[i]+=" ";
    for(int j = 0; j < 10000; j++)
      dangerStrs[i]+="0";
  }
        
  //******************************************
  //Set up save points
  for (int i = 0; i < savePoints.length; i++)
    savePoints[i]=new SavePoint();

  createFloor0();
  createFloor1();
  createFloor2();
  createFloor3();
  createFloor4();
  createFloor5();
  createFloor6();
  createTestRoom();
  
  //------------------------------------------
  //Activate danger maps
  for(int i = 0; i < dm.length; i++)
    dm[i] = new DangerMap(dangerStrs[i]);

  //------------------------------------------
  //Fill empty progressSwitches
  for(int i = 0; i < itemSwitches.length; i++)
    if(itemSwitches[i]==null)
      itemSwitches[i]=new ProgressSwitch();
}

void createFloor0()
{
  //Floor 0 - Cathedral/Forest/Dockyard
  
  //only floor that won't start with mapIndex++;

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  createLoot(lootIndex++, 0, 47, 8, Key.COPPER_KEY);
  createLoot(lootIndex++, mapIndex, 18, 53, Key.F);
  createLoot(lootIndex++, 0, 59, 14, new Equipment("Admirer's Chain","MetalMail.png",18,false,20,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST,Job.BARD) );
  //createLoot(lootIndex++, 0, 21, 29, new Equipment("Vestment","BlueShirt.png",3,false,7,true) );
  //createLoot(lootIndex++, 0, 22, 29, new Equipment("Vestment","BlueShirt.png",3,false,7,true) );
  createLoot(lootIndex++, 0, 1, 25, new Item("Golden Dice",19) );
  createLoot(lootIndex++, 0, 65, 29, new Item("Bread",10) );
  createLoot(lootIndex++, 0, 66, 29, new Item("Bread",10) );
  createLoot(lootIndex++, 0, 65, 33, new Item("Bread",10) );
  createLoot(lootIndex++, 0, 66, 33, new Item("Meat",20) );
  createLoot(lootIndex++, 0, 79, 29, new Item("Health Potion",12) );
  createLoot(lootIndex++, 0, 80, 29, new Item("Mana Potion",24) );
  //createLoot(lootIndex++, 0, 94, 41, new Equipment("Chainmail","MetalMail.png",9,false,14,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST) );
  createLoot(lootIndex++, 0, 95, 41, new Equipment("Old Plate","RustyArmor.png",7,false,18,Job.KNIGHT,Job.PRIEST) );
  createLoot(lootIndex++, 0, 96, 41, new Equipment("Axe","MetalSpikedAxe.png",9,true,22,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.DRUID) );
  createLoot(lootIndex++, 0, 79, 45, Key.CHARIS_NOTES);
  createLoot(lootIndex++, 0, 20, 63, new Equipment("Hunter's Garb","GreenLeatherArmor.png",4,false,14,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.BARD,Job.PRIEST,Job.DRUID) );
  createLoot(lootIndex++, 0, 18, 70, new Item("Antique Coin",19) );
  createLoot(lootIndex++, 0, 37, 79, new Item("Mana Potion",24) );
  createLoot(lootIndex++, 0, 20, 84, new Equipment("Spidersilk","WhiteShirt.png",21,false,12,true) );
  
  //Mother Sunita
  m[0].tiles[49][3].placeOccupant( color(150, 250, 250), "She doesn't have time to talk to you." );
  //Cellar keeper
  m[0].tiles[3][12].placeOccupant( color(150, 150, 250), "- Ah, just who I wanted to see! Yes, I've been negligent and let vermin into the cellar again. You'll help me out, won't you? You're welcome to take the supplies. Mother Sunita will just sell them if you don't." );
  //Scribes
  m[0].tiles[75][17].placeOccupant( color(150, 150, 250), "He's asleep at his desk." );
  m[0].tiles[75][20].placeOccupant( color(150, 150, 250), "- I've been charged with writing Father Charis's obituary. What can I say that isn't already known?" );
  //in method below
  //in method below
  m[0].tiles[79][17].placeOccupant( color(150, 150, 250), "- Are those the morning bells? I've been working since last night." );
  m[0].tiles[79][20].placeOccupant( color(150, 150, 250), "- Could you bring me more ink? No, nevermind, you'd probably spill it." );
  //Garden/Cloyster
  m[0].tiles[15][16].placeOccupant( color(150, 150, 250), "- All the potions made in the Cathedral use herbs from my garden. When the sweet, minty draught saves your life one day, know that you live by the sweat of my brow and the dirt on my knees." );
  //in method below
  m[0].tiles[37][17].placeOccupant( color(150, 150, 250), "- About time we cleared the riffraff from this holy place. If only Brother Ken could be next. He was supposed to open the cloister this morning, but I expect he's sampling wine in the cellar again." );

  //People at the table
  m[0].tiles[79][8].placeOccupant( initiateColor, "- My repairs have been delayed. Try to ignore that horrible thing for a few more days." );
  //in method below
  //Help room initiates    (do status conditions in Waraka)
  m[0].tiles[27][29].placeOccupant( ritisuColor, "- We are honored to be given space in this house of Illamar. May our knowledge serve you." );
  //m[0].tiles[32][32].placeOccupant( lesserRitisuColor, "- Don't get excited. There's no treasure in these." );
  m[0].tiles[25][30].placeOccupant( lesserRitisu, "- There is balance to the elements. Fire opposes ice. Earth opposes wind. But common monsters fear the elements as well. Have you seen how rats flee from fire?" );
  m[0].tiles[29][30].placeOccupant( lesserRitisu, "- Combat is taxing. If you are knocked out, potions and healing magic will revive you, but not with full strength." );
  m[0].tiles[33][30].placeOccupant( lesserRitisu, "- Martial fighters gain power as they fight, power that manifests as fearsome techniques. More experienced fighters learn more skills and can utilize more energy." );
  m[0].tiles[21][33].placeOccupant( lesserRitisu, "- There are often many ways forward, and not all of them are obvious." );
  m[0].tiles[25][34].placeOccupant( lesserRitisu, "- Only one of these Legend Gems is genuine. Human artifice has been unable to re-create the Tears of Ritisu, though many have tried." );
  m[0].tiles[29][34].placeOccupant( lesserRitisu, "- Always tell your tales to the gems. You will learn from your past and your possible futures reflected in their clear facets." );
  //in method below
  m[0].tiles[8][36].placeOccupant( lesserRitisu, "- There are other ways to move. Try the number pad, if you have one. The 7 key will open doors, and the 9 will interact with stairs." );
  m[0].tiles[8][32].placeOccupant( lesserRitisu, "- When choosing a hero for the use of items, the target of skills, or equipment, (a)(s)(d) and (1)(2)(3) work the same. This is also true when targeting monsters." );
  //in method below
  //in method below
  //Chilxius
  m[0].tiles[1][24].placeOccupant( color(0,200), "- Well done. You'll go far in this world. Look at your feet for a small reward. I will follow your progress, so seek me out in the future." );
  m[0].tiles[67][30].placeOccupant( color(150, 150, 250), "- Imagine my kitchen without the sound of you three sneaking in during the night, and thinking I never heard you. Take as much as you can carry, my children. You may find more skilled chefs out there in the world, but no one else's bread will taste like home." );
  m[0].tiles[70][31].placeOccupant( color(255,0), "- Sorry, I'm busy." );
  m[0].tiles[71][31].placeOccupant( color(150, 150, 200), "- Unused text." );
  m[0].tiles[68][33].placeOccupant( color(150, 150, 200), "- Bread fresh from the oven is heavenly, but one cannot subsist solely on grains. Adding a scrap of meat or slice of fruit can make it a meal. With a frugal attitude, you can improve your recovery for every type of food you have." );
  //m[0].tiles[68][29].placeOccupant( color(150, 150, 200), "- Explain synergy better." );
  //in method below
  m[0].tiles[83][29].placeOccupant( color(150, 150, 200), "- Basic health potions restore half of your vitality when consumed and, in my opinion, taste the best. Mana potions restore not only magical power, but a little health as well. Vapor potions are unstable and become a mist when exposed to the air. Elixirs are the pinacle of alchemy. I tasted one during my apprenticeship. I felt reborn." );
  m[0].tiles[92][41].placeOccupant( color(190, 170, 130), "A training dummy." );
  m[0].tiles[92][43].placeOccupant( color(190, 170, 130), "A training dummy." );
  //in method below
  m[0].tiles[96][43].placeOccupant( color(150, 150, 250), "- The light of Illamar shines equally upon all people until the day they are ferried through the Veil. Weapons of war serve only to busy the Black Vanguard. If you cannot justify your use of a blade before the gods, best to turn it upon yourself. Take what you need and go in peace." );
  //in method below
  //in method below
  m[0].tiles[93][43].placeOccupant( color(160, 160, 160), "He's busy training." );
  m[0].tiles[93][45].placeOccupant( color(160, 160, 160), "She's busy training." );
  m[0].tiles[52][51].placeOccupant( color(150, 150, 250), "- I've been tasked with cleaning out Father Charis's study. Yes, he was a good man, but Mother Sunita will prove to be a wiser leader." );
  m[0].tiles[49][59].placeOccupant( color(150, 150, 250), "- Could you help me? These people have gone mad." );
  //Upper garrison
  m[0].tiles[48][60].placeOccupant( color(160, 160, 160), "- Maybe it was a bad idea to leave our doors open to the public..." );
  m[0].tiles[51][60].placeOccupant( color(160, 160, 160), "- I'm sworn to protect the cathedral. But these people need help too." );
  //Townspeople
  m[0].tiles[49][60].placeOccupant( color(165,150,50), "- Where is Father Charis? I demand to speak to him!" );
  m[0].tiles[50][61].placeOccupant( color(150,50,165), "- Those abominations rise each night! We cannot live this way!" );
  m[0].tiles[56][63].placeOccupant( color(250,230,0), "- I just wanted to see the windows. The play of colors in the morning light takes my mind away. I don't have to be afraid of anything." );
  m[0].tiles[48][62].placeOccupant( color(165,150,50), "- One of those things was wearing my grandfather's ring. It can't be..." );
  m[0].tiles[51][63].placeOccupant( color(165,150,50), "- Let me join the garrison! I'll get something done around here." );
  m[0].tiles[52][64].placeOccupant( color(230,150,250), "- Father Charis will protect us. I know he will." );
  m[0].tiles[46][64].placeOccupant( color(150,50,165), "- How can they move with no flesh or muscle? It is a blasphemy against Am-asma. Please, do something!" );
  m[0].tiles[49][65].placeOccupant( color(150,50,165), "- At least let us take shelter in the cathedral." );
  m[0].tiles[54][71].placeOccupant( color(230,150,250), "The girl sits against the wall, staring ahead with bloodshot eyes." );
  //Lower garrison
  m[0].tiles[48][66].placeOccupant( color(160, 160, 160), "- Go home, Rask. You can tell the mayor that help is coming." );
  m[0].tiles[51][66].placeOccupant( color(160, 160, 160), "- It's so tragic. What was all my training for if not this?" );
  //in method below - Rask
  m[0].tiles[62][72].placeOccupant( color(150, 150, 250), "- Once you leave, you cannot return. Farewell, and may the light of Illamar shine upon you always." );
  //Outside
  m[0].tiles[29][53].placeOccupant( color(160, 160, 160), "- Please help these people if you can. I'm constrained by my orders." );
  m[0].tiles[31][53].placeOccupant( color(160, 160, 160), "- I've seen this before. Crowds gather in such numbers that the wagons cannot get through. Hysteria breeds hysteria." );
  //in method below
  m[0].tiles[31][56].placeOccupant( color(150,50,165), "- Let me talk to the exarchs. They'll listen to me." );
  m[0].tiles[29][56].placeOccupant( color(165,150,50), "- Are you with the garrison?" );
  m[0].tiles[32][57].placeOccupant( color(165,150,50), "- Someone needs to take the children back to town." );
  m[0].tiles[30][60].placeOccupant( color(230,150,250), "- Unused text." );
  m[0].tiles[32][61].placeOccupant( color(250,230,0), "- Unused text." );
  m[0].tiles[29][61].placeOccupant( color(150,50,165), "- Unused text." );
  m[0].tiles[31][63].placeOccupant( color(150,50,165), "- Unused text." );
  //Roadblock
  m[0].tiles[29][58].placeOccupant( color(250,230,0), "- Maybe we can stay safe by hiding the the woods?" );
  m[0].tiles[30][58].placeOccupant( color(150,50,165), "- Master Rask says there are venomous spiders in the woods. It's not safe there either." );
  m[0].tiles[31][59].placeOccupant( color(250,230,0), "- I don't care how brave you are. The man-wolf will eat you!" );
  m[0].tiles[32][59].placeOccupant( color(230,150,250), "- No, I know his weakness. I'll just hit him with my torch." );
  //Initiate chasing rats
  m[0].tiles[27][55].placeOccupant( color(150, 150, 200), "- Have you seen Kat? She was supposed to be in the laboratory an hour ago." );
  //Kat
  //in method below
  //Ghosts
  m[0].tiles[94][60].placeOccupant( color(200,150), "- Can you feel it? His fell influence is gone! Well done, mortal children." );
  m[0].tiles[90][58].placeOccupant( color(200,150), "- There is a cabin up ahead. Rest there." );
  //in method below
  m[0].tiles[78][61].placeOccupant( color(200,150), "- Even nature is free from the grip of death. Life will soon bloom anew." );
  m[0].tiles[97][75].placeOccupant( color(200,150), "- Unused text." );
  m[0].tiles[82][72].placeOccupant( color(200,150), "- Unused text." );
  m[0].tiles[91][71].placeOccupant( color(200,150), "- Unused text." );
  m[0].tiles[87][79].placeOccupant( color(200,150), "- Unused text." );
  //Dockyard
  m[0].tiles[70][87].placeOccupant( garrison, "- There were costs, but the mission was successful." );
  //in method below
  m[0].tiles[71][86].placeOccupant( color(mYoung), "- Unused text." );
  m[0].tiles[70][84].placeOccupant( color(mYoung), "- Unused text." );
  m[0].tiles[68][82].placeOccupant( color(mYoung), "- Unused text." );
  m[0].tiles[70][81].placeOccupant( color(fYoung), "- Unused text." );
  m[0].tiles[61][94].placeOccupant( color(clericColor), "- Am-asma is the patron of Waraka. If you appear before their queen, present the vessel Am-asma gave you with good posture." );
  m[0].tiles[62][93].placeOccupant( color(255,75), "- Unused text." );
  m[0].tiles[62][95].createEvent(false, "- Good, I was hoping to speak before your departure. Brother Ivo discovered Father Charis's death to be caused by a toxin in the blood."+
                                        " There was a man named Sirak who was born in Irohill. He and Father Charis argued often, and they continued to argue by missives once he left for Waraka."+
                                        " He commands a secretive peacekeeping force. Poisoning is not beneath them. When you arrive in Waraka, investigate him. But be careful.");
  m[0].tiles[62][94].placeOccupant( color(sunitaColor), "- Illamar light your path.");
  m[0].tiles[63][94].placeOccupant( color(clericColor), "- Mother Sunita requires an audience." );
  m[0].tiles[71][85].placeOccupant( garrison, "- Unused text." );
  m[0].tiles[68][83].placeOccupant( garrison, "- Unused text." );
  m[0].tiles[78][90].placeOccupant( color(raskColor), "- You did it! Illamar works through you, friends. Did you discover the cause? Strange messages with Waraka's seal? I'll recover the documents and investigate the symbols. Now that the docks are secure again, we are sending ships across the sea. I'll pay your way to Waraka if you want to go." );
  m[0].tiles[80][91].placeOccupant( color(male), "- They stopped moving, all at once." );
  m[0].tiles[77][92].placeOccupant( color(male), "- The land seems more vibrant this morning." );
  m[0].tiles[76][92].placeOccupant( color(female), "- Please, let me buy you a drink." );
  m[0].tiles[87][96].placeOccupant( color(male), "- Monsters are gone. Back to tending the farm." );
  m[0].tiles[87][89].placeOccupant( color(fYoung), "- AH! Bone monsters! Run!" );
  m[0].tiles[86][90].placeOccupant( color(fYoung), "- Where did you come from? Don't scare my sister like that." );
  m[0].tiles[78][95].placeOccupant( color(male), "- My father built this house. I suppose he would tell me to be thankful to be alive." );
  //In method below
  //In method below
  m[0].tiles[53][90].placeOccupant( color(sailor), "- We're ready to sail. Come aboard as soon as you're ready." );
  m[0].tiles[55][98].placeOccupant( lesserRitisu, "- A new one! None know where the Tears of Ritisu will fall." );
  m[0].tiles[57][92].placeOccupant( color(male), "- Aren't there pirates on the sea?" );
  m[0].tiles[56][92].placeOccupant( color(female), "- Don't be afraid. Sea monsters ate all the pirates years ago." );
  m[0].tiles[51][95].placeOccupant( color(sailor), "He's busy moving cargo." );
  //Boat
  m[0].tiles[50][85].placeOccupant( color(sailor), "NO TEXT." );
  m[0].tiles[46][85].placeOccupant( color(sailor), "NO TEXT." );
  
  //To the dormitory
  exits.add( new Portal(0,9,10,1,94,6, "Dormitory") );
  //To west cellar
  exits.add( new Portal(0,4,10,1,81,1, "The West Cellar") );
  //To/from help room
  exits.add( new Portal(0,42,28,0,27,32, "Shrine of Ritisu") );
  exits.add( new Portal(0,27,32,0,42,28) );
  //To/from kitchen
  exits.add( new Portal(0,57,28,0,65,31, "Kitchen") );
  exits.add( new Portal(0,65,31,0,57,28) );
  //To/from lab
  exits.add( new Portal(0,57,40,0,79,31, "Laboratory") );
  exits.add( new Portal(0,79,31,0,57,40) );
  //To/from armory
  exits.add( new Portal(0,42,40,0,98,43, "Armory") );
  exits.add( new Portal(0,98,43,0,42,40) );
  //Father Charis's study
  exits.add( new Portal(0,57,49,0,68,45, "Father Charis's Study") );
  exits.add( new Portal(0,68,45,0,57,49) );
  //Exit the cathedral
  exits.add( new Portal(0,63,73,0,30,52, "Irohill Forest") );
  //To well tunnel
  exits.add( new Portal(0,36,94,1,33,13, "Cenote") );
  
  //Cabin
  //exits.add( new Portal(0,79,60,0,96,26) );
  exits.add( new Portal(0,79,60,1,1,90) );
  //exits.add( new Portal(0,96,26,0,90,75, "Irohill") );
  exits.add( new Portal(1,1,90,0,90,75, "Irohill") );
  
  //Board Ship
  exits.add( new Portal(0,49,89,3,23,13, "The Barracuda Queen") );
  
  //Giant rat blocking camp
  m[0].tiles[1][53].placeBoss( 0, color(255,0), "There was one in the tent.", new Monster("Escaped Rat", "BrownRat.png", 20, 9, 15, 2, 0, 2, 4, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false, "T");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false, "T");
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false, "T");
      zoo.boss[bossIndex].attacks[4] = new Attack("bites and claws.", 40, false, "S");
  bossIndex++;
  
  //Giant rat blocking woods
  m[0].tiles[7][54].placeBoss( 0, color(150, 80, 40), "One of the big ones escaped.", new Monster("Escaped Rat", "BrownRat.png", 20, 11, 15, 2, 0, 2, 4, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks angrily.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false, "T");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false, "T");
      zoo.boss[bossIndex].attacks[3] = new Attack("bites and claws.", 40, false, "S");
      zoo.boss[bossIndex].attacks[4] = new Attack("swipes with its tail.", 30, true, "S");
  bossIndex++;
  
  //Spiders blocking chest
  m[0].tiles[36][79].placeBoss( 0, color(255, 175), "Hungry jaws surround you.", new Monster("Red Spider", "RedSpider.png", 10, 5, 10, 3, 0, 3, 5, 0, AttackType.NONE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("scurries forward.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites your arm.", 30, false, Debuff.POISON, "T");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites your leg.", 35, false, Debuff.POISON, "T");
      zoo.boss[bossIndex].attacks[3] = new Attack("bites your neck.", 45, false, Debuff.POISON, "T");
      zoo.boss[bossIndex].attacks[4] = new Attack("bites your hand.", 25, false, Debuff.POISON, "T");
  bossIndex++;
  
  //Spiders blocking save point
  m[0].tiles[3][94].placeBoss( 0, color(255, 175), "They're attracted to the Legend Gem.", new Monster("Red Spider", "RedSpider.png", 10, 5, 10, 3, 0, 3, 5, 0, AttackType.NONE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("scurries forward.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites your arm.", 30, false, Debuff.POISON, "T");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites your leg.", 35, false, Debuff.POISON, "T");
      zoo.boss[bossIndex].attacks[3] = new Attack("bites your neck.", 45, false, Debuff.POISON, "T");
      zoo.boss[bossIndex].attacks[4] = new Attack("bites your hand.", 25, false, Debuff.POISON, "T");
  bossIndex++;
  
  //The man-wolf
  m[0].tiles[20][93].placeBoss( 0, color(58,39,30), "It walks like a man.", new Monster("Man-wolf", "BrownWerewolf.png", 50, 20, 20, 3, 0, 5, 40, 0, AttackType.FIRE), false );
      zoo.boss[bossIndex].attacks[0] = new Attack("howls!");
      zoo.boss[bossIndex].attacks[1] = new Attack("claws.", 40, false, "S");
      zoo.boss[bossIndex].attacks[2] = new Attack("rends and claws!", 40, true, "S");
      zoo.boss[bossIndex].attacks[3] = new Attack("rends.", 40, false, "S");
      zoo.boss[bossIndex].attacks[4] = new Attack("bites!", 50, false, "T");
  bossIndex++;
  
  m[0].tiles[47][8].createEvent(false, "- Mother Sunita clasps her hands and straightens her posture."+
  " \"Illamar's light be upon you. Five hours and one minute ago, Father Charis succumbed to his weak heart and now serves from the other side of the Veil."+
  " I am honored to serve in his stead. Sadly, though he pledged to pass on his unique gift, neither I nor the other exarchs seemed to have received it."+
  " This is an ill omen, and coupled with the reports from Baron's Field, changes must be made. Lay persons will no longer be housed in the Cathedral."+
  " Loath as I am to undo one of Charis's beloved projects, the safety of the eparchy is our duty, and we must ration our resources. Children, you will find a key on the table before you."+
  " Take as much food as you need from the kitchens on your way out. The people of Irohill will surely receive you.\"");
  m[0].tiles[47][27].createEvent(true, "- Shrine of Ritisu");
  m[0].tiles[52][27].createEvent(true, "- Kitchen");
  m[0].tiles[47][39].createEvent(true, "- Armory");
  m[0].tiles[52][39].createEvent(true, "- Laboratory");
  m[0].tiles[52][39].createEvent(true, "- Laboratory");
  m[0].tiles[85][33].createEvent(false, " -The walls are still blackened from Sister Kat's latest experiment.");
  m[0].tiles[67][42].createEvent(false, "- Impressions from your and Charis's knees remain in the soil.");
  m[0].tiles[69][42].createEvent(false, "- The sharp medicinal scent of herbs has already begun to fade.");
  m[0].tiles[72][44].createEvent(false, "- You would hide among these old robes when playing games as children. Charis always pretended not to see you.");
  m[0].tiles[73][42].createEvent(false, "- Tucked between his holy scriptures are illustrated fairy tales.");
  m[0].tiles[77][43].createEvent(false, "- You can almost hear the familiar scratching of his quill.");
  //m[0].tiles[68][44].createEvent(false, "- In the waning days of his life, Father Charis's study went largely unused. You still remember days passed, when the smell of ink and herbs would mix with the sound of water and a scratching quill. How could this place be so empty when he was alive only yesterday?");
  m[0].tiles[75][44].createEvent(false, "- Charis had no more worldly possessions than any other cleric. Why did he have an extra closet?");
  m[0].tiles[4][63].createEvent(false, "- Weather and time have effaced the inscription.");
  m[0].tiles[34][79].createEvent(false, "- There is a giant web across the path.");
  m[0].tiles[13][93].createEvent(false, "- Something snaps under your foot. A bone. There are gnawed remains all around the trees near the bridge.");
  
  //Save points
  savePoints[savePointIndex++] = new SavePoint(0, 19, 9, 1); //near west cellar
  savePoints[savePointIndex++] = new SavePoint(0, 30, 35, 6); //shrine of Ritisu
  savePoints[savePointIndex++] = new SavePoint(0, 3, 46, 3); //forest north
  savePoints[savePointIndex++] = new SavePoint(0, 1, 94, 3); //forest south
  savePoints[savePointIndex++] = new SavePoint(0, 54, 98, 4); //Irohill dock

  //Danger map 0
  dangerMapIndex = 0; dangerStrs[dangerMapIndex] = "";

  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createFloor1()
{
  //--------------------------------------------------------------------------------------------------------------------\\
  //Floor 1 - Cellars/Houses/Caves/Etc.

  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  createLoot(lootIndex++, 1, 3, 4, Key.COPPER_KEY);
  createLoot(lootIndex++, 1, 1, 2, new Equipment("Brocade","YellowShirt.png",5,false,5,true));
  createLoot(lootIndex++, 1, 54, 1, new Equipment("Ivory Knife","IceDagger2.png",15,true,15,true));
  createLoot(lootIndex++, 1, 62, 1, new Equipment("Staff","Staff.png",2,true,14,Job.KNIGHT,Job.PRIEST,Job.DRUID,Job.MAGE));
  createLoot(lootIndex++, 1, 17, 21, Key.COPPER_KEY);
  createLoot(lootIndex++, 1, 79, 3, new Equipment("Vestment","BlueShirt.png",3,false,7,true));
  createLoot(lootIndex++, 1, 81, 5, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 83, 5, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 23, 17, new Item("Health Potion",12) );
  createLoot(lootIndex++, 1, 23, 19, new Equipment("Knife","MetalDagger2.png",4,true,12,true) );
  createLoot(lootIndex++, 1, 23, 21, new Item("Health Potion",12) );
  createLoot(lootIndex++, 1, 17, 17, new Equipment("Rusty Sword","CrimsonSword.png",6,true,20,Job.KNIGHT,Job.BARBARIAN,Job.BARD) );
  createLoot(lootIndex++, 1, 3, 18, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 4, 18, new Equipment("Old Leather","LeatherArmor.png",5,false,10,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.PRIEST) );
  createLoot(lootIndex++, 1, 5, 18, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 7, 15, Key.BRASS_KEY);
  createLoot(lootIndex++, 1, 48, 16, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 49, 16, new Item("Meat",20) );
  createLoot(lootIndex++, 1, 66, 15, new Equipment("Ratfang","Ratfang.png",15,true,20.01,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );
  createLoot(lootIndex++, 1, 33, 30, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 66, 53, Key.CRYPT_KEY );
  createLoot(lootIndex++, 1, 67, 53, Key.CRYPT_KEY );
  createLoot(lootIndex++, 1, 1, 59, new Item("Mana Potion", 24) );
  createLoot(lootIndex++, 1, 30, 41, Key.DRAGON );
  createLoot(lootIndex++, 1, 29, 41, new Item("Gold-Bound Book", 19) );
  createLoot(lootIndex++, 1, 83, 26, new Item("Pretend Cake", 10) );
  createLoot(lootIndex++, 1, 52, 50, Key.GATE );
  createLoot(lootIndex++, 1, 36, 50, Key.GATE );
  createLoot(lootIndex++, 1, 28, 50, Key.DRAGON );
  createLoot(lootIndex++, 1, 28, 51, new Item("Ivory Skull", 23) );
  createLoot(lootIndex++, 1, 51, 82, new Item("Fruit", 30) );
  createLoot(lootIndex++, 1, 80, 93, new Item("Bread", 10) );
  createLoot(lootIndex++, 1, 81, 93, new Item("Bread", 10) );
  createLoot(lootIndex++, 1, 81, 92, new Item("Bread", 10) );
  createLoot(lootIndex++, 1, 82, 95, new Item("Meat", 20) );
  createLoot(lootIndex++, 1, 83, 96, new Item("Bread", 10) );
  createLoot(lootIndex++, 1, 77, 95, new Item("Bread", 10) );
  createLoot(lootIndex++, 1, 77, 94, new Item("Health Potion", 12) );
  
  //Crypts
  createLoot(lootIndex++, 1, 76, 63, new Equipment("Alar's Axe","MetalAxe.png",25,true,27,Job.KNIGHT,Job.BARBARIAN) );
  createLoot(lootIndex++, 1, 76, 73, new Equipment("Lion's Hide","fur.png",25,false,25,Job.BARBARIAN,Job.DRUID) );
  createLoot(lootIndex++, 1, 76, 83, new Equipment("Purifier","StoneClub.png",25,true,27.5,Job.KNIGHT,Job.PRIEST) );
  createLoot(lootIndex++, 1, 98, 63, new Equipment("Cold Iron Plate","DarkArmor.png",25,false,28,Job.KNIGHT, Job.PRIEST) );
  createLoot(lootIndex++, 1, 98, 73, new Equipment("Scholar's Robe","aquaRobes.png",25,false,18, Job.KARATE, Job.BARD, Job.DRUID, Job.PRIEST, Job.MAGE) );
  createLoot(lootIndex++, 1, 98, 83, new Equipment("Flamecaster","Staff2.png",25,true,27.2,Job.DRUID,Job.MAGE) );
  
  //Boss Chamber
  createLoot(lootIndex++, 1, 37, 92 , new Equipment("Ritual Knife","curvedDagger.png",35,true,25.4,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );
  //createLoot(lootIndex++, 1, 38, 92 , new Equipment("Ritual Robes","darkRobes.png",29,false,20,true) );
  createLoot(lootIndex++, 1, 38, 92 , new Item("Gold Death Mask",32) );
  createLoot(lootIndex++, 1, 46, 92 , new Item("Mana Potion",12) );
  createLoot(lootIndex++, 1, 47, 92 , new Item("Health Potion",24) );
  
  m[1].tiles[2][2].createEvent(true, "- The (space) key can be used to open chests like this one. You also use this key to search your current square. See if you can find anything left behind in this room by careless initiates.");
  m[1].tiles[6][2].createEvent(true, "- This is a sacred Legend Gem. Gazing into it, you can feel your accomplishments being told around campfires centuries from now. Step on it and press capital (S) to activate it, and then press ENTER to confirm and save your progress.");
  m[1].tiles[6][4].createEvent(true, "- Some doors are locked. You can view your key ring by holding down the (k) key. By examining a door, you can determine what key is required. If you stand next to the door and press the (o) key, you will use the proper key if you possess it. Keys are fragile, and usually break after a single use.");
  m[1].tiles[2][7].createEvent(false, "- This stairwell will lead to a new room. To use it, stand on it and press the (>) key.");
  m[1].tiles[18][1].createEvent(false, "- Some of the clerics are busy cleaning the cellar. Walk into their space to speak with them.");
  m[1].tiles[35][3].createEvent(false, "- Sometimes, you can pass only one way across a threshold. This is one of those moments. Once you ascend these stairs, your story will truly begin. Good luck, young heroes.");
  m[1].tiles[97][5].createEvent(true, "- Press capital (R) on a bed to rest. Resting in a safe place will fully restore health and magic.");
  //m[1].tiles[97][5].createEvent(true, "- Press capital (X) on a bed to rest. Resting in a safe place will fully restore health and magic.");
  m[1].tiles[2][15].createEvent(false, "- Whatever that is, it's big. Make sure to (E)at if you feel weak.");
  m[1].tiles[6][15].createEvent(false, "- This hole was made recently.");
  m[1].tiles[94][97].createEvent(false, "- The disjoined spirits of Irohill stand in a ring around the old campsite.");
  
  //Boss Taunts
  m[1].tiles[56][97].createEvent(false, "- FEAR NOT THAT WHICH CAN DESTROY THE FLESH...");
  m[1].tiles[50][97].createEvent(false, "- NOR THAT WHICH CAN LAME THE SPIRIT...");
  m[1].tiles[44][97].createEvent(false, "- FEAR ME WHO CAN DO BOTH.");
  //Boss's Book
  m[1].tiles[42][91].createEvent(false, "- The book is written in a language of abstract pictograms. The only image you recognize is the Black Vanguard, but there are three of him. You have only ever seen him depicted alone. The cover is gilded with iron.");
  //Plot hook
  m[1].tiles[47][91].createEvent(false, "- There are messages here, written in that same inscrutable language. None of it is legible, but by putting the broken wax seals together you can make out the royal emblem of Waraka.");
  
  m[1].tiles[17][3].placeOccupant( color(75,100,255), "- Good morning, young ones. We made fresh bread this morning. To eat food you are carrying, press capital (E). You need peace and quiet to eat. Don't try to eat during a fight or it will ruin your digestion." );
  m[1].tiles[17][5].placeOccupant( color(75,100,255), "- I think we have some magical potions left in the western cellar. Those are quite useful as they can be consumed during combat. There are only four varieties of potion, though. Thanks, prohhibition. Press capital (D) to drink potions while in the field." );
  m[1].tiles[17][7].placeOccupant( color(75,100,255), "- When you are weary, seek out an inn or campsite. The people of Irid left many tents of sturdy and long-lasting leather across the land. Press capital (R) to rest at such a site." );
  m[1].tiles[23][3].placeOccupant( color(75,100,255), "- We have all we need here. However, if you some day leave, you may need to trade with vendors. Press capital (B) to bargain with them, but be wary of those who would cheat you." );
  m[1].tiles[23][5].placeOccupant( color(75,100,255), "- The Vendor's Guild is strict, and prohibits vedors from buying from you. Some will flaunt these rules and will give you gold for your unneeded treasures. Seek them out if you need coin." );
  m[1].tiles[23][7].placeOccupant( color(75,100,255), "- You were given a map of the Cathedral, yes? There is a helpful list of tips on the back of it. Hold the (h) key to view these tips whenever you need." );
  m[1].tiles[46][2].placeOccupant( color(75,100,255), "- Good morning, children. I'm sorry to tell you, but Father Charis crossed the Veil last night. He was a man of towering benevolence, though you know that better than anyone. Mother Sunita will be speaking on his behaf during morning meal." );
  m[1].tiles[46][4].placeOccupant( color(75,100,255), "- I wish Father Charis hadn't taken in so many orphans. You three made so much noise playing games and looking for secret rooms that I could barely focus on my gardening." );
  m[1].tiles[93][5].placeOccupant( color(75,100,255), "- Oh, good morning, children. I've just finished cleaning the dormitory. If you need to rest, there will be fresh sheets waiting for you here." );
  m[1].tiles[70][1].placeOccupant( color(75,100,255), "- Unholy vermin! I've dealt with pests before, but some of the rats down there have been gorged on magical potions and become enormous! You pick enough fights with the initiates. Why don't you fight something that deserves it for once?" );
  //Kat
  //in method below
  
  //Temple of Ritisu
  m[1].tiles[97][14].placeOccupant( color(31,153,226), "- Welcome to the temple of Ritisu. Gaze into the Gem and share your experience and knowledge. In return, we will share our knowledge with you." );
  m[1].tiles[98][15].placeOccupant( lesserRitisu, "- One needs not a strong body to endure elemental magic, but a strong will. A mage might endure a bolt of lightning that would cow the strongest warrior." );
  m[1].tiles[94][16].placeOccupant( lesserRitisu, "- Not all elemental skills draw from magical energy. Some are powered by strength or swiftness. Learn how your abilities affect different foes." );
  
  //Food Shop
  m[1].tiles[83][13].placeOccupant( color(165,150,50), "- My friends and neighbors are cowering in their homes. How can I charge them for food at such a time? Because of my generocity, all I have left is bread." );
  m[1].tiles[83][14].placeShop( new Item( "Bread",10 ), 12 );
  //m[1].tiles[83][14].createEvent(true, "Finest Bread: 15 Gold");
  m[1].tiles[86][14].placeOccupant( color(150,50,165), "- Don't listen to what he says. It was those giant rats that ate all our stock." );
  
  //Equipment Shop
  m[1].tiles[92][24].placeOccupant( color(165,150,50), "- A solid and heavy club is all it takes to bring down one of them. But there's never just one." );
  m[1].tiles[92][25].placeShop( new Equipment( "Club","OldClub.png", 7, true, 21, Job.KNIGHT, Job.BARBARIAN, Job.SAURIAN, Job.THIEF, Job.DRUID, Job.PRIEST ), 15 );
 // m[1].tiles[92][25].createEvent(true, "Club: 12 Gold  17 Power");
  m[1].tiles[93][24].placeOccupant( color(165,150,50), "- If you don't have a solid dagger at your side, you are not prepared." );
  m[1].tiles[93][25].placeShop( new Equipment( "Dagger","MetalDagger2.png", 5, true, 12, true ), 10 );
  //m[1].tiles[93][25].createEvent(true, "Dagger: 10 Gold  13 Power");
  m[1].tiles[96][24].placeOccupant( color(150,50,165), "- I have a few sets of iron plate left. They should protect you from those things." );
  m[1].tiles[96][25].placeShop( new Equipment( "Iron Plate","MetalArmor.png", 15, false, 24, Job.KNIGHT, Job.PRIEST ), 30 );
  //m[1].tiles[96][25].createEvent(true, "Iron Plate: 30 Gold  24 Defense");
  m[1].tiles[97][24].placeOccupant( color(150,50,165), "- Sorry, but we're all out of leather goods." );
  m[1].tiles[97][25].createEvent(true, "SOLD OUT");
  
  //Irohill Inn
  m[1].tiles[11][29].placeOccupant( color(165,150,50), "- You're here to help us, I guess. Half a pint each, on the house. But no more. Drunk adventurers become sober corpses." );
  m[1].tiles[6][31].placeOccupant( color(165,150,50), "- Welcome! Our hearths are warm and our walls are strong. You're safe from the monsters here." );
  m[1].tiles[10][31].placeOccupant( color(150,50,165), "- It took them ages to break through the wall of my home. But they scratched and scrached and, by inches, they did." );
  m[1].tiles[12][31].placeOccupant( color(165,150,50), "- We have time to drink and enjoy life. Another round." );
  m[1].tiles[5][29].placeOccupant( color(#FFB443), "- *Meow*" );
  
  //Houses
  m[1].tiles[32][29].placeOccupant( color(150,50,165), "- Ah! Visitors! I installed a windowed door to let guests know that they are welcome. Stay a while and chat! Help yourself to a snack as well." );
  m[1].tiles[21][29].placeOccupant( color(230,150,250), "- Papa locked the gate to Baron's Field to keep the monsters inside." );
  m[1].tiles[22][29].placeOccupant( color(250,230,0), "- Mama used to work in the library. I had so much fun climbing through the bookshelves." );
  m[1].tiles[23][29].placeOccupant( color(250,230,0), "- Papa keeps important things in his werehouse." );
  
  //Garrison
  //in method below
  m[1].tiles[1][41].placeOccupant( garrison, "- I remember when I stood in this line." );
  m[1].tiles[7][41].placeOccupant( garrison, "- Too young. They're too young. I taught these children to read and catch fish." );
  m[1].tiles[1][43].placeOccupant( color(mYoung), "- UNUSED TEXT" );
  m[1].tiles[1][44].placeOccupant( color(mYoung), "- It's mostly just guard duty, right?" );
  m[1].tiles[2][43].placeOccupant( color(mYoung), "- My father ordered me to sign up. I'll make him proud." );
  m[1].tiles[7][43].placeOccupant( color(mYoung), "He's staring at the floor." );
  //in method below
  
  //Town Hall 1
  //Guards
  m[1].tiles[86][49].placeOccupant( garrison, " - Please stay in line!" );
  m[1].tiles[97][49].placeOccupant( garrison, " - You're Rask's friends? Go on up, but try not to let anyone see you." );
  //Secretary
  m[1].tiles[92][49].placeOccupant( color(male), " - Thank you for forming such an orderly line. The mayor is happy to hear your complaints. He definitely does not have anything better to do." );
  //Line
  m[1].tiles[85][50].placeOccupant( color(male), " - My home is gone!" );
  m[1].tiles[85][51].placeOccupant( color(male), " - UNUSED TEXT." );
  m[1].tiles[86][51].placeOccupant( color(female), " - I won't sleep in the street while the mayor's family is safe and warm." );
  m[1].tiles[86][52].placeOccupant( color(female), " - I've been waiting since dawn." );
  m[1].tiles[86][53].placeOccupant( color(female), " - UNUSED TEXT." );
  m[1].tiles[87][53].placeOccupant( color(male), " - I'll fight. They can't conscript my son." );
  //Others
  m[1].tiles[96][52].placeOccupant( color(mYoung), " - Czar will keep me safe." );
  m[1].tiles[95][52].placeOccupant( color(125), " - *Woof*" );
  
  //Town Hall 2
  //Mayor
  m[1].tiles[71][53].placeOccupant( color(governor), " - Rask has faith in you. I will have faith in you as well. These keys have been gathering rust in the treasury for countless years. They will open the tombs of the honored dead. It is an indignity, but this evil magic is a far greater insult. Use what you find to save the living, but beware what may be within the tombs. Illamar guide you." );
  //Rask
  m[1].tiles[72][51].placeOccupant( color(raskColor), "- Good, you've arrived. We have the makings of a plan. Make your way into Baron's Field. Captain Rook will take the garrison to draw their attention. Your job will be to find the source of the curse, whether it be man or monster, and end it. Talk to the mayor for his contribution to your mission." );
  //Rook
  m[1].tiles[71][51].placeOccupant( garrison, "- My soldiers will be dying to open the way for you. Do not let us down." );
  //Secretary
  m[1].tiles[76][52].placeOccupant( female, "- The mayor is busy. Please be brief." );
  //Citizen
  m[1].tiles[66][49].placeOccupant( male, "- Hurry up. I was next in line.");
  
  //Hideout
  m[1].tiles[77][26].placeOccupant( mYoung, "- Are you really going into Baron's Field? Wow. You must be crazy. I want to be just like you some day." );
  m[1].tiles[80][24].placeOccupant( mYoung, "He says nothing while nervously extending his hand toward you. You grasp it affirmingly, and he stops shaking." );
  m[1].tiles[82][25].placeOccupant( fYoung, "- This is our pretend cake that we were saving for a special day. If you're going to chase away the bone men, then today is special. You have my permission to take it." );
  
  //Chilxius
  m[1].tiles[30][40].placeOccupant( chilxius, "- The loss of a good library is always tragic. Take your prizes and go. You made me lose my place." );
  m[1].tiles[28][52].placeOccupant( chilxius, "- One of our number was from Irohill. Never forget to respect the dead." );
  
  //Ghosts
  m[1].tiles[37][50].placeOccupant( ghostColor, "- Take this and find the tomb of the deGrace family. There is more within than bones. Beware those who aquire wealth with ease." );
  m[1].tiles[42][49].placeOccupant( ghostColor, "- Weariness. I remember it as disagreeable, but not the feel of it. Rest here. You are safe within these walls." );
  m[1].tiles[40][54].placeOccupant( ghostColor, "- I am, or was, Jon Mul. I was the first to be disjoined from flesh in Irohill. The meteor that struck the hill in ages past ended my mortal life, but I did not cross the Veil. I watched over Irohill instead, a silent observer as the cathedral and mausoleum were built and as infants became elders. Never have I cursed my lot more than now as hollow shells rise to trouble my home. Please, save Irohill. I will do all I can do and have ever done, and watch." );
  m[1].tiles[41][52].placeOccupant( ghostColor, "- Recently a light shone from the cathedral. It was like a spark of Illamar himself. The light swept through the catacombs and I heard a screech as one who denied death was pulled across the Veil. Your foe's spirit has gone. You need only destroy the lingering body." );
  m[1].tiles[36][54].placeOccupant( ghostColor, "- Why did my darling Sunita not inherit the gift? Shall we not speak again this side of the Veil?" );
  
  m[1].tiles[66][61].placeOccupant( ghostColor, "- Beux deGrace, at your service. The use of my family's tomb was his price for wealth and power. To be forever disjoined was not a part of the contract." );
  m[1].tiles[67][65].placeOccupant( ghostColor, "- Do you desire justice upon us for our role in this? My descendants and friends suffer. I hear their cries, but they are deaf to mine. No criminal court could do more to me." );
  m[1].tiles[48][74].placeOccupant( ghostColor, "- Could you please tell Mother Sunita that my tomb is leaking? Because I'm worried about the safety of the entire catacomb, of course." );
  m[1].tiles[12][71].placeOccupant( ghostColor, "- Our enemy stored his supplies in the cenotaph up ahead. It will do him no good now. Take it. Save Irohill." );
  
  //Circle of Ghosts
  m[1].tiles[93][96].placeOccupant( ghostColor, "- I have watched over Irohill for fifteen generations. I have watched you brave this cursed place. Now we shall watch and protect while you rest and prepare for the coming fight." );
  m[1].tiles[92][94].placeOccupant( ghostColor, "- He used my family. We may never expunge our sin, but let me do what I can." );
  m[1].tiles[93][92].placeOccupant( ghostColor, "- Until we can follow Charis through the Veil, you are our only link to the living world. Please stay alive." );
  //in method below
  m[1].tiles[96][94].placeOccupant( ghostColor, "- I do not know how his body continues to do evil without its spirit. Try to save his mangled remains for study." );
  m[1].tiles[95][96].placeOccupant( ghostColor, "- When you see my daughter, tell her that I am proud." );
  
  
  savePoints[savePointIndex++] = new SavePoint(1, 7, 2, 1); //Intro
  savePoints[savePointIndex++] = new SavePoint(1, 96, 14, 6); //Temple
  savePoints[savePointIndex++] = new SavePoint(1, 39, 49, 7); //Mausoleum
  
  //savePoints[savePointIndex++] = new SavePoint(1, 68, 61); //Temp save
  //savePoints[savePointIndex++] = new SavePoint(1, 12, 90); //Last save before boss
  
  //Start room - second room
  exits.add( new Portal(1,1,6,1,15,7) );
  exits.add( new Portal(1,15,7,1,1,6) );
  
  //second room - third room
  exits.add( new Portal(1,25,7,1,43,3) );
  exits.add( new Portal(1,43,3,1,25,7) );
  
  //To cathedral east
  exits.add( new Portal(1,35,1,0,96,12, "Irohill Cathedral") );
  
  //To cathedral west
  exits.add( new Portal(1,81,1,0,4,10, "Irohill Cathedral") );
  
  //West cellar upper to rat dungeon 1
  exits.add( new Portal(1,73,3,1,25,21) );
  exits.add( new Portal(1,25,21,1,73,3) );
  
  //Dormitory to Cathedral
  exits.add( new Portal(1,94,6,0,9,10, "Irohill Cathedral") );
  
  //Rat dungeon 1 and 2
  exits.add( new Portal(1,15,21,1,1,19) );
  exits.add( new Portal(1,1,19,1,15,21) );
  
  //Well cave to town
  exits.add( new Portal(1,93,35,2,49,23, "Irohill") );
  
  //Ritisu temple to town
  exits.add( new Portal(1,96,16,2,58,19, "Irohill") );
  
  //Inn to town
  exits.add( new Portal(1,7,33,2,70,20, "Irohill") );

  //from irohill equipment shop
  exits.add( new Portal(1,93,27,2,37,26) );
  exits.add( new Portal(1,96,27,2,40,26) );
  
  //from irohill food shop
  exits.add( new Portal(1,82,16,2,26,26) );
  exits.add( new Portal(1,84,16,2,29,26) );
  
  //Houses
  exits.add( new Portal(1,32,31,2,36,19) );
  exits.add( new Portal(1,22,31,2,16,19) );
  
  //Garrion
  exits.add( new Portal(1,4,45,2,57,12) );
  
  //Town Hall to town
  exits.add( new Portal(1,91,54,2,19,12) );
  exits.add( new Portal(1,92,54,2,20,12) );
  
  //Town Hall down to up
  exits.add( new Portal(1,85,49,1,66,49) );
  exits.add( new Portal(1,98,49,1,77,49) );
  //Town Hall up to down
  exits.add( new Portal(1,66,49,1,85,49) );
  exits.add( new Portal(1,77,49,1,98,49) );
  
  //Library
  exits.add( new Portal(1,9,60,2,80,27) );
  //Werehouse Exit
  exits.add( new Portal(1,57,57,2,83,20) );
  //Library Secret
  exits.add( new Portal(1,20,40,1,52,49,"?") );
  
  //Hideout
  exits.add( new Portal(1,77,24, 2,92,45,"Irohill") );
  
  //Grave to get inside graveyard
  exits.add( new Portal(1,12,98,2,43,58, "Baron's Field") );
  
  //Crypts to field
  exits.add( new Portal(1,83,63,2,16,80, "Baron's Field") );
  exits.add( new Portal(1,83,73,2,16,85, "Baron's Field") );
  exits.add( new Portal(1,83,83,2,16,90, "Baron's Field") );
  exits.add( new Portal(1,91,63,2,27,80, "Baron's Field") );
  exits.add( new Portal(1,91,73,2,27,85, "Baron's Field") );
  exits.add( new Portal(1,91,83,2,27,90, "Baron's Field") );
  
  //Mausoleum
  exits.add( new Portal(1,40,57,2,22,77, "Baron's Field") );
  exits.add( new Portal(1,39,57,2,21,77, "Baron's Field") );
  
  //To Cenotaph Field 1
  exits.add( new Portal(1,3,72,2,67,83, "Baron's Field") );
  //From Cenotaph 1
  exits.add( new Portal(1,80,98,2,67,81, "Baron's Field") );
  
  //To Cenotaph Field 2
  exits.add( new Portal(1,10,88,2,79,83, "Baron's Field") );
  //From Cenotaph 2
  exits.add( new Portal(1,94,98,2,79,81, "Baron's Field") );
  
  //To Final Stretch
  exits.add( new Portal(1,28,88,2,98,83, "Silent Path") );
  
  //To/from boss chamber
  exits.add( new Portal(1,65,89,1,69,97, "Catacombs") );
  exits.add( new Portal(1,69,96,1,65,89, "Catacombs") );
  
  //Boss chamber exits
  exits.add( new Portal(1,54,90,1,29,98) );
  exits.add( new Portal(1,29,98,1,54,90) );
  //2nd stair
  exits.add( new Portal(1,20,98,0,92,59) );
  
  //exits.add( new Portal(1,1,92,1,20,98) );
  
  //Dragon Grave
  exits.add( new Portal(1,28,48,2,40,59, "Baron's Field") );
  
  m[1].tiles[22][17].placeBoss( 1, color(150, 80, 40), "A large rat guards the way.", new Monster("Giant Rat", "BrownRat.png", 10, 5, 5, 1, 6, 1, 3, 0, AttackType.FIRE) );
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 25, false, "T");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false, "T");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 35, false, "T");
  bossIndex++;

  m[1].tiles[20][21].placeBoss( 1, color(150, 80, 40), "A large rat guards the way.", new Monster("Giant Rat", "BrownRat.png", 18, 6, 5, 1, 9, 1, 3, 0, AttackType.FIRE) );
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 27, false, "T");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 32, false, "T");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 37, false, "T");
  bossIndex++;

  m[1].tiles[18][19].placeBoss( 1, color(150, 80, 40), "A large rat guards the way.", new Monster("Giant Rat", "BrownRat.png", 26, 7, 5, 1, 9, 1, 4, 0, AttackType.FIRE) );
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 29, false, "T");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 34, false, "T");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 39, false, "T");
  bossIndex++;

  m[1].tiles[1][16].placeBoss( 1, color(150, 80, 40), "A swarm comes for you!", new Monster("Giant Rat", "BrownRat.png", 18, 5, 5, 1, 12, 1, 3, 0, AttackType.FIRE), true );
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 29, false, "T");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 34, false, "T");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 39, false, "T");
  bossIndex++;

  m[1].tiles[5][15].placeBoss( 1, color(200, 80, 40), "This must be their matriarch.", new Monster("Rat Queen", "RedRat.png", 35, 12, 5, 2, 24, 3, 5, 0, AttackType.NONE) );
    zoo.boss[bossIndex].attacks[0] = new Attack("eyes you hungrily.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 35, false, "T");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites and scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[3] = new Attack("whips her tail.", 35, false, "S");
    zoo.boss[bossIndex].attacks[4] = new Attack("summons her brood!", 30, true, "T");
  bossIndex++;

  m[1].tiles[62][18].placeBoss( 1, color(150, 80, 40), "Kat was right. They are getting bigger.", new Monster("Burning Rat", "fireRat.png", 45, 9, 10, 3, 9, 5, 7, 0, AttackType.ICE) );
    zoo.boss[bossIndex].attacks[0] = new Attack("bites.", 35, false, "T");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 35, false, "T");
    zoo.boss[bossIndex].attacks[2] = new Attack("coughs out fire.", 20, true, AttackStat.MAG, AttackType.FIRE, "F");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites with its glowing mouth.", 40, false, AttackStat.MAG, AttackType.FIRE, "T");
    zoo.boss[bossIndex].attacks[4] = new Attack("coughs up black smoke.");
  bossIndex++;
  
  m[1].tiles[4][55].placeBoss( 1, color(230), "Its empty eyes glow with malice.", new Monster("Skeleton", "Skeleton.png", 40, 9, 1, 2, 1, 3, 4, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("gouges with phalanges.", 45, false, "P");
    zoo.boss[bossIndex].attacks[3] = new Attack("gouges with phalanges.", 45, false, "P");
    zoo.boss[bossIndex].attacks[4] = new Attack("stabs with a rib.", 55, false, "P");
  bossIndex++;
  
  m[1].tiles[14][55].placeBoss( 1, color(230), "It is stained with ink and blood.", new Monster("Skeleton", "Skeleton.png", 40, 9, 1, 2, 1, 3, 5, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("slams with its radius.", 45, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("slams with its radius.", 45, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("hacks with its mandible.", 55, false, "B");
  bossIndex++;
  
  m[1].tiles[16][55].placeBoss( 1, color(230), "They've gathered in the darkness.", new Monster("Skeleton", "Skeleton.png", 35, 9, 1, 2, 1, 3, 6, 0, AttackType.HOLY),true );
    zoo.boss[bossIndex].attacks[0] = new Attack("tackles.", 40, false, "B");
    zoo.boss[bossIndex].attacks[1] = new Attack("swipes.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("throws a rib.", 45, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bashes with its skull.", 45, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("clubs with a femur!", 55, false, "B");
  bossIndex++;
  
  //Crypt Guardians
  m[1].tiles[78][63].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Alar", "Crypt1.png", 50, 13, 10, 7, 1, 3, 9, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("strikes with its knee.", 40, false, "B");
    zoo.boss[bossIndex].attacks[1] = new Attack("kicks.", 40, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("swings wide.", 40, true, "S");
    zoo.boss[bossIndex].attacks[3] = new Attack("swings its axe!", 60, false, "S");
    zoo.boss[bossIndex].attacks[4] = new Attack("swings its axe!", 60, false, "S");
  bossIndex++;
  m[1].tiles[78][73].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Corel", "Crypt6.png", 50, 13, 15, 7, 1, 3, 9, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("growls.");
    zoo.boss[bossIndex].attacks[1] = new Attack("swipes.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("lunges like a beast!", 60, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bashes with its jaw!", 60, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bashes with its club!", 60, false, "B");
  bossIndex++;
  m[1].tiles[78][83].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Ruath", "Crypt2.png", 50, 8, 10, 6, 8, 6, 9, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("intones muddled words.");
    zoo.boss[bossIndex].attacks[1] = new Attack("strikes with its hand.", 40, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("smites!", 60, false, AttackStat.STR, AttackType.HOLY, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("shines with holy light.", 30, true, AttackStat.MAG, AttackType.HOLY, "H");
    zoo.boss[bossIndex].attacks[4] = new Attack("swings its mace!", 60, false, "B");
  bossIndex++;
  m[1].tiles[96][63].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Zan", "Crypt3.png", 50, 9, 10, 10, 1, 4, 9, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("readies for your attack.");
    zoo.boss[bossIndex].attacks[1] = new Attack("attacks.", 45, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("strikes with the flat of its blade.", 50, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("stabs at you.", 55, false, "P");
    zoo.boss[bossIndex].attacks[4] = new Attack("swings its weapon!", 60, false, "S");
  bossIndex++;
  m[1].tiles[96][73].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Ivy", "Crypt4.png", 50, 2, 10, 2, 8, 9, 7, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("gazes silently.");
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its staff.", 45, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("levitates a tomb stone.", 50, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[3] = new Attack("speaks a secret word.", 55, false, AttackStat.MAG, AttackType.HOLY, "H" );
    zoo.boss[bossIndex].attacks[4] = new Attack("summons a storm of tomb dust!", 50, true, AttackStat.MAG, AttackType.WIND, "W" );
  bossIndex++;
  m[1].tiles[96][83].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Erar", "Crypt5.png", 50, 2, 10, 2, 9, 8, 7, 0, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("makes arcane gestures.");
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its staff.", 45, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("causes the crypt to shake!", 45, true, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[3] = new Attack("delivers an icy touch.", 50, false, AttackStat.MAG, AttackType.ICE, "I" );
    zoo.boss[bossIndex].attacks[4] = new Attack("conjures a ring of fire!", 55, true, AttackStat.MAG, AttackType.FIRE, "F" );
  bossIndex++;
  m[1].tiles[42][96].placeBoss( 1, color(77,20,20), "Malice smolders in its vacant eyes.", new Monster("Body of Necromancer", "Necro.png", 150, 20, 15, 6, 15, 10, 10, 50, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("stabs with a wicked knife.", 45, false, Debuff.POISON, "P");
    zoo.boss[bossIndex].attacks[1] = new Attack("exhales chilling air.", 40, true, AttackStat.MAG, AttackType.ICE, "I" );
    zoo.boss[bossIndex].attacks[2] = new Attack("drops stones to bury you!", 55, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[3] = new Attack("drops stones to bury you!", 55, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[4] = new Attack("causes your very bones to freeze!", 55, true, AttackStat.MAG, AttackType.ICE, "I" );
  bossIndex++;
  
  //Danger Map 1
  dangerMapIndex = 1; dangerStrs[dangerMapIndex] = "";

  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createFloor2()
{
  //---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 2 - Irohill
  
  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  savePoints[savePointIndex++] = new SavePoint(2, 98, 79, 5); //Last save before boss
  
  createLoot(lootIndex++, 2, 9, 95, new Item("Holy Symbol", 19) );
  //Gravekeeper hut
  createLoot(lootIndex++, 2, 96, 63, Key.CRYPT_KEY );
  createLoot(lootIndex++, 2, 95, 63, Key.GRAVE_NOTES );
  
  //Graveyard
  m[2].tiles[11][57].createEvent(false, "- An icy wind brushes your faces. It is the only sound within these walls.");
  m[2].tiles[44][58].createEvent(false, "- A figure stands in the courtyard, hazy like smoke and clear like glass.");
  m[2].tiles[45][58].createEvent(false, "- And he is not alone.");
  m[2].tiles[66][64].createEvent(false, "- Sounds of battle rise above the graveyard walls. The clash of metal, the scrape of bone, and screams.");
  //Pavel hut
  m[2].tiles[94][65].createEvent(false, "- You remember Father Pavel from your youth, the gravekeeper of Baron's Field. Back then his skin was healthy, and did not hang from his bones like a wet garment.");
  //Graves
  m[2].tiles[13][58].createEvent(false, "- Rest in peace");
  m[2].tiles[17][61].createEvent(false, "The inscription is worn away.");
  m[2].tiles[7][58].createEvent(false, "- Our beloved son, who proceeds us through the Veil.");
  m[2].tiles[3][61].createEvent(false, "- She shined like the sun from birth until the end.");
  m[2].tiles[5][64].createEvent(false, "- A rest well earned.");
  m[2].tiles[3][67].createEvent(false, "It is inscribed with Iridian runes.");
  m[2].tiles[11][67].createEvent(false, "- Your life was long, your memory will last forever.");
  m[2].tiles[24][67].createEvent(false, "- An unknown travler.");
  m[2].tiles[28][61].createEvent(false, "- A light to the community for fifty years.");
  m[2].tiles[26][58].createEvent(false, "The inscription is worn away.");
  m[2].tiles[30][58].createEvent(false, "- Our joy is buried with you.");
  m[2].tiles[34][61].createEvent(false, "- Claimed by the diseases he fought all his life.");
  m[2].tiles[36][67].createEvent(false, "- Born a slave, died a free man.");
  m[2].tiles[24][58].createEvent(true, "The stone has been scratched. Something recently disturbed the soil.");
  m[2].tiles[40][58].createEvent(true, "It bears a dragon symbol.");
  m[2].tiles[61][68].createEvent(true, "- Lord Rowan II.");
  m[2].tiles[73][68].createEvent(true, "- Lord and Lady Summer.");
  m[2].tiles[69][68].createEvent(true, "- Lord and Lady deGrace.");
  
  
  //Boy
  m[2].tiles[50][24].placeOccupant( color(250,230,0), "- Ma? Some strange people came out of the well." );
  //Buyer
  m[2].tiles[14][24].placeOccupant( color(10,10,50), "- Got anything you don't need? I won't buy perishable food, and I won't buy magic potions since those are too heavily regulated. But I can take anything else. You're lucky to find me here. With all the chaos, I don't have to hide as hard as my competitors do." );
  m[2].tiles[14][25].placeBuyer();
  
  //Road Guards
  m[2].tiles[48][5].placeOccupant( garrison, "- Mother Sunita has closed the Cathedral. The clerics are fasting." );
  m[2].tiles[49][5].placeOccupant( garrison, "- We have our orders. Sorry." );
  //Garrison
  m[2].tiles[58][10].placeOccupant( garrison, "- UNUSED TEXT." );
  m[2].tiles[56][10].placeOccupant( garrison, "- UNUSED TEXT." );
  m[2].tiles[63][9].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[63][11].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[63][13].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[64][9].placeOccupant( color(mYoung), "- This sword is heavier than it looked." );
  m[2].tiles[64][13].placeOccupant( color(fYoung), "- Our enemies aren't stuffed with straw. I've heard them rattle and seen their fleshless grins." );
  m[2].tiles[66][11].placeOccupant( garrison, "- Some will flee. Some will fall. Those who are left are soldiers." );
  m[2].tiles[69][9].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[69][11].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[69][13].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[68][11].placeOccupant( color(fYoung), "- You're trained for combat, right? Can you teach me some tricks? Anything to keep me alive?" );
  m[2].tiles[68][13].placeOccupant( color(mYoung), "- I'm ready now. Let's go. Let's destroy them." );
  //Old man
  m[2].tiles[75][8].placeOccupant( color(male), "- The signs have been clear for years. Life has grown weak around Irohill. Crops, animals, children. Charis and I were initiates together, so he had the sense to believe me. This won't be solved by building walls and equipping children. The cause is thaumaturgical. Find the source of these black arts and send him to the Black Vanguard." );
  //Player 3's friend
  //in method below
  
  //Extras
  m[2].tiles[39][28].placeOccupant( color(male), "- I could afford a weapon. But who would teach me to use it?" );
  m[2].tiles[7][8].placeOccupant( color(mYoung), "- You found me! I know the best hiding places. I had a secret reading corner in the library before the bone men came." );
  m[2].tiles[31][20].placeOccupant( color(female), "- Everyone's fighting and arguing. Day is becoming as stressful as the night. I'm sorry, you have enough to worry about." );
  m[2].tiles[45][13].placeOccupant( color(male), "- Where has she gone? She better not be playing by the river again." );
  
  //Kids at hideout
  //in method below
  m[2].tiles[93][45].placeOccupant( color(mYoung), "- I'm not afraid, but some of the others are. Would you mind going inside to talk to them? I'm sure the mud will wash off your fancy cathedral clothes. Eventually." );
  
  //People near graveyard
  m[2].tiles[18][48].placeOccupant( color(male), "- Many graves have been opened. Careful you don't fall in." );
  m[2].tiles[19][51].placeOccupant( color(female), "- We'll make sure none of them get out once you open that gate. Good luck." );
  
  //Ghosts
  m[2].tiles[47][62].placeOccupant( color(200,150), "- You can see me? Strange. I have appeared before you many times in the past." );
  m[2].tiles[51][62].placeOccupant( color(200,150), "- Charis used to visit to report on the world of the living. Now he has crossed the Veil without us? How dare he." );
  m[2].tiles[56][65].placeOccupant( color(200,150), "- These are the tombs of those wealthiest in life." );
  m[2].tiles[52][69].placeOccupant( color(200,150), "- Few have the gift of sight as Charis did. I expected it to pass to that young exarch. Lay children have never been able to see disjoined spirits." );
  
  //Pavel
  m[2].tiles[95][64].placeOccupant( color(#DCE65A), "- Charis and I acomplished much together in life, and after. It would horrify the exarchs to know our work allowed me to toil beyond death. I cannot leave, so I beg you take our work to Mother Veda, High Priestess of Ritisu. She resides in Mariva across the sea, working to solve what she calls the riddle of iron." );
  
  
  //Ritisu Temple
  exits.add( new Portal(2,58,19,1,96,16, "Temple of Ritisu") );
  
  //Irohill Inn
  exits.add( new Portal(2,70,20,1,7,33, "Irohill Inn") );
  
  //To equipment shop
  exits.add( new Portal(2,37,26,1,93,27) );
  exits.add( new Portal(2,40,26,1,96,27) );
  
  //To food shop
  exits.add( new Portal(2,26,26,1,82,16) );
  exits.add( new Portal(2,29,26,1,84,16) );
  
  //Houses
  exits.add( new Portal(2,36,19,1,32,31) );
  exits.add( new Portal(2,16,19,1,22,31) );
  
  //Garrion
  exits.add( new Portal(2,57,12,1,4,45, "Irohill Garrison") );
  
  //Town Hall
  exits.add( new Portal(2,19,12,1,91,54, "Irohill Town Hall") );
  exits.add( new Portal(2,20,12,1,92,54, "Irohill Town Hall") );
  
  //Library
  exits.add( new Portal(2,80,27,1,9,60, "Irohill Library") );
  
  //Hideout
  exits.add( new Portal(2,92,45,1,77,24, "Hideout") );
  
  //Mausoleum
  exits.add( new Portal(2,22,77,1,40,57, "Mausoleum") );
  exits.add( new Portal(2,21,77,1,39,57, "Mausoleum") );
  
  //Crypts
  exits.add( new Portal(2,16,80,1,83,63, "Tomb of Alar the Champion") );
  exits.add( new Portal(2,16,85,1,83,73, "Tomb of Corel the Beast") );
  exits.add( new Portal(2,16,90,1,83,83, "Tomb of Ruath the Pure") );
  exits.add( new Portal(2,27,80,1,91,63, "Tomb of Zan the Invincible") );
  exits.add( new Portal(2,27,85,1,91,73, "Tomb of Ivy the Wise") );
  exits.add( new Portal(2,27,90,1,91,83, "Tomb of Erar Thundercaller") );
  
  //Gravekeeper's hut
  exits.add( new Portal(2,96,92,2,94,66, "Gravekeeper's Hut") );
  exits.add( new Portal(2,94,66,2,96,92, "Baron's Field") );
  
  //Dragon Grave
  exits.add( new Portal(2,40,59,1,28,48, "?") );
  
  //Secret Grave to enter courtyard
  exits.add( new Portal(2,24,59,1,1,98, "?") );
  
  //Secret Grave (deGrace)
  exits.add( new Portal(2,69,69,1,67,62, "Mausoleum") );
  
  //From Cenotaph Field 1
  exits.add( new Portal(2,67,83,1,3,72, "Mausoleum") );
  //Cenotaph 1
  exits.add( new Portal(2,67,81,1,80,98, "Cenotaph") );
  
  //From Cenotaph Field 2
  exits.add( new Portal(2,79,83,1,10,88, "Mausoleum") );
  //Cenotaph 2
  exits.add( new Portal(2,79,81,1,94,98, "Cenotaph") );
  
  //Final Stretch
  exits.add( new Portal(2,98,83,1,28,88, "Mausoleum") );
  
  //To Boss
  exits.add( new Portal(2,90,79,1,65,85, "Catacombs") );
  
  m[2].tiles[90][79].createEvent(false, "- Moonlight illuminates a path beneath the colored glass.");
  
  m[2].tiles[93][79].placeBoss( 2, color(90,90,90), "They guard a hole in the monument.", new Monster("Skeletal Guardian", "DarkScimitarSkeleton.png", 50, 15, 5, 7, 0, 5, 9, 0, AttackType.HOLY), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("prepares for your attack.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its sword.", 45, false, "S");
      zoo.boss[bossIndex].attacks[2] = new Attack("swings wide!", 45, true, "S" );
      zoo.boss[bossIndex].attacks[3] = new Attack("bashes with the pommel.", 45, false, "B" );
      zoo.boss[bossIndex].attacks[4] = new Attack("lunges!", 55, false, "P" );
  bossIndex++;
  
  
  //Danger Map 2
  dangerMapIndex = 2; dangerStrs[dangerMapIndex] = "";

  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createFloor3()
{
//---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 3 - Boat (Irohill to Waraka)
  
  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  savePoints[savePointIndex++] = new SavePoint(3,45,56,6);
  
  createLoot(lootIndex++, 3, 7, 32, Key.IRON_KEY );
  createLoot(lootIndex++, 3, 3, 24, new Item("Doubloon", 9) );
  createLoot(lootIndex++, 3, 30, 25, new Item("Doubloon", 9) );
  createLoot(lootIndex++, 3, 29, 11, new Item("Doubloon", 9) );
  createLoot(lootIndex++, 3, 31, 74, new Item("Doubloon", 9) );
  createLoot(lootIndex++, 3, 67, 46, new Item("Doubloon", 9) );
  //Girl's hidden loot
  {
    int xRand = int(random(11)+1);
    int yRand = int(random(9)+1);
    if( (xRand%2==0 && yRand%2==0) || (xRand%2==1 &&yRand%2==1) ) yRand--;
    if(yRand==0) yRand = 9;
    //println(xRand + " " + yRand);
    
    createLoot(lootIndex++, 3, 51+xRand, 2+yRand, new Item("Doubloon", 9) );
  }
  //Wardroom
  createLoot(lootIndex++, 3, 2, 58, new Item("Bread", 10) );
  createLoot(lootIndex++, 3, 3, 58, new Item("Bread", 10) );
  createLoot(lootIndex++, 3, 4, 58, new Item("Bread", 10) );
  createLoot(lootIndex++, 3, 84, 40, new Item("Meat", 20) );
  //Kat's Chest
  createLoot(lootIndex++, 3, 5, 92, new Equipment("Rat's Pelt","darkFur.png",2,false,18,true) );
  createLoot(lootIndex++, 3, 2, 91, Key.CHEESE );
  createLoot(lootIndex++, 3, 55, 90, new Item("Vapor Potion", 36) );
  createLoot(lootIndex++, 3, 20, 71, new Equipment("Cutlass","cutlass.png",15,true,24,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.DRUID) );
  createLoot(lootIndex++, 3, 41, 96, new Item("Citrus", 30) );
  //Hold
  createLoot(lootIndex++, 3, 96, 56, new Item("Health Potion", 12) );
  createLoot(lootIndex++, 3, 96, 58, new Item("Mana Potion", 24) );
  createLoot(lootIndex++, 3, 53, 42, new Equipment("Uniform","uniform.png",28,false,22,Job.KNIGHT,Job.THIEF,Job.KARATE,Job.BARD,Job.PRIEST) );
  createLoot(lootIndex++, 3, 53, 44, new Equipment("Chain","chainWhip.png",11,true,22,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.DRUID,Job.PRIEST) );
  
  //Events
  m[mapIndex].tiles[8][90].createEvent(false, "- The room has the acrid scent of an alchemist's laboratory.");
  m[mapIndex].tiles[5][90].createEvent(false, "- You smell something else, something moldy and rich.");
  m[mapIndex].tiles[2][91].createEvent(true, "- The strange odor is coming from here.");
  
  //Captain
  m[mapIndex].tiles[17][27].placeOccupant( color(captain), "- Ahoy! My queen will treat you well, and ferry you safely across the sea. Breathe the salt air! Taste the winds of freedom!" );
  //Captain's daughter
  m[mapIndex].tiles[31][21].placeOccupant( color(fYoung), "- I'm not a child! I'm a mighty privateer! I'll be a famous captain some day, just like my daddy. I even hid some pirate gold. Bet you can't find it!" );
  //Cabin Boy
  m[mapIndex].tiles[4][54].placeOccupant( color(mYoung), "- Oh, h-hello sir, I mean ma'am, I mean, um... the captain is at the helm if you're looking for him. Please don't sleep in his bed. I just made it." );
  //Kat
    //in method below
  m[mapIndex].tiles[23][10].placeOccupant( color(sailor), "- The journey to Waraka will take a few days, assuming good weather. Your bunk is below decks. The Barracua Queen is strong and reliable, so you need not fear." );
  m[mapIndex].tiles[27][4].placeOccupant( color(sailor), "- Who locked the lower deck? We have cargo to stow!  " );
  m[mapIndex].tiles[13][26].placeOccupant( color(sailor), "- I'd get below decks soon, before the captain starts singing." );
  m[mapIndex].tiles[9][21].placeOccupant( color(sailor), "- What do we have 'ere? Lubbers still finding their sea legs. You don't know what's out here, do ye? Bet you never seen one of the monsters of Lost Star Isle. Well... neither have I. Do you know where they are?" );
  m[mapIndex].tiles[12][59].placeOccupant( color(sailor), "- There's food in the back. Help yourselves to as much as you can. I love watching landlubbers puke." );
  m[mapIndex].tiles[14][61].placeOccupant( color(sailor), "He's already passed out drunk." );
  m[mapIndex].tiles[40][21].placeOccupant( color(sailor), "- My guess is the pirates have retreated to plan something big." );
  m[mapIndex].tiles[41][21].placeOccupant( color(sailor), "- Nah, them villains got no patience." );
  m[mapIndex].tiles[47][25].placeOccupant( color(sailor), "- Cory is staring off at the horizion again. I think he might sleep there." );
  m[mapIndex].tiles[35][33].placeOccupant( color(sailor), "- I may be wrong, but are we listing to starboard? Someone must have loaded something heavy into the chain locker." );
  m[mapIndex].tiles[12][8].placeOccupant( color(sailor), "- No, I don't need help. Please stay out of my way." );
  m[mapIndex].tiles[13][11].placeOccupant( color(sailor), "- Thanks for offering, but I can handle this myself." );
  m[mapIndex].tiles[11][5].placeOccupant( color(sailor), "- Hardy sailors don't need help from the likes of ye. Go rest your soft muscles in your cabin." );
  m[mapIndex].tiles[8][5].placeOccupant( color(sailor), "- I actually could use some help, but I don't want the others to tease me. Thanks anyway." );
  m[mapIndex].tiles[42][6].placeOccupant( color(sailor), "- Crew quarters and chapel are through here." );
  //Cleric (in method below)
  //Officers' Cabins
  m[mapIndex].tiles[13][96].placeOccupant( color(sailor), "- NO TEXT." );
  m[mapIndex].tiles[15][97].placeOccupant( color(sailor), "- NO TEXT." );
  m[mapIndex].tiles[18][97].placeOccupant( color(sailor), "- NO TEXT." );
  m[mapIndex].tiles[11][97].placeOccupant( color(sailor), "- NO TEXT." );
  m[mapIndex].tiles[3][96].placeOccupant( color(sailor), "- NO TEXT." );
  
  //Cory
  m[mapIndex].tiles[51][27].placeOccupant( color(coryColor), "- My sister turned to piracy. Ever since the monsters emerged around Lost Star Isle, we stopped receiving her letters. That's why I sail. I haven't lost faith." );
  //Sailors in bunks
  m[mapIndex].tiles[29][61].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[33][62].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[38][60].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[39][60].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[33][51].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[32][51].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[28][52].placeOccupant( color(sailor), "NO TEXT." );
  //Ritisu priests
  m[mapIndex].tiles[43][56].placeOccupant( color(ritisuColor), "- Ever since my youth, I have seen naught but images of the wide blue sea in Ritisu's Tear. These shimmering waters are my past and my future." );
  m[mapIndex].tiles[46][57].placeOccupant( lesserRitisu, "- I see the ocean in the gem as well, though of late I sometimes notice strange and dark shapes in the water. It is not like Ritisu to veil knowledge." );
  m[mapIndex].tiles[35][56].placeOccupant( lesserRitisu, "- Oh, I'm not the chaplain. I'm the navigator. Our master directs the vessel during by day, while Illamar's thousand children guide her in the night." );
  m[mapIndex].tiles[40][57].placeOccupant( lesserRitisu, "- The Tears cannot be moved from where they land. This one forked a great oak when it fell, and that tree was used to build the forecastle." );
  //Sailor in your room
  m[mapIndex].tiles[16][90].placeOccupant( color(sailor), "- Oh, excuse me. I don't usually enter a paying passenger's room. I saw a giant rat and unbearable terror took over me. I don't care for rats of any size. Do exterminate them, won't you?" );
  //Galley
  m[mapIndex].tiles[43][93].placeOccupant( color(captain), "- It's been quiet out there. Are they done stowing already? Makes no difference to me. Supper will be ready on time, and it will be fish. Do you like fish? Because fish is what you'll be eating. Welcome to the sea, landlegs." );
  m[mapIndex].tiles[42][91].placeOccupant( color(mYoung), "- We have a few delicacies, if you ask nicely. That nice girl with the scratched up arms took our supply of esrom." );
  m[mapIndex].tiles[42][95].placeOccupant( color(fYoung), "- Fruit is vital to combat scurvy. Take some if you need." );
  m[mapIndex].tiles[37][88].placeOccupant( color(#FFB443), "- *HSSSS*     The poor cat is terrified." );
  //Card Players
  m[mapIndex].tiles[25][71].placeOccupant( color(sailor), "- NO TEXT." );
  m[mapIndex].tiles[27][71].placeOccupant( color(sailor), "- Haven't heard from the quartermaster in hours. He probably wants us to take a third break." );
  m[mapIndex].tiles[26][70].placeOccupant( color(sailor), "~ Within the cove at Marinstad "+
                                                          "~ Me widow scans the sky "+
                                                          "~ Scriven missives in her fist "+
                                                          "~ Hoarfrost upon her eye" );
  m[mapIndex].tiles[26][72].placeOccupant( color(sailor), "~ Her gold and smile secures a ship "+
                                                          "~ She raises high the sail "+
                                                          "~ Across a dark and angry sea "+
                                                          "~ We meet beyond the Veil" );

  //Lower Deck post-boss
  m[mapIndex].tiles[76][72].placeOccupant( color(sailor), "- A clean ship will sail long." );
  m[mapIndex].tiles[85][72].placeOccupant( color(sailor), "- Where did all these dead rats come from?" );
  m[mapIndex].tiles[88][76].placeOccupant( color(sailor), "- Do you hear someone shouting?" );
  m[mapIndex].tiles[92][77].placeOccupant( color(sailor), "- NO TEXT" );
  //Empty Beds
  m[mapIndex].tiles[57][92].placeOccupant( color(255,0), "- The bedspread is littered with vials and chemical stains." );
  m[mapIndex].tiles[65][98].placeOccupant( color(255,0), "- The sheet are fastidiously tucked in." );
  m[mapIndex].tiles[67][98].placeOccupant( color(255,0), "- It's rude to sleep in someone else's bed." );
  m[mapIndex].tiles[69][98].placeOccupant( color(255,0), "- The sheets are of a strange material from some faraway land." );
  
  //Kat (post-boss)
    //in method below
  //Galley
  m[mapIndex].tiles[96][93].placeOccupant( color(captain), "- I wonder how rat tastes. The crew is about to find out!" );
  m[mapIndex].tiles[95][91].placeOccupant( color(mYoung), "- Make sure to keep a balanced supply of rations on hand at all times. Drinking nothing but potions is bad for the liver." );
  m[mapIndex].tiles[94][95].placeOccupant( color(fYoung), "- Who took all our barrels?" );
  m[mapIndex].tiles[90][88].placeOccupant( color(#FFB443), "- *Meow*" );
  //Upper Deck post-boss
  m[mapIndex].tiles[67][12].placeOccupant( color(captain), "- We've recieved word that Waraka's port is blocked. We'll have to let you off here. The castle is less than a day's journey by land. Farewell, and never forget the feel of the wind of freedom!" );
  m[mapIndex].tiles[67][13].placeOccupant( color(coryColor), "- Look for me once you reach Waraka. I may have a job for you." );
  m[mapIndex].tiles[57][13].placeOccupant( color(clericColor), "- What a rugged land. I can see a tower rising from the hills. Is that Mariva?" );
  m[mapIndex].tiles[56][13].placeOccupant( lesserRitisu, "- Yes, and that is Ritisu's tower. I am bound there if you wish to go. The road passes through Waraka's checkpoints." );
  //Singing sailors
  m[mapIndex].tiles[83][3].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[83][4].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[84][5].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[85][5].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[86][4].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[86][3].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[85][2].placeOccupant( color(sailor), "They're singing a chantey." );
  m[mapIndex].tiles[84][2].placeOccupant( color(sailor), "They're singing a chantey." );
  //Captain's Daughter 2
  m[mapIndex].tiles[63][7].placeOccupant( color(fYoung), "- All right, landlubbers. Try to find my gold this time!" );
  
  m[mapIndex].tiles[40][32].placeBuyer();
  m[mapIndex].tiles[41][32].placeOccupant( color(10,10,50), "- I love the open sea. So much easier to hide from the Vendor's Guild. Got anything for me?" );
  
  //Deck to Fo'c'sle Deck
  exits.add( new Portal(3,42,2,3,29,22, "Forecastle Deck") );
  exits.add( new Portal(3,42,12,3,29,32, "Forecastle Deck") );
  //Fo'c'sle to Deck
  exits.add( new Portal(3,29,22,3,42,2, "Main Deck") );
  exits.add( new Portal(3,29,32,3,42,12, "Main Deck") );
  
  //Deck to Quarterdeck
  exits.add( new Portal(3,7,2,3,20,22, "Quarterdeck") );
  exits.add( new Portal(3,7,12,3,20,32, "Quarterdeck") );
  //Quarterdeck to Deck
  exits.add( new Portal(3,20,22,3,7,2, "Main Deck") );
  exits.add( new Portal(3,20,32,3,7,12, "Main Deck") );
  
  //Deck to Captain's Cabin
  exits.add( new Portal(3,6,4,3,19,53, "Captain's Cabin") );
  exits.add( new Portal(3,19,53,3,6,4, "Main Deck") );
  
  //Deck to Wardroom
  exits.add( new Portal(3,6,10,3,19,59, "Wardroom") );
  exits.add( new Portal(3,19,59,3,6,10, "Main Deck") );
  
  //Deck to Bunks (forecastle)
  exits.add( new Portal(3,43,7,3,27,56, "Forecastle") );
  exits.add( new Portal(3,27,56,3,43,7, "Main Deck") );
  
  //Deck to Lower Deck
  exits.add( new Portal(3,31,3,3,31,72, "Lower Deck") );
  exits.add( new Portal(3,31,72,3,31,3, "Main Deck") );
  
  //Lower Deck to Deck secret barrel
  exits.add( new Portal(3,31,11,3,31,78, "Lower Deck") );
  exits.add( new Portal(3,31,78,3,31,11, "Main Deck") );
  
  //Lower Deck to Galley
  exits.add( new Portal(3,43,71,3,26,89, "Galley") );
  exits.add( new Portal(3,26,89,3,43,71, "Lower Deck") );
  
  //Lower Deck to Chain Locker
  exits.add( new Portal(3,43,79,3,26,97, "Chain Locker") );
  exits.add( new Portal(3,26,97,3,43,79, "Lower Deck") );
  
  //Lower Deck to NE Cabin
  exits.add( new Portal(3,13,73,3,14,91, "Your Cabin") );
  exits.add( new Portal(3,14,91,3,13,73, "Lower Deck") );
  
  //Lower Deck to NW Cabin
  exits.add( new Portal(3,7,73,3,8,91, "Kat's Cabin") );
  exits.add( new Portal(3,8,91,3,7,73, "Lower Deck") );
  
  //Lower Deck to SE Cabin
  exits.add( new Portal(3,13,77,3,14,95, "Officer's Cabin") );
  exits.add( new Portal(3,14,95,3,13,77, "Lower Deck") );
  
  //Lower Deck to Ship's Office
  exits.add( new Portal(3,7,77,3,8,95, "Ship's Office") );
  exits.add( new Portal(3,8,95,3,7,77, "Lower Deck") );
  
  //From Chain Locker to Sail Locker
  exits.add( new Portal(3,38,97,3,91,60, "Sail Locker") );
  
  //From Sail Locker to Hold
  exits.add( new Portal(3,86,57,3,86,43, "Hold") );
  exits.add( new Portal(3,86,43,3,86,57, "Sail Locker") );
  
  //After the boss fight
  
  //Hold to Ship's Office (after boss)
  exits.add( new Portal(3,52,43,3,54,94, " Ship's Office ") );
  
  //Lower Deck to Ship's Office
  exits.add( new Portal(3,61,95,3,57,77, "Lower Deck") );
  exits.add( new Portal(3,57,77,3,61,95, "Ship's Office") );
  
  //Lower Deck to NW Cabin
  exits.add( new Portal(3,57,73,3,61,91, "Kat's Cabin") );
  exits.add( new Portal(3,61,91,3,57,73, "Lower Deck") );
  
  //Lower Deck to NE Cabin
  exits.add( new Portal(3,63,73,3,67,91, "Your Cabin") );
  exits.add( new Portal(3,67,91,3,63,73, "Lower Deck") );
  
  //Lower Deck to SE Cabin
  exits.add( new Portal(3,63,77,3,67,95, "Officer's Cabin") );
  exits.add( new Portal(3,67,95,3,63,77, "Lower Deck") );
  
  //Lower Deck to Galley
  exits.add( new Portal(3,93,71,3,79,89, "Galley") );
  exits.add( new Portal(3,79,89,3,93,71, "Lower Deck") );
  
  //Lower Deck to Main Deck
  exits.add( new Portal(3,81,72,3,75,3, "Main Deck") );
  exits.add( new Portal(3,81,78,3,75,11, "Main Deck") );
  exits.add( new Portal(3,75,3,3,81,72, "Lower Deck") );
  exits.add( new Portal(3,75,11,3,81,78, "Lower Deck") );
  
  //Gangplank
  exits.add( new Portal(3,68,14,4,93,89, "Waraka Sea Road") );
  exits.add( new Portal(3,69,14,4,93,89, "Waraka Sea Road") );
  
  //First big rat
  m[mapIndex].tiles[19][78].placeBoss( mapIndex, color(#4c585c), "It's bloated like a drowned body.", new Monster("Giant Bilge Rat", "blueRatBig.png", 100, 15, 5, 5, 0, 4, 12, 0, AttackType.FIRE), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("whips its tail.", 50, false, "S");
      zoo.boss[bossIndex].attacks[1] = new Attack("stomps.", 50, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites!", 65, false, "T" );
      zoo.boss[bossIndex].attacks[3] = new Attack("bites!", 65, false, "T" );
      zoo.boss[bossIndex].attacks[4] = new Attack("throws its body!", 60, true, "B" );
  bossIndex++;
  
  //Blocking the chest
  m[mapIndex].tiles[22][73].placeBoss( mapIndex, color(#4c585c), "Its head touches the deck above.", new Monster("Giant Bilge Rat", "blueRatBig.png", 100, 15, 5, 5, 0, 4, 12, 0, AttackType.FIRE), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("whips its tail.", 50, false, "S");
      zoo.boss[bossIndex].attacks[1] = new Attack("stomps.", 50, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites!", 65, false, "T" );
      zoo.boss[bossIndex].attacks[3] = new Attack("bites!", 65, false, "T" );
      zoo.boss[bossIndex].attacks[4] = new Attack("throws its body!", 60, true, "B" );
  bossIndex++;
  
  //Blocking doubloons
  m[mapIndex].tiles[29][77].placeBoss( mapIndex, color(#4c585c), "This one is collecting shiny objects.", new Monster("Giant Bilge Rat", "blueRatBig.png", 100, 15, 5, 5, 0, 4, 12, 5, AttackType.FIRE), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("whips its tail.", 50, false, "S");
      zoo.boss[bossIndex].attacks[1] = new Attack("stomps.", 50, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites!", 65, false, "T" );
      zoo.boss[bossIndex].attacks[3] = new Attack("bites!", 65, false, "T" );
      zoo.boss[bossIndex].attacks[4] = new Attack("throws its body!", 60, true, "B" );
  bossIndex++;
  
  //Boat Boss
  m[mapIndex].tiles[54][43].placeBoss( mapIndex, color(140,150,150), "This is the last, and the largest.", new Monster("Deep Ratlord", "abyssBig.png", 150, 18, 10, 4, 10, 4, 15, 0, AttackType.HOLY), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("sprays icy seawater.", 40, true, AttackStat.MAG, AttackType.ICE, "I");
      zoo.boss[bossIndex].attacks[1] = new Attack("tosses you aside!", 70, false, "B" );
      zoo.boss[bossIndex].attacks[2] = new Attack("bites!", 70, false, "T" );
      zoo.boss[bossIndex].attacks[3] = new Attack("sweeps its tail!", 55, true, "S" );
      zoo.boss[bossIndex].attacks[4] = new Attack("grips you with icy claws!", 60, false, AttackStat.MAG, AttackType.ICE, "B");
  bossIndex++;
  
  
  //Danger Map 3 (Boat)
  dangerMapIndex = mapIndex; dangerStrs[dangerMapIndex] = "";

  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createFloor4()
{
//---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 4 - Mountain Path (Road to Waraka)
  
  //Side paths to caves filled with bees
  //Have to go through river - one-way paths
  
  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  //River
  exits.add( new Portal(4,7,17, 5,34,93, "Subterranean River") ); //Into first cave
  exits.add( new Portal(4,7,34, 6,2,0, "Subterranean River") ); //Into second cave
  
  //TESTING
  savePoints[savePointIndex++] = new SavePoint(4,18,12);
  
  //Return to ship
  exits.add( new Portal(4,93,89,3,68,14, "Barracuda Queen") );
  //Gatehouse
  exits.add( new Portal(4,82,88,5,72,3) );
  //Barn
  exits.add( new Portal(4,63,92,5,16,3, "Barn") ); //main door
  exits.add( new Portal(4,66,92,5,21,3, "Barn") ); //barn door
  //Temple of Ritisu
  exits.add( new Portal(4,51,88,5,4,7, "Temple of Ritisu") );
  //Tomb
  exits.add( new Portal(4,30,98,5,97,1, "Tomb") );
  //Houses
  exits.add( new Portal(4,45,88,5,41,3) ); //Graveyard girl
  exits.add( new Portal(4,40,88,5,51,3) );
  exits.add( new Portal(4,35,88,5,61,3) );
  exits.add( new Portal(4,30,88,5,84,3) );
  //Bathhouse
  exits.add( new Portal(4,37,82, 5,46,14, "Bathhouse") );
  //Shop
  exits.add( new Portal(4,45,81, 5,73,14) );
  exits.add( new Portal(4,48,81, 5,76,14) );
  exits.add( new Portal(4,51,81, 5,79,14) );
  exits.add( new Portal(4,47,79, 5,76,10) ); //secret
  exits.add( new Portal(4,48,79, 5,76,10) ); //secret
  exits.add( new Portal(4,49,79, 5,76,10) ); //secret
  //Hut
  exits.add( new Portal(4,81,73, 5,97,15) );
  //Sea Road Tunnel
  exits.add( new Portal(4,88,52, 5,16,34, "Sea Road Tunnel" ) ); //first bee cave (entrance)
  exits.add( new Portal(4,92,43, 5,31,23, "Sea Road Tunnel" ) ); //first bee cave (exit)
  //Ruined Temple
  exits.add( new Portal(4,73,7, 5,97,26, "Temple of Ritisu" ) );
  //North Tunnel
  exits.add( new Portal(4,83,1, 5,87,30, "Outer Hive" ) );
  exits.add( new Portal(4,9,93, 5,1,51, "Outer Hive" ) );  //outer hive exit
  //Houses
  exits.add( new Portal(4,14,63, 5,49,39 ) );
  exits.add( new Portal(4,4,59, 5,60,39 ) );
  exits.add( new Portal(4,4,55, 5,2,67, "Old Well" ) ); //well
  //Central Hive
  exits.add( new Portal(4,5,41, 5,25,61, "Central Hive" ) );
  //Manor front door
  exits.add( new Portal(4,38,62, 5,28,83, "Honeydell Manor" ) );
  exits.add( new Portal(4,39,62, 5,29,83, "Honeydell Manor" ) );
  //Garden Secret
  exits.add( new Portal(4,34,58, 5,44,57, "Honeydell Tunnel" ) );
  //Kat's Camp to hive
  exits.add( new Portal( 4,16,17, 5,17,42, "Central Hive" ) );
  
  //Events
  m[mapIndex].tiles[77][91].createEvent(false, "- Hoary peaks cut jagged triangles out of the horizon. The greenery is more vibrant here, and the people are tall and strong. This is Waraka, a land favored by Am-asma.");
  m[mapIndex].tiles[69][82].createEvent(true, "- Gullhaven Village");
  //Kat's voice
    //in method below
    //in method below
  
  //m[mapIndex].tiles[72][80].createEvent(true, "- To Waraka Castle");
  //TESTING
  //m[mapIndex].tiles[53][21].createEvent(true, "- Water 1");
  //m[mapIndex].tiles[53][22].createEvent(true, "- Water 2");
  //m[mapIndex].tiles[53][23].createEvent(true, "- Water 3");
  
  //Sailor on pier
  m[mapIndex].tiles[94][92].placeOccupant( sailor, "- Shipment was supposed to arrive yesterday. Seas have been unpredictable of late." );
  //Sailors at dock
  m[mapIndex].tiles[86][91].placeOccupant( sailor, "- Hey HUP, hut HA! Lift!" );
  m[mapIndex].tiles[84][91].placeOccupant( sailor, "- Ha HEY, rah RUM! Push!" );
  m[mapIndex].tiles[82][93].placeOccupant( sailor, "- Why do I always have to work with those weirdos?" );
  m[mapIndex].tiles[81][90].placeOccupant( sailor, "A tall saurian dockworker is moving crates. He smiles as you pass, revealing a mouth full of jagged teeth." );
  //People outside
  m[mapIndex].tiles[72][92].placeOccupant( mYoung, "- I've got my eye on you." );
  m[mapIndex].tiles[74][84].placeOccupant( male, "- Caves swarming, bridge out, and now we have clueless foreigners wandering around. Yes, I know they're behind me." );
  m[mapIndex].tiles[74][85].placeOccupant( male, "- Seems the road to the castle is unusable." );
  //Buyer
  m[mapIndex].tiles[84][99].placeOccupant( color(10,10,50), "- I saw you arrive. Got any Irohill crafts? They make good metal over there." );
  m[mapIndex].tiles[85][99].placeBuyer();
  //People in town
  m[mapIndex].tiles[58][80].placeOccupant( female, "- See these blooms? This is Mireroot. It repels insects. Be wary of colorful plants and what they attract." );
  m[mapIndex].tiles[36][83].placeOccupant( female, "- Don't know what this is, strangers? Warakan bathhouses are open to all. Strong bodies need good keeping." );
  m[mapIndex].tiles[44][97].placeOccupant( color(170,150,110), "He stares at you. You stare at him. There is no hint of fear in his eyes, nor in his straw-filled body." );
  //Man in flowers
  m[mapIndex].tiles[86][73].placeOccupant( female, "- Have you seen my husband? With the recent swarms, I'm getting worried." );
  m[mapIndex].tiles[97][74].placeOccupant( male, "You wake him from a heavy slumber. - Must have stung me. I'll be fine now. My lunch is around here somewhere if you want it. I just need five more minutes..." );
  //Bridge
  m[mapIndex].tiles[63][65].placeOccupant( female, "NO TEXT." );
  m[mapIndex].tiles[64][66].placeOccupant( male, "- I suppose we could take the sea road north to the castle, if the river is calm." );
  m[mapIndex].tiles[65][65].placeOccupant( male, "- Destroyed again. We should petition the queen for a bridge made of stone." );
  //Honey Collectors
  m[mapIndex].tiles[85][64].placeOccupant( female, "- Good harvest this year, if we can get it to the castle." );
  m[mapIndex].tiles[91][67].placeOccupant( female, "- Don't get too close." );
  m[mapIndex].tiles[97][66].placeOccupant( mYoung, "- They look scary, but wait until the wind blows them over. It's hilarious!" );
  m[mapIndex].tiles[89][61].placeOccupant( male, "- The bakers from Gullhaven used to use the tunnel all the time. They had some secret for getting through quickly." );
  m[mapIndex].tiles[87][62].placeOccupant( male, "- You headed north? You'll have to go through that tunnel. Used to be safe, until the hive spread into it." );
  //Refugees
  m[mapIndex].tiles[2][81].placeOccupant( ritisuColor, "- You made it through the hive safely? Praise Illamar's light! We were driven out of our temple by bandits. They and we are both trapped here because of the swarms. Rest here. I wish we could do more for you." );
  m[mapIndex].tiles[6][80].placeOccupant( garrison, "She's armed with a plowshare and wares a hammered pot for a helmet." );
  m[mapIndex].tiles[6][82].placeOccupant( male, "- Get inside, quickly!" );
  m[mapIndex].tiles[1][84].placeOccupant( fYoung, "- You smell sweet. Like honey." );
  m[mapIndex].tiles[5][83].placeOccupant( male, "- We and the hives exist in a tenuous balance. Because of those brigands, we couldn't harvest the royal jelly this season." );
  m[mapIndex].tiles[4][83].placeOccupant( female, "- The queen has grown too strong. If she dies, the hive will have to rear a new one. It will take a few years for the hive to recover, but the roads will be safe." );
  m[mapIndex].tiles[1][78].placeOccupant( lesserRitisu, "- One of Ritisu's tears fell into the hive. It will not be hard to find. Honey and wax will not cling to a true Legend Gem." );
  m[mapIndex].tiles[2][78].placeOccupant( lesserRitisu, "- The bandits are growing restless and desperate. They have devised a way to weaponize bumblewere venom. Arm yourselves with knowledge, friends." );
  //Player 1's admirer (in method below)
  m[mapIndex].tiles[1][82].placeOccupant( mYoung, "He's playing with a bit of wax. As he holds it over a fire, it melts and drips onto the ground." );
  m[mapIndex].tiles[4][80].placeOccupant( female, "- Those crooks chased us out in the middle of the night. I don't know what happened to my children. I can only hope they escaped through the passage that leads to the garden." );
  m[mapIndex].tiles[5][79].placeOccupant( male, "- There is a door in back of the hive. We use it for transporting honey, but it's locked. We left the key behind when we fled." );
  //Sister Kat
    //in method below
  m[mapIndex].tiles[4][29].placeOccupant( katColor, "NO TEXT" );
  //Spirit
  m[mapIndex].tiles[10][33].placeOccupant( color(ghostColor,150), "NO TEXT" );
  
  
  //Grave Keys
  createLoot(lootIndex++, mapIndex, 51, 85, Key.GRAVE );
  createLoot(lootIndex++, mapIndex, 79, 91, Key.GRAVE );
  //Bread in flowers
  createLoot(lootIndex++, mapIndex, 99,73, new Item("Bread", 10 ) );
  //Wind knife
  createLoot(lootIndex++, mapIndex, 98,4, new Equipment("Windrazor","windKnife.png", 15, true, 21.3,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );  
  //Admirer's Food
  createLoot(lootIndex++, mapIndex, 0,81, new Item("Meat", 20 ) );
  //Kat's Food
  createLoot(lootIndex++, mapIndex, 18,17, new Item("Bread", 10 ) );
  createLoot(lootIndex++, mapIndex, 19,17, new Item("Meat", 20 ) );
  
  //Cows
  m[mapIndex].tiles[72][97].createEvent(true, "- *Mooo?*");
  m[mapIndex].tiles[82][99].createEvent(true, "- *Mooo*");
  m[mapIndex].tiles[65][95].placeOccupant( color(130,110,70), "- *Mooo*" );
  m[mapIndex].tiles[67][94].placeOccupant( color(130,110,70), "- *Mooo*" );
  m[mapIndex].tiles[68][93].placeOccupant( color(130,110,70), "- *Mooo*" );
  m[mapIndex].tiles[65][93].placeOccupant( color(130,110,70), "- *Mooo*" );
  
  //Bees                                                                                                                  //String n, String image,  health, s,  d, c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[94][74].placeBoss( mapIndex, color(#f5c800), "This creature has an intoxicating smell.", new Monster("Nectarseeker", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );
      zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );
      zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );
      zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "?" );
  bossIndex++;
  //In first meadow
  m[mapIndex].tiles[83][35].placeBoss( mapIndex, color(255,0), "Pollen sprays as they emerge.", new Monster("Nectarhunter", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "?" );
  bossIndex++;
  m[mapIndex].tiles[89][27].placeBoss( mapIndex, color(255,0), "They fly as if in formation.", new Monster("Nectarhunter", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "?" );
  bossIndex++;
  m[mapIndex].tiles[93][20].placeBoss( mapIndex, color(255,0), "The air is alive with their buzzing.", new Monster("Nectarhunter", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "?" );
  bossIndex++;
  m[mapIndex].tiles[91][23].placeBoss( mapIndex, color(255,0), "They descend from the trees.", new Monster("Nectarhunter", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "?" );
  bossIndex++;
  m[mapIndex].tiles[81][19].placeBoss( mapIndex, color(255,0), "A big one patrols the meadow road.", new Monster("Nectarhunter", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "?" );
  bossIndex++;
  //Bees guarding barrel                                                                                                                //String n, String image,  health, s,  d, c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[97][4].placeBoss( mapIndex, color(#f5c800), "Something in that barrel has upset them.", new Monster("Nectarseeker", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "T" );
      zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );
      zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "P" );
      zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "B" );
  bossIndex++;
  //Bandit ambush                                                                   //String n, String image,  health, s,  d,  c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[10][86].placeBoss( mapIndex, color(255,5), "Ambush!", new Monster("Bandit", "bandit.png", 90, 26, 30, 7, 1, 4, 20, 7, AttackType.NONE, 6), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("stabs with a knife.", 50, false, AttackStat.DEX, AttackType.NONE, "P" );
    zoo.boss[bossIndex].attacks[1] = new Attack("flings knives!", 50, true, "P" );
    zoo.boss[bossIndex].attacks[2] = new Attack("strikes with his sword.", 70, false, "S" );
    zoo.boss[bossIndex].attacks[3] = new Attack("uses a toxin.", 60, false, Debuff.POISON, "S" );
    zoo.boss[bossIndex].attacks[4] = new Attack("tries to get behind you." );
  bossIndex++; 
  
  
  //Danger Map 4 (Road)
  dangerMapIndex = mapIndex; dangerStrs[dangerMapIndex] = "";
  
  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createFloor5()
{
//---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 5 - Caves and Houses (Waraka)
  
  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  savePoints[savePointIndex++] = new SavePoint(5,4,4,6); //Temple of Ritisu
  savePoints[savePointIndex++] = new SavePoint(5,97,23,6); //Temple of Ritisu (on sea road)
  savePoints[savePointIndex++] = new SavePoint(5,63,48,11); //Central Hive
  
  //Gatehouse
  exits.add( new Portal(5,72,3, 4,82,88) );
  //Barn
  exits.add( new Portal(5,16,3, 4,63,92, "Barn") ); //main door
  exits.add( new Portal(5,21,3, 4,66,92, "Barn") ); //barn door
  //Temple of Ritisu
  exits.add( new Portal(5,4,7, 4,51,88, "Gullhaven") );
  //Tomb
  exits.add( new Portal(5,97,1, 4,30,98, "Gullhaven") ); //tomb entrance to surface
  exits.add( new Portal(5,2,33, 5,97,6) ); //fake to tomb
  exits.add( new Portal(5,31,1, 4,30,98, "Gullhaven") ); //real to surface
  exits.add( new Portal(5,97,6, 5,2,33) );  //tomb to fake
  exits.add( new Portal(5,2,41, 5,31,9 ) ); //fake to real
  //Houses
  exits.add( new Portal(5,41,3, 4,45,88) ); //Graveyard girl
  exits.add( new Portal(5,51,3, 4,40,88) );
  exits.add( new Portal(5,61,3, 4,35,88) );
  exits.add( new Portal(5,84,3, 4,30,88) );
  //Bathhouse
  exits.add( new Portal(5,46,14, 4,37,82, "Gullhaven" ) );
  exits.add( new Portal(5,51,10, 5,64,14 ) );
  exits.add( new Portal(5,64,14, 5,51,10 ) );
  //Shop
  exits.add( new Portal(5,73,14, 4,45,81) );
  exits.add( new Portal(5,76,14, 4,48,81) );
  exits.add( new Portal(5,79,14, 4,51,81) );
  exits.add( new Portal(5,76,10, 4,48,79) ); //secret
  //Hut
  exits.add( new Portal(5,97,15, 4,81,73) );
  //Sea Road Tunnel
  exits.add( new Portal(5,16,34, 4,88,52, "Waraka Sea Road" ) ); //first bee cave
  exits.add( new Portal(5,13,29, 5,33,34 ) ); //first to second
  exits.add( new Portal(5,33,34, 5,13,29 ) ); //second to first
  exits.add( new Portal(5,30,30, 5,88,17 ) ); //to shortcut (bottom)
  exits.add( new Portal(5,88,17, 5,30,30 ) ); //from shortcut (bottom)
  exits.add( new Portal(5,30,26, 5,88,13 ) ); //to shortut (top)
  exits.add( new Portal(5,88,13, 5,30,26 ) ); //from shortcut (top)
  exits.add( new Portal(5,31,23, 4,92,43, "Waraka Sea Road" ) ); //exit
  //Ruined Temple
  exits.add( new Portal(5,97,26, 4,73,7, "Waraka Sea Road" ) );
  //Outer Hive
  exits.add( new Portal(5,87,30, 4,83,1, "Waraka Sea Road" ) );
  exits.add( new Portal(5,73,29, 5,98,35 ) );  //golem chamber entrance (in)
  exits.add( new Portal(5,98,35, 5,73,29 ) );  //golem chamber entrance (out)
  exits.add( new Portal(5,95,36, 5,69,28 ) );  //golem chamber exit (out)
  exits.add( new Portal(5,69,28, 5,95,36 ) );  //golem chamber exit (in)
  exits.add( new Portal(5,64,24, 5,3,58 ) );  //exit tunnel entrance (in)
  exits.add( new Portal( 5,3,58, 5,64,24 ) );  //exit tunnel entrance (out)
  exits.add( new Portal(5,1,51, 4,9,93, "Waraka Sea Road" ) );  //exit
  //Houses
  exits.add( new Portal( 5,49,39, 4,14,63 ) );
  exits.add( new Portal( 5,60,39, 4,4,59 ) );
  exits.add( new Portal( 5,3,74,  5,69,37) );
  exits.add( new Portal( 5,71,39,  4,4,67, "Waraka Sea Road" ) );
  //Central Hive
  exits.add( new Portal( 5,25,61, 4,5,41, "Waraka Sea Road" ) );
  exits.add( new Portal( 5,15,57, 5,80,40 ) ); //golem chamber entrance (in)
  exits.add( new Portal( 5,80,40, 5,15,57 ) ); //golem chamber entrance (out)
  exits.add( new Portal( 5,84,38, 5,16,55 ) ); //golem chamber exit (out)
  exits.add( new Portal( 5,16,55, 5,84,38 ) ); //golem chamber exit (in)
  exits.add( new Portal( 5,34,55, 5,98,46 ) ); //main chamber tunnel entrance (in)
  exits.add( new Portal( 5,98,46, 5,34,55 ) ); //main chamber tunnel entrance (out)
  exits.add( new Portal( 5,94,44, 5,28,55 ) ); //main chamber tunnel exit (out)
  exits.add( new Portal( 5,28,55, 5,94,44 ) ); //main chamber tunnel exit (in)
  exits.add( new Portal( 5,28,45, 5,63,51 ) ); //save room (in)
  exits.add( new Portal( 5,63,51, 5,28,45 ) ); //save room (out)
  exits.add( new Portal( 5,24,48, 5,44,48 ) ); //left tunnel (in)
  exits.add( new Portal( 5,44,48, 5,24,48 ) ); //left tunnel (out)
  exits.add( new Portal( 5,33,47, 5,53,49 ) ); //right tunnel (in)
  exits.add( new Portal( 5,53,49, 5,33,47 ) ); //right tunnel (out)
  exits.add( new Portal( 5,32,49, 5,73,49 ) ); //manor tunnel left (in)
  exits.add( new Portal( 5,73,49, 5,32,49 ) ); //manor tunnel left (out)
  exits.add( new Portal( 5,86,48, 4,37,70 ) ); //manor tunnel right (to outside)
  exits.add( new Portal( 4,37,70, 5,86,48, "Central Hive" ) ); //manor tunnel right (to inside)
  exits.add( new Portal( 5,24,46, 5,98,54 ) ); //top fork (in)
  exits.add( new Portal( 5,98,54, 5,24,46 ) ); //top fork (out)
  exits.add( new Portal( 5,23,50, 5,98,60 ) ); //bottom fork (in)
  exits.add( new Portal( 5,98,60, 5,23,50 ) ); //bottom fork (out)
  exits.add( new Portal( 5,17,51, 5,80,57 ) ); //left fork (in)
  exits.add( new Portal( 5,80,57, 5,17,51 ) ); //left fork (out)
  exits.add( new Portal( 5,17,42, 4,16,17, "Waraka Sea Road" ) ); //final exit
  //Honeydell Manor
  //Manor front door
  exits.add( new Portal( 5,28,83, 4,38,62, "Honeydell" ) );
  exits.add( new Portal( 5,29,83, 4,39,62, "Honeydell" ) );
  //tunnel to outside
  exits.add( new Portal( 5,44,57, 4,34,58, "Honeydell" ) ); //tunnel to outside
  exits.add( new Portal( 5,72,59, 5,62,71, "Honeydell Library" ) ); //tunnel to library
  exits.add( new Portal( 5,62,71, 5,72,59, "Honeydell Tunnel" ) ); //library to tunnel
  //Bedroom left
  exits.add( new Portal( 5,13,80, 5,56,80, "Honeydell Bedroom" ) );
  exits.add( new Portal( 5,56,80, 5,13,80, "Honeydell Manor" ) );
  //Bedroom right
  exits.add( new Portal( 5,19,80, 5,62,80, "Honeydell Bedroom" ) );
  exits.add( new Portal( 5,62,80, 5,19,80, "Honeydell Manor" ) );
  //Library left
  exits.add( new Portal( 5,13,76, 5,56,76, "Honeydell Library" ) );
  exits.add( new Portal( 5,56,76, 5,13,76, "Honeydell Manor" ) );
  //Library right
  exits.add( new Portal( 5,22,73, 5,65,73, "Honeydell Library" ) );
  exits.add( new Portal( 5,65,73, 5,22,73, "Honeydell Dining Hall" ) );
  //Larder left
  exits.add( new Portal( 5,35,73, 5,78,73, "Honeydell Larder" ) );
  exits.add( new Portal( 5,78,73, 5,35,73, "Honeydell Dining Hall" ) );
  //Larder right
  exits.add( new Portal( 5,39,76, 5,82,76, "Honeydell Larder" ) );
  exits.add( new Portal( 5,82,76, 5,39,76, "Honeydell Manor" ) );
  //Kitchen
  exits.add( new Portal( 5,39,80, 5,82,80, "Honeydell Kitchen" ) );
  exits.add( new Portal( 5,82,80, 5,39,80, "Honeydell Manor" ) );
  //Stairs left (23,69) (34,69)      (-1,+14)
  exits.add( new Portal( 5,23,69, 5,12,96, "Attic" ) );
  exits.add( new Portal( 5,12,96, 5,23,69, "Honeydell Dining Hall" ) );
  //Stairs right (23,69) (34,69)      (-1,+14)
  exits.add( new Portal( 5,34,69, 5,23,96, "Attic" ) );
  exits.add( new Portal( 5,23,96, 5,34,69, "Honeydell Dining Hall" ) );
  //To Dragon (46,80)
  exits.add( new Portal( 5,46,80, 5,89,80, "Honeydell Kitchen" ) );
  exits.add( new Portal( 5,89,80, 5,46,80, "Honeydell Manor" ) );
  //North Water Caves
  exits.add( new Portal( 5,31,99, 5,47,93 ) ); //Left Path
  exits.add( new Portal( 5,46,99, 5,75,93 ) );
  exits.add( new Portal( 5,37,99, 5,66,93 ) ); //Right Path
  exits.add( new Portal( 5,65,99, 5,81,93 ) );
  exits.add( new Portal( 5,79,99, 5,97,89 ) ); //Merged Path
  exits.add( new Portal( 5,93,99, 4,10,21 ) ); //Left Exit
  exits.add( new Portal( 5,97,99, 4,10,21 ) ); //Right Exit
  
  //Grave
  m[mapIndex].tiles[97][3].createEvent(false, "- Laughter echos from somewhere below.");
  m[mapIndex].tiles[2][37].createEvent(false, "- The laughing has stopped, replaced by whispers.");
  m[mapIndex].tiles[31][10].createEvent(false, "- The chamber is lit with candles and lightly scented with purfume.");
  //Bathhouse
  m[mapIndex].tiles[46][13].createEvent(false, "- A warm and soapy mist surrounds you with its scent.");
  m[mapIndex].tiles[64][11].createEvent(false, "- The air is thinner here, sweetened with incense.");
  //Manor
  m[mapIndex].tiles[82][81].createEvent(false, "- They have left behind little apart from the smell of burnt bread.");
  m[mapIndex].tiles[19][95].createEvent(false, "- It seems you've interrupted a game. Even when safe in their hideout, these bandits have weapons at the ready.");
  m[mapIndex].tiles[79][73].createEvent(false, "- The bandits' stores are running low, it seems. They had not planned to be here so long.");
  
  //Gatehouse
  m[mapIndex].tiles[72][1].placeOccupant( male, "- Your paperwork has been processed. Welcome to Waraka." );
  m[mapIndex].tiles[74][1].placeOccupant( male, "- UNUSED TEXT." );
  //Passport
  createLoot(lootIndex++, mapIndex, 70, 2, Key.PASSPORT );
  
  //Ritisu
  m[mapIndex].tiles[4][1].placeOccupant( ritisuColor, "- So much is hidden in the hills of this land. I have spent decades delving its secrets, bringing glory to Ritisu." );
  m[mapIndex].tiles[5][7].placeOccupant( lesserRitisu, "- Welcome to our tower of knowledge." );
  m[mapIndex].tiles[6][3].placeOccupant( lesserRitisu, "- Watch out for the rapids. It is shallow enough to walk, but will carry you away." );
  m[mapIndex].tiles[2][5].placeOccupant( lesserRitisu, "- Our clerics work with the royal blacksmiths to infuse weapons with magic. A stronger blade is not always the right tool." );
  m[mapIndex].tiles[1][4].placeOccupant( lesserRitisu, "- Oh, I'm just an initiate. Um... do you know about the (h) key if you need help? You did? Sorry, I'm still learning." );
  //Graveyard Girls
  m[mapIndex].tiles[33][11].placeOccupant( fYoung, "- Welcome. Do you fear death?" );
  m[mapIndex].tiles[30][10].placeOccupant( fYoung, "- We are the Graveyard Girls." );
  m[mapIndex].tiles[32][6].placeOccupant( fYoung, "- We meet here in the house of our departed grandmothers." );
  m[mapIndex].tiles[30][3].placeOccupant( fYoung, "- We fear not death. Crossing the Veil will be like going home to supper." );
  m[mapIndex].tiles[30][6].placeOccupant( fYoung, "She watches you in silence." );
  m[mapIndex].tiles[28][12].placeOccupant( fYoung, "- This is the path of the dead. Pass our tests to walk here." );
  m[mapIndex].tiles[32][14].placeOccupant( fYoung, "- Is that what they wear in Irohill?" );
  m[mapIndex].tiles[31][13].placeOccupant( fYoung, "- You seek my key? \"What is death, if not forever hidden behind our knowledge?\"" );
  m[mapIndex].tiles[23][12].placeOccupant( fYoung, "- You seek my key? \"Rest we seek, yet the long rest we fear.\"" );
  m[mapIndex].tiles[18][11].placeOccupant( fYoung, "- You seek my key? \"The gate, the threshold. All are welcomed through the Veil.\"" );
  m[mapIndex].tiles[6][16].placeOccupant( fYoung, "- That was fast. We need to hide our keys better." );
  m[mapIndex].tiles[4][15].placeOccupant( fYoung, "- Wear our uniform with pride. Enjoy life while you can." );
  m[mapIndex].tiles[1][15].placeOccupant( fYoung, "- Does no one else think this place is spooky!?" );
  m[mapIndex].tiles[2][17].placeOccupant( fYoung, "- Are you sure you cracked all our riddles?" );
  //G Girl's brother
  m[mapIndex].tiles[40][2].placeOccupant( mYoung, "- My sister and her friends are weird. She barely even uses that bed anymore." );
  //People in houses
  m[mapIndex].tiles[51][1].placeOccupant( male, "- Visit our bathhouse. We are proud of them in Waraka. Oh, that was not a suggestion. You smell like wet rats." );
  m[mapIndex].tiles[60][1].placeOccupant( male, "- Waraka controls trade along the coast. We see many exotic people and crafts." );
  m[mapIndex].tiles[62][1].placeOccupant( male, "- Quiet, I'm concentrating. With every move sideways, I am forced to move down. I think I can barely make it." );
  m[mapIndex].tiles[84][2].placeOccupant( female, "- Where are your sisters? Were they sneaking around the village hiding things again?" );
  m[mapIndex].tiles[83][1].placeOccupant( mYoung, "- UNUSED TEXT" );
  m[mapIndex].tiles[84][1].placeOccupant( mYoung, "- UNUSED TEXT" );
  m[mapIndex].tiles[85][1].placeOccupant( mYoung, "- UNUSED TEXT" );
  //Bathhouse
  m[mapIndex].tiles[42][11].placeOccupant( male, "- Leave me be." );
  m[mapIndex].tiles[41][12].placeOccupant( male, "- We have scented soaps, if you like, imported from Mariva." );
  m[mapIndex].tiles[44][11].placeOccupant( male, "- UNUSED TEXT" );
  m[mapIndex].tiles[50][11].placeOccupant( female, "- *yawn*" );
  m[mapIndex].tiles[49][12].placeOccupant( female, "- Ah, so warm. The water is heated with red crystal from a spirit cave near the capital. We pay a lot for them." );
  m[mapIndex].tiles[51][13].placeOccupant( female, "- They have beds for massage and rest, if you are weary." );
  m[mapIndex].tiles[61][11].placeOccupant( male, "- Did you enjoy your soak? I keep the baths clean, while my wife has hands that can wrest the ache out of the most intractable muscle." );
  m[mapIndex].tiles[60][11].placeOccupant( female, "She looks down at you while cracking her knuckles. - I think not. It would be dangerous on ones so soft." );
  m[mapIndex].tiles[61][13].placeOccupant( female, "- I come here for the aches in my back." );
  //Shop
  m[mapIndex].tiles[79][11].placeOccupant( color(150,50,165), "- We bake our bread with bumblewere honey. Buy before the cost of their honey goes up." );
  m[mapIndex].tiles[79][12].placeShop( new Item( "Sweet Bread",10 ), 15 );
  m[mapIndex].tiles[73][11].placeOccupant( color(150,50,165), "- Warakan Mead jolts the system with a rush of vigor." );
  m[mapIndex].tiles[73][12].placeShop( new Item( "Warakan Mead",12 ), 25 );
  m[mapIndex].tiles[77][12].placeOccupant( color(150,50,165), "- I've been searching for two days now! Where is that key?" );
  //Barn
  m[mapIndex].tiles[17][1].placeOccupant( color(130,110,70), "- *Mooo*" );
  m[mapIndex].tiles[18][1].placeOccupant( mYoung, "- Some of our animals have gone missing, but I can still hear them at night." );
  m[mapIndex].tiles[19][1].placeOccupant( color(130,110,70), "- *Mooo*" );
  m[mapIndex].tiles[20][1].placeOccupant( fYoung, "- I hate milking. I wish I were in a tomb. *giggle*" );
  //Hut
  m[mapIndex].tiles[96][14].placeOccupant( fYoung, "- Will you make him stop?" );
  m[mapIndex].tiles[98][14].placeOccupant( mYoung, "- Buzz! Buzz! I'll sting you! Watch out!" );
  //Honeydell kids
  m[mapIndex].tiles[46][59].placeOccupant( fYoung, "She's barely awake. Her shirt is crusty with honey and her hand his stuck to her cheek." );
  m[mapIndex].tiles[49][58].placeOccupant( mYoung, "- Did momma send you to get us? Can we stay a little longer? Please?" );
  m[mapIndex].tiles[52][59].placeOccupant( fYoung, "~ I am quick like a buzzing bee ~ Nasty men will not find me" );
  //Honeydell bandits
  m[mapIndex].tiles[20][93].placeOccupant( #812323, "She glares at you as blood trickles down her face. She's no threat to you anymore." );
  m[mapIndex].tiles[18][93].placeOccupant( #09215a, "You've broken his staff and his arm." );
  //Honeydell beds
  m[mapIndex].tiles[64][82].placeOccupant( color(255,0), "- The bedding has been removed." );
  m[mapIndex].tiles[64][83].placeOccupant( color(255,0), "- Someone has used the matress to test their knives." );
  m[mapIndex].tiles[64][85].placeOccupant( color(255,0), "- It stinks of rotten food." );
  m[mapIndex].tiles[54][82].placeOccupant( color(255,0), "- Someone slept here recently. You wouldn't want to be caught sleeping if they returned." );
  m[mapIndex].tiles[54][84].placeOccupant( color(255,0), "- It's surprisingly well kept." );
  
  //Secret shop key
  createLoot(lootIndex++, mapIndex, 75, 11, Key.CAVE );
  //Grave Keys
  createLoot(lootIndex++, mapIndex, 42, 1, Key.GRAVE );
  //Grave Rewards
  createLoot(lootIndex++, mapIndex, 6, 17, new Item("Health Potion",12) );
  createLoot(lootIndex++, mapIndex, 1, 17, new Equipment("Grave Gown","graveShirt.png",25,false,24,Job.THIEF,Job.KARATE,Job.PRIEST,Job.MAGE) );
  //Sea Road Tunnel
  createLoot(lootIndex++, mapIndex, 11, 26, new Item("Bread",10 ) );
  //Ruined Temple
  createLoot(lootIndex++, mapIndex, 98, 23, new Item("Meat",20 ) );
  //First Hive Treasure
  createLoot(lootIndex++, mapIndex, 66, 28, new Item("Royal Jelly",26 ) );
  //Ruined village key
  createLoot(lootIndex++, mapIndex, 71, 37, Key.IRON_KEY );
  //Second Hive Treasure
  createLoot(lootIndex++, mapIndex, 19, 55, new Item("Royal Jelly",26 ) );
  //Manor
  createLoot(lootIndex++, mapIndex, 79, 84, new Item("Bread",10 ) ); //kitchen
  createLoot(lootIndex++, mapIndex, 54, 83, new Item("Bread",10 ) ); //bedroom
  createLoot(lootIndex++, mapIndex, 88, 72, new Item("Meat", 20 ) ); //larder
  createLoot(lootIndex++, mapIndex, 84, 73, new Item("Meat", 20 ) ); //larder
  createLoot(lootIndex++, mapIndex, 81, 74, new Item("Bread",10 ) ); //larder
  createLoot(lootIndex++, mapIndex, 85, 75, new Item("Bread",10 ) ); //larder
  createLoot(lootIndex++, mapIndex, 12, 93, Key.BRASS_KEY );
  createLoot(lootIndex++, mapIndex, 12, 94, new Equipment("Plundered Chain","chainBroken.png",19,false,29,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.PRIEST) );
  //Queen Treasures
  createLoot(lootIndex++, mapIndex, 15, 43, new Item("Larval Queen", 45 ) );
  createLoot(lootIndex++, mapIndex, 19, 43, new Equipment("Stinger","stinger.png",15,true,30.02,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID) );
  
  //Dragon Ninja (graveyard)
  m[mapIndex].tiles[3][25].placeOccupant( chilxius, "- Do the Graveyard Girls really still meet? That brings back memories." );
  //Dragon Treasure
  createLoot(lootIndex++, mapIndex, 2, 25, new Item("Onyx Vanguard", 27) );
  createLoot(lootIndex++, mapIndex, 1, 25, Key.DRAGON );
  //Dragon Ninja (manor)
  m[mapIndex].tiles[97][72].placeOccupant( chilxius, "- This manor was once used as a smuggler's cache during the embargo. It was before your time." );
  //Dragon Treasure
  createLoot(lootIndex++, mapIndex, 98, 72, Key.DRAGON );
  createLoot(lootIndex++, mapIndex, 98, 73, new Item("Gold Hexagon", 27) );
  
  //Bandit                                                                                                  //String n, String image,  health, s,  d,  c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[97][24].placeBoss( mapIndex, color(#6d4800), "- You shouldn't have come here.", new Monster("Lone Bandit", "bandit.png", 120, 26, 32, 7, 1, 4, 20, 10, AttackType.NONE, 6), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("flings knives!", 50, true, "P" );
    zoo.boss[bossIndex].attacks[1] = new Attack("flings knives!", 50, true, "P" );
    zoo.boss[bossIndex].attacks[2] = new Attack("uses a toxin.", 65, false, Debuff.SLEEP, "S" );
    zoo.boss[bossIndex].attacks[3] = new Attack("uses a toxin.", 65, false, Debuff.POISON, "S" );
    zoo.boss[bossIndex].attacks[4] = new Attack("pierces your armor!", 80, false, AttackStat.DEX, AttackType.NONE, "P" );
  bossIndex++;  
  //Wax Golem guarding jelly                                                                                     //String n, String image,  health, s,  d,  c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[96][36].placeBoss( mapIndex, color(#a18000), "The mass of wax and honey animates.", new Monster("Wax Golem", "honeyGolem.png", 100, 24, 15, 9, 1, 4,  13, 0, AttackType.FIRE, 10), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("slams its fist.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its elbow.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("stomps its foot.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("flings hot wax!", 70, false, AttackStat.STR, AttackType.FIRE, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("lumbers forward.");
  bossIndex++;  
  //Wax Golem (Hive exit)                                                                                              //String n, String image,  health, s,  d,  c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[2][49].placeBoss( mapIndex, color(#a18000), "Its massive frame blocks the passage.", new Monster("Wax Golem", "honeyGolem.png", 100, 24, 15, 9, 1, 4,  13, 0, AttackType.FIRE, 10), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("slams its fist.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its elbow.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("stomps its foot.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("sprays hot wax!", 50, false, AttackStat.STR, AttackType.FIRE, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("reattaches is broken pieces.");
  bossIndex++;
  //Wax Golem
    m[mapIndex].tiles[82][39].placeBoss( mapIndex, color(#a18000), "This one is larger, and faster.", new Monster("Wax Golem", "honeyGolem.png", 120, 24, 18, 9, 1, 4,  16, 0, AttackType.FIRE, 10), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("swings its fists!", 65, true, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its elbow.", 65, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("stomps its foot.", 65, false, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("flings hot wax!", 70, false, AttackStat.STR, AttackType.FIRE, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("lets out an echoing roar!");
  bossIndex++;
  //Bandit Boss
    m[mapIndex].tiles[19][94].placeBoss( mapIndex, #d28200, "- Stand and deliver!", new Monster("Bandit Boss", "banditBoss.png", 160, 28, 30, 9, 18, 9, 22, 0, AttackType.NONE, 20), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("flings knives.", 65, true, "P" );
    zoo.boss[bossIndex].attacks[1] = new Attack("flicks a poison knife.", 65, false, Debuff.POISON, "P" );
    zoo.boss[bossIndex].attacks[2] = new Attack("conjures spikes of stone.", 65, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[3] = new Attack("thrusts for the heart!", 70, false, Debuff.SLEEP, "P" );
    zoo.boss[bossIndex].attacks[4] = new Attack("slices for the neck!", 70, false, Debuff.SLEEP, "S" );
  bossIndex++;
  //Queen Bee                                                                                                //String n, String image,  health, s,  d, c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[17][43].placeBoss( mapIndex, #cd7100, "This is the buzzing heart of the swarm.", new Monster("Queen", "queenBee2.png", 150, 28, 35, 8, 20, 7, 25, 0, AttackType.NONE), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("delivers a crushing bite.", 80, false, Debuff.POISON, "T" );
    zoo.boss[bossIndex].attacks[1] = new Attack("jabs with her barbed stinger.", 70, false, Debuff.SLEEP, "P" );
    zoo.boss[bossIndex].attacks[2] = new Attack("commands her hive to crush you!", 55, false, AttackStat.MAG, AttackType.EARTH, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("summons a swarm!", 70, true, "T" );
    zoo.boss[bossIndex].attacks[4] = new Attack("sprays pollen.", 30, true, Debuff.SLEEP, "W" );
  bossIndex++;
  
  //Danger Map 5
  dangerMapIndex = mapIndex; dangerStrs[dangerMapIndex] = "";
  
  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createFloor6()
{
//---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 6 - Underground River Rapids
  
  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("map"+mapIndex+".txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);
  
  //First Flume to First Chamber
  exits.add( new Portal(mapIndex,3,51, mapIndex,10,0) );
  //First Chamber recovery chute
  exits.add( new Portal(mapIndex,10,12, mapIndex,1,58) );
  exits.add( new Portal(mapIndex,5,60,  mapIndex,25,0) );
  //First Chamber treasure chute (chamber - tunnel - swirl - chamber)
  exits.add( new Portal(mapIndex,60,17, mapIndex,1,98) );
  exits.add( new Portal(mapIndex,1,81, mapIndex,7,74) );
  exits.add( new Portal(mapIndex,3,72, mapIndex,29,0) );
  //First Chamber to first decision fork
  exits.add( new Portal(mapIndex,44,23, mapIndex,52,0) );
  //North path
  exits.add( new Portal(mapIndex,76,1, mapIndex,12,25) );
  exits.add( new Portal(mapIndex,18,52, mapIndex,52,0) );
  //South path
  exits.add( new Portal(mapIndex,73,9, mapIndex,67,16) );
  exits.add( new Portal(mapIndex,97,25, mapIndex,52,0) );
  
  //Kat's Ice Bob Kit
  createLoot(lootIndex++, mapIndex, 31, 13, Key.I );
  //First waterway treasure
  //createLoot(lootIndex++, mapIndex, 5, 91, ITEM );
  
  //Inspect shipwreck
  m[mapIndex].tiles[44][13].createEvent(false, "- The wreckage of a small boat is caught against a stalagmite.");
  //Kat's Ice Bomb Kit
  m[mapIndex].tiles[31][12].createEvent(false, "- The rats were chewing into a leather box. You recognize Sister Kat's monogram on it.");
  //First decision fork
  m[mapIndex].tiles[65][3].createEvent(false, "- The current seems calmer in the northern passage. You recognize the noxious scent of Sister Kat's potions to the south.");
  
  ////Squid Test
  //m[mapIndex].tiles[2][2].placeBoss( mapIndex, color(#369c46), "TEST", new Monster("Giant Squid", "GreenSquidBoss.png",  7, 4, 2, 1, 6, 1, 2, 0, AttackType.FIRE), false);
  //  zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
  //  zoo.boss[bossIndex].attacks[1] = new Attack("scurries.");
  //  zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 35, false);
  //  zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 35, false);
  //  zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 35, false);
  //bossIndex++;

   //Danger Map 6
  dangerMapIndex = mapIndex; dangerStrs[dangerMapIndex] = "";
  
  inputTest = loadStrings("danger"+mapIndex+".txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void createTestRoom()
{
//---------------------------------------------------------------------------------------------------------------------------\\
  //Floor X - TEST ROOMS
  
  mapIndex++; mapStrings[mapIndex] = "";

  String[] inputTest = loadStrings("mapX.txt");
  String nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  m[mapIndex] = new Map(nextMap,mapIndex);

  savePoints[savePointIndex++] = new SavePoint(mapIndex,50,2);

  //Signs
  m[mapIndex].tiles[44][2].createEvent(true, "- Tiny Rat.");
  m[mapIndex].tiles[40][2].createEvent(true, "- Rat.");
  m[mapIndex].tiles[36][2].createEvent(true, "- Large Rat.");
  m[mapIndex].tiles[32][2].createEvent(true, "- Giant Rat.");
  m[mapIndex].tiles[28][2].createEvent(true, "- Rat Queen.");
  
  m[mapIndex].tiles[44][8].createEvent(true, "- Escaped Rat.");
  m[mapIndex].tiles[40][8].createEvent(true, "- Large Rat.");
  m[mapIndex].tiles[36][8].createEvent(true, "- Spider.");
  m[mapIndex].tiles[32][8].createEvent(true, "- Red Spider.");
  m[mapIndex].tiles[28][8].createEvent(true, "- The Man Wolf.");
  m[mapIndex].tiles[44][10].createEvent(true, "- Burning Rat.");
  
  m[mapIndex].tiles[44][14].createEvent(true, "- Skeleton.");
  m[mapIndex].tiles[40][14].createEvent(true, "- Fragile Skeleton.");
  m[mapIndex].tiles[36][14].createEvent(true, "- Sturdy Skeleton.");
  m[mapIndex].tiles[32][14].createEvent(true, "- Fragile Skeleton. (Advanced)");
  m[mapIndex].tiles[28][14].createEvent(true, "- Sturdy Skeleton. (Advanced)");
  m[mapIndex].tiles[24][14].createEvent(true, "- Blackened Skeleton.");
  m[mapIndex].tiles[20][14].createEvent(true, "- Guardian.");
  m[mapIndex].tiles[16][14].createEvent(true, "- Necromancer.");
  
  m[mapIndex].tiles[44][16].createEvent(true, "- Alar.");
  m[mapIndex].tiles[40][16].createEvent(true, "- Corel.");
  m[mapIndex].tiles[36][16].createEvent(true, "- Ruath.");
  m[mapIndex].tiles[32][16].createEvent(true, "- Zan.");
  m[mapIndex].tiles[28][16].createEvent(true, "- Ivy.");
  m[mapIndex].tiles[24][16].createEvent(true, "- Erar.");
  
  m[mapIndex].tiles[44][20].createEvent(true, "- Bilge Rat.");
  m[mapIndex].tiles[40][20].createEvent(true, "- Abyss Rat.");
  m[mapIndex].tiles[36][20].createEvent(true, "- Giant Bilge Rat.");
  m[mapIndex].tiles[32][20].createEvent(true, "- Deep Ratlord.");
  
  m[mapIndex].tiles[44][26].createEvent(true, "- Nectarseeker.");
  m[mapIndex].tiles[40][26].createEvent(true, "- Drone.");
  m[mapIndex].tiles[36][26].createEvent(true, "- Swarm.");
  m[mapIndex].tiles[32][26].createEvent(true, "- Wax Golem 1.");
  m[mapIndex].tiles[28][26].createEvent(true, "- Wax Golem 2.");
  m[mapIndex].tiles[24][26].createEvent(true, "- Queen.");
  m[mapIndex].tiles[44][28].createEvent(true, "- Bandit.");
  m[mapIndex].tiles[40][28].createEvent(true, "- Bandit Mage.");
  m[mapIndex].tiles[36][28].createEvent(true, "- Bandit Boss.");
  
  //Tiny Rat
  m[mapIndex].tiles[43][1].placeBoss( mapIndex, color(150, 80, 40), "Tiny Rat", new Monster("Tiny Rat", "GreyRat.png",  1, 1, 1, 1, 6, 1, 4, 0, AttackType.FIRE), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("scurries.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 20, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 20, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 20, false, "B");
  bossIndex++;
  //Rat
  m[mapIndex].tiles[39][1].placeBoss( mapIndex, color(150, 80, 40), "Rat", new Monster("Rat", "SlimyRat.png",  4, 3, 2, 1, 6, 1, 2, 0, AttackType.FIRE), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("scurries.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 30, false, "B");
  bossIndex++;
  //Large Rat
  m[mapIndex].tiles[35][1].placeBoss( mapIndex, color(150, 80, 40), "Large Rat", new Monster("Large Rat", "DarkRat.png",  7, 4, 2, 1, 6, 1, 2, 0, AttackType.FIRE), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("scurries.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 35, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 35, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 35, false, "B");
  bossIndex++;
  //Giant Rat
  m[mapIndex].tiles[31][1].placeBoss( mapIndex, color(150, 80, 40), "Giant Rat", new Monster("Giant Rat", "BrownRat.png", 18, 5, 5, 1, 12, 1, 3, 0, AttackType.FIRE), true );
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 29, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 34, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 39, false, "B");
  bossIndex++;
  //Rat Queen
  m[mapIndex].tiles[27][1].placeBoss( mapIndex, color(200, 80, 40), "Rat Queen.", new Monster("Rat Queen", "RedRat.png", 35, 12, 5, 2, 24, 3, 5, 0, AttackType.NONE), true );
    zoo.boss[bossIndex].attacks[0] = new Attack("eyes you hungrily.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 35, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites and scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[3] = new Attack("whips her tail.", 35, false, "S");
    zoo.boss[bossIndex].attacks[4] = new Attack("summons her brood!", 30, true, "B");
  bossIndex++;
    
  //Act 1 Items
  createLoot(lootIndex++, mapIndex, 56, 1, new Equipment("Brocade","YellowShirt.png",5,false,5,true));
  m[mapIndex].tiles[55][2].createEvent(true, "Brocade.");
  createLoot(lootIndex++, mapIndex, 59, 1, new Equipment("Ivory Knife","IceDagger2.png",15,true,15,true));
  m[mapIndex].tiles[58][2].createEvent(true, "Ivory Knife.");
  createLoot(lootIndex++, mapIndex, 62, 1, new Equipment("Staff","Staff.png",2,true,14,Job.KNIGHT,Job.PRIEST,Job.DRUID,Job.MAGE));
  m[mapIndex].tiles[61][2].createEvent(true, "Staff.");
  createLoot(lootIndex++, mapIndex, 65, 1, new Equipment("Vestment","BlueShirt.png",3,false,7,true));
  m[mapIndex].tiles[64][2].createEvent(true, "Vestment.");
  createLoot(lootIndex++, mapIndex, 68, 1, new Equipment("Knife","MetalDagger2.png",4,true,12,true) );
  m[mapIndex].tiles[67][2].createEvent(true, "Knife.");
  createLoot(lootIndex++, mapIndex, 71, 1, new Equipment("Rusty Sword","CrimsonSword.png",6,true,20,Job.KNIGHT,Job.BARBARIAN,Job.BARD) );
  m[mapIndex].tiles[70][2].createEvent(true, "Rusty Sword.");
  createLoot(lootIndex++, mapIndex, 74, 1, new Equipment("Old Leather","LeatherArmor.png",5,false,10,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.PRIEST) );
  m[mapIndex].tiles[73][2].createEvent(true, "Old Leather.");
  //Act 1 Special Item
  createLoot(lootIndex++, mapIndex, 56, 5, new Equipment("Admirer's Chain","MetalMail.png",18,false,20,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST,Job.BARD) );
  m[mapIndex].tiles[55][4].createEvent(true, "Admirer's Chain.");
  
  //Escaped Rat
  m[mapIndex].tiles[43][7].placeBoss( mapIndex, color(150, 80, 40), "Escaped Rat.", new Monster("Escaped Rat", "BrownRat.png", 20, 11, 15, 2, 0, 2, 4, 0, AttackType.FIRE), true );
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks angrily.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites and claws.", 40, false, "S");
    zoo.boss[bossIndex].attacks[4] = new Attack("swipes with its tail.", 30, true, "S");
  bossIndex++;
  //Large Rat
  m[mapIndex].tiles[39][7].placeBoss( mapIndex, color(150, 80, 40), "Large Rat.", new Monster("Large Rat", "DarkRat.png",    7, 4, 2, 1, 0, 1, 2, 0, AttackType.FIRE), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
    zoo.boss[bossIndex].attacks[1] = new Attack("scurries.");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 40, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 40, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 40,  false, "B");
  bossIndex++;
  //Spider
  m[mapIndex].tiles[35][7].placeBoss( mapIndex, color(0,100,0), "Spider.", new Monster("Spider",  "GreenSpider.png",  9, 5, 13, 2, 0, 2, 4, 0, AttackType.NONE), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("scratches.", 35, false, "S");
    zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 35, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites your foot.", 5, false, Debuff.POISON, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites your arm.", 5, false, Debuff.POISON, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites your leg.", 5, false, Debuff.POISON, "B");
  bossIndex++;
  //Red Spiders
  m[mapIndex].tiles[31][7].placeBoss( mapIndex, color(200,0,0), "Red Spider.", new Monster("Red Spider", "RedSpider.png", 10, 5, 10, 3, 0, 3, 5, 0, AttackType.NONE), true );
    zoo.boss[bossIndex].attacks[0] = new Attack("scurries forward.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites your arm.", 30, false, Debuff.POISON, "T");
    zoo.boss[bossIndex].attacks[2] = new Attack("bites your leg.", 35, false, Debuff.POISON, "T");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites your neck.", 45, false, Debuff.POISON, "T");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites your hand.", 25, false, Debuff.POISON, "T");
  bossIndex++;
  //The man-wolf
  m[mapIndex].tiles[27][7].placeBoss( mapIndex, color(58,39,30), "The Man-wolf.", new Monster("Man-wolf", "BrownWerewolf.png", 50, 20, 20, 3, 0, 5, 40, 0, AttackType.FIRE), true );
    zoo.boss[bossIndex].attacks[0] = new Attack("howls!");
    zoo.boss[bossIndex].attacks[1] = new Attack("claws.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("rends and claws!", 40, true, "S");
    zoo.boss[bossIndex].attacks[3] = new Attack("rends.", 40, false, "S");
    zoo.boss[bossIndex].attacks[4] = new Attack("bites!", 50, false, "T");
  bossIndex++;
  //Burning Rat
  m[mapIndex].tiles[43][11].placeBoss( mapIndex, color(150, 80, 40), "Burning Rat.", new Monster("Burning Rat", "fireRat.png", 45, 9, 10, 3, 9, 5, 7, 0, AttackType.ICE), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("bites.", 35, false, "B");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 35, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("coughs out fire.", 20, true, AttackStat.MAG, AttackType.FIRE, "F");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites with its glowing mouth.", 40, false, AttackStat.MAG, AttackType.FIRE, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("coughs up black smoke.");
  bossIndex++;
    
  //Act 2 Items
  createLoot(lootIndex++, mapIndex, 56, 7, new Equipment("Old Plate","RustyArmor.png",7,false,18,Job.KNIGHT,Job.PRIEST) );
  m[mapIndex].tiles[55][8].createEvent(true, "Old Plate.");
  createLoot(lootIndex++, mapIndex, 59, 7, new Equipment("Axe","MetalSpikedAxe.png",9,true,22,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.DRUID) );
  m[mapIndex].tiles[58][8].createEvent(true, "Axe.");
  createLoot(lootIndex++, mapIndex, 62, 7, new Equipment("Hunter's Garb","GreenLeatherArmor.png",4,false,14,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.BARD,Job.PRIEST,Job.DRUID) );
  m[mapIndex].tiles[61][8].createEvent(true, "Hunter's Garb.");
  createLoot(lootIndex++, mapIndex, 65, 7, new Equipment("Spidersilk","WhiteShirt.png",21,false,12,true) );
  m[mapIndex].tiles[64][8].createEvent(true, "Spidersilk.");
  //Act 2 Special Item
  createLoot(lootIndex++, mapIndex, 56, 11, new Equipment("Ratfang","Ratfang.png",15,true,20.01,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );
  m[mapIndex].tiles[55][10].createEvent(true, "Ratfang.");
  
  //Skeleton
  m[mapIndex].tiles[43][13].placeBoss( mapIndex, color(230), "Skeleton.", new Monster("Skeleton", "Skeleton.png", 35, 9, 1, 2, 1, 3, 6, 0, AttackType.HOLY),true );
    zoo.boss[bossIndex].attacks[0] = new Attack("tackles.", 40, false, "B");
    zoo.boss[bossIndex].attacks[1] = new Attack("swipes.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("throws a rib.", 45, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bashes with its skull.", 45, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("clubs with a femur!", 55, false, "B");
  bossIndex++;
  m[mapIndex].tiles[39][13].placeBoss( mapIndex, color(230,230,200), "Fragile Skeleton.", new Monster("Fragile Skeleton",  "WeakSkeleton2.png",  20, 10, 20, 2, 0, 3, 7, 0, AttackType.HOLY), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("crumbles as it moves.");
    zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("lunges forward.", 45, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 50, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("flails wildly.", 30, true, "B");
  bossIndex++;
  m[mapIndex].tiles[35][13].placeBoss( mapIndex, color(230,150,50), "Sturdy Skeleton.", new Monster("Sturdy Skeleton",  "WeakSkeleton3.png",  30, 15, 10, 3, 0, 2, 5, 0, AttackType.HOLY), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("rattles.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bashes.", 45, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("bashes with a rock.", 50, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("slams its body.", 55, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("strikes with a bone spur.", 50, false, "B");
  bossIndex++;
  m[mapIndex].tiles[31][13].placeBoss( mapIndex, color(230,230,200), "Fragile Skeleton 2", new Monster("Fragile Skeleton",  "WeakSkeleton.png",  20, 14, 20, 3, 0, 4, 8, 0, AttackType.HOLY), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("crumbles as it moves.");
    zoo.boss[bossIndex].attacks[1] = new Attack("cuts.", 40, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("lunges forward.", 45, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 50, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("flails wildly.", 30, true, "B");
  bossIndex++;
  m[mapIndex].tiles[27][13].placeBoss( mapIndex, color(230,150,50), "Sturdy Skeleton 2", new Monster("Sturdy Skeleton",  "WeakSkeleton4.png",  35, 17, 10, 4, 0, 3, 7, 0, AttackType.HOLY), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("rattles.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bashes.", 45, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("bashes with a rock.", 50, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("slams its axe.", 55, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("strikes with a bone spur.", 50, false, "B");
  bossIndex++;
  m[mapIndex].tiles[23][13].placeBoss( mapIndex, color(50), "Blackened Skeleton.", new Monster("Blackened Skeleton",  "DarkSkeleton.png",  45, 19, 5, 7, 0, 4, 6, 0, AttackType.HOLY), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("laughs.");
    zoo.boss[bossIndex].attacks[1] = new Attack("strikes with its knee.", 45, false, "B");
    zoo.boss[bossIndex].attacks[2] = new Attack("strikes your chest.", 55, false, "B");
    zoo.boss[bossIndex].attacks[3] = new Attack("slams with its arm.", 55, false, "B");
    zoo.boss[bossIndex].attacks[4] = new Attack("gives an icy stare.", 30, true, AttackStat.MAG, AttackType.ICE, "I");
  bossIndex++;
  m[mapIndex].tiles[19][13].placeBoss( mapIndex, color(90,90,90), "Skeletal Guardian.", new Monster("Skeletal Guardian", "DarkScimitarSkeleton.png", 50, 15, 5, 7, 0, 5, 9, 0, AttackType.HOLY), true);
    zoo.boss[bossIndex].attacks[0] = new Attack("prepares for your attack.");
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its sword.", 45, false, "S");
    zoo.boss[bossIndex].attacks[2] = new Attack("swings wide!", 45, true, "S" );
    zoo.boss[bossIndex].attacks[3] = new Attack("bashes with the pommel.", 45, false, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("lunges!", 55, false, "B" );
  bossIndex++;
  //Necromancer
  m[mapIndex].tiles[15][13].placeBoss( mapIndex, color(77,20,20), "Necromancer.", new Monster("Body of Necromancer", "Necro.png", 150, 20, 15, 6, 15, 10, 10, 50, AttackType.HOLY) );
    zoo.boss[bossIndex].attacks[0] = new Attack("stabs with a wicked knife.", 45, false, Debuff.POISON, "B");
    zoo.boss[bossIndex].attacks[1] = new Attack("exhales chilling air.", 40, true, AttackStat.MAG, AttackType.ICE, "I" );
    zoo.boss[bossIndex].attacks[2] = new Attack("drops stones to bury you!", 55, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[3] = new Attack("drops stones to bury you!", 55, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[4] = new Attack("causes your very bones to freeze!", 55, true, AttackStat.MAG, AttackType.ICE, "I" );
  bossIndex++;
  //Crypt Guardians
  m[mapIndex].tiles[43][17].placeBoss( mapIndex, color(255), "Alar. (Axe)", new Monster("Body of Alar", "Crypt1.png", 50, 13, 10, 7, 1, 3, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("strikes with its knee.", 40, false, "B");
      zoo.boss[bossIndex].attacks[1] = new Attack("kicks.", 40, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("swings wide.", 40, true, "S");
      zoo.boss[bossIndex].attacks[3] = new Attack("swings its axe!", 60, false, "S");
      zoo.boss[bossIndex].attacks[4] = new Attack("swings its axe!", 60, false, "S");
  bossIndex++;
  m[mapIndex].tiles[39][17].placeBoss( mapIndex, color(255), "Corel. (Hide)", new Monster("Body of Corel", "Crypt6.png", 50, 13, 15, 7, 1, 3, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("growls.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swipes.", 40, false, "S");
      zoo.boss[bossIndex].attacks[2] = new Attack("lunges like a beast!", 60, false, "B");
      zoo.boss[bossIndex].attacks[3] = new Attack("bashes with its jaw!", 60, false, "B");
      zoo.boss[bossIndex].attacks[4] = new Attack("bashes with its club!!", 60, false, "B");
  bossIndex++;
  m[mapIndex].tiles[35][17].placeBoss( mapIndex, color(255), "Ruath. (Purifier)", new Monster("Body of Ruath", "Crypt2.png", 50, 8, 10, 6, 8, 6, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("intones muddled words.");
      zoo.boss[bossIndex].attacks[1] = new Attack("strikes with its hand.", 40, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("smites!", 60, false, AttackStat.STR, AttackType.HOLY, "H");
      zoo.boss[bossIndex].attacks[3] = new Attack("shines with holy light.", 30, true, AttackStat.MAG, AttackType.HOLY, "H");
      zoo.boss[bossIndex].attacks[4] = new Attack("swings its mace!", 60, false, "B");
  bossIndex++;
  m[mapIndex].tiles[31][17].placeBoss( mapIndex, color(255), "Zan. (Armor)", new Monster("Body of Zan", "Crypt3.png", 50, 9, 10, 10, 1, 4, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("readies for your attack.");
      zoo.boss[bossIndex].attacks[1] = new Attack("attacks.", 45, false, "S");
      zoo.boss[bossIndex].attacks[2] = new Attack("strikes with the flat of its blade.", 50, false, "B");
      zoo.boss[bossIndex].attacks[3] = new Attack("stabs at you.", 55, false, "B");
      zoo.boss[bossIndex].attacks[4] = new Attack("swings its weapon!", 60, false, "S");
  bossIndex++;
  m[mapIndex].tiles[27][17].placeBoss( mapIndex, color(255), "Ivy. (Robe)", new Monster("Body of Ivy", "Crypt4.png", 50, 2, 10, 2, 8, 9, 7, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("gazes silently.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its staff.", 45, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("levitates a tomb stone.", 50, false, AttackStat.MAG, AttackType.EARTH, "E" );
      zoo.boss[bossIndex].attacks[3] = new Attack("speaks a secret word.", 55, false, AttackStat.MAG, AttackType.HOLY, "H" );
      zoo.boss[bossIndex].attacks[4] = new Attack("summons a storm of tomb dust!", 50, true, AttackStat.MAG, AttackType.WIND, "W" );
  bossIndex++;
  m[mapIndex].tiles[23][17].placeBoss( mapIndex, color(255), "Erar. (Flamecaster)", new Monster("Body of Erar", "Crypt5.png", 50, 2, 10, 2, 9, 8, 7, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("makes arcane gestures.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its staff.", 45, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("causes the crypt to shake!", 45, true, AttackStat.MAG, AttackType.EARTH, "E" );
      zoo.boss[bossIndex].attacks[3] = new Attack("delivers an icy touch.", 50, false, AttackStat.MAG, AttackType.ICE, "I" );
      zoo.boss[bossIndex].attacks[4] = new Attack("conjures a ring of fire!", 55, true, AttackStat.MAG, AttackType.FIRE, "F" );
  bossIndex++;
  
  //Act 3 Items
  m[mapIndex].tiles[55][14].createEvent(true, "Club.");
  createLoot(lootIndex++, mapIndex, 56, 13, new Equipment( "Club","OldClub.png", 7, true, 21, Job.KNIGHT, Job.BARBARIAN, Job.SAURIAN, Job.THIEF, Job.DRUID, Job.PRIEST ) );
  m[mapIndex].tiles[58][14].createEvent(true, "Knife.");
  createLoot(lootIndex++, mapIndex, 59, 13, new Equipment( "Dagger","MetalDagger2.png", 5, true, 12, true ) );
  m[mapIndex].tiles[61][14].createEvent(true, "Iron Plate.");
  createLoot(lootIndex++, mapIndex, 62, 13, new Equipment( "Iron Plate","MetalArmor.png", 15, false, 24, Job.KNIGHT, Job.PRIEST ) );
  
  //Act 3 Special Items
  m[mapIndex].tiles[55][16].createEvent(true, "Alar's Axe.");
  createLoot(lootIndex++, mapIndex, 56, 17, new Equipment("Alar's Axe","MetalAxe.png",25,true,27,Job.KNIGHT,Job.BARBARIAN) );
  m[mapIndex].tiles[58][16].createEvent(true, "Lion's Hide.");
  createLoot(lootIndex++, mapIndex, 59, 17, new Equipment("Lion's Hide","fur.png",25,false,25,Job.BARBARIAN,Job.DRUID) );
  m[mapIndex].tiles[61][16].createEvent(true, "Purifier.");
  createLoot(lootIndex++, mapIndex, 62, 17, new Equipment("Purifier","StoneClub.png",25,true,27.5,Job.KNIGHT,Job.PRIEST) );
  m[mapIndex].tiles[64][16].createEvent(true, "Cold Iron Plate.");
  createLoot(lootIndex++, mapIndex, 65, 17, new Equipment("Cold Iron Plate","DarkArmor.png",25,false,28,Job.KNIGHT, Job.PRIEST) );
  m[mapIndex].tiles[67][16].createEvent(true, "Scholar's Robe.");
  createLoot(lootIndex++, mapIndex, 68, 17, new Equipment("Scholar's Robe","aquaRobes.png",25,false,18, Job.KARATE, Job.BARD, Job.DRUID, Job.PRIEST, Job.MAGE) );
  m[mapIndex].tiles[70][16].createEvent(true, "Flamecaster Staff.");
  createLoot(lootIndex++, mapIndex, 71, 17, new Equipment("Flamecaster","Staff2.png",25,true,27.2,Job.DRUID,Job.MAGE) );
  m[mapIndex].tiles[73][16].createEvent(true, "Ritual Knife.");
  createLoot(lootIndex++, mapIndex, 74, 17, new Equipment("Ritual Knife","curvedDagger.png",35,true,25.4,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );
  
  //Bilge Rat
  m[mapIndex].tiles[43][19].placeBoss( mapIndex, color(#4c585c), "Bilge Rat.", new Monster("Bilge Rat",  "blueRat.png",  30, 19, 15, 5, 5, 4, 12, 0, AttackType.FIRE), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("coughs up salt water.");
      zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false, "S");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 55, false, "B");
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 55, false, "B");
      zoo.boss[bossIndex].attacks[4] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE, "I");
      //zoo.boss[bossIndex].attacks[0] = new Attack("bites.", 55, false, Debuff.PARA);
      //zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false, Debuff.PARA);
      //zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 55, false, Debuff.PARA);
      //zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 55, false, Debuff.PARA);
      //zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 55, false, Debuff.PARA);
  bossIndex++;
  //Abyss Rat
  m[mapIndex].tiles[39][19].placeBoss( mapIndex, color(140,150,150), "Abyss Rat.", new Monster("Abyss Rat",  "abyssRat.png",  40, 10, 20, 4, 13, 8, 10, 0, AttackType.HOLY), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("watches you silently.");
      zoo.boss[bossIndex].attacks[1] = new Attack("sprays icy seawater.", 30, true, AttackStat.MAG, AttackType.ICE, "I");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites with an icy fang.", 35, false, AttackStat.MAG, AttackType.ICE, "I");
      zoo.boss[bossIndex].attacks[3] = new Attack("bites with an icy fang.", 35, false, AttackStat.MAG, AttackType.ICE, "I");
      zoo.boss[bossIndex].attacks[4] = new Attack("sprays icy seawater.", 30, false, AttackStat.MAG, AttackType.ICE, "I");
  bossIndex++;
  //Giant Bilge
  m[mapIndex].tiles[35][19].placeBoss( mapIndex, color(#4c585c), "Giant Bilge Rat.", new Monster("Giant Bilge Rat", "blueRatBig.png", 100, 15, 5, 5, 0, 4, 12, 0, AttackType.FIRE), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("whips its tail.", 50, false, "S");
      zoo.boss[bossIndex].attacks[1] = new Attack("stomps.", 50, false, "B");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites!", 65, false, "B" );
      zoo.boss[bossIndex].attacks[3] = new Attack("bites!", 65, false, "B" );
      zoo.boss[bossIndex].attacks[4] = new Attack("throws its body!", 60, true, "B" );
  bossIndex++;
  //Ratlord
  m[mapIndex].tiles[31][19].placeBoss( mapIndex, color(140,150,150), "Deep Ratlord.", new Monster("Deep Ratlord", "abyssBig.png", 150, 18, 10, 4, 10, 4, 15, 0, AttackType.HOLY), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("sprays icy seawater.", 40, true, AttackStat.MAG, AttackType.ICE, "I");
      zoo.boss[bossIndex].attacks[1] = new Attack("tosses you aside!", 70, false, "B" );
      zoo.boss[bossIndex].attacks[2] = new Attack("bites!", 70, false, "B" );
      zoo.boss[bossIndex].attacks[3] = new Attack("sweeps its tail!", 55, true, "S" );
      zoo.boss[bossIndex].attacks[4] = new Attack("grips you with icy claws!", 60, false, AttackStat.MAG, AttackType.ICE, "B");
  bossIndex++;
  
  //Act 4 Items
  m[mapIndex].tiles[55][20].createEvent(true, "Rat Pelt.");
  createLoot(lootIndex++, mapIndex, 56, 19, new Equipment("Rat's Pelt","darkFur.png",2,false,18,true) );
  m[mapIndex].tiles[58][20].createEvent(true, "Cutlass.");
  createLoot(lootIndex++, mapIndex, 59, 19, new Equipment("Cutlass","cutlass.png",15,true,24,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.DRUID) );
  m[mapIndex].tiles[61][20].createEvent(true, "Uniform.");
  createLoot(lootIndex++, mapIndex, 62, 19, new Equipment("Uniform","uniform.png",28,false,22,Job.KNIGHT,Job.THIEF,Job.KARATE,Job.BARD,Job.PRIEST) );
  m[mapIndex].tiles[64][20].createEvent(true, "Chain.");
  createLoot(lootIndex++, mapIndex, 65, 19, new Equipment("Chain","chainWhip.png",11,true,22,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.DRUID,Job.PRIEST) );
  
  //Act 5 Monsters
  //Nectarseeker                                                                                                                  //String n, String image,  health, s,  d, c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[43][25].placeBoss( mapIndex, color(#f5c800), "This creature has an intoxicating smell.", new Monster("Nectarseeker", "Wasp.png", 60, 20, 30, 4, 1, 5, 18, 0, AttackType.WIND), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "B" );
  bossIndex++;
  //Drone
  m[mapIndex].tiles[39][25].placeBoss( mapIndex, color(#f5c800), "Drone.", new Monster("Drone", "WaspSmall.png", 45, 20, 30, 4, 1, 5, 20, 0, AttackType.WIND, 2) );
    zoo.boss[bossIndex].attacks[0] = new Attack("buzzes around your heads.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 55, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("jabs with its stinger!", 60, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("emits a high-pitched tone.", 20, true, AttackStat.MAG, AttackType.NONE, "B" );
  bossIndex++;
  //Swarm
  m[mapIndex].tiles[35][25].placeBoss( mapIndex, color(#f5c800), "Swarm", new Monster("Swarm", "swarm.png", 60, 10, 10, 2, 1, 5, 25, 0, AttackType.WIND, 2) );
    zoo.boss[bossIndex].attacks[0] = new Attack("surrounds you.");
    zoo.boss[bossIndex].attacks[1] = new Attack("bites and scratches.", 55, false, "S" );
    zoo.boss[bossIndex].attacks[2] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("jabs and stings.", 50, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("descends upon you.", 40, true, "B" );
  //Wax Golem (1st)                                                                                            //String n, String image,  health, s,  d,  c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[31][25].placeBoss( mapIndex, color(#a18000), "Slow Wax Golem", new Monster("Wax Golem", "honeyGolem.png", 100, 24, 15, 9, 1, 4,  13, 0, AttackType.FIRE, 10), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("slams its fist.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its elbow.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("stomps its foot.", 60, false, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("sprays hot wax!", 50, false, AttackStat.STR, AttackType.FIRE, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("reattaches is broken pieces.");
  bossIndex++;
  //Wax Golem (2nd)
  m[mapIndex].tiles[27][25].placeBoss( mapIndex, color(#a18000), "Fast Wax Golem", new Monster("Wax Golem", "honeyGolem.png", 120, 24, 18, 9, 1, 4,  16, 0, AttackType.FIRE, 10), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("swings its fists!", 65, true, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("swings its elbow.", 65, false, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("stomps its foot.", 65, false, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("flings hot wax!", 70, false, AttackStat.STR, AttackType.FIRE, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("lets out an echoing roar!");
  bossIndex++;
  //Queen Bee                                                                                                //String n, String image,  health, s,  d, c, m,  w, sp, g, AttackType weak
  m[mapIndex].tiles[23][25].placeBoss( mapIndex, #cd7100, "Queen", new Monster("Queen", "queenBee2.png", 150, 28, 35, 8, 20, 7, 25, 0, AttackType.NONE), false);
    zoo.boss[bossIndex].attacks[0] = new Attack("delivers a crushing bite.", 80, false, Debuff.POISON, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("jabs with her barbed stinger.", 70, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("commands her hive to crush you!", 55, false, AttackStat.MAG, AttackType.EARTH, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("summons a swarm!", 70, true, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("sprays pollen.", 30, true, Debuff.SLEEP, "W" );
  //Bandit
  bossIndex++;
  m[mapIndex].tiles[43][29].placeBoss( mapIndex, #AF3232, "Bandit", new Monster("Bandit", "bandit.png", 90, 26, 30, 7, 1, 4, 20, 0, AttackType.NONE, 10) );
    zoo.boss[bossIndex].attacks[0] = new Attack("tries to get behind you.");
    zoo.boss[bossIndex].attacks[1] = new Attack("uses a toxin.", 55, false, Debuff.SLEEP, "S" );
    zoo.boss[bossIndex].attacks[2] = new Attack("stabs with a knife.", 50, false, AttackStat.DEX, AttackType.NONE, "B" );
    zoo.boss[bossIndex].attacks[3] = new Attack("strikes with his sword.", 70, false, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("flings knives!", 50, true, "B" );
  //Bandit Mage
  m[mapIndex].tiles[39][29].placeBoss( mapIndex, #3232AF, "Bandit Mage", new Monster("Bandit Mage", "banditMage.png", 90, 7, 20, 4, 15, 7, 18, 0, AttackType.NONE, 10) );
    zoo.boss[bossIndex].attacks[0] = new Attack("begins chanting a spell.");
    zoo.boss[bossIndex].attacks[1] = new Attack("uses a toxin.", 55, false, Debuff.SLEEP, "S" );
    zoo.boss[bossIndex].attacks[2] = new Attack("summons a ball of fire.", 50, false, AttackStat.MAG, AttackType.FIRE, "F" );
    zoo.boss[bossIndex].attacks[3] = new Attack("summons shards of ice.", 55, false, AttackStat.MAG, AttackType.ICE, "I" );
    zoo.boss[bossIndex].attacks[4] = new Attack("conjures a tempest!", 55, true, AttackStat.MAG, AttackType.WIND, "W" );
  //Bandit Boss
  m[mapIndex].tiles[35][29].placeBoss( mapIndex, #d28200, "Bandit Boss", new Monster("Bandit Boss", "banditBoss.png", 160, 28, 30, 9, 18, 9, 22, 0, AttackType.NONE, 20) );
    zoo.boss[bossIndex].attacks[0] = new Attack("flings knives.", 65, true, "B" );
    zoo.boss[bossIndex].attacks[1] = new Attack("flicks a poison knife.", 65, false, Debuff.POISON, "B" );
    zoo.boss[bossIndex].attacks[2] = new Attack("conjures spikes of stone.", 65, false, AttackStat.MAG, AttackType.EARTH, "E" );
    zoo.boss[bossIndex].attacks[3] = new Attack("thrusts for the heart!", 70, false, Debuff.SLEEP, "B" );
    zoo.boss[bossIndex].attacks[4] = new Attack("slices for the neck!", 70, false, Debuff.SLEEP, "S" );
  bossIndex++;
  
  //Act 5 Items
  m[mapIndex].tiles[55][26].createEvent(true, "Grave Gown.");
  createLoot(lootIndex++, mapIndex, 56, 25, new Equipment("Grave Gown","graveShirt.png",25,false,24,Job.THIEF,Job.KARATE,Job.PRIEST,Job.MAGE) );
  m[mapIndex].tiles[58][26].createEvent(true, "Windrazor.");
  createLoot(lootIndex++, mapIndex, 59, 25, new Equipment("Windrazor","windKnife.png", 15, true, 21.3,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );  
  m[mapIndex].tiles[61][26].createEvent(true, "Plundered Chain.");
  createLoot(lootIndex++, mapIndex, 62, 25, new Equipment("Plundered Chain","chainBroken.png",19,false,29,Job.KNIGHT,Job.BARBARIAN,Job.BARD,Job.THIEF,Job.PRIEST) );
  m[mapIndex].tiles[64][26].createEvent(true, "Stinger.");
  createLoot(lootIndex++, mapIndex, 65, 25, new Equipment("Stinger","stinger.png",15,true,30.02,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID) );
  
  //Danger Map X (TEST ROOM)
  dangerMapIndex = mapIndex; dangerStrs[dangerMapIndex] = "";

  inputTest = loadStrings("dangerX.txt");
  nextMap = "";
  for( int j = 0; j < inputTest.length; j++ )
    nextMap += inputTest[j];
  dangerStrs[dangerMapIndex] = nextMap;
}

void setNameDependentText()
{
  String knightName="";
  String barbName="";
  String saurName="";
  String thiefName="";
  String bardName="";
  String monkName="";
  String druidName="";
  String priestName="";
  String mageName="";
  String magePhrase = "";
  String heroWeapon[] = {"","",""};
  
  for(int i=0;i<3;i++)
  {
    if(party.hero[i].job==Job.KNIGHT)    knightName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.BARBARIAN) barbName  = " like "+party.hero[i].name;
    if(party.hero[i].job==Job.SAURIAN)   saurName  = " like "+party.hero[i].name;
    if(party.hero[i].job==Job.THIEF)     thiefName = " like "+party.hero[i].name;
    if(party.hero[i].job==Job.BARD)      bardName  = " like "+party.hero[i].name;
    if(party.hero[i].job==Job.KARATE)    monkName  = " like "+party.hero[i].name;
    if(party.hero[i].job==Job.DRUID)     druidName = " like "+party.hero[i].name;
    if(party.hero[i].job==Job.PRIEST)    priestName= " such as "+party.hero[i].name;
    if(party.hero[i].job==Job.MAGE)    { mageName  = " such as "+party.hero[i].name; magePhrase=", as "+party.hero[i].name+" can attest"; }  

    if(party.hero[i].job==Job.KNIGHT)    heroWeapon[i] = "sword";
    if(party.hero[i].job==Job.BARBARIAN) heroWeapon[i] = "axe";
    if(party.hero[i].job==Job.SAURIAN)   heroWeapon[i] = "claws";
    if(party.hero[i].job==Job.KARATE)    heroWeapon[i] = "fists";
    if(party.hero[i].job==Job.BARD)      heroWeapon[i] = "wit";
    if(party.hero[i].job==Job.THIEF)     heroWeapon[i] = "knives";
    if(party.hero[i].job==Job.DRUID)     heroWeapon[i] = "power";
    if(party.hero[i].job==Job.PRIEST)    heroWeapon[i] = "faith";
    if(party.hero[i].job==Job.MAGE)      heroWeapon[i] = "magic";
  }
  
  //Floor 0
  
  //mean scribes
  m[0].tiles[77][17].placeOccupant( color(150, 150, 250), "- You would have made a good scribe, " +party.hero[0].name+ ", if only you weren't stupid." );
  m[0].tiles[77][20].placeOccupant( color(150, 150, 250), "- You would have made a good scribe, " +party.hero[1].name+ ", if only you were more patient." );
    
  //People at the table
  for(int i = 0; i < 12; i++)
  {
    m[0].tiles[44+i][5].placeOccupant( color(150, 150, 250), "- Have a seat, "+party.hero[i%3].name+"." );
    if(i!=3)
    m[0].tiles[44+i][8].placeOccupant( color(150, 150, 250), "- Have a seat, "+party.hero[(i+1)%3].name+"." );
  }
  m[0].tiles[46][8].placeOccupant( color(150,150,250), "- I think she put the key by your plate.");
  
  //Admirer
  m[0].tiles[40][13].placeOccupant( color(150, 150, 250), "- Oh, h-hello, "+party.hero[2].name.charAt(0)+"-"+party.hero[2].name+". Is it really true that you're leaving? I... I have something that will keep you safe. It's technically contraband, so I had to hide it in a tree. Check the other side of the cloister. Goodbye. I'll m-miss you, "+party.hero[2].name+"." );
  
  //master alchemist
  m[0].tiles[82][33].placeOccupant( color(150, 150, 250), "- Ah, "+party.hero[1].name+", how badly I wanted you as an apprentice. You and Sister Kat have such graceful hands, fashioned by Am-asma himself for alchemy. Alas, fate had other designs. What I have left, it is yours!" );
  
  //cleric owed money
  m[0].tiles[44][52].placeOccupant( color(150, 150, 250), "- You have to promise to return some day, "+party.hero[0]+". No matter where the path takes you, find your way home. You still owe me four gold for that ale I sneaked in." );
  
  //player 3's friend
  m[0].tiles[32][55].placeOccupant( color(165,150,50), "- Hello "+party.hero[2].name+". Sorry I haven't brought you any new books lately. The library is next to Baron's Field, and was one of the first places we abandoned. If your "+heroWeapon[2]+" can clear out the animated dead, I'll get you the next story in that series you like so much." );
  m[2].tiles[78][28].placeOccupant( color(male), "- It's a sorry sight, "+party.hero[2].name+". I spent so many days in here, as did you. As I recall, you spent some nights with a book for a pillow when the hours got away from you. I want to salvage what books remain, but some of the abominations were trapped inside. I've opened the door for you. Our reclamation begins here." );
  //player 3's parent
  m[1].tiles[95][92].placeOccupant( ghostColor, "- You've grown strong, "+party.hero[2].name+". I... I watched as you studied under Charis. From time to time I read over your shoulder at the library. I was so afraid for you as I lay dying, and at first I disliked the name "+party.hero[2].name+"... I've said too much. Sleep soundly and complete your task." );
  m[0].tiles[84][58].placeOccupant( ghostColor, "- I'm so proud of you, "+party.hero[2].name+"." );
 
  //Teachers
  m[0].tiles[12][32].placeOccupant( lesserRitisu, "- Knights"+knightName+" rely on their armor, and gain two energy when they defend against an attack. Barbarians"+barbName+" gain one anger whenever they are attacked. The reptile people"+saurName+" are natural warriors, and gain energy twice as fast as humans." );
  m[0].tiles[12][36].placeOccupant( lesserRitisu, "- Thieves"+thiefName+" gain five energy on successful critical blows. Martial artists"+monkName+" do not gain bonus energy, but will always start a fight full of spiritual power. Bards"+bardName+" can feel a kind of combat rhythm, and gain energy when their allies use abilities." );
  m[0].tiles[33][34].placeOccupant( lesserRitisu, "- Magical Power is used by mages"+mageName+" and priests"+priestName+" to fuel their magic. The lure of magic is strong, but once their power is spent a mage can do little." );
  m[0].tiles[21][30].placeOccupant( lesserRitisu, "- The Saurian people are blessed by Am-asma with strength and with scales like iron. Even without a weapon they can devistate their foes." );
  m[0].tiles[34][32].placeOccupant( lesserRitisu, "- There is great power in the natural world, and Druids"+druidName+" have learned to borrow it. They use magic power to beckon the elements or take the form of beasts." );
  
  //Garrison
  m[0].tiles[98][41].placeOccupant( color(160, 160, 160), "- Knights"+knightName+" can wear heavy armor, which provides the best protection. Priests of Illamar"+priestName+" have been blessed with the strength to wear plate as well. Simpler armors like chain and leather can be worn by wild warriors"+barbName+" and rogues"+thiefName+". Martial artists"+monkName+" are trained to fight wearing common garb, and the magic of magi is disrupted by heavy material"+magePhrase+"." );
  m[0].tiles[98][45].placeOccupant( color(160, 160, 160), "- Swords and axes are the weapons of warriors. Knights"+knightName+" and barbaric fighters"+barbName+" should see no difficulty wielding them. Simpler arms like the club or knife are suitable for those without formal training, though mages"+mageName+" can only manage simple knives and staves. Martial artists"+monkName+" need naught but the hands Am-asma gave them." );
  m[0].tiles[92][45].placeOccupant( color(190, 170, 130), "A training dummy. Someone has drawn "+party.hero[0].name+"'s face on it." );
  
  //Rask
  m[0].tiles[48][67].placeOccupant( color(250, 100, 50), "- "+party.hero[0].name+"? "+party.hero[1].name+"? Good, I'm glad to see you. We need help and we won't get it from Mother Sunita. I'm headed to the mayor's office. Meet me there as soon as you can." );
  
  //Kat
  m[0].tiles[19][53].placeOccupant( katColor, "- AH! "+party.hero[1].name+", where did you come from? Was it you who slew those rats in the cellar? You're strong, "+party.hero[1].name+". Brave, too. If only I could borrow that courage. Some of them escaped the cellar with my prototype potions. I don't know what effect they will have on fauna, but it is my responsibilty to prevent harm. I-if you want to help, I'd appreciate it. I'll even lend you my... invention. I-if you promise not to tell Brother Idris about it." );//My "+heroWeapon[1]+" "+wasOrWere(heroWeapon[1].charAt(heroWeapon[1].length()-1))+" never as strong as yours." );
  m[1].tiles[49][14].placeOccupant( katColor, "She's slumped against the wall. Her arm is burned. - "+party.hero[1].name+"? How did you avoid the man-wolf? I had to use my draught of disguise. The rats are getting larger, and mutating in strange ways. May Am-asma forgive me for my part in this. I was able to trap one up ahead. Could you please fight him? I have food here if you feel hungry. I'll be fine, I just need a rest..." );
  m[3].tiles[ 1][24].placeOccupant( katColor, "Her face is pale and dripping with cold sweat. - Uh... oh, "+party.hero[1].name+". Why are you here? Books with strange symbols? Looking into Father Charis's death? Wow, you sure have been busy since leaving the cathedral. I was following the rats, but some of them followed me. They're in the ship. I locked them in the lower deck. I was going to tell the captain, but the ship started swaying and... uh, my poor stomach... I must have dropped the key." );
  m[3].tiles[58][89].placeOccupant( katColor, "- I think I'm past the worst of it now. Thank you again, "+party.hero[1].name+". After I clean the rest of them off the ship I plan to stop in Waraka castle to restock on reagents. I used my last brewing this potion. Take it as a show of thanks. Illamar guide you." );
  m[4].tiles[12][ 6].placeOccupant( katColor, "- "+party.hero[1].name+"? I thought you'd be in Waraka Castle by now. Why do you smell like honey? I took the wooded road so I could gather reagents, but I've been stuck here since the river flooded. Some of my supplies were swept downstream. It should be calm enough to cross now, especially for someone as strong as you." );
  m[4].tiles[ 9][12].createEvent(false, "- " + party.hero[1].name + "! Are you all right? Um, don't panic! Just... try to keep your head above water!");
  m[4].tiles[ 9][26].createEvent(false, "- " + party.hero[1].name + "! " + party.hero[1].name + "! Where are you? Oh, what do I do?" );
  
  //Garrison
  m[1].tiles[4][42].placeOccupant( garrison, "- " + party.hero[0].name + "! Finally come to your senses and decided to join the garrison? We need " + needAnA(heroWeapon[0]) + heroWeapon[0] + " like yours to help train these milksops to soldier!" );
  m[1].tiles[7][44].placeOccupant( color(fYoung), "- Thank you, " + party.hero[1].name + ". I never forgot what you taught me. You thought it would be years before they allowed me to be a soldier, but they need everyone they can get. This has always been my destiny." );
  m[0].tiles[69][86].placeOccupant( color(fYoung), "- " + party.hero[1].name + "? I... it was... I don't want to be a solider." );
  
  //Hideout kids
  m[2].tiles[79][46].placeOccupant( color(fYoung), "- " + party.hero[0].name + "! " + party.hero[0].name + "! The hideout you helped us build is still here! The bone men haven't found it yet!" );
  
  //Dock
  m[0].tiles[70][94].placeOccupant( color(mYoung), "- I'm going to be just like "+party.hero[0].name+". My "+heroWeapon[0]+" will stop anyone who attacks my town!" );
  m[0].tiles[69][94].placeOccupant( color(fYoung), "- Yeah! "+party.hero[0].name+" is the best!" );
  
  //Boat
  m[3].tiles[14][1].placeOccupant( color(clericColor), "- I swore to stay in Irohill forever, "+party.hero[2].name+", but here I am, watching Illamar's light glisten on the sea. A strange new era is dawning." );

  //Warakan Admirer
  m[4].tiles[0][82].placeOccupant( color(#0FFA7D), "- Stay safe, " +party.hero[0].name + ". I want to see you again some day." );
  m[4].tiles[0][81].createEvent(false, "This merchant has been watching you, impressed by " + party.hero[0].name + "'s " + heroWeapon[0] + ". - Well met. It'll be nice to have someone new to talk to while we wait for support from the captial. What? You plan to face those robbers? That's... very brave. " + party.hero[0].name + ", was it? I buried some extra rations here. Take them, and may Am-asma keep you healthy.");
}

//Expected Level:
//(old exp system)
//Rat queen 1.7 / 1.9                                          2.1    2
//man-wolf 3.3 / 3.2 / 3.1                                     3.1    3
//crypt guards 4.5 before, 5.2 back at courtyard                      5
//before necro 6.7 / 5.7 (died) / 5.5 (close fight) / 5.7      5.8    6/5
//after deep rat 6.5                                           6.9    7/6
//bandit boss                                                         9
//queen                                                               9

//Deities:
//Black Vanguard - anubis
//Illamar - sun god
//Ritisu - god of save crystals, legend, stories, history
//Am-asma - god of creatures and medicine

//Plot notes:
//Mother Veda is in Mariva across the sea and is high priestess of Ritisu
//Messages to necromancer came from Waraka
//Assassin boss Sirak in Waraka - respected Charis
//Monsters of Lost Star Isle (later dungeon: shipwreck of Barracuda Queen and pirate ship)
//Bandits took over sea road, didn't know how to contain bees

//NPC colors:
//Chilxius (0,200)
//Mother Sunita (150, 250, 250)
//Clerics (150, 150, 250)
//Initiates (150, 150, 200)
//Secret teachers ( color(200, 150, 200)
//Priest of ritisu (31,153,226)  lesser (75,180,243)
//Training dummy (190, 170, 130)
//Garrison (160)
//Commoner male  (165,150,50)  young (250,230,0)
//Commoner female  (150,50,165)  young (230,150,250)
//Rask (250, 100, 50)
//Kat (250,0,170)
