//Secondary map of danger levels, checked when triggering battles
//Danger of 0 will not trigger battles
//Danger level rises 1-9, then a-w
//Anything else will default to 0

class DangerMap
{
  char map[][] = new char[100][100];
  
  public DangerMap( String input )
  {
    if( input.length() < 10000 )
      println("Danger Map error");
    while( input.length() < 10000 )
      input += "x";
      
    for(int i = 0; i < 100; i++)
      for(int j = 0; j < 100; j++)
        map[j][i] = input.charAt(i*100+j);
  }
  
  char dangerValueChar( int x, int y )
  {
    return map[x][y];
  }
}
