class GhostNumber
{
  float X, Y;
  int yOffsets[];
  color numColor;
  int value;
  int duration;
  int digits;
  boolean active;
  String word;
  boolean isWord;
  
  public GhostNumber( float xPos, float yPos, color c, int v )
  {
    X = xPos;
    Y = yPos;
    numColor = c;
    value = v;
    duration = 60;
    digits = 1;
    active = true;
    int tempValue = value;
    while( tempValue / 10 > 0 )
    {
      digits++;
      tempValue /= 10;
    }
    yOffsets = new int[digits];
    isWord = false;
  }
  
  public GhostNumber( float xPos, float yPos, color c, String w )
  {
    X = xPos;
    Y = yPos;
    numColor = c;
    word = w;
    duration = 60;
    digits = w.length();
    active = true;
    yOffsets = new int[digits];
    isWord = true;
  }
  
  void moveAndDrawNumber() //Causes the number's digits to bounce once before settling
  {                           //Movement not based on millis()
    textSize(30*fontScale);
    textAlign(CENTER);
    fill(numColor);
    for( int i = 0; i < digits; i++)
    {
      if(duration < 60-i*5) //makes the numbers appear from left to right
      {
        if( duration > 54 - i*5 )
          yOffsets[i]-=3;
        else
          yOffsets[i]+=3;
         
        if(!isWord)
        {
          //This works. Don't touch it.
          textSize(36*fontScale); fill(0); //black outline
          text( (value/(int(pow(10,digits-i-1))))%10, X-9*digits+20*i, min(3+Y+yOffsets[i],3+Y) );
          textSize(30*fontScale); fill(numColor);
          text( (value/(int(pow(10,digits-i-1))))%10, X-9*digits+20*i, min(Y+yOffsets[i],Y) );
        }
        else
        {
          textSize(36*fontScale); fill(0); //black outline
          text( word.charAt(i), X-9*digits+20*i, min(3+Y+yOffsets[i],3+Y) );
          textSize(30*fontScale); fill(numColor);
          text( word.charAt(i), X-9*digits+20*i, min(Y+yOffsets[i],Y) );
        }
      }
    }
    duration--;
    if(duration<=0)
      active = false;
  }
}
