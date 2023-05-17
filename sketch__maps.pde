color chilxiusColor = color(0,200);
color sunitaColor   = color(150, 250, 250);
color clericColor   = color(150, 150, 250);
color initiateColor = color (150, 150, 200);
color secretTeacherColor = color(200, 150, 200);
color ritisuColor   = color(31,153,226), lesserRitisuColor = color(75,180,243);
color dummyColor    = color(190, 170, 130);
color garrisonColor = color(160);
color governor      = color(125,110,10);
color male          = color(165,150,50),  mYoung     = color(250,230,0);
color female        = color(150,50,165),  fYoung     = color(230,150,250);
color raskColor     = color(250, 100, 50), coryColor = color(100,100,200);
color katColor      = color(250,0,170);
color sailor        = color(150,100,100), captain    = color(200,100,100);

void setupMaps()
{ 
  String mapStrings[] = new String[mapCount]; //10 is temporary
  String dangerStrs[] = new String[mapCount];
  
  //These should always ++ themselves when used
  int savePointIndex = 0;
  int lootIndex = 0;
  
  //This should be ++'d when the boss is made, then used for its attacks
  int bossIndex = 0;
  
  int mapIndex = 0;
  int dangerMapIndex = 0;
  
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
    
    
  //Key:  D-dark tree    T-tree    t-secret tree    #-wall      =-chest    ?-sign    *-save crystal  •-fake crystal
  //       -darkness     £-darkness wall (alt+3)    3-dark wall 5-sandstone wall     [-barrel        ©-werewolf statue (alt+©)
  //      G-gargoyle     R-dark gargoyle            W-wood      ∑-dark wood (alt+w)     „-light wood (alt+shift+w)
  //      .-stone floor  r-red floor  ∫-blue floor

  //      +-locked door  _-safe path  w-water       g-grave   &-stained glass    @-campsite/tavern
  //      c-copper key   i-iron key   s-skel key    b-brass key   ç-crypt key    ˝-gate key (alt+shift+g)  ~-grass    `-dirt    ,-dark dirt
  //      6-cave        §-brown cave
  //      $-secret wall   ¢-secret dark wall (alt+4)

  //      >-Stairs    <-Door(stairs)


  //---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 0 - Cathedral/Forest/Dockyard
  
  mapIndex = 0; mapStrings[mapIndex] = "";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT##################TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#####&&&&##&&&&##&&&&#####TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT########&#......„„„„„„......#&########TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTT########&#............„„„„............#&########TTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTT####&##&#....................................#&##&####TTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTT#####&#................∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫................#&#####TTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTT#####....................∫∫WWWWWWWWWWWW∫∫....................#####TTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTT#########...................∫∫WWWWWWWWWWWW∫∫...................#########TTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTT####.....##..................∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫..................##G....####TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTT###TT###T####...*...##..................................................##.......####T###TTT###TT";
  mapStrings[mapIndex] += "TTT#>#TT#>#####.........##....c....##############################.........##.........#####>#TTT#>#TT";
  mapStrings[mapIndex] += "TT##.####.####..G..G..G..#####+#####~~~~~~~~D#wwwwwwww#~~t~~~~~~#####.#####..©..G..G..####+#####+##T";
  mapStrings[mapIndex] += "TT#.............................#~~~~~~~T~~~~wwwwwwwwww~~~~~D~~~~~~#......................i.....i.#T";
  mapStrings[mapIndex] += "TT#.∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫..#~~~t~~~~~~~TwwwwwwwwwwT~~~~~~~~T~~#..∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫∫.#T";
  mapStrings[mapIndex] += "TT#.i....i.....G...G...G........~~~~~~~~~~~~~wwww##wwww~~~~t~~~~~~~~........G...G...G.....i.....i.#T";
  mapStrings[mapIndex] += "TT##+####+######.......####.....~~~~~~T~~~t~~Tww####wwt~~~~~~~~~~~~~.....########...######+#####+##T";
  mapStrings[mapIndex] += "TTT#>#TT#>####...„„„„„„„„##..G..#~~~~~~~~~~~~~~~~##~~~~~~~~~~~t~~~~#..G..##¬.¬.¬#...######>#TTT#>#TT";
  mapStrings[mapIndex] += "TTT###TT###T##[..„%%„%%„%##.....#~T~b~~D~~~~t~~~####~~~~~~T~~~~i~~~#.....##.....#...####T###TTT###TT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTT##..„%%„%%„%###########+############..############+###########.....#...###TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTwww%TTTTT##.„%%„%%„%##....................................k.........##¬.¬.¬#...##TTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTwwwwTTTTTT##„%%„%%„%##.G....................rr....................G.##.....#..##TTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTwwwTTTTTT##%%„%%„%##......................rr......................##B......##TTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTT###############################.rr.###############################TTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TDTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTWWWWWWW";
  mapStrings[mapIndex] += "D~DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTW,,€„,W";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTW,„„,„W";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTWWW<WWW";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#..G..?.rr.?..G..#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTT#################TTTTT#>.∫∫∫∫∫rr∫∫∫∫∫.>#TTTTT#########TTTTT#########TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTT#∫∫BB•..∫..•BB∫∫#TTTTT#..G....rr....G..#TTTTT#[[...∑]#TTTTT#==...3w#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTT&∫.....∫∫∫.....∫&TTTTT#######.rr.#######TTTTT#...W.∑.&TTTTT#.....33#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#########TTTT&.....∫∫∫∫∫.....&TTTTTTTTTTT#.rr.#TTTTTTTTTTT#>....∑.&TTTTT#>......#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#∫∫∫#rrr#TTTT#....∫∫∫>∫∫∫...%#TTTTTTTTTTT#.rr.#TTTTTTTTTTT#...W.∑.&TTTTT#..„„„..#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#.∫...r.#TTTT&3....∫∫∫∫∫.....&TTTTTTTTTTT#.rr.#TTTTTTTTTTT#[[...∑]#TTTTT#„„„„„„„#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#...#...#TTTT&3¢....∫∫∫.....∫&TTTTTTTTTTT#.rr.#TTTTTTTTTTT#########TTTTT#########TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#.r...∫.$tttt$¢¢3.•..∫..*..∫∫#TTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#rrr#∫∫∫#TTTT#################TTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT##$$#####TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TttttttttTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#..G..?.rr.?..G..#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT#>.∫∫∫∫∫rr∫∫∫∫∫.>#TTTTTT################TTTTTTTTTT#########";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#..G....rr....G..#TTTTTT########B#######TTTTTTTTTT#rr]==..#";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT#######.rr.#######TTTTTT##,,∞„.∫∫∫...∑##TTTTTTTTTT&.......#";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT##„„„„.∫∫∫...¬##TTTTTTTTTT&rr....>#";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT##.....i..k..∑##TTTTTTTTTT&.......#";
  mapStrings[mapIndex] += "TT%%%TTTTTTTTT#.rrrrrrrrrrrrrrr#TTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT###>###+##+###=#TTTTTTTTTT#rr.[]..#";
  mapStrings[mapIndex] += "TT%*%TTTTTTTTT##&###&###&###&#<#TTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT##########$$$$$#TTTTTTTTTT#########";
  mapStrings[mapIndex] += "TTT~TT~TTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "~TTtTTTTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTT~TTTTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTT#>##>##.rr.##>##>#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTtTTTTTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTT#+##+##.rr.##+##+#TTTTDTTTTDTTTTTTTDTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTT~TTTTTTTT%TTTTTTTTT~TTTTT##π##TTTTTT###i..i...rr...i..k###TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "```~TT%TTTTTTTT~TTTTTTTTTT~TG.i.GTTTTTT#>+i......rr......i+>#TTDTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "`@`TTTTTT~~~TTT~~t%~~~~t%~~~D...~TTTTTT###i..i...rr...i..i###TTTTTTTTTTYYY¨YYYYYYYYYYYYYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "````~~~~~~T~~~~~~~~~%T~t~~T~~`.`~TTTTTTTT#+##+##.rr.##+##+#TTTTTTTTTTTTYYYYYYYY,YYYYYY,YYYYYYY,YYYYY";
  mapStrings[mapIndex] += "T``TT~~TTTTT~TTT~TTTTTTTTTT~~```~TTTTTTTT#>##>##.rr.##>##>#TTTTDTTTTTTTYYY,YY,YYYY,YYYYYYYYYYYYY,YYY";
  mapStrings[mapIndex] += "TTTTTT~TT~TTTTTTTTTTTTT~TTTTT~```TTTTTTTT#######.rr.#######TTTTTTTTTTTTYYY¨YYY,YTYYY,YY¨YY¨Y¨YYYYYYY";
  mapStrings[mapIndex] += "TTTTT~tTT|TTT%TTTTTTTT%TTTTTT~```TTTTTTTTTTTTT##.rr.##TTTTTTTTTDTTTTTTTYYYY,YYYYY,YYYY¨Y¨YY¨YY¨¨YY,Y";
  mapStrings[mapIndex] += "DTTT~~TTTTT~~~~~~~TTTTT%T~TT~```~TTTTTTTTTTTT##..rr..##TTTTTTTTTTTTTTTTY,YYY`TTYYYYYyYYYYY¨YYYYYYYYY";
  mapStrings[mapIndex] += "TTTT~~~TT~~~~T%TT~~TTDTTTTTT~```~TTTTTTTTTTT##...rr...##TTTTTTTTTTTTTTTYYYYYTT∑∑∑YYY,yy¨¨¨,¨|¨Y¨Y,YY";
  mapStrings[mapIndex] += "TTTTT~~~~~%TTTTTT~~%TTTTTTTTT~```~TTTTTTTTT##..#.rr.#..##TTTTTTDTTTTTTTYYYYY~TW<WYYY¨YYYY¨Y¨¨,¨YYYYY";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTT~~~tTTTTTTTTT~```~TTTTTTTT##.....rr.....##TTTTTTTTTTTTTYY,YY~Y,,,¨yy,YY¨YY¨Y¨YYYYY¨Y";
  mapStrings[mapIndex] += "TTTTTTTTTTTtTTT%~~TttTTTTTTT~```~TTTTTTTTT&..#...rr...#..&TTTTTTTTTTTTTYYYY,YY,¨,YYYYTYY¨YY¨YYYY,YYY";
  mapStrings[mapIndex] += "TTTTg%%TT~~~~tt~~TTT=TTTTTTT~```~TTTTTTTTT&......rr......&TTDTTTTTTTTTTYY¨YYY¨YYYYYY¨YY¨YYYYY,Y,YYYY";
  mapStrings[mapIndex] += "TTTT%%%T~~TT~~~~TTTTTDTTTTTTT~```~TTTTTTTT&..#...rr...#..&TTTTTTTTTTTTTYYYYYYYY,YYY,YYYYYY,YYYYYYYYY";
  mapStrings[mapIndex] += "TTTT%%~~~TTTT~%TTTTTTTTTTTTTTTTTTTTTTTTTTT##.....rr.....##TTTTTTTTTTTTTYYYY,YYYYYYYYYYYYYYYYYYY,YYYY";
  mapStrings[mapIndex] += "TTTT~~~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT##..#.rr.#..##TTTTTTTTTTTTTTYYYYYYYY,YYYYYYYYY,YYYYYYYYYY";
  mapStrings[mapIndex] += "TTTTt~~tTTTTTTTTTTTTwwwwTTTTTTTTTTTTTTTTTTTT##...rr...##TTTTTTTTTTTTTTTYYYYYYYYYYYY¨YYYYYYYY¨YYYYYYY";
  mapStrings[mapIndex] += "TTTttTTtttTTTTTTTTwwwwwwwwTTTTTTTTTTTTTTTTTTT##..rr..##TTTTTTTTTTTTTTTTYYYYYYYYYYYYYYYYYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "TTTTtTTtTtTTTTTTTTTwwwwwwwwTTTTTTTTTTTTTTTTTTT##.rr.##TTTTTTTT###TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TT~tttTtttTTTTTTT``wwwwwwwTTTTTTTTTTTTTTTTTTTTT#.rr.#####&###&#.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTtTTtTtTttTTTTT``wwwwwwwwwTTTTTTTTTTTTTTTTTTTT#.rrrrrrrrrrrrrrr&TTTTTTTTTTTTTTTTTTTT%TTTTTTT~TT%TTT";
  mapStrings[mapIndex] += "TTttTTTTTTtTTTTT`wwwwwwwTTTTTTTTTTTTTTTTTTTTTTT#.rrrrrrrrrrrrrrr&TTTTTTTTTTTTTTT~TTTTTT~T%~~TTTTTTTT";
  mapStrings[mapIndex] += "TTTtTTTTtt~TTTTT```„„„„````TTTTTTTTTTTTTTTTTTTT##&###&###&###&#<#TTTTTTTTTTTTTTTTTTT%TTTT∑∑∑TTTTTTTT";
  mapStrings[mapIndex] += "TTTttTTttTTTTTT```wwwwww`T```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTTTTTTTTTTTTTTTTTW+WTT%TT~TT";
  mapStrings[mapIndex] += "TTTTttttTTTTTT~~`wwwwwwwwwwT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTTTTTTTTTTT~TTT%%~`~%%TTTTTT";
  mapStrings[mapIndex] += "TTTTT~~TTTTTT~~~`wwwwwwwwTTTT`TTTTTTTT~TTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTTTTTTTTTTTTT%TT%~`~%TTTT%TT";
  mapStrings[mapIndex] += "TTTTTT~~t~~t~~TTTTTTwwwTTTTT|`TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTTTTTTTTTT~TT~TTTT`TTT~TTTTT";
  mapStrings[mapIndex] += "TTTTT~~TTTTTTTTTTTTwwwTTTTTTT`|TTTT|D|TTTTTTTTTTTTTTTTTTTTTTT##π##TTTTTTTTTTTTTTTTTTTTTTTTtTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTttTTTTTTTTTTTTTTwwwwTTTTT`t~~t~t~=|TTTTTTTTTTTTTTTTTTTT~TG.i.GTTTTTTTTTTTTTTTTTTTTTTTT`TTTTTTTTT";
  mapStrings[mapIndex] += "TTTtttTTTTTTTTTTTTTTTwwwTTTTT`tTTTTTDT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTT...TTTTTTTTTTTTTTTTTTTtTTTTTTTTT";
  mapStrings[mapIndex] += "T%tttTTTTTTTTTTTTTTTwwwwTTTTT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT...TTTTTTTTTTTTTTTTTTTtTTTTTTTTT";
  mapStrings[mapIndex] += "tttT%TTTTTTTTTTTTTwwwwwwwTTTTT`TTTTTTTTTTTTwTTTTTTTTTTwwwwTTTTTTTTTT...TTTTTTTTTTTTTTTTTTT`tTTTTTTTT";
  mapStrings[mapIndex] += "TttTTTTTTTTTTTTTTwwwwwwwTTTTTT`TT|TTTTTTTT%wwwwwwwwwwWTTTwwwwTTTTTTT...TTTTwwwTTTTTTTTTTTTTt`TTTTTww";
  mapStrings[mapIndex] += "|tT|TTTTTTTTTTTTwww`y`www~TTTT`TTTTTTTTTTTwwwwwwWwwwwWWWTTTTwwwwTTTTT...TTwwwwwwT%TTTTTDDTTT~~TTwwwT";
  mapStrings[mapIndex] += "T@|TTTTTTTTTTT``„„„```„„„``TT``TTTTTTTTTT%ww∑∑„„W„„∑w`WWWWTTTTTwwwwww„„„wwwT~~%wwwwwTT%%%wwww„wwwTTT";
  mapStrings[mapIndex] += "|TTT|TTTTTTTTT`~wwwwwwwwwT````TTTTTTTTTTTTTww∑∑∑∑∑∑∑w((((((WT#TTTTTTT...TTTTTTTTTTTwwwwwwwwTT~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTT``TTwwwwwwwTTTTTTTTTTTTTTTTTTTwww∑∑∑W∑ww∑∑∑∑∑∑WTT#TT#T##..|##TT#TTTTTTTTTTTTTTT~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTT``TTTTTwwwwTTTTTTTTTTTTTTTTTTTTwwwwwwWwww##+###WWTTT~~~~~...~~~~~~~~~~~~~t~tt~tt~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTT``TTTTTTwwwTTTTTTTTTTTTTT~TTTTTTwwwwww„„„„````∑``WTTTT~~~....~~~~~~~~~~~~~~t~ttttTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~T~TT``TTTTTwwwwTTTTTTTTTTT~TTTTTTTTTwwwwwwwwww```````WWT~~~~....T~~~~~~~~~T~~~~~~t~t~TTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTT|TTT``TTTTwwwwwTTTTTTTTTTTTTTTTT|TTwwwwwwwwww````````WTT~~....~~~~~~~``~~~~~~~~~t~tTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT~T|TTTT~`TTTTwwwwwwwTTTTTT~TTTTT|TTTTTTwwwwwwwww`````````WTT~....~~~~~~~~~``~~~~~~~~~tTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT|T~`~~~~````„„„„„„„„„~~TTTTTTTTTTTTTTTTwwwwww„„„````````.WTT....~~~~T~~~~~~~~~~)))~~TTTTTTTTTTTT";
  mapStrings[mapIndex] += "T*t~``~TT|TTTTTwwwwwwTTwww~~t~~~t~tt>TTTTTTwwwwwwww````````........~~~~~~~~)~~~~~~~W+W~~TTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTT~TTTwwwwwwwwTTTTTTTTTTTTTTT|TTTwwwwwwww`}``````.......~~~~~~~~~W`|~~~~~~`````,∞,∞∞,TTTTT";
  mapStrings[mapIndex] += "TTT|TT|TTTTTTTTTTTwwwwwTTTTTTT|TTTTTT~TTTTTwwwwwww`````}````.W~~~~~~~~~~~~~~~~~~~~~TTTT~```````TTTTT";
  mapStrings[mapIndex] += "TTTTTTT~TTTTTTTTTTTwwTTTTTTTTTTTTT~TTTTTTTTwwwwwww}}````````WWTTTTTTTTTTTTTTTTTTTTTTTTTTT∞,∞,∞∞TTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTwwwwww}}}}`*`}}[WWTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTTWWWWWWWWWWWWWWWWWTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";

  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  
  createLoot(lootIndex++, 0, 47, 8, Key.COPPER_KEY);
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
  m[0].tiles[25][30].placeOccupant( lesserRitisuColor, "- There is balance to the elements. Fire opposes ice. Earth opposes wind. But common monsters fear the elements as well. Have you seen how rats flee from fire?" );
  m[0].tiles[29][30].placeOccupant( lesserRitisuColor, "- Combat is taxing. If you are knocked out, potions and healing magic will revive you, but not with full strength." );
  m[0].tiles[33][30].placeOccupant( lesserRitisuColor, "- Martial fighters gain power as they fight, power that manifests as fearsome techniques. More experienced fighters learn more skills and can utilize more energy." );
  m[0].tiles[21][33].placeOccupant( lesserRitisuColor, "- There are often many ways forward, and not all of them are obvious." );
  m[0].tiles[25][34].placeOccupant( lesserRitisuColor, "- Only one of these Legend Gems is genuine. Human artifice has been unable to re-create the Tears of Ritisu, though many have tried." );
  m[0].tiles[29][34].placeOccupant( lesserRitisuColor, "- Always tell your tales to the gems. You will learn from your past and your possible futures reflected in their clear facets." );
  //in method below
  m[0].tiles[8][36].placeOccupant( lesserRitisuColor, "- There are other ways to move. Try the number pad, if you have one. The 7 key will open doors, and the 9 will interact with stairs." );
  m[0].tiles[8][32].placeOccupant( lesserRitisuColor, "- When choosing a hero for the use of items, the target of skills, or equipment, (a)(s)(d) and (1)(2)(3) work the same. This is also true when targeting monsters." );
  //in method below
  //in method below
  //Chilxius
  m[0].tiles[1][24].placeOccupant( color(0,200), "- Well done. You'll go far in this world. Look at your feet for a small reward. I will follow your progress, so seek me out in the future." );
  m[0].tiles[67][30].placeOccupant( color(150, 150, 250), "- Imagine my kitchen without the sound of you three sneaking in during the night, and thinking I never heard you. Take as much as you can carry, my children. You may find more skilled chefs out there in the world, but no one else's bread will taste like home." );
  m[0].tiles[71][31].placeOccupant( color(150, 150, 200), "- Sorry, I'm busy." );
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
  m[0].tiles[70][87].placeOccupant( color(garrisonColor), "- There were costs, but the mission was successful." );
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
  m[0].tiles[71][85].placeOccupant( color(garrisonColor), "- Unused text." );
  m[0].tiles[68][83].placeOccupant( color(garrisonColor), "- Unused text." );
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
  m[0].tiles[53][90].placeOccupant( color(male), "- We're ready to sail. Come aboard as soon as you're ready." );
  m[0].tiles[55][98].placeOccupant( color(lesserRitisuColor), "- A new one! None know where the Tears of Ritisu will fall." );
  m[0].tiles[57][92].placeOccupant( color(male), "- Aren't there pirates on the sea?" );
  m[0].tiles[56][92].placeOccupant( color(female), "- Don't be afraid. Sea monsters ate all the pirates years ago." );
  m[0].tiles[51][95].placeOccupant( color(male), "He's busy moving cargo." );
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
  
  /*
  //Chest goblin
  m[0].tiles[34][32].placeBoss( 0, color(255,5), "Something pops out of the chest!", new Monster("Box Goblin", "RedBoxBoy.png", 1, 1, 1, 1, 1, 1, 1, 0, AttackType.NONE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("looks around.");
      zoo.boss[bossIndex].attacks[1] = new Attack("pretends to be a box.");
      zoo.boss[bossIndex].attacks[2] = new Attack("speaks in a strange language.");
      zoo.boss[bossIndex].attacks[3] = new Attack("does nothing.");
      zoo.boss[bossIndex].attacks[4] = new Attack("does a little dance.");
  bossIndex++;
  */
  
  //Giant rat blocking camp
  m[0].tiles[3][54].placeBoss( 0, color(150, 80, 40), "It's guarding that campsite.", new Monster("Escaped Rat", "BrownRat.png", 20, 9, 15, 2, 0, 2, 4, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites and claws.", 40, false);
  bossIndex++;
  
  //Giant rat blocking woods
  m[0].tiles[7][54].placeBoss( 0, color(150, 80, 40), "One of the big ones escaped.", new Monster("Escaped Rat", "BrownRat.png", 20, 11, 15, 2, 0, 2, 4, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks angrily.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites and claws.", 40, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("swipes with its tail.", 30, true);
  bossIndex++;
  
  //Spiders blocking chest
  m[0].tiles[36][79].placeBoss( 0, color(255, 175), "Hungry jaws surround you.", new Monster("Red Spider", "RedSpider.png", 10, 5, 10, 3, 0, 3, 5, 0, AttackType.NONE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("scurries forward.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites your arm.", 30, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites your leg.", 35, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites your neck.", 45, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites your hand.", 25, false, Debuff.POISON);
  bossIndex++;
  
  //Spiders blocking save point
  m[0].tiles[3][94].placeBoss( 0, color(255, 175), "They're attracted to the Legend Gem.", new Monster("Red Spider", "RedSpider.png", 10, 5, 10, 3, 0, 3, 5, 0, AttackType.NONE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("scurries forward.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites your arm.", 30, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites your leg.", 35, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites your neck.", 45, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites your hand.", 25, false, Debuff.POISON);
  bossIndex++;
  
  //The man-wolf
  m[0].tiles[20][93].placeBoss( 0, color(58,39,30), "It walks like a man.", new Monster("Man-wolf", "BrownWerewolf.png", 50, 20, 20, 3, 0, 5, 40, 0, AttackType.FIRE), false );
      zoo.boss[bossIndex].attacks[0] = new Attack("howls!");
      zoo.boss[bossIndex].attacks[1] = new Attack("claws.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("rends and claws!", 40, true);
      zoo.boss[bossIndex].attacks[3] = new Attack("rends.", 40, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites!", 50, false);
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
  m[0].tiles[67][42].createEvent(false, "- Impressions from your and Charis's knees remain in the soil.");
  m[0].tiles[69][42].createEvent(false, "- The sharp medicinal scent of herbs has already begun to fade.");
  m[0].tiles[72][44].createEvent(false, "- You would hide among these old robes when playing games as children. Charis always pretended not to see you.");
  m[0].tiles[73][42].createEvent(false, "- Tucked between his holy scriptures are illustrated fairy tales.");
  m[0].tiles[77][43].createEvent(false, "- You can almost hear the familiar scratching of his quill.");
  //m[0].tiles[68][44].createEvent(false, "- In the waning days of his life, Father Charis's study went largely unused. You still remember days passed, when the smell of ink and herbs would mix with the sound of water and a scratching quill. How could this place be so empty when he was alive only yesterday?");
  m[0].tiles[75][44].createEvent(false, "- Charis had no more worldly possessions than any other cleric. Why did he have an extra closet?");
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
  for(int i = 0; i < 58; i++)
    dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222222222222222222222xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "22222222222222222222233333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "00000022222222222222333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "00000222222222222222333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "00000222222222222222333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "00000333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "00000333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "00000333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "33333333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "33333333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "33333333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "33333333333333333333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "333333333333333333333xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";


  //--------------------------------------------------------------------------------------------------------------------\\
  //Floor 1 - Cellars/Houses/Caves/Etc.

  mapIndex++; mapStrings[mapIndex] = "";
  mapStrings[mapIndex] += "£  333     £  33###########  £  ################     ###  £  ###     ################  £  ######### ";
  mapStrings[mapIndex] += "3333R3333  £  3...........#  £  #&#>#&#........#     #=#  £  #=#     #........#&#>#&#  £  #W.W.W.W# ";
  mapStrings[mapIndex] += "3=?...?*3  £  3.33#.w.###.#  £  ###.###.#####..#     £ £  £  £ £     #..#####.###.###  £  #€.€.€.€# ";
  mapStrings[mapIndex] += "3.......3  £  3.3...w...#.#  £  ##...##....>#..#     £ £  £  £ £     #[.#>....$[....#  £  #.......# ";
  mapStrings[mapIndex] += "3[.[[.?.3  £  3.333.w.###.#  £  #.....#######..#££££££ £  £  £ ££££££#..#######....[#  £  #.......# ";
  mapStrings[mapIndex] += "3333333c3  £  3.3...w...#.#  £  #..............‹       £  £  £       $...........[[[#  £  #......?# ";
  mapStrings[mapIndex] += "3>33333+3  £  3.333.w.###.#  £  ################£££££££   £   £££££££################  £  ####>#### ";
  mapStrings[mapIndex] += "3.......3  £  3>3...w...#>#  £                            £                            £     ###    ";
  mapStrings[mapIndex] += "333333333  £  3333333333###  £                            £                            £            ";
  mapStrings[mapIndex] += "           £                 £££££££££££££££££££££££££££££ £££££££££££££££££££££££££££££            ";
  mapStrings[mapIndex] += "           £                 £                                            £             ££££££££££££";
  mapStrings[mapIndex] += "£££££££££££ £££££££££££££££££                                             £               £         ";
  mapStrings[mapIndex] += "           £                 £   §§§§§§§§                                 £    ∑∑∑∑∑∑∑∑∑  £         ";
  mapStrings[mapIndex] += "           £                 £  §,,,,,,,,§§§§§§§§§                        £    ∑,,W,W,,∑  £  #&###&#";
  mapStrings[mapIndex] += "333333|33  £  33###########  £   §§§§,,,,,,,,,,,,,§§§          §§§§       £    ∑,|,,,,,∑  £  #..*..#";
  mapStrings[mapIndex] += "3......=3  £  3.....#.....#  £       §§§§,,,,,,,,,,,,§§§      §,,,=§      £    ∑,,,,,,|∑  £  #.....#";
  mapStrings[mapIndex] += "3.|333333  £  3.33|.#.###.#  £           §§§§§§§]],,,,,,§    §,,§§§       £    ∑∑∑<∑<∑∑∑  £  #..>..#";
  mapStrings[mapIndex] += "3.......3  £  3.3[[.#..[#.#  £   £              §§§§,,,,,§   §,§          £       £ £     £  #######";
  mapStrings[mapIndex] += "333[=[3+3  £  3.333.#.|##.#  £       £             §§§§§,§   §,§          £               £         ";
  mapStrings[mapIndex] += "3>33333c3  £  3.3[..3.[=#.#  £           £      §§§,,,,,,§   §,,§         £               £         ";
  mapStrings[mapIndex] += "3.......3  £  3.333.3.###.#  £                 §,,,,§§§§§     §,,§       ££££££££££££££ ££ £££££££££";
  mapStrings[mapIndex] += "333333333  £  3>3=.....[#>#  £              £  §,§§§           §,,§      £             £            ";
  mapStrings[mapIndex] += "           £  3333333333###  £             £  §§,§§      §§§    §,,§     £             £            ";
  mapStrings[mapIndex] += "           £                 £            £  §,,,,,§§§§§§,,,§§§§§]]§     £   §§§§§§§   £  ∑∑∑∑∑∑∑∑∑∑";
  mapStrings[mapIndex] += "££££££££££££                 £           £  §,,§§§,,,,,,,,,,,,,,,,,§§    £  §„,,``ßB§  £  ∑W,,WW,,W∑";
  mapStrings[mapIndex] += "            £££££££££££££££££££££££££      §,,§   §§§§,,,,,,~~,,,,,,,§   £  §,,`§`,`§  £  ∑,,,,,,,,∑";
  mapStrings[mapIndex] += "                 £         £         £     §,§§       §,,,,,~~~,,,,,,§   £  §``,```]§  £  ∑,,,,,,,,∑";
  mapStrings[mapIndex] += "                 £         £         £     §,,,§       §,,,,,,,,,,,§,,§  £   §§§§§§§   £  ∑∑∑<∑∑<∑∑∑";
  mapStrings[mapIndex] += "###############  £  #####  £  WWWWW  £      §§,,§       §,,,,,,,,,§§,,§  £             £     £  £   ";
  mapStrings[mapIndex] += "#€#€#.......]]#  £  #∫∫∫#  £  WrrrW  £        §,,§    §§,,,,,,,,,,,§§,§  £             £            ";
  mapStrings[mapIndex] += "#.#.#.rrrWWWWW#  £  #∫∫∫#  £  Wrr]W  £         §,,§ §§,,,,,,,§§,,,,,,,§   £££££££££££££ ££££££££££££";
  mapStrings[mapIndex] += "#.#.#.rrrrrrr.#  £  ##<##  £  WW<WW  £          §,,§,,,,,,,,§§,,,,,,§§                              ";
  mapStrings[mapIndex] += "#.............#  £    £    £    £    £          §,,,,,,,,,,,,,,,,,,§                                ";
  mapStrings[mapIndex] += "#######<#######  £         £         £         §,,,,,,,,,,,,,,,,,,,,§  §§§§§§§§§§§                  ";
  mapStrings[mapIndex] += "       £         £££££ ££££ ££££ ££££   §§§§§§§wwwwww,,,,,,,,,,,,,,,,§§,,,,,,,,,,,§§§§§§§§§§§§§§§§§§";
  mapStrings[mapIndex] += "                 £    £         £    £  wwwwwwwwwwwwwwwwwwwwwww,,,,,,,,,,,wwww,,,,,,,,,,,,,,,>wwwwww";
  mapStrings[mapIndex] += "                 £                   £  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww,,,,wwwwwwwwwwwww";
  mapStrings[mapIndex] += "£££££££££££ £££££                    £   ,wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "           £                         £   ,,wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "           £       333££££££££££     £   ,,,,,,,,,,,,,,wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww§";
  mapStrings[mapIndex] += "#########  £       3>‹       ..B£    £   ,,,,,,,,,,,,,,,,,,,,,,wwwwwww,,,,,,,,,,wwwwwwwwwww,,,,,,,§§";
  mapStrings[mapIndex] += "#.......#  £       £ ££££££££==„£    £   ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,§§§";
  mapStrings[mapIndex] += "#WW...WW#  £       £ £       £££     £   ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,§§§";
  mapStrings[mapIndex] += "#.......#  £       £ £               £                                                              ";
  mapStrings[mapIndex] += "#.......#  £       £ £               £                                                              ";
  mapStrings[mapIndex] += "####<####  £       £ £                ££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££";
  mapStrings[mapIndex] += "    £      £       £ £                         £              £                  £                  ";
  mapStrings[mapIndex] += "           £       £ £      £                  £              £                  £                  ";
  mapStrings[mapIndex] += "           £       £ £  £  £>£  £  33&3333&33  £  ##########  £  ∑∑∑∑∑∑∑∑∑∑∑∑∑∑  £  ################";
  mapStrings[mapIndex] += "£££££££££££        £ £  £  £,£  £  3...*...@3  £  #      WW#  £  ∑>„„BBßBBß„„>∑  £  #>„„„rrrrrr„„„>#";
  mapStrings[mapIndex] += "                   £ £  £  £=£  £  3≥.......3  £  #}= }}  W#  £  ∑„„„„„„„„„„„„∑  £  #„„„„r∑∑∑∑r„„„„#";
  mapStrings[mapIndex] += "                   £ £  £  £=£  £  3##....##3  £  #} }}}}  #  £  ∑„„„∫∫∫∫∫∫„„„∑  £  #„„„„r∑∑∑∑r„„„„#";
  mapStrings[mapIndex] += "WWWWWWWWWWWWWWWWWWWW £  £  £,£  £  3........3  £  #}}     }#  £  ∑„„„∫WWWW∫„„B∑  £  #B„„„rrrrrr„„„B#";
  mapStrings[mapIndex] += "Wß             ß  Í  £      £   £  3##....##3  £  #   }}}}}#  £  ∑≠≠„∫∫∫∫∫∫„ıB∑  £  #B„„„„„„„„„„„„B#";
  mapStrings[mapIndex] += "W  B ßßÍBßBBßß ßß ß|£           £  3........3  £  # }}     #  £  ∑∑∑∑∑∑∑∑∑∑∑∑∑∑  £  #######<<#######";
  mapStrings[mapIndex] += "W∑ Í  ß     Í  ß  B||           £  3##....##3  £  # }  }} }#  £                  £         ££       ";
  mapStrings[mapIndex] += "WBÍß  ß ß ß B ßB | ||           £  3........3  £  #   }}}  #  £                  £                  ";
  mapStrings[mapIndex] += "W  BB Í B ß ß  ß  Í||           £  33&3<<3|33  £  #######<##   £££££££££££££££££££                  ";
  mapStrings[mapIndex] += "£| ß  ß ß ß B ßß   | |          £      ££      £         £    £         £         ££££££££££££££££££";
  mapStrings[mapIndex] += "W= ßB   ßrß B    |ß||           £              £              £         £              £            ";
  mapStrings[mapIndex] += "WWWWWWWWW<WWWWWWW||||| |         ££££££££££££££ ££££££££££££££   66666  £              £            ";
  mapStrings[mapIndex] += "         £                                               £       6,,,6  £  #########   £   #########";
  mapStrings[mapIndex] += "                                                                 6,,,6  £  #..33.#.#   £   #.#.33..#";
  mapStrings[mapIndex] += "                                                                 6,,,6  £  #≠....πç>£  £  £>çπ....≠#";
  mapStrings[mapIndex] += "                                                                 6,,66  £  #..33.#.#   £   #.#.33..#";
  mapStrings[mapIndex] += "                                                                66,,6   £  #########   £   #########";
  mapStrings[mapIndex] += "                                £££££££££££££££££££££££££    6666,,66   £              £            ";
  mapStrings[mapIndex] += "                                                            66,,,,6     £              £            ";
  mapStrings[mapIndex] += "                                                           66,,6666      £££££££££££££££££££££££££££";
  mapStrings[mapIndex] += "    ####  ####  ####  ####  ####   ###   ####  ####  ####  6``66 ####   £              £            ";
  mapStrings[mapIndex] += "   ##..####..####..####..####..#####G#####.w####..####..####..####..##  £              £            ";
  mapStrings[mapIndex] += "  ##G......................................ww,,......................#  £  #########   £   #########";
  mapStrings[mapIndex] += "  #>........................................ww,,.....................π  £  #..33.#.#   £   #.#.33..#";
  mapStrings[mapIndex] += "  ##G........................................w,,,....................#  £  #≠....πç>£  £  £>çπ....≠#";
  mapStrings[mapIndex] += "   ##..####..####..####..####..#####G#####..####,,####..####..####..##  £  #..33.#.#   £   #.#.33..#";
  mapStrings[mapIndex] += "    ####  ####  #..#  ####  ####   ###   ##$#  ##,#  #$##  ####  ####   £  #########   £   #########";
  mapStrings[mapIndex] += "                #..#                      £ £   £ £  £ £                £              £            ";
  mapStrings[mapIndex] += "    ####  ####  #..#  ####  ####          £ £   £ £  £ £                £              £            ";
  mapStrings[mapIndex] += "   ##..####..####..####..####..##         £ £   £ £  £ £  ££££££££££££££ £££££££££££££££££££££££££££";
  mapStrings[mapIndex] += "   #...|........................#         £ £   £ £  £ £  £             £              £            ";
  mapStrings[mapIndex] += "   ###.....|################G...#         £ £   £ £  £ £  £             £              £            ";
  mapStrings[mapIndex] += "      ###|......................#         6,66666,6666,6  £    33333    £  #########   £   #########";
  mapStrings[mapIndex] += "         ##..####..####..####..##         6,,,,,,,6%~~,6  £   3     3   £  #..33.#.#   £   #.#.33..#";
  mapStrings[mapIndex] += "          ####  #..#  ####  ####          66666666666666  £  3       3  £  #≠....πç>£  £  £>çπ....≠#";
  mapStrings[mapIndex] += "                #..#                                      £  3       3  £  #..33.#.#   £   #.#.33..#";
  mapStrings[mapIndex] += "           ###  #..#  ###                                 £  3       3  £  #########   £   #########";
  mapStrings[mapIndex] += "£££££     ##.####..####.#####     ££££££££££££££££££££££££   3    ¶  3  £              £            ";
  mapStrings[mapIndex] += "£££  £   ##G.............|.|##   £                        £  3       3  £              £            ";
  mapStrings[mapIndex] += "„„,£ £   #>............|....>#   £                        £   3     3    £££££££££££££££££££££££££££";
  mapStrings[mapIndex] += "€„„£ £   ##G.............#.|##   £  3333333333333££££££   £    33<33     £             £            ";
  mapStrings[mapIndex] += "£<£  £    ##.####..####.####     £  3BßB rır BBÍ¢     >£  £      £       £             £            ";
  mapStrings[mapIndex] += " £   £     ###  ####  ###        £  3    rrr    3££££££   £              £  ##&###&##  £  ##&###&## ";
  mapStrings[mapIndex] += "     £                           £  3±≠       ≠≠3          £££££££££££££££  #...[[..#  £  #3.....3# ";
  mapStrings[mapIndex] += "     £                           £  33333   33333                        £  #[..[].|#  £  #3.....3# ";
  mapStrings[mapIndex] += "£££££ £££££££££££££££££££££££££££        3 3                             £  #][....[#  £  #...@...# ";
  mapStrings[mapIndex] += "                                 £      33 3333333333333333              £  #[....[[#  £  #.......# ";
  mapStrings[mapIndex] += "                                  £££   3   3  3  3  3  3 3333333333333  £  #......]#  £  #3.....3# ";
  mapStrings[mapIndex] += "333££33£££3£33     ###££#££££££      £  3                             3  £  #|.[....#  £  #3.....3# ";
  mapStrings[mapIndex] += "£,,`,````,,,>3  £  #>...     >£      £  3   3  3  3  3  3 3333333333333  £  ##&#<#&##  £  ##&#<#&## ";
  mapStrings[mapIndex] += " 3££££3££3£33      ##£#££££££££      £  3333333333333333333              £     ###     £     ###    ";
  
  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  //m[1].floorNumber=1;
  
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
  createLoot(lootIndex++, 1, 98, 83, new Equipment("Flamecaster Staff","Staff2.png",25,true,27.2,Job.DRUID,Job.MAGE) );
  
  //Boss Chamber
  createLoot(lootIndex++, 1, 37, 92 , new Equipment("Ritual Knife","curvedDagger.png",35,true,30.01,Job.KNIGHT,Job.BARBARIAN,Job.SAURIAN,Job.BARD,Job.THIEF,Job.DRUID,Job.MAGE) );
  createLoot(lootIndex++, 1, 38, 92 , new Equipment("Ritual Robes","darkRobes.png",29,false,20,true) );
  createLoot(lootIndex++, 1, 46, 92 , new Item("Mana Potion",12) );
  createLoot(lootIndex++, 1, 47, 92 , new Item("Health Potion",24) );
  
  m[1].tiles[2][2].createEvent(true, "- The (space) key can be used to open chests like this one. You also use this key to search your current square. See if you can find anything left behind in this room by careless initiates.");
  m[1].tiles[6][2].createEvent(true, "- This is a sacred Legend Gem. Gazing into it, you can feel your acomplishments being told around campfires centuries from now. Step on it and press capital (S) to activate it, and then press ENTER to confirm and save your progress.");
  m[1].tiles[6][4].createEvent(true, "- Some doors are locked. You can view your key ring by holding down the (k) key. By examining a door, you can determine what key is required. If you stand next to the door and press the (o) key, you will use the proper key if you possess it. Keys are fragile, and usually break after a single use.");
  m[1].tiles[2][7].createEvent(false, "- This stairwell will lead to a new room. To use it, stand on it and press the (>) key.");
  m[1].tiles[18][1].createEvent(false, "- Some of the clerics are busy cleaning the cellar. Walk into their space to speak with them.");
  m[1].tiles[35][3].createEvent(false, "- Sometimes, you can pass only one way across a threshold. This is one of those moments. Once you ascend these stairs, your story will truly begin. Good luck, young heroes.");
  m[1].tiles[97][5].createEvent(true, "- Press capital (R) on a bed to rest. Resting in a safe place will fully restore health and magic.");
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
  m[1].tiles[98][15].placeOccupant( color(75,180,243), "- One needs not a strong body to endure elemental magic, but a strong will. A mage might endure a bolt of lightning that would cow the strongest warrior." );
  m[1].tiles[94][16].placeOccupant( color(75,180,243), "- Not all elemental skills draw from magical energy. Some are powered by strength or swiftness. Learn how your abilities affect different foes." );
  
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
  m[1].tiles[1][41].placeOccupant( color(garrisonColor), "- I remember when I stood in this line." );
  m[1].tiles[7][41].placeOccupant( color(garrisonColor), "- Too young. They're too young. I taught these children to read and catch fish." );
  m[1].tiles[1][43].placeOccupant( color(mYoung), "- UNUSED TEXT" );
  m[1].tiles[1][44].placeOccupant( color(mYoung), "- It's mostly just guard duty, right?" );
  m[1].tiles[2][43].placeOccupant( color(mYoung), "- My father ordered me to sign up. I'll make him proud." );
  m[1].tiles[7][43].placeOccupant( color(mYoung), "He's staring at the floor." );
  //in method below
  
  //Town Hall 1
  //Guards
  m[1].tiles[86][49].placeOccupant( color(garrisonColor), " - Please stay in line!" );
  m[1].tiles[97][49].placeOccupant( color(garrisonColor), " - You're Rask's friends? Go on up, but try not to let anyone see you." );
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
  m[1].tiles[71][51].placeOccupant( color(garrisonColor), "- My soldiers will be dying to open the way for you. Do not let us down." );
  //Secretary
  m[1].tiles[76][52].placeOccupant( color(female), "- The mayor is busy. Please be brief." );
  //Citizen
  m[1].tiles[66][49].placeOccupant( color(male), "- Hurry up. I was next in line.");
  
  //Hideout
  m[1].tiles[77][26].placeOccupant( color(mYoung), "- Are you really going into Baron's Field? Wow. You must be crazy. I want to be just like you some day." );
  m[1].tiles[80][24].placeOccupant( color(mYoung), "He says nothing while nervously extending his hand toward you. You grasp it affirmingly, and he stops shaking." );
  m[1].tiles[82][25].placeOccupant( color(fYoung), "- This is our pretend cake that we were saving for a special day. If you're going to chase away the bone men, then today is special. You have my permission to take it." );
  
  //Chilxius
  m[1].tiles[30][40].placeOccupant( color(chilxiusColor), "- The loss of a good library is always tragic. Take your prizes and go. You made me lose my place." );
  m[1].tiles[28][52].placeOccupant( color(chilxiusColor), "- One of our number was from Irohill. Never forget to respect the dead." );
  
  //Ghosts
  m[1].tiles[37][50].placeOccupant( color(255,150), "- Take this and find the tomb of the deGrace family. There is more within than bones. Beware those who aquire wealth with ease." );
  m[1].tiles[42][49].placeOccupant( color(255,150), "- Weariness. I remember it as disagreeable, but not the feel of it. Rest here. You are safe within these walls." );
  m[1].tiles[40][54].placeOccupant( color(255,150), "- I am, or was, Jon Mul. I was the first to be disjoined from flesh in Irohill. The meteor that struck the hill in ages past ended my mortal life, but I did not cross the Veil. I watched over Irohill instead, a silent observer as the cathedral and mausoleum were built and as infants became elders. Never have I cursed my lot more than now as hollow shells rise to trouble my home. Please, save Irohill. I will do all I can do and have ever done, and watch." );
  m[1].tiles[41][52].placeOccupant( color(255,150), "- Recently a light shone from the cathedral. It was like a spark of Illamar himself. The light swept through the catacombs and I heard a screech as one who denied death was pulled across the Veil. Your foe's spirit has gone. You need only destroy the lingering body." );
  m[1].tiles[36][54].placeOccupant( color(255,150), "- Why did my darling Sunita not inherit the gift? Shall we not speak again this side of the Veil?" );
  
  m[1].tiles[66][61].placeOccupant( color(200,150), "- Beux deGrace, at your service. The use of my family's tomb was his price for wealth and power. To be forever disjoined was not a part of the contract." );
  m[1].tiles[67][65].placeOccupant( color(200,150), "- Do you desire justice upon us for our role in this? My descendants and friends suffer. I hear their cries, but they are deaf to mine. No criminal court could do more to me." );
  m[1].tiles[48][74].placeOccupant( color(200,150), "- Could you please tell Mother Sunita that my tomb is leaking? Because I'm worried about the safety of the entire catacomb, of course." );
  m[1].tiles[12][71].placeOccupant( color(255,150), "- Our enemy stored his supplies in the cenotaph up ahead. It will do him no good now. Take it. Save Irohill." );
  
  //Circle of Ghosts
  m[1].tiles[93][96].placeOccupant( color(255,150), "- I have watched over Irohill for fifteen generations. I have watched you brave this cursed place. Now we shall watch and protect while you rest and prepare for the coming fight." );
  m[1].tiles[92][94].placeOccupant( color(255,150), "- He used my family. We may never expunge our sin, but let me do what I can." );
  m[1].tiles[93][92].placeOccupant( color(255,150), "- Until we can follow Charis through the Veil, you are our only link to the living world. Please stay alive." );
  //in method below
  m[1].tiles[96][94].placeOccupant( color(255,150), "- I do not know how his body continues to do evil without its spirit. Try to save his mangled remains for study." );
  m[1].tiles[95][96].placeOccupant( color(255,150), "- When you see my daughter, tell her that I am proud." );
  
  
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
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 25, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 35, false);
  bossIndex++;

  m[1].tiles[20][21].placeBoss( 1, color(150, 80, 40), "A large rat guards the way.", new Monster("Giant Rat", "BrownRat.png", 18, 6, 5, 1, 9, 1, 3, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 27, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 32, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 37, false);
  bossIndex++;

  m[1].tiles[18][19].placeBoss( 1, color(150, 80, 40), "A large rat guards the way.", new Monster("Giant Rat", "BrownRat.png", 26, 7, 5, 1, 9, 1, 4, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 29, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 34, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 39, false);
  bossIndex++;

  m[1].tiles[1][16].placeBoss( 1, color(150, 80, 40), "A swarm comes for you!", new Monster("Giant Rat", "BrownRat.png", 18, 5, 5, 1, 12, 1, 3, 0, AttackType.FIRE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 29, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 34, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 39, false);
  bossIndex++;

  m[1].tiles[5][15].placeBoss( 1, color(200, 80, 40), "This must be their matriarch.", new Monster("Rat Queen", "RedRat.png", 35, 12, 5, 2, 24, 3, 5, 0, AttackType.NONE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("eyes you hungrily.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 35, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites and scratches.", 40, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("whips her tail.", 35, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("summons her brood!", 30, true);
  bossIndex++;

  m[1].tiles[62][18].placeBoss( 1, color(150, 80, 40), "Kat was right. They are getting bigger.", new Monster("Burning Rat", "RedRat.png", 45, 9, 10, 3, 9, 5, 7, 0, AttackType.ICE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("bites.", 35, false);
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 35, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("coughs out fire.", 20, true, AttackStat.MAG, AttackType.FIRE);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites with its glowing mouth.", 40, false, AttackStat.MAG, AttackType.FIRE);
      zoo.boss[bossIndex].attacks[4] = new Attack("coughs up black smoke.");
  bossIndex++;
  
  m[1].tiles[4][55].placeBoss( 1, color(230), "Its empty eyes glow with malice.", new Monster("Skeleton", "Skeleton.png", 40, 9, 1, 2, 1, 3, 4, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("scratches.", 40, false);
      zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("gouges with phalanges.", 45, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("gouges with phalanges.", 45, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("stabs with a rib.", 55, false);
  bossIndex++;
  
  m[1].tiles[14][55].placeBoss( 1, color(230), "It is stained with ink and blood.", new Monster("Skeleton", "Skeleton.png", 40, 9, 1, 2, 1, 3, 5, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("scratches.", 40, false);
      zoo.boss[bossIndex].attacks[1] = new Attack("scratches.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("slams with its radius.", 45, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("slams with its radius.", 45, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("hacks with its mandible.", 55, false);
  bossIndex++;
  
  m[1].tiles[16][55].placeBoss( 1, color(230), "They've gathered in the darkness.", new Monster("Skeleton", "Skeleton.png", 35, 9, 1, 2, 1, 3, 6, 0, AttackType.HOLY),true );
      zoo.boss[bossIndex].attacks[0] = new Attack("tackles.", 40, false);
      zoo.boss[bossIndex].attacks[1] = new Attack("swipes.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("throws a rib.", 45, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bashes with its skull.", 45, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("clubs with a femur!", 55, false);
  bossIndex++;
  
  //Crypt Guardians
  m[1].tiles[78][63].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Alar", "Crypt1.png", 50, 13, 10, 7, 1, 3, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("strikes with its knee.", 40, false);
      zoo.boss[bossIndex].attacks[1] = new Attack("kicks.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("swings wide.", 40, true);
      zoo.boss[bossIndex].attacks[3] = new Attack("swings its axe!", 60, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("swings its axe!", 60, false);
  bossIndex++;
  m[1].tiles[78][73].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Corel", "Crypt6.png", 50, 13, 15, 7, 1, 3, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("growls.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swipes.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("lunges like a beast!", 60, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bashes with its jaw!", 60, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bashes with its club!!", 60, false);
  bossIndex++;
  m[1].tiles[78][83].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Ruath", "Crypt2.png", 50, 8, 10, 6, 8, 6, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("intones muddled words.");
      zoo.boss[bossIndex].attacks[1] = new Attack("strikes with its hand.", 40, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("smites!", 60, false, AttackStat.STR, AttackType.HOLY);
      zoo.boss[bossIndex].attacks[3] = new Attack("shines with holy light.", 30, true, AttackStat.MAG, AttackType.HOLY);
      zoo.boss[bossIndex].attacks[4] = new Attack("swings its mace!", 60, false);
  bossIndex++;
  m[1].tiles[96][63].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Zan", "Crypt3.png", 50, 9, 10, 10, 1, 4, 9, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("readies for your attack.");
      zoo.boss[bossIndex].attacks[1] = new Attack("attacks.", 45, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("strikes with the flat of its blade.", 50, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("stabs at you.", 55, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("swings its weapon!", 60, false);
  bossIndex++;
  m[1].tiles[96][73].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Ivy", "Crypt4.png", 50, 2, 10, 2, 8, 9, 7, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("gazes silently.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its staff.", 45, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("levitates a tomb stone.", 50, false, AttackStat.MAG, AttackType.EARTH );
      zoo.boss[bossIndex].attacks[3] = new Attack("speaks a secret word.", 55, false, AttackStat.MAG, AttackType.HOLY );
      zoo.boss[bossIndex].attacks[4] = new Attack("summons a storm of tomb dust!", 50, true, AttackStat.MAG, AttackType.WIND );
  bossIndex++;
  m[1].tiles[96][83].placeBoss( 1, color(200,130,100), "The guardian rises to test you.", new Monster("Body of Erar", "Crypt5.png", 50, 2, 10, 2, 9, 8, 7, 0, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("makes arcane gestures.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its staff.", 45, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("causes the crypt to shake!", 45, true, AttackStat.MAG, AttackType.EARTH );
      zoo.boss[bossIndex].attacks[3] = new Attack("delivers an icy touch.", 50, false, AttackStat.MAG, AttackType.ICE );
      zoo.boss[bossIndex].attacks[4] = new Attack("conjures a ring of fire!", 55, true, AttackStat.MAG, AttackType.FIRE );
  bossIndex++;
  m[1].tiles[42][96].placeBoss( 1, color(77,20,20), "Malice smolders in its vacant eyes.", new Monster("Body of Necromancer", "Necro.png", 150, 20, 15, 6, 15, 10, 10, 50, AttackType.HOLY) );
      zoo.boss[bossIndex].attacks[0] = new Attack("stabs with a wicked knife.", 45, false, Debuff.POISON);
      zoo.boss[bossIndex].attacks[1] = new Attack("exhales chilling air.", 40, true, AttackStat.MAG, AttackType.ICE );
      zoo.boss[bossIndex].attacks[2] = new Attack("drops stones to bury you!", 55, false, AttackStat.MAG, AttackType.EARTH );
      zoo.boss[bossIndex].attacks[3] = new Attack("drops stones to bury you!", 55, false, AttackStat.MAG, AttackType.EARTH );
      zoo.boss[bossIndex].attacks[4] = new Attack("causes your very bones to freeze!", 55, true, AttackStat.MAG, AttackType.ICE );
  bossIndex++;
  
  //Danger Map 1
  dangerMapIndex = 1; dangerStrs[dangerMapIndex] = "";
  for(int i = 0; i < 12; i++)
  dangerStrs[dangerMapIndex] += "A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "1111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "C11111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "111111111111111111111111111111xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "Exxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "Fxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "Gxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "H55555555555555555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "555555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxx555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxx555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "xxx555555555555555555555555555xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "x44444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  
  
  //---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 2 - Irohill
  
  mapIndex++; mapStrings[mapIndex] = "";
  mapStrings[mapIndex] += "YTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
 
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTT~TTTTTTTTTTTTTTTTTT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTT~~~TT~~~~TTT~~~~~TT~~TTTTT~~~~TT~~~T~```~~~~~~~~~~~T~~~TTTTT~~~T~TTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~TTT~~~~~~~~~~~~```~~~$~~~~~$~~~T~~~TT~T~~~~~,,∞,,,∞,,,,,∞,,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~T~~~~~))))))))~~~~~~~~~~~~~~~~~~~T~~~~```~~T$$$$$$$~~T~~T~~~~~~T~~~```````````````~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTT~~~~))))∑∑∑∑∑∑∑∑))))~~~T~~~~~~~~~~~~~~~~```~~~#+###+#~T```````T~~~~~~,,,,∞,,,,,∞,,,,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~))))))))))))))))~~~~~(((~~(((~~(((~~```~~~#.....#~~```````~~T~T~~```````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~~~∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑~~~~~WWW~~WWW~~WWW~~```~~~#######T~```````~~~(((~∞,,,,∞,∞,,,,,∞,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~T~~#######<<#######~~T~~#+#~~W+W~~W+W~~```~~~###<###~~```````T~~∑∑∑~```````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~T~~%~%~%~``~%~%~%~~T~~~~`~~~~`~~~~`~T~```~T~##~`~##~T```````~~~∑+∑~,,∞∞,,,,,,∞,,,,~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTT~~~~~~~~~~~``~~~~~~~~~~~~~`T~~~`~~~~`~~~```~~~~~~`~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~`````````````````````````````````````````````````````````````````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~T~~~```~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~(((~~(((~~(((~~(((~~(((~~(((~~(((~~~~~```~~~~~#&#&#~T~(((((((((((((~~((((((~~~T~~~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~T~~WWW~~∑∑∑~~∑∑∑~~∑∑∑~~∑∑∑~~WWW~T∑∑∑~~~```````~T~#####~~~(((((((((((((~~((((((~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~W+W~~#<#~~∑+∑~~#+#T~∑+∑~~W<W~~∑+∑~~``TTTTT``~~##>##~~~∑∑∑∑∑∑∑∑∑∑∑∑∑~T######~~~~T~~TTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~~`~~~~`~~~%`%~~~`~~~~`~~~~`~~~~`~~~`T%%%%%T`~~~G.G~~~~######<######~~####+#T~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~`~~T~`~~~~`~~~~`~~~~`~~~~`~~~~`~~~`T%WWW%T`~~~~.~~~~ˆ~~~~~~`~~~~~~~~~~~~~~~~~~~~~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~```````````````````````````````````T%WwW%T``````````````````````````````````~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~#############~((((((((~~~((((((((~~`T%WWW%T`~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTTT~~#(((~(((~(((#~((((((((~T~((((((((~~`T%~`~%T`~~(((~~~~~~~~~`~~~~T~~~~~~~~~~~~~~~~~~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~#∑∑∑~∑∑∑~∑∑∑#~∑∑∑∑∑∑∑∑~~~∑∑∑∑∑∑∑∑~~``T~`~T``~~WWW~~W||`~|~~~``~~~~(((((~~~~~~T~~~~TTTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~#∑+∑~∑+∑~∑+∑#~∑∑<∑∑<∑∑~~~∑∑<∑∑<∑∑~~~```````~~~W+W~~#.|~~||~~~|~`~WWWWWWWW||~~~~~~~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~T~~~~`~~~`~~~`~~~~~`~~`~~~~T~~`~~`~~~~~~~~`~~~~~~~`~~~~`~~~~`~`~~~~`|WWWW<WWW|~|~`~~TTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~`~~~`~~~`~~~~÷`~~`÷~~~~~/`~~`/~~~~%%%`%``~~~~`~~~~`~~~~`~~~~~~~~~~~```~~~~~~~~~~TTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~~~`````````````````````````````````````````````````````````````~`````~~````~`~`~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTT~~~~~~~T~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~`~~~~~~~~~~~~~`~~~~~~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTT~~~~T~~~~~~~~T~~~~~~~~~~T~~~~~~~~~~~~~~~~TT~~~~~~~~~~~~~~~~~~~T~~~~~`~~~``~~~~~``~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTT~TTT~~~T~TTT~T~~T~~~~TTT~~~~~TTTTTT~~~TTTT~~~TT~~~~T~~~~~T~TT~~~~~~~``~~~~~`~~``|~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~|~~`~~~~`~~~TTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT~`~~~`~`~TTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT~`~`~~`~~TTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT~```~~`~TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT~TTTT```````TTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT````````TTTTTT~TTTTTTTT";
  mapStrings[mapIndex] += "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYTTTTTTTTTTTTTTT````T```TTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYTTTTTTTTTTTTT`````TT``TT~TTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YY¨YYYYYY¨YYYY¨YYYYYY¨YYYYYYYYYYYY¨YYYYYYY¨YYYYY¨YYY¨YwwwwwwwwwwwwwwTTTTT`````TT``TTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YYYY¨YY¨YYYYYYYYYY¨YYYYYYYYYYY¨YYYYYYYY¨YYYYY¨¨YYY¨YYwwwwwwwwwwwwwwwwTTT``````TT`TTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "Y¨YYYYYY¨YYY¨YYY¨YYY¨YYY¨YY¨YYYY¨YYY¨YYYY¨YYY¨YYY¨YYYwwwwwwwwwwwwwwwwTT```````T``TTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YYYY¨¨YYYY¨YYY¨YYY¨YY¨YY¨YYYYY¨YYYYYYY¨YYYY¨Y¨YYYYY¨YYwwwwwwwwwwwwwwwT```````````TTTTTTTTTTT`TTTTTTT";
  mapStrings[mapIndex] += "Y¨YYYYY¨¨YYY¨¨YY¨YY¨YYYYYYYY¨YYY¨¨¨YYYYY¨¨¨YYY¨¨¨YYY¨¨¨wwwwwwwwwwwwwT````````````tt`tttt`tt`,`TTTTTT";
  mapStrings[mapIndex] += "YY¨¨Y¨¨¨¨¨¨¨¨¨¨¨YYYYY¨¨Y¨¨¨¨YY¨¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨¨YYwwwwwwwwwwwwwwT,``,```````TTTTTTTTTTTT`TTTTTTT";
  mapStrings[mapIndex] += "Y¨¨¨¨¨¨¨Y¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨,,,,,,,„„„„„„„„„„„„„„„„,,,```,```TTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "Y¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨Y¨¨¨Y¨¨¨¨Y¨¨¨¨YY¨¨¨¨¨,,,,,,,,,„„„„„„„„„„„„„„„„,,,,,``TTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YY¨¨¨¨Y¨¨Y¨¨¨¨¨,,,,,,,,,,,,,,,,,,,,¨Yww¨¨,,,,,,¨¨¨¨¨,,wwwwwwwwwwwwwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "Y¨¨Y¨¨¨¨¨¨¨Y¨,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,¨¨¨¨YY¨¨¨¨wwwwwwwwwwwwwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YY¨¨¨¨Y¨¨¨¨,,,,,¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨Y,,,,,,,,,,¨¨¨¨¨¨YYYYYYwwwwwwwwwwwwwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "¨YY¨¨¨¨¨¨¨,,,,,¨Y¨¨¨¨¨Y¨¨¨¨¨Y¨¨Y¨¨¨¨¨¨¨Y¨¨¨¨¨YY¨¨YY¨YYYYwwwwwwwwwwwwwwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YYYY¨¨¨Y¨¨,,,,¨¨¨¨Y¨¨¨¨¨¨Y¨¨¨Y¨¨¨¨Y¨¨¨¨¨¨Y¨¨Y¨¨¨YYYYYYYYYwwwwwwwwwwwwwwwwwTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "YYYYYY¨¨¨,V,V,¨Y¨¨¨¨¨Y¨¨¨Y¨¨¨¨¨Y¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨YYYYY¨¨¨¨YYwwwwwwwwwwwwwwwTTTTTTTTTT¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨";
  mapStrings[mapIndex] += "Y¢¢¢¢¢¢¢¢¢¢˝¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢¢Y¨YYYYY¨¨¨YY¨¨YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33333333333∏33333333333333333333333333333333YYYY¨¨YYY¨¨Y3333333333333333333333¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨,¨¨¨¨¨¨¨¨¨33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3333333333333333¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨YYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨|¨g¨g¨g¨,¨g¨g¨g¨|¨33¨g¨g¨g¨|¨g¨g¨g¨g¨g¨3¢,,¨¨¨¨¨¨,,,333¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨YYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨,¨¨¨,¨¨¨,¨¨¨,¨,¨¨¨33,,,¨¨¨¨¨¨∞¨¨¨,¨¨¨%¨333¨¨Y¨¨¨¨¨¨,,33¨¨¨g¨¨¨g¨¨¨g¨¨¨g¨¨¨3¨¨¨¨¨¨¨¨YYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨,¨¨¨¨¨¨¨¨¨33¨,¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨¨¨¨¨¨¨¨¨,,3¨¨¨%¨¨¨~¨¨¨%¨¨¨~¨¨¨3¨¨¨¨¨¨¨¨33333333333333";
  mapStrings[mapIndex] += "33¨g¨g¨g¨|¨,¨g¨|¨g¨|¨33¨¨¨|¨g¨g¨|¨g¨g¨g¨|¨33¨¨¨¨¨¨R¨¨¨Y,,3¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨33333333333333";
  mapStrings[mapIndex] += "33¨∞¨∞¨¨¨¨¨,¨¨¨¨¨¨¨,¨33¨¨¨,¨¨¨,¨¨¨,¨,¨,¨¨¨33Y¨¨¨¨¨.¨¨¨¨¨,3¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨YY33Y#######33";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨,¨¨¨¨¨¨¨¨¨33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨¨¨...¨¨¨¨,3333333333∏3333333333¨¨¨¨¨¨¨¨YY33¨#€∑„≥≥#33";
  mapStrings[mapIndex] += "33¨g¨g¨g¨g¨,,,,,,,,,,,,,,,,,,,¨¨,,,,¨,,¨¨¨¨∏k.....Y.....˝∏¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨YY33¨#„„„„ı#33";
  mapStrings[mapIndex] += "33¨¨¨,¨¨¨,¨¨¨¨¨¨¨¨¨¨¨|,¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨...¨¨¨¨¨333333333|¨¨|33333333¨¨¨¨¨¨¨¨YY33¨#„„„„„#33";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3|¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨|3¨¨¨¨¨¨.¨¨¨¨¨¨3¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨%%%3¨¨¨¨¨¨¨¨YY33¨###<###33";
  mapStrings[mapIndex] += "33¨g¨g¨|¨g¨g¨|¨g¨|¨|¨33¨g¨|¨|¨g¨g¨g¨g¨|¨|¨33¨¨¨¨¨¨.¨¨¨¨¨¨3¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨%%3¨¨¨¨¨¨¨¨YY33¨¨¨###¨¨33";
  mapStrings[mapIndex] += "33¨,¨¨¨,¨,¨¨¨∞¨,¨¨¨,¨33¨,¨¨¨,¨¨¨,¨,¨,¨,¨,¨33%%¨¨¨¨.¨¨¨¨¨¨3¨¨¨g¨¨¨|¨¨¨g¨¨¨g¨¨%3¨¨¨¨¨¨¨¨YY333333¨33333";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨333%%¨¨¨.¨¨¨Y¨33¨¨¨~¨¨¨¨¨¨,,,¨¨%¨¨¨3¨¨¨¨¨¨¨¨YY333333¨33333";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3333%%%¨.¨¨¨¨333¨¨¨¨¨¨¨¨¨¨¨,¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨,,∞,,,,,,,∞,33";
  mapStrings[mapIndex] += "33333333333333333333333333333333333333333333333333.3333333¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨3¨¨¨¨¨¨¨¨,,,,∞,,,,,,,33";
  mapStrings[mapIndex] += "333333333333333333333333333333333333333333333333¨...¨3333333333333333333333333¨¨¨¨¨¨¨¨,,,,,,,,,∞,,33";
  mapStrings[mapIndex] += "33¨Y¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨y¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨Y¨¨33¨¨Y¨¨...¨¨¨¨Y33¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨YYYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨¨¨¨YY¨¨¨¢¢¢¢¢¢¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨V¨...¨V¨¨¨33¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨YYYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨Y3&33 3¨¨¨¨¨¨¨¨Y¨¨¨Y¨¨¨¨33¨¨¨3¨...¨3Y¨¨33¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨Y¨¨¨¨¨YYYYYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨333333¨Y¨¨¨YY¨¨¨¨¨¨¨¨¨Y33Y¨¨¨¨...¨¨¨¨¨33¨¨¨Y¨¨¨Y¨¨¨¨¨¨Y¨¨Y¨¨¨¨YY¨¨Y¨¨Y¨YY¨Y¨¨YY¨¨";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨Y¨33<<33¨¨Y¨¨¨¨¨¨¨¨¨¨¨Y¨¨33¨¨¨¨¨...¨¨¨Y¨33¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨Y¨¨¨Y¨¨¨¨YYY¨Y333YY¨YY¨YY";
  mapStrings[mapIndex] += "33¨¨Y¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨..Y¨¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨33¨¨¨¨Y...Y¨¨¨¨33¨¨Y¨¨3333333¨Y¨¨¨3333333¨¨YYY33333YYYYYYY";
  mapStrings[mapIndex] += "33¨¨¨333333333333G¨¨¨..¨¨¨.333333333333¨Y¨33¨Y¨¨¨...¨¨¨¨Y33¨¨¨¨Y3&333&3Y¨¨¨¨3&333&3¨¨YY¨33‡¢¢.....*Y";
  mapStrings[mapIndex] += "33¨¨¨33333333333>..........>33333333333¨¨¨33¨¨¨V¨...¨V¨¨¨33¨Y¨¨¨3333333¨¨Y¨¨3333333¨YYYY33333YY¨¨.Y¨";
  mapStrings[mapIndex] += "33¨¨¨333333333333|¨¨¨..¨¨¨|333333333333¨¨Y33¨¨¨3¨...¨3¨¨¨33¨¨¨Y¨3¨3<3¨3¨¨¨¨Y3¨3<3¨3¨YYY¨Y333......¨Y";
  mapStrings[mapIndex] += "33Y¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨..¨¨¨,,,∞,ww,,¨¨¨¨¨¨¨33¨¨¨¨¨...¨¨Y¨¨33Y¨Y¨¨3¨¨¨¨¨3¨Y¨¨¨3¨¨¨¨¨3¨¨YYY¨YY¨.YY¨Y¨Y¨";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨Y¨¨¨¨¨Y¨¨¨¨¨¨..¨,,,,,,,,,,¨¨¨¨¨¨¨¨33¨¨¨Y¨...¨¨¨¨¨33¨¨¨¨Y3¨¨>¨¨3¨¨¨Y¨3¨¨>¨¨3Y¨YYY¨Y¨Y......>Y";
  mapStrings[mapIndex] += "33¨¨¨333333333333G¨¨¨..,,,,333333333333Y¨¨33¨¨¨¨¨...Y¨¨¨¨33¨Y¨¨¨3333333¨¨¨¨¨3333333¨YY¨YYYYYYYYYYYYY";
  mapStrings[mapIndex] += "33¨Y¨33333333333>.....,,,..>33333333333¨¨¨33¨Y¨¨¨...¨¨¨Y¨33¨¨¨¨¨¨Y¨¨¨¨¨¨¨Y¨¨Y¨¨¨¨Y¨¨¨YY¨¨YYY¨Y¨YYY¨Y";
  mapStrings[mapIndex] += "33¨¨¨333333333333G¨¨¨,,,¨¨|333333333333¨Y¨33¨¨¨V¨...¨¨¨¨¨33¨¨Y¨¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨Y¨Y¨Y¨Y¨YY¨¨YY¨";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨,,¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨3¨...¨|¨Y¨33¨¨¨¨¨Y¨¨¨¨¨¨¨Y¨¨¨¨Y¨¨¨¨Y¨¨YYYYYYYYyYYYYYY";
  mapStrings[mapIndex] += "33Y¨¨¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨,,,¨¨¨¨¨¨¨¨¨¨¨Y¨¨YY¨¨¨33¨¨Y¨¨...¨¨¨¨¨33¨¨Y¨¨¨¨¨¨¨Y¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨Y¨¨¨YY¨¨¨¨Y¨¨Y¨";
  mapStrings[mapIndex] += "33¨¨¨333333333333G¨,,,.¨¨¨|333333333333¨¨¨33¨¨¨¨¨...Y¨¨¨¨33¨Y¨¨¨Y¨¨Y¨¨Y¨¨¨Y¨¨¨¨¨¨Y¨¨¨¨Y¨¨Y¨¨YYYYYYYY";
  mapStrings[mapIndex] += "33¨¨¨33333333333>..,,......>33333333333¨¨¨33¨¨¨¨Y...¨¨¨¨¨3333333333333333333333333333333333333333333";
  mapStrings[mapIndex] += "33¨Y¨333333333333|,,¨..¨¨¨G333333333333Y¨¨33Y¨¨¨¨...¨¨Y¨¨33Y¨¨¨¨Y¨Y¨¨¨¨¨¨¨Y¨Y¨¨¨Y¨,,¨Y¨¨¨Y¨¨Y3Y∑∑∑33";
  mapStrings[mapIndex] += "33¨¨¨¨¨¨¨¨¨¨¨¨¨¨,,,¨¨..¨¨¨¨Y¨¨¨¨¨¨¨¨¨¨¨¨¨Y33¨¨¨¨¨...¨¨¨¨¨33¨¨¨Y¨¨¨¨¨Y,,¨Y¨¨,¨Y¨¨¨¨Y,,¨¨Y¨Y¨¨Y3¨#<#33";
  mapStrings[mapIndex] += "33¨¨Y¨¨¨YwwwYY∞,,,¨¨¨........................................¨........,,∞∞,,,Y¨Y,,Y,,¨,¨∞,,Y¨3¨¨¨¨33";
  mapStrings[mapIndex] += "33¨¨¨¨Y¨wwwwwww,,¨Y¨¨..........................V.....V............¨¨....,,¨,∞,,Y,∞,¨¨,,Y,,,,Y333∏333";
  mapStrings[mapIndex] += "33¨Y¨¨Yww%wwwYw,,¨¨¨¨Y¨¨¨¨¨¨¨Y¨¨¨¨¨¨YY¨¨¨¨33¨¨¨3¨¨¨¨¨3¨¨¨33¨Y¨¨¨¨¨¨¨¨Y¨,,¨,,Y,,,Y¨,,¨Y¨Y¨,∞,,,,∞˚,33";
  mapStrings[mapIndex] += "33¨¨¨¨¨Ywyy∞,,,∞Y¨¨¨¨¨¨¨Y¨¨¨¨¨¨¨¨Y¨¨¨¨¨¨Y¨33¨¨¨¨¨¨¨¨¨¨¨¨¨33¨¨¨¨¨¨Y¨¨¨¨,,,Y¨¨¨¨,,Y¨¨,Y¨¨¨Y¨,,∞,,,,∞33";
  mapStrings[mapIndex] += "Y3¢¢YY¢Y¢¢¢YYYY¢¢¢¢¢¢¢YY¢¢YYY¢¢¢¢¢¢YY¢¢¢¢¢Y3¢¢¢¢¢¢¢YY¢¢¢Y33¢¢¢¢YYYYY¢¢¢¢¢¢¢¢¢¢YY¢¢¢YYY¢¢¢¢¢¢¢¢Y¢¢¢¢¢";
  mapStrings[mapIndex] += "YYY3YYY333YYY333YY333YYYY3YYYY33YY3Y3YYY33YYY333YYYYY33YYYYY3YYYYYYYY3333YYYYYYY33YYYY3333YYYYY3333Y";
  mapStrings[mapIndex] += "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY";
  

  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  
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
  m[2].tiles[48][5].placeOccupant( color(garrisonColor), "- Mother Sunita has closed the Cathedral. The clerics are fasting." );
  m[2].tiles[49][5].placeOccupant( color(garrisonColor), "- We have our orders. Sorry." );
  //Garrison
  m[2].tiles[58][10].placeOccupant( color(garrisonColor), "- UNUSED TEXT." );
  m[2].tiles[56][10].placeOccupant( color(garrisonColor), "- UNUSED TEXT." );
  m[2].tiles[63][9].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[63][11].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[63][13].placeOccupant( color(dummyColor), "A training dummy." );
  m[2].tiles[64][9].placeOccupant( color(mYoung), "- This sword is heavier than it looked." );
  m[2].tiles[64][13].placeOccupant( color(fYoung), "- Our enemies aren't stuffed with straw. I've heard them rattle and seen their fleshless grins." );
  m[2].tiles[66][11].placeOccupant( color(garrisonColor), "- Some will flee. Some will fall. Those who are left are soldiers." );
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
  m[2].tiles[51][62].placeOccupant( color(200,150), "- Charis used to visit to report on the world of the living. Now he has crossed the Veil without us? I feel anger. And sorrow." );
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
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its sword.", 45, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("swings wide!", 45, true );
      zoo.boss[bossIndex].attacks[3] = new Attack("bashes with the pommel.", 45, false );
      zoo.boss[bossIndex].attacks[4] = new Attack("lunges!", 55, false );
  bossIndex++;
  
  
  //Danger Map 2
  dangerMapIndex = 2; dangerStrs[dangerMapIndex] = "";
  for(int i = 0; i < 57; i++)
    dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444xxxxxxxxxxxxxxxx5555555555555555555xxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "444444444444444444444444444444444444444444444444444444444xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444000044";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444000044";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  dangerStrs[dangerMapIndex] += "4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444";
  
   
  //---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 3 - Boat (Irohill to Waraka)
  
  mapIndex++; mapStrings[mapIndex] = "";
  mapStrings[mapIndex] += "w∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑∑„„„„„„„„„„„„„ÇÇÇÇ„ÇÇÇ„Ç„„„„„„„„„„„∑∑∑∑∑∑∑∑∑∑„„„„„„„„„„„„„ÇÇÇÇ„ÇÇÇ„Ç„„„„„„„„„„„∑∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑M„„„„„„„„„„„„„ÇÇÇ„„„ÇWWWWW„Ç„„„„„„„M∑∑∑∑∑∑∑∑M„„„„„„„„„„„„„ÇÇÇ„„„ÇWWWWW„Ç„„„„„„„M∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑„„„„„„„„„„„„„„„ÇÇ„„„„i+„MW„„„„„„„„„„∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„ÇÇ„„„„i+„MW„„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑<„„„„„„„„„„„„„Ç„„„„Ç„„WWWWW„„Ç„„„„„„„∑∑∑∑∑∑∑<„„„„„„„„„„„„„Ç„„„„Ç„„WWWWW„„Ç„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑Ç„„„„„„„„„„„„ÇÇÇÇ„„„„„ÇÇ„Ç„„„„„„„„„„∑∑∑∑∑∑∑∑Ç„„„„„„„„„„„„ÇÇÇÇ„„„„„ÇÇ„Ç„„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑ÇÇ„„„„„„„„„„„„Ç∑∑∑Ç„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑ÇÇ„„„„„„„„„„„„Ç∑∑∑Ç„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑ÇÇÇ„„„„„„„„„„„„∑∑∑„„ÇÇÇ„„Ç„„„„„„„„„„<∑∑∑∑∑∑∑ÇÇÇ„„„„„„„„„„„„∑∑∑„„ÇÇÇ„„Ç„„„„„„„„„„<∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑ÇÇ„„Ç„„„„„„„„„„∑∑∑„„„„„„„„Ç„„„„„„„„„∑∑∑∑∑∑∑∑ÇÇ„„Ç„„„„„„„„„„∑∑∑„„„„„„„„Ç„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑Ç„„„„„„„„„„„„„„„Ç„„„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑Ç„„„„„„„„„„„„„„„Ç„„„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑<„„„„„„„„„„„„„„„„„„„„„WWWWW„„„„„„„„„„∑∑∑∑∑∑∑<„„„„„„„„„„„„„„„„„„„„„WWWWW„„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„„„„„W]„MW„„„„„„„„„„∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„„„„„W]„MW„„„„„„„„„„∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑M„„„„„„„„„„„„„„„„„„„„WWWWW„„„„„„„„„M∑∑∑∑∑∑∑∑M„„„„„„„„„„„„„„„„„„„„WWWWW„„„„„„„„„M∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑Ç„„„„„„„„„„„„∑∑WWWW∑∑[„„ÇÇ„Ç„„„Ç„„„∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "w∑∑∑ÇÇ„Ç„„„„„„„„„„„„M∑WWWWWW∑M„[[Ç„„„„„Ç„„„„„„∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑ÇÇÇ„Ç„„Ç„„„„„„„„„„„∑WWWWWW∑„[[Ç„„„„„„„„„„„Ç„„„∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„Ç„Ç„Ç„„„„„Ç„„„„„„„„∑WWWWWW∑Ç„[ÇÇ„„„„„„„„„Ç„„„„„∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„Ç„Ç„„Ç„„„„„„„„„„„„∑∑WWWWWW∑∑[Ç„„„„„„Ç„„„„„„„„„„„∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„Ç„„„„„ÇÇ∑∑∑„„„„WW„∑WWWWWWWW∑Ç„„„„„ÇÇ∑∑∑„„„„„„„„„„∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„Ç„Ç„Ç„ÇÇ∑∑∑„„„„„∑„∑WWWWWWWW∑Ç„„„„„„Ç∑∑∑Ç„„„„Ç„„„„„∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„„„Ç„„„„Ç∑∑∑„„„„WW„∑WWWWWWWW∑„„„„„„„„∑∑∑„ÇÇ„„„„„„„∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„Ç„Ç„ÇÇ„„Ç„„„„„„„„„∑∑WWWWWW∑∑„„„„„ÇÇ„Ç„ÇÇ„Ç„„„Ç„„∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„„Ç„Ç„„„„Ç„„„„„„„„„„∑WWWWWW∑„„„„„„Ç„„Ç„„„„„Ç„„„„∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑„ÇÇ„„ÇÇ„„Ç„„„„„„„„„∑WWWWWW∑„„„„„„„„ÇÇ„ÇÇÇ„Ç„Ç„∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "w∑∑∑„Ç„„Ç„„„„„„„„„„„M∑WWWWWW∑M„„„„„Ç„„Ç„„„Ç„„„∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑„„Ç„„„„„„„„„„∑∑WWWW∑∑„„„„ÇÇ„„ÇÇÇÇÇÇ∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑„„„BB„„ßB„„∑∑∑∑∑∑∑∑„€„€„€„€„€„€„∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "w∑∑∑„∫€∫„„„„„„„„„„„∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„==∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑W¬„∫∫∫„„„„„WW„„„„∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„„∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„„„„„„„„„„„„„„„„„„<∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„„„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„.∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑≠„„„„„„„„∑∑∑„„„„„„∑∑∑∑∑∑∑∑∑„„„„„„„„∑∑∑„„„„„.∫.∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑<„``````„∑∑∑„``„.∫*∫∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„„„„„„„„„∑∑∑„„„„„„∑∑∑∑∑∑∑∑∑„„„„„„„„∑∑∑„„„„„.∫.∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„]]]„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„.∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑„„„„„„„„rrrrrrrrr„<∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑„„„Ç„„„rWWWWWWWr„∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„„„„„∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "w∑∑∑„ÇÇ„„rrrrrrrrr„∑∑∑∑∑∑∑∑„„„„„„„„„„„„„„==∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑„„„„„„„„„„„∑∑∑∑∑∑∑∑„€„€„€„€„€„€„∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑WW∑WWWWWWWW∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„∑WWWWWWWWWWWW∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "w∑∑∑WWWWWW∑WWWWWWWW∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„<WWWWWWWWWWWWWWW∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑WWWWWWWW∑WWWWWWWW∑„„„„„„„„„„„„„„„„M„„„„„„„„„„„„„„„∑WWWWWWWWWWWWWWWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑WWWWW∑∑<∑∑∑∑∑<∑∑∑∑∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„∑WWWWWWWWWWWWWWWWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑WWWWW∑„„„„„„„„„„„„„„„„„„„„„„„„„„∑∑∑„„„„„„„„„„„„„„„„∑WWWWWW∑∑∑WWWWWWWWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑„„„∑„„„„„„„„„„„„„„„„„„„„„„∑∑∑„„„„„„„„„„„„„„„„∑WWWWWW∑∑∑WWWWWWWWWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑WWWWW∑„„„„„„„„„„„„„„„„„„„„„„„„„„∑∑∑„„„„„„„„„„„„„„„„∑∑∑∑∑∑∑∑∑∑∑∑∑∑WWWWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑WWWWW∑∑<∑∑∑∑∑<∑∑∑∑∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„∑WWWWWWWWWWWW∑WWWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "∑∑WWWWWWWW∑WWWWWWWW∑„„„„„„„„„„„„„„„„M„„„„„„„„„„„„„„„∑WWWWWWWWWWWW∑WWWW∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "w∑∑∑WWWWWW∑WWWWWWWW∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„<WWWWWWWWWWWW∑WW∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑WW∑WWWWWWWW∑„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„„∑WWWWWWWWWWWW∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwww";
  mapStrings[mapIndex] += "www∑∑∑∑∑„„∑„€„€„€„Ç∑WWWWWW∑„„„„„„„„„„„∑∑∑∑wwwwwwwwwwwwww∑∑∑∑∑„„∑„€„€„€„Ç∑WWWWWW∑„„„„„„„„„„„∑∑∑∑wwwww";
  mapStrings[mapIndex] += "w∑∑∑„„„„„„∑„`````„„∑WWWWWW<„„„„„„„„„„„„„„∑∑∑wwwwwwwwww∑∑∑„„„„„„∑„``````„∑WWWWWW<„„„„„„„„„„„„„„∑∑∑www";
  mapStrings[mapIndex] += "∑∑„„„„„„„„∑„„„„„„„]∑WWWWWW∑„„„„„„„„„„„„„„„„∑∑wwwwwwww∑∑„„„„„„„„∑„„„„„„„]∑WWWWWW∑„„„„„„„„„„„„„„„„∑∑ww";
  mapStrings[mapIndex] += "∑Ç„„„„∑∑<∑∑∑∑∑<∑∑∑∑∑WWWWWW∑„„„„„„„„„„„„„„„„„∑∑wwwwwww∑„„„„„∑∑<∑∑∑∑∑<∑∑∑∑∑WWWWWW∑„„„„„„„„„„„„„„„„„∑∑w";
  mapStrings[mapIndex] += "∑ÇÇ„€=∑WWWWWWWWWWWWWWWWWWW∑„„„„„„∑∑∑„„„„„„„„„∑∑wwwwww∑„„„„„∑WWWWWWWWWWWWWWWWWWW∑„„„„„„∑∑∑„„„„„„„„„∑∑";
  mapStrings[mapIndex] += "∑∑∑∑∑∑∑WWW∑WWWWWWWWWWWWWWW∑„„„„„„∑∑∑„„„„„„„„„∑∑wwwwww∑∑∑∑∑∑∑WWW∑WWWWWWWWWWWWWWW∑„„„„„„∑∑∑„„„„„„„„„∑∑";
  mapStrings[mapIndex] += "∑≠Ç„BB∑WWWWWWWWWWWWWWWWWWW∑∑∑∑∑∑∑∑∑∑∑∑∑∑„„„„„∑∑wwwwww∑≠Ç„BB∑WWWWWWWWWWWWWWWWWWW∑∑∑∑∑∑∑∑∑∑∑∑∑∑„„„„„∑∑";
  mapStrings[mapIndex] += "∑Ç„„„„∑∑<∑∑∑∑∑<∑∑∑∑∑WWWWWW∑„„„„„„„„„„„„∑„„„„∑∑wwwwwww∑Ç„„„„∑∑<∑∑∑∑∑<∑∑∑∑∑WWWWWW∑„„„„„„„„„„„„∑„„„„∑∑w";
  mapStrings[mapIndex] += "∑∑¬„„„„„„„∑„„„„„„ÇÇ∑WWWWWW∑„„„„„„„„„„„„∑„„„∑∑wwwwwwww∑∑¬„„„„„„„∑„„„„„„„„∑WWWWWW∑„„„„„„„„„„„„∑„„„∑∑ww";
  mapStrings[mapIndex] += "w∑∑∑WW„„„ß∑„`````„„∑WWWWWW<„„„„„„„„„„„„∑„∑∑∑wwwwwwwwww∑∑∑WW„„„ß∑„„„„„„„„∑WWWWWW<„„„„„„„„„„„„∑„∑∑∑www";
  mapStrings[mapIndex] += "www∑∑∑∑∑„B∑„€„€„€„Ç∑WWWWWW∑„„„„„„„„„„„∑∑∑∑wwwwwwwwwwwwww∑∑∑∑∑„B∑„„„„„„„„∑WWWWWW∑„„„„„„„„„„„∑∑∑∑wwwww";
  mapStrings[mapIndex] += "wwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwwwwwwwwwwwwwwww∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑wwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  

  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  
  savePoints[savePointIndex++] = new SavePoint(3,45,47,8);
  
  createLoot(lootIndex++, 3, 7, 32, Key.IRON_KEY );
  createLoot(lootIndex++, 3, 3, 24, new Item("Doubloon", 9) );
  createLoot(lootIndex++, 3, 30, 25, new Item("Doubloon", 9) );
  createLoot(lootIndex++, 3, 29, 11, new Item("Doubloon", 9) );
  //Wardroom
  createLoot(lootIndex++, 3, 2, 49, new Item("Bread", 10) );
  createLoot(lootIndex++, 3, 3, 49, new Item("Bread", 10) );
  createLoot(lootIndex++, 3, 4, 49, new Item("Bread", 10) );
  //Kat's Chest
  createLoot(lootIndex++, 3, 5, 83, new Equipment("Rat's Pelt","darkFur.png",2,false,18,true) );
  
  //m[mapIndex].tiles[0][0].createEvent(false, "- TEXT");
  
  //Captain
  m[mapIndex].tiles[17][27].placeOccupant( color(captain), "- Ahoy! My queen will treat you well, and ferry you safely across the sea. Breathe the salt air! Taste the winds of freedom!" );
  //Captain's daughter
  m[mapIndex].tiles[31][21].placeOccupant( color(fYoung), "- I'm not a child! I'm a mighty privateer! I'll be a famous captain some day, just like my daddy. I even hid some pirate gold. Bet you can't find it!" );
  //Cabin Boy
  m[mapIndex].tiles[4][45].placeOccupant( color(mYoung), "- Oh, h-hello sir, I mean ma'am, I mean, um... the captain is at the helm if you're looking for him. Please don't sleep in his bed. I just made it." );
  //Kat
  //in method below
  m[mapIndex].tiles[23][10].placeOccupant( color(sailor), "- The journey to Waraka will take a few days, assuming good weather. Your bunk is below decks. The Barracua Queen is strong and reliable, so you need not fear." );
  m[mapIndex].tiles[27][4].placeOccupant( color(sailor), "- Who locked the lower deck? We have cargo to stow!  " );
  m[mapIndex].tiles[13][26].placeOccupant( color(sailor), "- I'd get below decks soon, before the captain starts singing." );
  m[mapIndex].tiles[9][21].placeOccupant( color(sailor), "- What do we have 'ere? Lubbers still finding their sea legs. You don't know what's out here, do ye? Bet you never seen one of the monsters of Lost Star Isle. Well... neither have I. Do you know where they are?" );
  m[mapIndex].tiles[12][50].placeOccupant( color(sailor), "- There's food in the back. Help yourselves to as much as you can. I love watching landlubbers puke." );
  m[mapIndex].tiles[14][52].placeOccupant( color(sailor), "He's already passed out drunk." );
  m[mapIndex].tiles[40][21].placeOccupant( color(sailor), "- My guess is the pirates have retreated to plan something big." );
  m[mapIndex].tiles[41][21].placeOccupant( color(sailor), "- Nah, them villains got no patience." );
  m[mapIndex].tiles[47][25].placeOccupant( color(sailor), "- Cory is staring off at the horizion again. I think he might sleep there." );
  //Cory
  m[mapIndex].tiles[51][27].placeOccupant( color(coryColor), "- My sister turned to piracy. Ever since the monsters emerged around Lost Star Isle, we stopped receiving her letters. That's why I sail. I haven't lost faith." );
  //Sailors in bunks
  m[mapIndex].tiles[29][52].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[33][53].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[38][51].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[39][51].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[33][42].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[32][42].placeOccupant( color(sailor), "NO TEXT." );
  m[mapIndex].tiles[28][43].placeOccupant( color(sailor), "NO TEXT." );
  //Ritisu priests
  m[mapIndex].tiles[44][46].placeOccupant( color(ritisuColor), "- Ever since my youth, I have seen naught but images of the wide blue sea in Ritisu's Tear. These shimmering waters are my past and my future." );
  m[mapIndex].tiles[45][49].placeOccupant( color(lesserRitisuColor), "- I see the ocean in the gem as well, though of late I sometimes notice strange and dark shapes in the water. It is not like Ritisu to veil knowledge." );
  //Sailor in your room
  m[mapIndex].tiles[16][81].placeOccupant( color(sailor), "Oh, excuse me. I don't usually enter a paying passenger's room. I saw a giant rat and unbearable terror took over me. I don't care for rats of any size. Do exterminate them, won't you?" );
  
  
  
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
  exits.add( new Portal(3,6,4,3,19,44, "Captain's Cabin") );
  exits.add( new Portal(3,19,44,3,6,4, "Main Deck") );
  
  //Deck to Wardroom
  exits.add( new Portal(3,6,10,3,19,50, "Wardroom") );
  exits.add( new Portal(3,19,50,3,6,10, "Main Deck") );
  
  //Deck to Bunks (forecastle)
  exits.add( new Portal(3,43,7,3,27,47, "Forecastle") );
  exits.add( new Portal(3,27,47,3,43,7, "Main Deck") );
  
  //Deck to Lower Deck
  exits.add( new Portal(3,31,3,3,36,63, "Lower Deck") );
  exits.add( new Portal(3,36,63,3,31,3, "Main Deck") );
  
  //Lower Deck to Deck secret barrel
  exits.add( new Portal(3,31,11,3,36,69, "Lower Deck") );
  exits.add( new Portal(3,36,69,3,31,11, "Main Deck") );
  
  //Lower Deck to Galley
  exits.add( new Portal(3,52,62,3,26,80, "Galley") );
  exits.add( new Portal(3,26,80,3,52,62, "Lower Deck") );
  
  //Lower Deck to Chain Locker
  exits.add( new Portal(3,52,70,3,26,88, "Chain Locker") );
  exits.add( new Portal(3,26,88,3,52,70, "Lower Deck") );
  
  //Lower Deck to NE Cabin
  exits.add( new Portal(3,14,64,3,14,82, "Your Cabin") );
  exits.add( new Portal(3,14,82,3,14,64, "Lower Deck") );
  
  //Lower Deck to NW Cabin
  exits.add( new Portal(3,8,64,3,8,82, "Kat's Cabin") );
  exits.add( new Portal(3,8,82,3,8,64, "Lower Deck") );
  
  //Lower Deck to SE Cabin
  exits.add( new Portal(3,14,68,3,14,86, "Officer's Cabin") );
  exits.add( new Portal(3,14,86,3,14,68, "Lower Deck") );
  
  //Lower Deck to Ship's Office
  exits.add( new Portal(3,8,68,3,8,86, "Ship's Office") );
  exits.add( new Portal(3,8,86,3,8,68, "Lower Deck") );
  
  /*
  m[mapIndex].tiles[0][0].placeBoss( mapIndex, color(0), "TEXT.", new Monster("Skeletal Guardian", "DarkScimitarSkeleton.png", 50, 15, 5, 7, 0, 5, 9, 0, AttackType.HOLY), true);
      zoo.boss[bossIndex].attacks[0] = new Attack("prepares for your attack.");
      zoo.boss[bossIndex].attacks[1] = new Attack("swings its sword.", 45, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("swings wide!", 45, true );
      zoo.boss[bossIndex].attacks[3] = new Attack("bashes with the pommel.", 45, false );
      zoo.boss[bossIndex].attacks[4] = new Attack("lunges!", 55, false );
  bossIndex++;
  */
  
  //Danger Map 3 (Boat)
  dangerMapIndex = mapIndex; dangerStrs[dangerMapIndex] = "";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  dangerStrs[dangerMapIndex] += "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
  
  
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
    if(party.hero[i].job==Job.KNIGHT)knightName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.BARBARIAN)barbName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.SAURIAN)saurName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.THIEF)thiefName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.BARD)bardName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.KARATE)monkName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.DRUID)druidName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.PRIEST)priestName= " such as "+party.hero[i].name;
    if(party.hero[i].job==Job.MAGE){mageName= " such as "+party.hero[i].name;magePhrase=", as "+party.hero[i].name+" can attest";}  

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
    m[0].tiles[44+i][5].placeOccupant( color(150, 150, 250), "- Have a seat, "+party.hero[i%3].name+"." ); if(i!=3)
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
  m[1].tiles[95][92].placeOccupant( color(255,150), "- You've grown strong, "+party.hero[2].name+". I... I watched as you studied under Charis. From time to time I read over your shoulder at the library. I was so afraid for you as I lay dying, and at first I disliked the name "+party.hero[2].name+"... I've said too much. Sleep soundly and complete your task. " );
  m[0].tiles[84][58].placeOccupant( color(200,150), "- I'm so proud of you, "+party.hero[2].name+"." );
 
  //Teachers
  m[0].tiles[12][32].placeOccupant( lesserRitisuColor, "- Knights"+knightName+" rely on their armor, and gain two energy when they defend against an attack. Barbarians"+barbName+" gain one anger whenever they are attacked. The reptile people"+saurName+" are natural warriors, and gain energy twice as fast as humans." );
  m[0].tiles[12][36].placeOccupant( lesserRitisuColor, "- Thieves"+thiefName+" gain five energy on successful critical blows. Martial artists"+monkName+" do not gain bonus energy, but will always start a fight full of spiritual power. Bards"+bardName+" can feel a kind of combat rhythm, and gain energy when their allies use abilities." );
  m[0].tiles[33][34].placeOccupant( lesserRitisuColor, "- Magical Power is used by mages"+mageName+" and priests"+priestName+" to fuel their magic. The lure of magic is strong, but once their power is spent a mage can do little." );
  m[0].tiles[21][30].placeOccupant( lesserRitisuColor, "- The Saurian people are blessed by Am-asma with strength and with scales like iron. Even without a weapon they can devistate their foes." );
  m[0].tiles[34][32].placeOccupant( lesserRitisuColor, "- There is great power in the natural world, and Druids"+druidName+" have learned to borrow it. They use magic power to beckon the elements or take the form of beasts." );
  
  //Garrison
  m[0].tiles[98][41].placeOccupant( color(160, 160, 160), "- Knights"+knightName+" can wear heavy armor, which provides the best protection. Priests of Illamar"+priestName+" have been blessed with the strength to wear plate as well. Simpler armors like chain and leather can be worn by wild warriors"+barbName+" and rogues"+thiefName+". Martial artists"+monkName+" are trained to fight wearing common garb, and the magic of magi is disrupted by heavy material"+magePhrase+"." );
  m[0].tiles[98][45].placeOccupant( color(160, 160, 160), "- Swords and axes are the weapons of warriors. Knights"+knightName+" and barbaric fighters"+barbName+" should see no difficulty wielding them. Simpler arms like the club or knife are suitable for those without formal training, though mages"+mageName+" can only manage simple knives and staves. Martial artists"+monkName+" need naught but the hands Am-asma gave them." );
  m[0].tiles[92][45].placeOccupant( color(190, 170, 130), "A training dummy. Someone has drawn "+party.hero[0].name+"'s face on it." );
  
  //Rask
  m[0].tiles[48][67].placeOccupant( color(250, 100, 50), "- "+party.hero[0].name+"? "+party.hero[1].name+"? Good, I'm glad to see you. We need help and we won't get it from Mother Sunita. I'm headed to the mayor's office. Meet me there as soon as you can." );
  
  //Kat
  m[0].tiles[19][53].placeOccupant( color(250,0,170), "- AH! "+party.hero[1].name+", where did you come from? Was it you who slew those rats in the cellar? You're strong, "+party.hero[1].name+". Brave, too. If only I could borrow that courage. Some of them escaped the cellar with my prototype potion. I don't know what effect it will have on fauna, but it is my responsibilty to prevent harm. I-if you want to help, I'd appreciate it. My "+heroWeapon[1]+" "+wasOrWere(heroWeapon[1].charAt(heroWeapon[1].length()-1))+" never as strong as yours." );
  m[1].tiles[49][14].placeOccupant( color(250,0,170), "She's slumped against the wall. Her arm is burned. - "+party.hero[1].name+"? How did you avoid the man-wolf? I had to use my draught of disguise. The rats are getting larger, and mutating in strange ways. May Am-asma forgive me for my part in this. I was able to trap one up ahead. Could you please fight him? I have food here if you feel hungry. I'll be fine, I just need a rest..." );
  m[3].tiles[1][24].placeOccupant( color(katColor), "Her face is pale and dripping with cold sweat. - Uh... oh, "+party.hero[1].name+". Why are you here? Books with strange symbols? Investigating Father Charis's death? Wow, you sure have been busy since leaving the cathedral. I was following the rats, but some of them followed me. They're in the ship. I locked them in the lower deck. I was going to tell the captain, but the ship started swaying and... uh, my poor stomach... I must have dropped the key." );
  
  //Garrison
  m[1].tiles[4][42].placeOccupant( color(garrisonColor), "- " + party.hero[0].name + "! Finally come to your senses and decided to join the garrison? We need " + needAnA(heroWeapon[0]) + heroWeapon[0] + " like yours to help train these milksops to soldier!" );
  m[1].tiles[7][44].placeOccupant( color(fYoung), "- Thank you, " + party.hero[1].name + ". I never forgot what you taught me. You thought it would be years before they allowed me to be a soldier, but they need everyone they can get. This has always been my destiny." );
  m[0].tiles[69][86].placeOccupant( color(fYoung), "- " + party.hero[1].name + "? I.. it was... I don't want to be a solider." );
  
  //Hideout kids
  m[2].tiles[79][46].placeOccupant( color(fYoung), "- " + party.hero[0].name + "! " + party.hero[0].name + "! The hideout you helped us build is still here! The bone men haven't found it yet!" );
  
  //Dock
  m[0].tiles[70][94].placeOccupant( color(mYoung), "- I'm going to be just like "+party.hero[0].name+". My "+heroWeapon[0]+" will stop anyone who attacks my town!" );
  m[0].tiles[69][94].placeOccupant( color(fYoung), "- Yeah! "+party.hero[0].name+" is the best!" );
}

//Expected Level:
//(old exp system)
//Rat queen 1.7 / 1.9
//man-wolf 3.3 / 3.2
//crypt guards 4.5 before, 5.2 back at courtyard
//before necro 6.7 / 5.7 (died)

//Deities:
//Black Vanguard - anubis
//Illamar - sun god
//Ritisu - god of save crystals, legend, stories, history
//Am-asma - god of creatures and medicine

//Plot notes:
//Mother Veda is in Mariva across the sea and is high priestess of Ritisu
//Messages to necromancer came from Waraka
//Assassin boss Sirak in Waraka
//Monsters of Lost Star Isle (later dungeon: shipwreck of Barracuda Queen and pirate ship)

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
