class GhostNumber
{
  float X, Y;
  int yOffsets[];
  color numColor;
  int value;
  int duration;
  int digits;
  boolean active;
  
  public GhostNumber( float xPos, float yPos, color c, int v )
  {
    X = xPos;
    Y = yPos;
    numColor = c;
    value = v;
    duration = 300;
    digits = 1;
    active = true;
    int tempValue = value;
    while( tempValue / 10 > 0 )
    {
      digits++;
      tempValue /= 10;
    }
    yOffsets = new int[digits];
  }
  
  void moveAndDrawNumber() //Causes the number's digits to bounce once before settling
  {                           //Movement not based on millis()
    textSize(30);
    fill(numColor);
    for( int i = digits; i > 0; i--)
    {
      if(duration < 300-i*5) //makes the numbers appear from left to right
      {
        if( duration > 290 - i*5 )
          yOffsets[i-1]-=2;
        else
          yOffsets[i-1]+=2;
        text( (value/(i*10))%10, X-10*digits+20*i, min(Y+yOffsets[i-1],Y) );
      }
    }
    duration--;
    if(duration<=0)
      active = false;
  }
}
