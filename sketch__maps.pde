void setupMaps()
{
  String mapStrings[] = new String[mapCount]; //10 is temporary
  String dangerStrs[] = new String[mapCount];
  
  for(int i = 0; i < dangerStrs.length; i++)
  {
    mapStrings[i] = " ";
    dangerStrs[i] = "";
    for(int j = 0; j < 9999; j++)
      mapStrings[i]+=" ";
    for(int j = 0; j < 10000; j++)
      dangerStrs[i]+="0";
  }
  
  //Key:  D-dark tree    T-tree    t-secret tree    #-wall    =-chest?-sign    *-save crystal
  //       -darkness     £-dark wall (alt-3)

  //      +-locked door  .-safe path  w-water       g-grave   &-stained glass    @-campsite/tavern
  //      c-copper key   i-iron key   s-skel key    b-brass key

  //      >-New floor portal

  mapStrings[0] = "";
  mapStrings[0] += "D########T~~tt~~t~~~~T~~~~~=~~~~~~~~~~~~~~~~>TTTTT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~DTTTDTTTT~~D~~~";
  mapStrings[0] += "##.?.?.?############~~~%%%%%%%%%~~~~###~###~~?TTTT#######~~~~~~~~~~~~~~~~~~~~~~~~~~~DT=~~TTTTTT###D~";
  mapStrings[0] += "#.....?*.#.....=.==#~~~%%%www%%%~~~T#.#~#=#~~~~TTT#&&&&&#~~~~~~~~~~~~~~~~~~~~~~~~~~~DT~~~~~~tt~~>#~~";
  mapStrings[0] += "#?.......###.#######~~~%%%%%%%%%~~~~#@#~#+#~~T~~TT############~~~~~~~~~~~~~~~~~~~~~~DT~~~TTTTTT###~D";
  mapStrings[0] += "#..........?......c+......~?~............c.......i+       s+=#~~~~~~~~~~~~~~~~~~~~~~~DTTTTwwTwTTTT~~";
  mapStrings[0] += "#=.?.=..........?.?#~~~~~.....~~~~~~~~~~%.%~T~~~TT############~~~~~~~~~~~~~~~~~~~~~~~~DDDDDwwwTT~~T~";
  mapStrings[0] += "####################%~~~~~~~~~~~g%~~~~T~%.%~~~~~TT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%wwwTT~~~";
  mapStrings[0] += "~TTTTTTTTTTTT~~~~~~%~~~~~~~~~~g~~~~~~~~~%.%~~~~TTT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%%ww%~~~";
  mapStrings[0] += "~TTtttttttttt~~~~~%~~%~%%www~~~#.#.#%~~~%*%~T~TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#TTtTTTTTTTTTT~~~~~%~~~~~wDw~~~#.#.#~~T~%%%~~TTT~T~TT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "#TTtttttttTTTTT~~~~~%~~~%www~~~#####~~~~~~~~TTT~T~TTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~TTTTTTTTtTTTTTTTTTTTTTTTTwTTTTT~~~~~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[0] += "~TTTTT=tttTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#TTTTTTTTTTTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~TTTTTTTTTTTTTTTTTTTTTTTTTTwwwwTTTTTTTTTTTTTTTTTTTTTTTT                                            ~";
  mapStrings[0] += "~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#TTTTTTTTTTTTTTTTTTTTTTTTTTTTwwwTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  mapStrings[0] += "~         ~                 wwwww                 T                                                ~";
  mapStrings[0] += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~wwwww~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  mapStrings[0] += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~wwwww~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
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

  m[0] = new Map(mapStrings[0]);
  
  exits.add( new Portal(44,0,0,2,3,1) );
  exits.add( new Portal(96,2,0,41,3,1) );

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
  
  dangerStrs[0] = "";
  dangerStrs[0] += "A000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";

  dangerStrs[0] += "B000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  dangerStrs[0] += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
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
  
  mapStrings[1] += "£ ###       ###      ###      ###     #####              ###£££££££££££££££££££££#####              ";
  mapStrings[1] += " #   #      #&#      #&#      #&#    ##   ##    #        #                          =#              ";
  mapStrings[1] += "#     ################################     #    #        # #£££££££££££££££££££££# ###              ";
  mapStrings[1] += "# >                                      >*#    #        £ £                     # #                ";
  mapStrings[1] += "#     ################ ###############     #             £ £                     £ £                ";
  mapStrings[1] += " #   #     ###£££    # #             ##   ##             £ £                     £ £                ";
  mapStrings[1] += "  ###      #    £    # #              #####              £ £                     £ £                ";
  mapStrings[1] += "           #=#£ £    # #                                 £ £                     £ £                ";
  mapStrings[1] += "           ###£ £ #### ####                              £ £                     £                  ";
  mapStrings[1] += "              £ ££#       #££££££££££££££££££££££££££££££# #                     £ £                ";
  mapStrings[1] += "              £   $ = = = $                                #                     £ £                ";
  mapStrings[1] += "              ££££#########££££££££££££££££££££££££££££££###                       £                ";
  mapStrings[1] += "                                                                                 £ £                ";
  mapStrings[1] += "                                                                                 #b#                ";
  mapStrings[1] += "                                                                                 #+#                ";
  mapStrings[1] += "                                                                                 # #                ";
  mapStrings[1] += "                                                                                 ###                ";
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
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  mapStrings[1] += "                                                                                                    ";
  
  exits.add( new Portal(2,3,1,44,0,0) );
  exits.add( new Portal(41,3,1,96,2,0) );
  
  m[1] = new Map(mapStrings[1]);
  
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
      
      
  //******************************************
  //Set up save points
  for (int i = 0; i < savePoints.length; i++)
    savePoints[i]=new SavePoint();
  savePoints[0] = new SavePoint(7, 2, 0);
  savePoints[1] = new SavePoint(41, 8, 0);
  savePoints[2] = new SavePoint(42, 3, 1);
  
  //for(int i = 2; i < m.length; i++)
  //  m[i] = new Map(mapStrings[i]);
  for(int i = 0; i < dm.length; i++)
    dm[i] = new DangerMap(dangerStrs[i]);
}
