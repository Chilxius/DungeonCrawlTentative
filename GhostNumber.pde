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
  }
  
  void moveAndDrawNumber() //Causes the number's digits to bounce once before settling
  {                           //Movement not based on millis()
    textSize(30);
    fill(numColor);
    for( int i = 0; i < digits; i++)
    {
      if(duration < 60-i*5) //makes the numbers appear from left to right
      {
        if( duration > 54 - i*5 )
          yOffsets[i]-=3;
        else
          yOffsets[i]+=3;
          
        //This works. Don't touch it.
        text( (value/(int(pow(10,digits-i-1))))%10, X-9*digits+20*i, min(Y+yOffsets[i],Y) );
      }
    }
    duration--;
    if(duration<=0)
      active = false;
  }
}
