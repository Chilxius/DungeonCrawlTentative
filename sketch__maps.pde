color chilxiusColor = color(0,200);
color sunitaColor   = color(150, 250, 250);
color clericColor   = color(150, 150, 250);
color initiateColor = color (150, 150, 200);
color secretTeacherColor = color(200, 150, 200);
color ritisuColor   = color(31,153,226), lesserRitisuColor = color(75,180,243);
color dummyColor    = color(190, 170, 130);
color garrisonColor = color(160);
color governor      = color(125,110,10);
color male          = color(165,150,50),  mYoung = color(250,230,0);
color female        = color(150,50,165),  fYoung = color(230,150,250);
color raskColor     = color(250, 100, 50);
color katColor      = color(250,0,170);

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
  //      c-copper key   i-iron key   s-skel key    b-brass key   ç-crypt key    ~-grass    `-dirt    ,-dark dirt
  //      6-cave        §-brown cave
  //      $-secret wall   ¢-secret dark wall (alt+4)

  //      >-Stairs    <-Door(stairs)


  //---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 0 - Cathedral
  
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
  mapStrings[mapIndex] += "TTT#>#TT#>####...„„„„„„„„##..G..#~~~~~~~~~~~~~~~~##~~~~~~~~~~~t~~~~#..G..##W.W.W#...######>#TTT#>#TT";
  mapStrings[mapIndex] += "TTT###TT###T##[..„%%„%%„%##.....#~T~b~~D~~~~t~~~####~~~~~~T~~~~i~~~#.....##.....#...####T###TTT###TT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTT##..„%%„%%„%###########+############..####.#######+###########.....#...###TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTwww%TTTTT##.„%%„%%„%##....................................k.........##W.W.W#...##TTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTwwwwTTTTTT##„%%„%%„%##.G....................rr....................G.##.....#..##TTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTwwwTTTTTT##%%„%%„%##......................rr......................##.......##TTTTTT##########";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTT###############################.rr.###############################TTTTTTT#........#";
  mapStrings[mapIndex] += "TDTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#>.......#";
  mapStrings[mapIndex] += "D~DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT##########";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#..G..?.rr.?..G..#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTT#################TTTTT#>.∫∫∫∫∫rr∫∫∫∫∫.>#TTTTT#########TTTTT#########TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTT#=≠±#...#.J.#.©.#TTTTT#..G....rr....G..#TTTTT#[[...∑]#TTTTT#==...3w#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTTTTTTTTTTTTTTT&...#...#...#...&TTTTT#######.rr.#######TTTTT#...W.∑.&TTTTT#.....33#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#########TTTT&.∫∫∫∫∫∫∫∫∫∫∫∫∫.&TTTTTTTTTTT#.rr.#TTTTTTTTTTT#>....∑.&TTTTT#>......#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#∫∫∫#rrr#TTTT#.∫∫∫∫∫∫>∫∫∫∫∫∫.#TTTTTTTTTTT#.rr.#TTTTTTTTTTT#...W.∑.&TTTTT#..„„„..#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#.∫.#.r.#TTTT&.∫∫∫∫∫∫∫∫∫∫∫∫∫.&TTTTTTTTTTT#.rr.#TTTTTTTTTTT#[[...∑]#TTTTT#„„„„„„„#TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#.......#TTTT&...#...#...#...&TTTTTTTTTTT#.rr.#TTTTTTTTTTT#########TTTTT#########TTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#.r.#.∫.$tttt$¢¢¢#*••#.G.#.R.#TTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT#rrr#∫∫∫#TTTT#################TTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TtTTTT##$$#####TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TttttttttTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#..G..?.rr.?..G..#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT#>.∫∫∫∫∫rr∫∫∫∫∫.>#TTTTTT################TTTTTTTTTT#########";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#..G....rr....G..#TTTTTT################TTTTTTTTTT#rr]==..#";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT#######.rr.#######TTTTTT##~%~„.∫∫∫..∑w##TTTTTTTTTT&.......#";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT##„„„„.∫∫∫..∑w##TTTTTTTTTT&rr....>#";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT##.....i..k.∑∑##TTTTTTTTTT&.......#";
  mapStrings[mapIndex] += "TT%%%TTTTTTTTT#.rrrrrrrrrrrrrrr#TTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT###>###+##+###=#TTTTTTTTTT#rr.[]..#";
  mapStrings[mapIndex] += "TT%*%TTTTTTTTT##&###&###&###&#<#TTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTT##########$$$$$#TTTTTTTTTT#########";
  mapStrings[mapIndex] += "TTT~TT~TTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTTTTTTTT#.rr.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "~TTtTTTTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTT~TTTTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTT#>##>##.rr.##>##>#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTtTTTTTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTT#+##+##.rr.##+##+#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTT~TTTTTTTT%TTTTTTTTT~TTTTT##π##TTTTTT###i..i...rr...i..k###TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "```~TT%TTTTTTTT~TTTTTTTTTT~TG.i.GTTTTTT#>+i......rr......i+>#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "`@`TTTTTT~~~TTT~~t%~~~~t%~~~D...~TTTTTT###i..i...rr...i..i###TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "````~~~~~~T~~~~~~~~~%T~t~~T~~`.`~TTTTTTTT#+##+##.rr.##+##+#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "T``TT~~TTTTT~TTT~TTTTTTTTTT~~```~TTTTTTTT#>##>##.rr.##>##>#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~TT~TTTTTTTTTTTTT~TTTTT~```TTTTTTTT#######.rr.#######TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTT~tTT|TTT%TTTTTTTT%TTTTTT~```TTTTTTTTTTTTT##.rr.##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "DTTT~~TTTTT~~~~~~~TTTTT%T~TT~```~TTTTTTTTTTTT##..rr..##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT~~~TT~~~~T%TT~~TTDTTTTTT~```~TTTTTTTTTTT##...rr...##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTT~~~~~%TTTTTT~~%TTTTTTTTT~```~TTTTTTTTT##..#.rr.#..##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTT~~~tTTTTTTTTT~```~TTTTTTTT##.....rr.....##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTtTTT%~~TttTTTTTTT~```~TTTTTTTTT&..#...rr...#..&TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTg%%TT~~~~tt~~TTT=TTTTTTT~```~TTTTTTTTT&......rr......&TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT%%%T~~TT~~~~TTTTTDTTTTTTT~```~TTTTTTTT&..#...rr...#..&TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT%%~~~TTTT~%TTTTTTTTTTTTTTTTTTTTTTTTTTT##.....rr.....##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT~~~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT##..#.rr.#..##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTt~~tTTTTTTTTTTTTwwwwTTTTTTTTTTTTTTTTTTTT##...rr...##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTttTTtttTTTTTTTTwwwwwwwwTTTTTTTTTTTTTTTTTTT##..rr..##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTtTTtTtTTTTTTTTTwwwwwwwwTTTTTTTTTTTTTTTTTTT##.rr.##TTTTTTTT###TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TT~tttTtttTTTTTTT``wwwwwwwTTTTTTTTTTTTTTTTTTTTT#.rr.#####&###&#.#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTtTTtTtTttTTTTT``wwwwwwwwwTTTTTTTTTTTTTTTTTTTT#.rrrrrrrrrrrrrrr&TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTttTTTTTTtTTTTT`wwwwwwwTTTTTTTTTTTTTTTTTTTTTTT#.rrrrrrrrrrrrrrr&TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTtTTTTtt~TTTTT```„„„„````TTTTTTTTTTTTTTTTTTTT##&###&###&###&#<#TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTttTTttTTTTTT```wwwwww`T```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTttttTTTTTT~~`wwwwwwwwwwT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTT~~TTTTTT~~~`wwwwwwwwTTTT`TTTTTTTT~TTTTTTTTTTTTTTTTTTTTTTDDDDDTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~t~~t~~TTTTTTwwwTTTTT|`TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTD###DTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTT~~TTTTTTTTTTTTwwwTTTTTTT`|TTTT|D|TTTTTTTTTTTTTTTTTTTTTTT##π##TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTttTTTTTTTTTTTTTTwwwwTTTTT`t~~t~t~=|TTTTTTTTTTTTTTTTTTTT~TG.i.GTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTtttTTTTTTTTTTTTTTTwwwTTTTT`tTTTTTDT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "T%tttTTTTTTTTTTTTTTTwwwwTTTTT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "tttT%TTTTTTTTTTTTTwwwwwwwTTTTT`TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TttTTTTTTTTTTTTTTwwwwwwwTTTTTT`TT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "|tT|TTTTTTTTTTTTwww`t`www~TTTT`TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "T@|TTTTTTTTTTT``„„„```„„„``TT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "|TTT|TTTTTTTTT`~wwwwwwwwwT````TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTT``TTwwwwwwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTT``TTTTTwwwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTT``TTTTTTwwwTTTTTTTTTTTTTT~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~T~TT``TTTTTwwwwTTTTTTTTTTT~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTT|TTT``TTTTwwwwwTTTTTTTTTTTTTTTTT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT~T|TTTT~`TTTTwwwwwwwTTTTTT~TTTTT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTT|T~`~~~~````„„„„„„„„„~~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "T*t~``~TT|TTTTTwwwwwwTTwww~~t~~~t~tt>TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTT~TTTwwwwwwwwTTTTTTTTTTTTTTT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTT|TT|TTTTTTTTTTTwwwwwTTTTTTT|TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~TTTTTTTTTTTwwTTTTTTTTTTTTT~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTG";

  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  
  createLoot(lootIndex++, 0, 47, 8, Key.COPPER_KEY);
  createLoot(lootIndex++, 0, 59, 14, new Equipment("Admirer's Chain","MetalMail.png",18,false,22,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST) );
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
  createLoot(lootIndex++, 0, 96, 41, new Equipment("Axe","MetalSpikedAxe.png",9,true,22,Job.KNIGHT,Job.BARBARIAN,Job.THIEF) );
  createLoot(lootIndex++, 0, 79, 45, Key.CHARIS_NOTES);
  createLoot(lootIndex++, 0, 20, 63, new Equipment("Hunter's Garb","GreenLeatherArmor.png",4,false,14,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST) );
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
  //in method below
  m[0].tiles[79][8].placeOccupant( color(150, 150, 250), "- My repairs have been delayed. Try to ignore that horrible thing for a few more days." );
  //Help room initiates
  m[0].tiles[21][30].placeOccupant( color(150, 150, 200), "- Chests come in many styles. These are mostly for show. Out in the world, there will always be SOMETHING inside of them." );
  m[0].tiles[25][30].placeOccupant( color(150, 150, 200), "- Some monsters are especially vulnurable to elemental skills and magic. Fire opposes ice, wind opposes earth. The divine light of Illamar is effective against anything unholy. Even natural creatures may have elemental weaknesses. You may have noticed that fire is effective against rats." );
  m[0].tiles[29][30].placeOccupant( color(150, 150, 200), "- There are many bodily ills in this world. Poison will sap your health until you perish or recover. Some monsters attack the senses so that you fall asleep while standing. Worse are those that induce paralysis. Some ailments are magical in nature, such as atrophy. It causes your muscles to weaken. If a curse is put upon you, your ability cast magic is reduced, as is your power to resist it." );
  m[0].tiles[33][30].placeOccupant( color(150, 150, 200), "- Let's review your lessons. Strength, combined with the power of your weapon, will determine the damage you deal in combat. Dexterity is a more subtle skill, but you will find it valuable when it allows you to land critical blows. A strong Constitution will prevent harm from physical blows. Magical power, obviously, powers magic spells and techniques. Willpower serves as your defense against the magic of others. Speed will determine how quickly you can act in combat." );
  m[0].tiles[21][34].placeOccupant( color(150, 150, 200), "- There are often many ways forward, and not all of them are obvious." );
  m[0].tiles[25][34].placeOccupant( color(150, 150, 200), "- Only one of these Legend Gems is genuine. Human artifice has been unable to re-create the Tears of Ritisu, though many have tried. Always tell your tales to the Gems. You will learn from your past and your possible futures reflected in its clear facets." );
  m[0].tiles[29][34].placeOccupant( color(150, 150, 200), "- Energy is used by martial fighters to fuel their combat techniques. You start with some energy and gain one every time you attack. Your maximum energy is dictated by your level of experience." );
  //in method below
  m[0].tiles[8][32].placeOccupant( color(200, 150, 200), "- There are other ways to move. Try the number pad, if you have one. The 7 key will open doors, and the 9 will interact with stairs." );
  m[0].tiles[12][32].placeOccupant( color(200, 150, 200), "- When choosing a hero for the use of items, the target of skills, or equipment, (a)(s)(d) and (1)(2)(3) work the same. This is also true when targeting monsters." );
  //in method below
  //in method below
  //Chilxius
  m[0].tiles[1][24].placeOccupant( color(0,200), "- Well done. You'll go far in this world. Look at your feet for a small reward. I will follow your progress, so seek me out in the future." );
  m[0].tiles[67][30].placeOccupant( color(150, 150, 250), "- Imagine my kitchen without the sound of you three sneaking in during the night, and thinking I never heard you. Take as much as you can carry, my children. You may find more skilled chefs out there in the world, but no one else's bread will taste like home." );
  m[0].tiles[71][31].placeOccupant( color(150, 150, 200), "- Sorry, I'm busy." );
  m[0].tiles[68][33].placeOccupant( color(150, 150, 200), "- Bread fresh from the oven is heavenly, but one cannot subsist solely on grains. Adding a scrap of meat or slice of fruit can make it a meal. With a frugal attitude, you can improve your recovery for every type of food you have." );
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

  //To the dormitory
  exits.add( new Portal(0,9,10,1,94,6, "Dormitory") );
  //To west cellar
  exits.add( new Portal(0,4,10,1,81,1, "The West Cellar") );
  //To/from help room
  exits.add( new Portal(0,42,28,0,27,32, "Initiates' Classroom") );
  exits.add( new Portal(0,27,32,0,42,28) );
  //To/from kitchen
  exits.add( new Portal(0,57,28,0,65,31) );
  exits.add( new Portal(0,65,31,0,57,28) );
  //To/from lab
  exits.add( new Portal(0,57,40,0,79,31) );
  exits.add( new Portal(0,79,31,0,57,40) );
  //To/from armory
  exits.add( new Portal(0,42,40,0,98,43) );
  exits.add( new Portal(0,98,43,0,42,40) );
  //Father Charis's study
  exits.add( new Portal(0,57,49,0,68,45, "Father Charis's Study") );
  exits.add( new Portal(0,68,45,0,57,49) );
  //Exit the cathedral
  exits.add( new Portal(0,63,73,0,30,52, "Irohill Forest") );
  //To well tunnel
  exits.add( new Portal(0,36,94,1,33,13) );
  
  //Chest goblin
  m[0].tiles[20][29].placeBoss( 0, color(255,5), "Something pops out of the chest!", new Monster("Box Goblin", "RedBoxBoy.png", 1, 1, 1, 1, 1, 1, 1, 0, AttackType.NONE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("looks around.");
      zoo.boss[bossIndex].attacks[1] = new Attack("pretends to be a box.");
      zoo.boss[bossIndex].attacks[2] = new Attack("speaks in a strange language.");
      zoo.boss[bossIndex].attacks[3] = new Attack("does nothing.");
      zoo.boss[bossIndex].attacks[4] = new Attack("does a little dance.");
  bossIndex++;
  
  //Giant rat blocking camp
  m[0].tiles[3][54].placeBoss( 0, color(150, 80, 40), "It's guarding that campsite.", new Monster("Escaped Rat", "BrownRat.png", 20, 9, 15, 2, 0, 2, 4, 0, AttackType.FIRE) );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 30, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites and claws.", 40, false);
  bossIndex++;
  
  //Giant rat blocking woods
  m[0].tiles[6][56].placeBoss( 0, color(150, 80, 40), "One of the big ones escaped.", new Monster("Escaped Rat", "BrownRat.png", 20, 11, 15, 2, 0, 2, 4, 0, AttackType.FIRE) );
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
  m[0].tiles[3][94].placeBoss( 0, color(255, 175), "They're protecting the Legend Gem.", new Monster("Red Spider", "RedSpider.png", 10, 5, 10, 3, 0, 3, 5, 0, AttackType.NONE), true );
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
  m[0].tiles[47][27].createEvent(true, "- Initiate's Classrooms");
  m[0].tiles[52][27].createEvent(true, "- Kitchen");
  m[0].tiles[47][39].createEvent(true, "- Armory");
  m[0].tiles[52][39].createEvent(true, "- Laboratory");
  m[0].tiles[68][44].createEvent(false, "- In the waning days of his life, Father Charis's study went largely unused. You still remember days passed, when the smell of ink and herbs would mix with the sound of water and a scratching quill. How could this place be so empty when he was alive only yesterday?");
  m[0].tiles[75][44].createEvent(false, "- Charis had no more worldly possessions than any other cleric. Why did he have an extra closet?");
  m[0].tiles[34][79].createEvent(false, "- There is a giant web across the path.");
  m[0].tiles[13][93].createEvent(false, "- Something snaps under your foot. A bone. There are gnawed remains all around the trees near the bridge.");
  
  //Save points
  savePoints[savePointIndex++] = new SavePoint(0, 19, 9);
  savePoints[savePointIndex++] = new SavePoint(0, 24, 35);
  savePoints[savePointIndex++] = new SavePoint(0, 3, 46);
  savePoints[savePointIndex++] = new SavePoint(0, 1, 94);

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
  //Floor 1 - Cellars

  mapIndex++; mapStrings[mapIndex] = "";
  mapStrings[mapIndex] += "£  333     £  33###########  £  ################     ###  £  ###     ################  £  ######### ";
  mapStrings[mapIndex] += "3333R3333  £  3...........#  £  #&#>#&#........#     #=#  £  #=#     #........#&#>#&#  £  #W.W.W.W# ";
  mapStrings[mapIndex] += "3=?...?*3  £  3.33#.w.###.#  £  ###.###.#####..#     £ £  £  £ £     #..#####.###.###  £  #@.@.@.@# ";
  mapStrings[mapIndex] += "3.......3  £  3.3...w...#.#  £  ##...##....>#..#     £ £  £  £ £     #[.#>....$[....#  £  #.......# ";
  mapStrings[mapIndex] += "3[.[[.?.3  £  3.333.w.###.#  £  #.....#######..#££££££ £  £  £ ££££££#..#######....[#  £  #.......# ";
  mapStrings[mapIndex] += "3333333c3  £  3.3...w...#.#  £  #..............¢       £  £  £       $...........[[[#  £  #......?# ";
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
  mapStrings[mapIndex] += "3.......3  £  3.3[[.#..[#.#  £                  §§§§,,,,,§   §,§          £       £ £     £  #######";
  mapStrings[mapIndex] += "333[=[3+3  £  3.333.#.|##.#  £                     §§§§§,§   §,§          £               £         ";
  mapStrings[mapIndex] += "3>33333c3  £  3.3[..3.[=#.#  £                  §§§,,,,,,§   §,,§          £££££££££££££  £         ";
  mapStrings[mapIndex] += "3.......3  £  3.333.3.###.#  £                 §,,,,§§§§§     §,,§                      ££ £££££££££";
  mapStrings[mapIndex] += "333333333  £  3>3=.....[#>#  £                 §,§§§           §,,§                    £            ";
  mapStrings[mapIndex] += "           £  3333333333###  £                §§,§§      §§§    §,,§                   £            ";
  mapStrings[mapIndex] += "           £                 £               §,,,,,§§§§§§,,,§§§§§]]§                   £  ∑∑∑∑∑∑∑∑∑∑";
  mapStrings[mapIndex] += "££££££££££££                 £              §,,§§§,,,,,,,,,,,,,,,,,§§                  £  ∑W,,WW,,W∑";
  mapStrings[mapIndex] += "            £££££££££££££££££££££££££      §,,§   §§§§,,,,,,~~,,,,,,,§                 £  ∑,,,,,,,,∑";
  mapStrings[mapIndex] += "                 £         £         £     §,§§       §,,,,,~~~,,,,,,§                 £  ∑,,,,,,,,∑";
  mapStrings[mapIndex] += "                 £         £         £     §,,,§       §,,,,,,,,,,,§,,§                £  ∑∑∑<∑∑<∑∑∑";
  mapStrings[mapIndex] += "###############  £  #####  £  WWWWW  £      §§,,§       §,,,,,,,,,§§,,§                £     £  £   ";
  mapStrings[mapIndex] += "#@#@#.......]]#  £  #∫∫∫#  £  W```W  £        §,,§    §§,,,,,,,,,,,§§,§                £            ";
  mapStrings[mapIndex] += "#.#.#.rrrWWWWW#  £  #∫∫∫#  £  W``]W  £         §,,§ §§,,,,,,,§§,,,,,,,§                 ££££££££££££";
  mapStrings[mapIndex] += "#.#.#.rrrrrrr.#  £  ##<##  £  WW<WW  £          §,,§,,,,,,,,§§,,,,,,§§                              ";
  mapStrings[mapIndex] += "#.............#  £    £    £    £    £          §,,,,,,,,,,,,,,,,,,§                                ";
  mapStrings[mapIndex] += "#######<#######  £         £         £  §§§§§§§§,,,,,,,,,,,,,,,,,,,,§  §§§§§§§§§§§                  ";
  mapStrings[mapIndex] += "       £         £££££ ££££ ££££ ££££   wwwwwwwwwwwww,,,,,,,,,,,,,,,,§§,,,,,,,,,,,§§§§§§§§§§§§§§§§§§";
  mapStrings[mapIndex] += "                 £    £         £    £  wwwwwwwwwwwwwwwwwwwwwww,,,,,,,,,,,wwww,,,,,,,,,,,,,,,>wwwwww";
  mapStrings[mapIndex] += "                 £                   £  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww,,,,wwwwwwwwwwwww";
  mapStrings[mapIndex] += "£££££££££££ £££££                    £   ,wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "           £                         £   ,,wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
  mapStrings[mapIndex] += "           £       333               £   ,,,,,,,,,,,,,,wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww§";
  mapStrings[mapIndex] += "#########  £       3>3               £   ,,,,,,,,,,,,,,,,,,,,,,wwwwwww,,,,,,,,,,wwwwwwwwwww,,,,,,,§§";
  mapStrings[mapIndex] += "#.......#  £       £ £               £   ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,§§§";
  mapStrings[mapIndex] += "#WW...WW#  £       £ £               £   ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,§§§";
  mapStrings[mapIndex] += "#.......#  £       £ £               £                                                              ";
  mapStrings[mapIndex] += "#.......#  £       £ £               £                                                              ";
  mapStrings[mapIndex] += "####<####  £       £ £                ££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££££";
  mapStrings[mapIndex] += "    £      £       £ £                         £              £                  £                  ";
  mapStrings[mapIndex] += "           £       £ £                         £              £                  £                  ";
  mapStrings[mapIndex] += "           £       £ £                         £  ##########  £  ∑∑∑∑∑∑∑∑∑∑∑∑∑∑  £  ################";
  mapStrings[mapIndex] += "£££££££££££        £ £                         £  #∑     W∑#  £  ∑>„„„„„„„„„„>∑  £  #>„„„rrrrrr„„„>#";
  mapStrings[mapIndex] += "                   £ £                         £  #W= WW  W#  £  ∑„„„„„„„„„„„„∑  £  #„„„„r∑∑∑∑r„„„„#";
  mapStrings[mapIndex] += "                   £ £                         £  #∑∑W∑∑W  #  £  ∑„„„∫∫∫∫∫∫„„„∑  £  #„„„„r∑∑∑∑r„„„„#";
  mapStrings[mapIndex] += "WWWWWWWWWWWWWWWWWWW  £                         £  #W      ∑#  £  ∑„„„∫WWWW∫„„„∑  £  #„„„„rrrrrr„„„„#";
  mapStrings[mapIndex] += "W              ß  Í  £                         £  #  ∑W∑W∑W#  £  ∑≠≠„∫∫∫∫∫∫„≠≠∑  £  #„„„„„„„„„„„„„„#";
  mapStrings[mapIndex] += "W  B ßßÍBßBBßß ß  ß|£                          £  # ∑W     #  £  ∑∑∑∑∑∑∑∑∑∑∑∑∑∑  £  #######<<#######";
  mapStrings[mapIndex] += "W∑ Í        Í  ß  B||                          £  # W  ∑∑  #  £                  £         ££       ";
  mapStrings[mapIndex] += "WBÍß  ß B ß B  B | ||                          £  #   WW∑  #  £                  £                  ";
  mapStrings[mapIndex] += "W  B  Í ∑ ∑ ß  ß  Í||                          £  #######<##   £££££££££££££££££££                  ";
  mapStrings[mapIndex] += "£| ß  ß     B  ß   | |                         £         £    £                   ££££££££££££££££££";
  mapStrings[mapIndex] += "W= ß  ß  r  B    |ß||                          £              £                                     ";
  mapStrings[mapIndex] += "WWWWWWWWW<WWWWWWW||||| |                        ££££££££££££££                                      ";
  mapStrings[mapIndex] += "         £                                               £                                          ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
    
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  mapStrings[mapIndex] += "                                                                                                    ";
  
  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  //m[1].floorNumber=1;
  
  createLoot(lootIndex++, 1, 3, 4, Key.COPPER_KEY);
  createLoot(lootIndex++, 1, 1, 2, new Equipment("Brocade","YellowShirt.png",5,false,5,true));
  createLoot(lootIndex++, 1, 54, 1, new Equipment("Ivory Knife","IceDagger.png",15,true,15,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST,Job.MAGE));
  createLoot(lootIndex++, 1, 62, 1, new Equipment("Staff","Staff.png",2,true,10,Job.KNIGHT,Job.PRIEST,Job.MAGE));
  createLoot(lootIndex++, 1, 17, 21, Key.COPPER_KEY);
  createLoot(lootIndex++, 1, 79, 3, new Equipment("Vestment","BlueShirt.png",3,false,7,true));
  createLoot(lootIndex++, 1, 81, 5, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 83, 5, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 23, 17, new Item("Health Potion",12) );
  createLoot(lootIndex++, 1, 23, 19, new Equipment("Knife","MetalDagger.png",4,true,12,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST,Job.MAGE) );
  createLoot(lootIndex++, 1, 23, 21, new Item("Health Potion",12) );
  createLoot(lootIndex++, 1, 17, 17, new Equipment("Rusty Sword","CrimsonSword.png",6,true,20,Job.KNIGHT,Job.BARBARIAN) );
  createLoot(lootIndex++, 1, 3, 18, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 4, 18, new Equipment("Old Leather","LeatherArmor.png",5,false,10,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.PRIEST) );
  createLoot(lootIndex++, 1, 5, 18, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 7, 15, Key.BRASS_KEY);
  createLoot(lootIndex++, 1, 48, 16, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 49, 16, new Item("Meat",20) );
  createLoot(lootIndex++, 1, 66, 15, new Equipment("Ratfang","Ratfang.png",15,true,24,Job.KNIGHT,Job.BARBARIAN,Job.THIEF,Job.MAGE) );
  createLoot(lootIndex++, 1, 33, 30, new Item("Bread",10) );
  createLoot(lootIndex++, 1, 66, 53, Key.CRYPT_KEY );
  createLoot(lootIndex++, 1, 67, 53, Key.CRYPT_KEY );
  createLoot(lootIndex++, 1, 76, 53, Key.CRYPT_KEY );
  createLoot(lootIndex++, 1, 77, 53, Key.CRYPT_KEY );
  //1,1,39 - libray loot
  
  m[1].tiles[2][2].createEvent(true, "- The (space) key can be used to open chests like this one. You also use this key to search your current square. See if you can find anything left behind in this room by careless initiates.");
  m[1].tiles[6][2].createEvent(true, "- This is a sacred Legend Gem. Gazing into it, you can feel your acomplishments being told around campfires centuries from now. Step on it and press capital (S) to activate it, and then press ENTER to confirm and save your progress.");
  m[1].tiles[6][4].createEvent(true, "- Some doors are locked. You can view your key ring by holding down the (k) key. By examining a door, you can determine what key is required. If you stand next to the door and press the (o) key, you will use the proper key if you possess it. Keys are fragile, and usually break after a single use.");
  m[1].tiles[2][7].createEvent(false, "- This stairwell will lead to a new room. To use it, stand on it and press the (>) key.");
  m[1].tiles[18][1].createEvent(false, "- Some of the clerics are busy cleaning the cellar. Walk into their space to speak with them.");
  m[1].tiles[35][3].createEvent(false, "- Sometimes, you can pass only one way across a threshold. This is one of those moments. Once you ascend these stairs, your story will truly begin. Good luck, young heroes.");
  m[1].tiles[97][5].createEvent(true, "- Press capital (R) on a bed to rest. Resting in a safe place will fully restore health and magic.");
  m[1].tiles[2][15].createEvent(false, "- Whatever that is, it's big. Make sure to (E)at if you feel weak.");
  m[1].tiles[6][15].createEvent(false, "- This hole was made recently.");
  //Town
  m[1].tiles[83][14].createEvent(true, "Finest Bread: 15 Gold");
  m[1].tiles[92][25].createEvent(true, "Club: 12 Gold");
  m[1].tiles[93][25].createEvent(true, "Dagger: 10 Gold");
  m[1].tiles[96][25].createEvent(true, "Iron Plate: 30 Gold");
  m[1].tiles[97][25].createEvent(true, "SOLD OUT");
  
  m[1].tiles[17][3].placeOccupant( color(75,100,255), "- Good morning, young ones. We made fresh bread this morning. To eat food you are carrying, press capital (E). You need peace and quiet to eat. Don't try to eat during a fight or it will ruin your digestion." );
  m[1].tiles[17][5].placeOccupant( color(75,100,255), "- I think we have some magical potions left in the western cellar. Those are quite useful as they can be consumed during combat. There are only four varieties of potion, though. Thanks, prohhibition. Press capital (D) to drink potions while in the field." );
  m[1].tiles[17][7].placeOccupant( color(75,100,255), "- When you are weary, seek out an inn or campsite. The people of Irid left many tents of sturdy and long-lasting leather across the land. Press capital (R) to rest at such a site." );
  m[1].tiles[23][3].placeOccupant( color(75,100,255), "- We have all we need here at the Irohill Cathedral. However, if you some day leave, you may need to trade with vendors. Press capital (B) to bargain with them, but be wary of those who would cheat you." );
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
  m[1].tiles[83][14].placeShop( new Item( "Bread",10 ), 15 );
  m[1].tiles[86][14].placeOccupant( color(150,50,165), "- Don't listen to what he says. It was those giant rats that ate all our stock." );
  
  //Equipment Shop
  m[1].tiles[92][24].placeOccupant( color(165,150,50), "- A solid and heavy club is all it takes to bring down one of them. But there's never just one." );
  m[1].tiles[92][25].placeShop( new Equipment( "Club","OldClub.png", 6, true, 17, Job.KNIGHT, Job.BARBARIAN, Job.THIEF, Job.PRIEST ), 12 );
  m[1].tiles[93][24].placeOccupant( color(165,150,50), "- If you don't have a solid dagger at your side, you are not prepared." );
  m[1].tiles[93][25].placeShop( new Equipment( "Dagger","MetalDagger2.png", 5, true, 13, Job.KNIGHT, Job.BARBARIAN, Job.THIEF, Job.MAGE ), 10 );
  m[1].tiles[96][24].placeOccupant( color(150,50,165), "- I have a few sets of iron plate left. They should protect you from those things." );
  m[1].tiles[96][25].placeShop( new Equipment( "Iron Plate","MetalArmor.png", 15, true, 24, Job.KNIGHT, Job.BARBARIAN ), 30 );
  m[1].tiles[97][24].placeOccupant( color(150,50,165), "- Sorry, but we're all out of leather goods." );
  
  //Irohill Inn
  m[1].tiles[11][29].placeOccupant( color(165,150,50), "- You're here to help us, I guess. Half a pint each, on the house. But no more. A drunk adventurer soon becomes a drunk corpse." );
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
  
  //Town Hall 2
  //Mayor
  m[1].tiles[71][53].placeOccupant( color(governor), "Rask has faith in you. I will have faith in you as well. These keys have been gathering rust in the treasury for countless years. They will open the tombs of the honored dead. It is an indignity, but this evil magic is a far greater insult. Use what you find to save the living, but beware what may be within the tombs. Illamar guide you." );
  //Rask
  m[1].tiles[70][51].placeOccupant( color(raskColor), "- Good, you've arrived. We have the makings of a plan. Make your way into Baron's Field. Captain Rook will take the garrison to draw their attention. Your job will be to find the source of the curse, whether it be man or monster, and end it. Talk to the mayor for his contribution to your mission." );
  //Rook
  m[1].tiles[71][51].placeOccupant( color(garrisonColor), "- My soldiers will be dying to open the way for you. Do not let us down." );
  
  savePoints[savePointIndex++] = new SavePoint(1, 7, 2); //Intro
  savePoints[savePointIndex++] = new SavePoint(1, 96, 14); //Temple
  
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
  exits.add( new Portal(1,96,16,2,58,19) );
  
  //Inn to town
  exits.add( new Portal(1,7,33,2,70,20) );

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
  //Library Secret
  exits.add( new Portal(1,20,40,1,55,49,"?") );
  //Library Exit
  exits.add( new Portal(1,57,57,2,83,20) );
  
  
  
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

  m[1].tiles[1][16].placeBoss( 1, color(150, 80, 40), "A swarm comes for you!", new Monster("Giant Rat", "BrownRat.png", 18, 5, 5, 1, 9, 1, 3, 0, AttackType.FIRE), true );
      zoo.boss[bossIndex].attacks[0] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[1] = new Attack("squeaks.");
      zoo.boss[bossIndex].attacks[2] = new Attack("bites.", 29, false);
      zoo.boss[bossIndex].attacks[3] = new Attack("bites.", 34, false);
      zoo.boss[bossIndex].attacks[4] = new Attack("bites.", 39, false);
  bossIndex++;

  m[1].tiles[5][15].placeBoss( 1, color(200, 80, 40), "This must be their matriarch.", new Monster("Rat Queen", "RedRat.png", 35, 12, 5, 2, 21, 3, 5, 0, AttackType.NONE) );
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
  
  //1,4,55 - skeleton
  //1,14,55 - skeleton
  //1,16,55 - skeleton
  
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

  dangerStrs[dangerMapIndex] += "Hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "Ixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  dangerStrs[dangerMapIndex] += "Jxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dangerStrs[dangerMapIndex] += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  
  
  //---------------------------------------------------------------------------------------------------------------------------\\
  //Floor 2 - Irohill
  
  mapIndex++; mapStrings[mapIndex] = "";
  mapStrings[mapIndex] += "YTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT```TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
 
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT``TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~```~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TTTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~```~~~$~~~~~$~~~~~~~~~~~~~~~~,,∞,,,∞,,,,,∞,,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~))))))))~~~~~~~~~~~~~~~~~~~~~~~~```~~~$$$$$$$~~~~~~~~~~~~~~~~```````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~))))∑∑∑∑∑∑∑∑))))~~~~~~~~~~~~~~~~~~~~```~~~#+###+#~~```````~~~~~~~,,,,∞,,,,,∞,,,,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~))))))))))))))))~~~~~(((~~(((~~(((~~```~~~#.....#~~```````~~~~~~~```````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑∑~~~~~WWW~~WWW~~WWW~~```~~~#######~~```````~~~(((~∞,,,,∞,∞,,,,,∞,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~#######<<#######~~~~~#+#~~W+W~~W+W~~```~~~###<###~~```````~~~∑∑∑~```````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~%~~%~~``~~%~~%~~~~~~~`~~~~`~~~~`~~~```~~~##~`~##~~```````~~~∑+∑~,,∞∞,,,,,,∞,,,,~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~``~~~~~~~~~~~~~`~~~~`~~~~`~~~```~~~~~~`~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~`````````````````````````````````````````````````````````````````````````~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~```~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~(((~~(((~~(((~~(((~~(((~~(((~~(((~~~~~```~~~~~#&#&#~~~(((((((((((((~~((((((~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~WWW~~∑∑∑~~∑∑∑~~∑∑∑~~∑∑∑~~WWW~~∑∑∑~~~```````~~~#####~~~(((((((((((((~~((((((~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~W+W~~#<#~~∑+∑~~#+#~~∑+∑~~W<W~~∑+∑~~``~~~~~``~~##>##~~~∑∑∑∑∑∑∑∑∑∑∑∑∑~~######~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~`~~~~`~~~%`%~~~`~~~~`~~~~`~~~~`~~~`~~%~%%~`~~~G.G~~~~######<######~~####+#~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~`~~~~`~~~~`~~~~`~~~~`~~~~`~~~~`~~~`~%WWW~~`~~~~.~~~~ˆ~~~~~~`~~~~~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~```````````````````````````````````~~WwW%~``````````````````````````````````~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~#############~((((((((~~~((((((((~~`~%WWW~~`~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~#(((~(((~(((#~((((((((~~~((((((((~~`~%~`~%~`~~(((~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~#∑∑∑~∑∑∑~∑∑∑#~∑∑∑∑∑∑∑∑~~~∑∑∑∑∑∑∑∑~~``~~`~~``~~WWW~~W||~~~~~~~~~~~~(((((~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~#∑+∑~∑+∑~∑+∑#~∑∑<∑∑<∑∑~~~∑∑<∑∑<∑∑~~~```````~~~W+W~~#.|~~||~~~~~~~WWWWWWWW||~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~`~~~`~~~`~~~~~`~~`~~~~~~~`~~`~~~~~~~~`~~~~~~~`~~~~`~~~~`~~~~~~~|WWWW<WWW|~|~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~`~~~`~~~`~~~~÷`~~`÷~~~~~/`~~`/~~~~~~~`~~~~~~~`~~~~`~~~~`~~~~~~~~~~~```~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~`````````````````````````````````````````````````````````````~`````~~````~`~`~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``~~~~~``~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~TTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  mapStrings[mapIndex] += "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  

  m[mapIndex] = new Map(mapStrings[mapIndex],mapIndex);
  
  //Boy
  m[2].tiles[50][24].placeOccupant( color(250,230,0), "- Ma? Some strange people came out of the well." );
  //Buyer
  m[2].tiles[14][24].placeOccupant( color(10,10,50), "- Got anything you don't need? I won't buy perishable food, and I won't buy magic potions since those are too heavily regulated. But I can take anything else. You're lucky to find me here. With all the chaos, I don't have to hide as hard as my competitors do." );
  m[2].tiles[14][25].placeSeller();
  
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
  m[2].tiles[75][8].placeOccupant( color(male), "- The signs have been clear for years. Life has grown weak around Irohill. Crops, animals, children. Charis and I were initiates together, so he had the sense to believe me. This won't be solved by building walls and equipping children. The cause is thaumaturgical. Find the source of these black arts and send him to the Black Vanguard." );
  //Player 3's friend
  //in method below
  
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
  
  //savePoints[savePointIndex++] = new SavePoint(2, 7, 7);
  
  
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
  String thiefName="";
  String monkName="";
  String priestName="";
  String mageName="";
  String magePhrase = "";
  String heroWeapon[] = {"","",""};
  
  for(int i=0;i<3;i++)
  {
    if(party.hero[i].job==Job.KNIGHT)knightName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.BARBARIAN)barbName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.THIEF)thiefName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.KARATE)monkName= " like "+party.hero[i].name;
    if(party.hero[i].job==Job.PRIEST)priestName= " such as "+party.hero[i].name;
    if(party.hero[i].job==Job.MAGE){mageName= " such as "+party.hero[i].name;magePhrase=", as "+party.hero[i].name+" can attest";}  

    if(party.hero[i].job==Job.KNIGHT)    heroWeapon[i] = "sword";
    if(party.hero[i].job==Job.BARBARIAN) heroWeapon[i] = "axe";
    if(party.hero[i].job==Job.KARATE)    heroWeapon[i] = "fists";
    if(party.hero[i].job==Job.THIEF)     heroWeapon[i] = "knives";
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
  
  //Teachers
  m[0].tiles[8][36].placeOccupant( color(200, 150, 200), "- Knights"+knightName+" rely on their armor, and gain two energy when they defend against an attack. Barbarians"+barbName+" gain one anger whenever they are attacked." );
  m[0].tiles[12][36].placeOccupant( color(200, 150, 200), "- Thieves"+thiefName+" gain five energy on successful critical blows. Martial artists"+monkName+" do not gain bonus energy, but will always start a fight full of spiritual power." );
  m[0].tiles[33][34].placeOccupant( color(150, 150, 200), "- Magical Power is used by mages"+mageName+" and priests"+priestName+" to fuel their magic. The lure of magic is strong, but once their power is spent a mage can do little." );
  //Garrison
  m[0].tiles[98][41].placeOccupant( color(160, 160, 160), "- Knights"+knightName+" can wear heavy armor, which provides the best protection. Priests of Illamar"+priestName+" have been blessed with the strength to wear plate as well. Simpler armors like chain and leather can be worn by wild warriors"+barbName+" and rogues"+thiefName+". Martial artists"+monkName+" are trained to fight wearing common garb, and the magic of magi is disrupted by heavy material"+magePhrase+"." );
  m[0].tiles[98][45].placeOccupant( color(160, 160, 160), "- Swords and axes are the weapons of warriors. Knights"+knightName+" and barbaric fighters"+barbName+" should see no difficulty wielding them. Simpler arms like the club or knife are suitable for those without formal training, though mages"+mageName+" can only manage simple knives and staves. Martial artists"+monkName+" need naught but the hands Am-asma gave them." );
  m[0].tiles[92][45].placeOccupant( color(190, 170, 130), "A training dummy. Someone has drawn "+party.hero[0].name+"'s face on it." );
  
  //Rask
  m[0].tiles[48][67].placeOccupant( color(250, 100, 50), "- "+party.hero[0].name+"? "+party.hero[1].name+"? Good, I'm glad to see you. We need help and we won't get it from Mother Sunita. I'm headed to the mayor's office. Meet me there as soon as you can." );
  
  //Kat
  m[0].tiles[19][53].placeOccupant( color(250,0,170), "- AH! "+party.hero[1].name+", where did you come from? Was it you who slew those rats in the cellar? You're strong, "+party.hero[1].name+". Brave, too. If only I could borrow that courage. Some of them escaped the cellar with my prototype potion. I don't know what effect it will have on fauna, but it is my responsibilty to prevent harm. I-if you want to help, I'd appreciate it. My "+heroWeapon[1]+" "+wasOrWere(heroWeapon[1].charAt(heroWeapon[1].length()-1))+" never as strong as yours." );
  m[1].tiles[49][14].placeOccupant( color(250,0,170), "She's slumped against the wall. Her arm is burned. - "+party.hero[1].name+"? How did you avoid the man-wolf? I had to use my draught of disguise. The rats are getting larger, and mutating in strange ways. May Am-asma forgive me for my part in this. I was able to trap one up ahead. Could you please fight him? I have food here if you feel hungry. I'll be fine, I just need a rest..." );
  
  //Garrison
  m[1].tiles[4][42].placeOccupant( color(garrisonColor), "- " + party.hero[0].name + "! Finally come to your senses and decided to join the garrison? We need " + needAnA(heroWeapon[0]) + heroWeapon[0] + " like yours to help train these milksops to soldier!" );
  m[1].tiles[7][44].placeOccupant( color(fYoung), "- Thank you, " + party.hero[1].name + ". I never forgot what you taught me. You thought it would be years before they allowed me to be a soldier, but they need everyone they can get. This has always been my destiny." );
  
}

//Expected Level
//Rat queen 1.7
//man-wolf 3.3

//Deities:
//Black Vanguard - anubis
//Illamar - sun god
//Ritisu - god of save crystals, legend, stories, history
//Am-asma - god of creatures and medicine

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
