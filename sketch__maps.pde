void setupMaps()
{ 
  String mapStrings[] = new String[mapCount]; //10 is temporary
  String dangerStrs[] = new String[mapCount];
  
  //These should always ++ themselves when used
  int savePointIndex = 0;
  int lootIndex = 0;
  int mapIndex = 0;
  
  //This should be ++'d when the boss is made, then used for its attacks
  int bossIndex = 0;
  
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
    
    
  //Key:  D-dark tree    T-tree    t-secret tree    #-wall      =-chest    ?-sign    *-save crystal
  //       -darkness     £-darkness wall (alt+3)    3-dark wall 5-sandstone wall     [-barrel        ©-werewolf statue (alt+©)
  //      G-gargoyle     R-dark gargoyle            W-wood      ∑-dark wood (alt+w)     „-light wood (alt+shift+w)

  //      +-locked door  .-safe path  w-water       g-grave   &-stained glass    @-campsite/tavern
  //      c-copper key   i-iron key   s-skel key    b-brass key ~-grass          $-secret wall   ¢-secret dark wall (alt+4)

  //      >-Stairs

  mapStrings[0] = "";
  mapStrings[0] += "DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT##################TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#####&##&##&##&##&##&#####TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT########&#......„„„„„„......#&########TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTTTTTTTTTTT########&#............„„„„............#&########TTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTTTTTTTT####&##&#....................................#&##&####TTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTTTT#####&#................................................#&#####TTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTT#####......................WWWWWWWWWWWW......................#####TTTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTT#########.....................WWWWWWWWWWWW.....................#########TTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTT####.....##....................................................##G....####TTTTTTTTTTTTT";
  mapStrings[0] += "DTT###TT###T####...*...##..................................................##.......####T###TTT###TT";
  mapStrings[0] += "DTT#>#TT#>#####.........##....c....##############################.........##.........#####>#TTT#.#TT";
  mapStrings[0] += "DT##.####+####..G..G..G..#####+#####~~~~~~~~D#wwwwwwww#~~T~~~~~~#####.#####..©..G..G..####+#####.##T";
  mapStrings[0] += "DT#......i......................#~~~~~~~T~~~~wwwwwwwwww~~~~~T~~~~~~#.....##...............i......*#T";
  mapStrings[0] += "TT#.............................#~~~T~~~~~~~TwwwwwwwwwwT~~~~~~~~T~~#..............................#T";
  mapStrings[0] += "TT#.i....i.....G...G...G........~~~~~~~~~~~~~wwww##wwww~~~~t~~~~~~~~........G...G...G.....i.....i.#T";
  mapStrings[0] += "DT##+####+#####........####.....~~~~~~T~~~T~~Tww####wwT~~~~~~~~~~~~~.....########...######+#####+##T";
  mapStrings[0] += "DTT#>#TT#>####...„„„„„„„„##.....#~~~~~~~~~~~~~~~~##~~~~~~~~~~~~D~~~#.....##W.W.W#...######>#TTT#>#TT";
  mapStrings[0] += "DTT###TT###T##[..„%%„%%„%##.....#~T~~~~D~~~~~~~b~##~i~~~~~T~~~~~~~~#.....##.....#...####T###TTT###TT";
  mapStrings[0] += "DTTTTTTTTTTTT##..„%%„%%„%######################+####+######################.....#...###TTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTT##.„%%„%%„%##..............................................##W.W.W#...##TTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTT##„%%„%%„%##..............................................##.....#..##TTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTT##%%„%%„%##..............................................##.......##TTTTTTTTTTTTTTTT";
  mapStrings[0] += "DTTTTTTTTTTTTTTTT##################################################################TTTTTTTTTTTTTTTTT";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                                       T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~                                                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";

  m[0] = new Map(mapStrings[0],mapIndex++);
  
  createLoot(lootIndex++, 0, 47, 8, Key.COPPER_KEY);
  createLoot(lootIndex++, 0, 59, 14, new Equipment("Chainmail","MetalMail.png",18,false,22,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST) );
  
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
  m[0].tiles[14][16].placeOccupant( color(150, 150, 250), "- All the potions made in the Cathedral use herbs from my garden. When the sweet, minty draught saves your life one day, know that you live by the sweat of my brow and the dirt on my knees." );
  //in method below
  
  //People at the table
  //in method below
  
  m[0].tiles[79][8].placeOccupant( color(150, 150, 250), "- My repairs have been delayed. Try to ignore that horrible thing for a few more days." );
  
  //To west cellar
  exits.add( new Portal(0,4,10,1,81,1, "The West Cellar") );
  
  m[0].tiles[47][8].createEvent(false, "Mother Sunita clasps her hands and streightens her posture."+
  " - Illamar's light be upon you. Five hours and one minute ago, Father Charis succumbed to his weak heart and now serves from the other side of the Veil."+
  " I am honored to serve in his stead. Sadly, though he pledged to pass on his unique gift, neither I nor the other exarchs seemed to have received it."+
  " This is an ill omen, and coupled with the reports from Baron's Field, changes must be made. Lay persons will no longer be housed in the Cathedral."+
  " Loath as I am to undo one of Charis's beloved projects, the safety of the eparchy is our duty. Children, you will find a key on the table before you."+
  " Take as much food as you need from the kitchens on your way out. The people Irohill will surely be gracious to you.");
  
  //Save points
  savePoints[savePointIndex++] = new SavePoint(0, 19, 9);
  savePoints[savePointIndex++] = new SavePoint(0, 97, 12);

/*
  m[0].tiles[10][0].placeOccupant( color(150, 150, 250), "- You found one of my hiding spots!" );
  m[0].tiles[10][2].placeOccupant( color(255, 0, 0), "- I think I dropped a key in the flower garden." );
  m[0].tiles[16][2].placeOccupant( color(255, 150, 0), "- I love hiding things in chests!");
  m[0].tiles[22][0].placeOccupant( color(120, 120, 250), "- Where did my sister go?");
  m[0].tiles[37][2].placeOccupant( color(90, 70, 30), "- Welcome to my tavern. Press capital (R) to rest and recover.");
  m[0].tiles[34][9].placeOccupant( color(190, 170, 130), "- You look like you could use some armor. I've got shirts of iron chain for twelve gold.");
  m[0].tiles[34][9].type = TileType.MERCHANT;
  m[0].tiles[32][9].placeOccupant( color(190, 170, 130), "- Me sell axe. It cost twenty. You like?");
  m[0].tiles[32][9].type = TileType.MERCHANT;
  
  m[0].tiles[32][11].placeOccupant( color(50), "- You got something to sell me, bud?");

  m[0].tiles[34][8].placeShop( new Equipment( "Chain Shirt","MetalMail.png", 12, false, 10, Job.KNIGHT, Job.BARBARIAN, Job.PRIEST), 20 );
  m[0].tiles[32][8].placeShop( new Equipment( "Axe","MetalSpikedAxe.png", 20, true, 35, Job.KNIGHT, Job.BARBARIAN ), 20 );

  m[0].tiles[33][11].placeSeller();

  m[0].tiles[11][4].createEvent(true, "- Walk into people to talk to them.");
  m[0].tiles[1][3].createEvent(true, "- Press (space) to search your current square. You can open chests this way, and also find items dropped by clumsy monsters.");
  m[0].tiles[3][1].createEvent(true, "- Hold (i) to view your inventory. You can hold up to thirty items. While viewing, press (s) to sort.");
  m[0].tiles[5][1].createEvent(true, "- Press capital (E) to eat something. There are only four kinds of food on the planet.");
  m[0].tiles[7][1].createEvent(true, "- Press capital (D) to drink magic potions. These are better than food items, but more expensive. We blame prohibition.");
  m[0].tiles[3][5].createEvent(true, "- This sign paid for by a generous donation from the sign foundation. And viewers like you.");
  m[0].tiles[6][2].createEvent(true, "- This is a save crystal. Step on it and type capital (S) to activate it. Press (ENTER) to confirm or any other key to abort.");
  m[0].tiles[18][5].createEvent(true, "- Hold (k) to view your Keys. This door requires a Copper Key");
  m[0].tiles[16][5].createEvent(true, "- Press (o) to attempt to open a door. If you have the right key, it will be used up.");
  m[0].tiles[27][4].createEvent(true, "- Please do not step on the flowers.");
  m[0].tiles[45][1].createEvent(true, "- Press (>) to go through doors such as this one.");
  //m.tiles[6][1].createEvent(false,"Event C","Three lines of text","Only happens once");

  m[0].tiles[54][4].placeBoss( 0, color(0, 0, 200), "A terrible creature guards the way!", new Monster("Xaxaphar", "BlueMindflair.png", 20, 5, 5, 5, 5, 5, 5, 50, AttackType.HOLY) );
      zoo.boss[0].attacks[0] = new Attack("whips his tentacles.", 40, false);
      zoo.boss[0].attacks[1] = new Attack("shoots fire!", 35, false, AttackStat.MAG, AttackType.FIRE);
      zoo.boss[0].attacks[2] = new Attack("causes a quake!", 30, true, AttackStat.MAG, AttackType.EARTH);
      zoo.boss[0].attacks[3] = new Attack("causes a hurricane!", 30, true, AttackStat.MAG, AttackType.WIND);
      zoo.boss[0].attacks[4] = new Attack("casts a freezing ray!", 35, false, AttackStat.MAG, AttackType.ICE);
  
  m[0].tiles[88][2].placeBoss( 0, color(200, 150, 100), "You've entered a forbidden place...", new Monster("Werewolf", "BrownWerewolf.png", 40, 12, 12, 5, 0, 3, 7, 0, AttackType.FIRE) );
      zoo.boss[1].attacks[0] = new Attack("licks its lips.");
      zoo.boss[1].attacks[1] = new Attack("claws!", 45, false);
      zoo.boss[1].attacks[2] = new Attack("bites!", 55, false);
      zoo.boss[1].attacks[3] = new Attack("rends and tears!", 45, true);
      zoo.boss[1].attacks[4] = new Attack("goes for the jugular!", 85, false);
*/
  dangerStrs[0] = "";
  dangerStrs[0] += "A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

  dangerStrs[0] += "B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Cxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Exxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Fxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Gxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Ixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[0] += "Jxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[0] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";


  mapStrings[1] = "";
  
  mapStrings[1] += "£  333     £  33###########  £  ################     ###  £  ###     ################  £            ";
  mapStrings[1] += "3333R3333  £  3...........#  £  #&#>#&#........#     #=#  £  #=#     #........#&#>#&#  £            ";
  mapStrings[1] += "3=?...?*3  £  3.33#.w.###.#  £  ###.###.#####..#     £ £  £  £ £     #[.#####.###.###  £            ";
  mapStrings[1] += "3.......3  £  3.3...w...#.#  £  ##...##....>#..#     £ £  £  £ £     #..#>....#.....#  £            ";
  mapStrings[1] += "3[.[[.?.3  £  3.333.w.###.#  £  #.....#######..#££££££ £  £  £ ££££££#..#######.....#  £            ";
  mapStrings[1] += "3333333c3  £  3.3...w...#.#  £  #..............¢       £  £  £       $............[[#  £            ";
  mapStrings[1] += "3>33333+3  £  3.333.w.###.#  £  ################£££££££   £   £££££££################  £            ";
  mapStrings[1] += "3.......3  £  3>3...w...#>#  £                            £                            £            ";
  mapStrings[1] += "333333333  £  3333333333###  £                            £                            £            ";
  mapStrings[1] += "           £                 £££££££££££££££££££££££££££££ ££££££££££££££££££££££££££££             ";
  mapStrings[1] += "           £                 £                                                                      ";
  mapStrings[1] += "£££££££££££ £££££££££££££££££                                                                       ";
  mapStrings[1] += "           £                 £                                                                      ";
  mapStrings[1] += "           £                 £                                                                      ";
  mapStrings[1] += "333333333  £  33###########  £                                                                      ";
  mapStrings[1] += "3.......3  £  3...........#  £                                                                      ";
  mapStrings[1] += "3.3333333  £  3.33#...###.#  £                                                                      ";
  mapStrings[1] += "3.......3  £  3.3.......#.#  £                                                                      ";
  mapStrings[1] += "3333333+3  £  3.333...###.#  £                                                                      ";
  mapStrings[1] += "3>33333c3  £  3.3.......#.#  £                                                                      ";
  mapStrings[1] += "3.......3  £  3.333...###.#  £                                                                      ";
  mapStrings[1] += "333333333  £  3>3=......#>#  £                                                                      ";
  mapStrings[1] += "           £  3333333333###  £                                                                      ";
  mapStrings[1] += "           £                 £                                                                      ";
  mapStrings[1] += "££££££££££££                 £                                                                      ";
  mapStrings[1] += "            £££££££££££££££££                                                                       ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
    
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
    
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
    
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  
  m[1] = new Map(mapStrings[1],mapIndex++);
  //m[1].floorNumber=1;
  
  createLoot(lootIndex++, 1, 3, 4, Key.COPPER_KEY);
  createLoot(lootIndex++, 1, 1, 2, new Equipment("Brocade","YellowShirt.png",5,false,5,true));
  createLoot(lootIndex++, 1, 54, 1, new Equipment("Ivory Knife","IceDagger.png",15,true,15,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST,Job.MAGE));
  createLoot(lootIndex++, 1, 62, 1, new Equipment("Club","OldClub.png",3,true,20,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST));
  createLoot(lootIndex++, 1, 17, 21, Key.COPPER_KEY);
  
  m[1].tiles[2][2].createEvent(true, "- The (space) key can be used to open chests like this one. You also use this key to search your current square. See if you can find anything left behind in this room by careless initiates.");
  m[1].tiles[6][2].createEvent(true, "- This is a sacred Legend Gem. Gazing into it, you can feel your acomplishments being told around campfires centuries from now. Step on it and press capital (S) to activate it, and then press ENTER to confirm and save your progress.");
  m[1].tiles[6][4].createEvent(true, "- Some doors are locked. You can view your key ring by holding down the (k) key. By examining a door, you can determine what key is required. If you stand next to the door and press the (o) key, you will use the proper key if you possess it. Keys are fragile, and usually break after a single use.");
  m[1].tiles[2][7].createEvent(false, "- This stairwell will lead to a different room. Stand on it and press the (>) key to ascend.");
  m[1].tiles[18][1].createEvent(false, "- Some of the clerics are busy cleaning the cellar. Walk into their space to speak with them.");
  m[1].tiles[35][3].createEvent(false, "- Sometimes, you can pass only one way across a threshold. This is one of those moments. Once you ascend these stairs, your story will truly begin. Good luck, young heroes.");
  
  m[1].tiles[17][3].placeOccupant( color(75,100,255), "- Good morning, young ones. We made fresh bread this morning. To eat food you are carrying, press capital (E). You need peace and quiet to eat. Don't try to eat during a fight or it will ruin your digestion." );
  m[1].tiles[17][5].placeOccupant( color(75,100,255), "- I think we have some magical potions left in the western cellar. Those are quite useful as they can be consumed during combat. There are only four varieties of potion, though. Thanks, prohhibition. Press capital (D) to drink potions while in the field." );
  m[1].tiles[17][7].placeOccupant( color(75,100,255), "- When you are weary, seek out an inn or campsite. The people of Irid left many tents of sturdy and long-lasting leather across the land. Press capital (R) to rest at such a site." );
  m[1].tiles[23][3].placeOccupant( color(75,100,255), "- We have all we need here at the Irohill Cathedral. However, if you some day leave, you may need to trade with vendors. Press capital (B) to bargain with them, but be wary of those who would cheat you." );
  m[1].tiles[23][5].placeOccupant( color(75,100,255), "- The Vendor's Guild is strict, and prohibits vedors from buying from you. Some will flaunt these rules and will give you gold for your unneeded treasures. Seek them out if you need coin." );
  m[1].tiles[23][7].placeOccupant( color(75,100,255), "- You were given a map of the Cathedral, yes? There is a helpful list of tips on the back of it. Hold the (h) key to view these helpful tips whenever you need." );
  m[1].tiles[46][2].placeOccupant( color(75,100,255), "- Good morning, children. I'm sorry to tell you, but Father Charis crossed the Veil last night. He was a man of towering benevolence, though you know that better than anyone. Mother Sunita will be speaking on his behaf during morning meal." );
  m[1].tiles[46][4].placeOccupant( color(75,100,255), "- I wish Father Charis hadn't taken in so many orphans. You three made so much noise playing games and looking for secret rooms that I could barely focus on my gardening." );
  
  savePoints[savePointIndex++] = new SavePoint(1, 7, 2);
  
  //Start room - second room
  exits.add( new Portal(1,1,6,1,15,7) );
  exits.add( new Portal(1,15,7,1,1,6) );
  
  //second room - third room
  exits.add( new Portal(1,25,7,1,43,3) );
  exits.add( new Portal(1,43,3,1,25,7) );
  
  //To cathedral east
  exits.add( new Portal(1,35,1,0,96,10, "Irohill Cathedral") );
  
  //To cathedral west
  exits.add( new Portal(1,81,1,0,4,10, "Irohill Cathedral") );
  
  //West cellar upper to rat dungeon 1
  exits.add( new Portal(1,73,3,1,25,21) );
  exits.add( new Portal(1,25,21,1,73,3) );
  
  //Rat dungeon 1 and 2
  exits.add( new Portal(1,15,21,1,1,19) );
  exits.add( new Portal(1,1,19,1,15,21) );

  m[1].tiles[7][15].placeBoss( 1, color(150, 80, 40), "This must be the matriarch.", new Monster("Giant Rat", "BrownRat.png", 15, 5, 10, 1, 100, 5, 5, 0, AttackType.FIRE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("summons its brood!", 35, true);
  bossIndex++;
  
  /*
  exits.add( new Portal(2,3,1,44,0,0) );
  exits.add( new Portal(41,3,1,96,2,0) );
  
  
  m[1].tiles[50][10].createEvent(false, "You feel a chill in your bones...");
  
  m[1].tiles[3][4].placeOccupant( color(200,200,255), "- There's a fourth chest down here. I can smell it." );
  m[1].tiles[40][4].placeOccupant( color(200,200,255), "- I wouldn't go up there if I were you." );
  m[1].tiles[83][8].placeOccupant( color(127), "He's dead..." );
  m[1].tiles[81][11].placeOccupant( color(127), "His lifeless eyes gaze back at you." );

  m[1].tiles[82][15].placeBoss( 1, color(125, 113, 153), "SoMe ThInGs ShOuLd NeVeR bE rElEaSeD", new Monster("????????", "error.png", 50, 12, 12, 12, 10, 8, 6, 0, AttackType.HOLY) );
      zoo.boss[2].attacks[0] = new Attack("grows stronger.");
      zoo.boss[2].attacks[1] = new Attack("exists.", 40, true);
      zoo.boss[2].attacks[2] = new Attack("strikes with [??????]!", 50, false);
      zoo.boss[2].attacks[3] = new Attack("attacks with [??????]!", 45, false);
      zoo.boss[2].attacks[4] = new Attack("freezes your game!", 35, true, AttackStat.MAG, AttackType.ICE);
    */  

  //savePoints[1] = new SavePoint(41, 8, 0);
  //savePoints[2] = new SavePoint(42, 3, 1);
  
  //for(int i = 2; i < m.length; i++)
  //  m[i] = new Map(mapStrings[i]);
  
  for(int i = 0; i < dm.length; i++)
    dm[i] = new DangerMap(dangerStrs[i]);


//---------LOOT SECTION-------------------//

  /*
  //Sets up first floor's loot
  createLoot(0,0, 15,2 ,Key.COPPER_KEY);
  createLoot(0,1, 1, 5 ,new Item("Red Crystal",75));
  createLoot(0,2, 5, 5 ,new Item("Orange Crystal",75));
  createLoot(0,3, 30,2 ,Key.COPPER_KEY);
  createLoot(0,4, 41,2 ,Key.IRON_KEY);
  createLoot(0,5, 6, 12,Key.SKELETON_KEY);
  createLoot(0,6, 60,4 ,new Item("Win Crystal",800));
  createLoot(0,7, 2, 3 ,new Item("Gold Coin",5));
  createLoot(0,8, 27,0 ,new Equipment("Dagger","MetalDagger.png",15,true,25,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.MAGE)); 
  
  createLoot(1,9, 12,7 ,new Item("Dog Statue",500));
  createLoot(1,10,20,10,new Equipment("Steel Plate","MetalArmor.png",50,false,20,Job.KNIGHT,Job.PRIEST));
  createLoot(1,11,22,10,new Equipment("Boiled Leather","LeatherArmor.png",25,false,15,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST));
  createLoot(1,12,24,10,new Equipment("Silk Shirt","BlueShirt.png",15,false,8,true));
  
  createLoot(0,13,86,1 ,new Equipment("The Hurter","RubyAxe.png",100,true,100,Job.KNIGHT,Job.BARBARIAN));
  
  createLoot(1,14,84,1 ,Key.BRASS_KEY);
  */
  //fill empty progressSwitches
  for(int i = 0; i < itemSwitches.length; i++)
    if(itemSwitches[i]==null)
      itemSwitches[i]=new ProgressSwitch();
}

void setNameDependentText()
{
  //Floor 0
  
  //mean scribes
  m[0].tiles[77][17].placeOccupant( color(150, 150, 250), "- You would have made a good scribe, " +party.hero[0].name+ ", if only you weren't stupid." );
  m[0].tiles[77][20].placeOccupant( color(150, 150, 250), "- You would have made a good scribe, " +party.hero[1].name+ ", if only you were more patient." );
    
  //People at the table
  for(int i = 0; i < 12; i++)
  {
    m[0].tiles[44+i][5].placeOccupant( color(150, 150, 250), "- Have a seat, "+party.hero[i%3].name+"." ); if(i!=3)
    m[0].tiles[44+i][8].placeOccupant( color(150, 150, 250), "- Have a seat, "+party.hero[(i+1)%3].name+"." );
  }
  
  //nevrous cleric
  m[0].tiles[40][13].placeOccupant( color(150, 150, 250), "- Oh, h-hello, "+party.hero[2].name.charAt(0)+"-"+party.hero[2].name+". Is it really true that you're leaving? I can't believe it. I... I have something that will keep you safe. It's technically contraband, so I had to hide it in a tree. Check the other side of the cloister. Goodbye, "+party.hero[2].name+". I'll miss you." );
  
  
  
}
