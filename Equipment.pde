class Equipment extends Item
{
  Job allowedJobs[] = new Job[6];
  boolean isWeapon;
  int power;
  PImage pic;
  String imageName;
  AttackType element;
  
  public Equipment()
  {
    this( "None", "error.png", 1, true, 0, Job.KNIGHT );
  }
  
  public Equipment( Equipment e )
  {
    super( e.name, e.value );
    isWeapon = e.isWeapon;
    element = determineElement(e.power);
    power = int(e.power);
    imageName = e.imageName;
    pic = e.pic;
    
    allowedJobs[0]=e.allowedJobs[0];
    allowedJobs[1]=e.allowedJobs[1];
    allowedJobs[2]=e.allowedJobs[2];
    allowedJobs[3]=e.allowedJobs[3];
    allowedJobs[4]=e.allowedJobs[4];
    allowedJobs[5]=e.allowedJobs[5];
  }
  
  //Constructors for assigning a piece of equipment to
  //certain classes. The rest become Job.NONE.
  public Equipment( String n, String picN, int v, boolean IW, float p, boolean allClasses ){this( n, picN, v, IW, p, Job.KNIGHT, Job.BARBARIAN, Job.KARATE, Job.THIEF, Job.PRIEST, Job.MAGE);}
  public Equipment( String n, String picN, int v, boolean IW, float p ){this( n, picN, v, IW, p, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j ){this( n, picN, v, IW, p, j, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2 ){this( n, picN, v, IW, p, j, j2, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3 ){this( n, picN, v, IW, p, j, j2, j3, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4 ){this( n, picN, v, IW, p, j, j2, j3, j4, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4, Job j5 ){this( n, picN, v, IW, p, j, j2, j3, j4, j5, Job.NONE );}
  
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j0, Job j1, Job j2, Job j3, Job j4, Job j5 )
  {
    super( n, v );
    isWeapon = IW;
    element = determineElement(p);
    power = int(p);
    
    imageName = picN;
    
    try{pic = loadImage(picN);}
    catch(Exception e){pic=loadImage("error.png");}
    pic.resize(56,0);
    
    allowedJobs[0]=j0;
    allowedJobs[1]=j1;
    allowedJobs[2]=j2;
    allowedJobs[3]=j3;
    allowedJobs[4]=j4;
    allowedJobs[5]=j5;
  }
  
  public AttackType determineElement( float p )
  {    
    switch( (int)((power*10)%10) ) //can't switch on floats; I learned something today
    {
      case 1:  return AttackType.EARTH;   //Captain Planet
      case 2:  return AttackType.FIRE;    //ordering to
      case 3:  return AttackType.WIND;    //help remember
      case 4:  return AttackType.ICE;
      case 5:  return AttackType.HOLY;
      default: return AttackType.NONE;
    }
  }
  
  public boolean setPic( String fileName )
  {
    try {
      if( fileName.substring(fileName.length()-4).equals(".png") )
        pic = loadImage(fileName);
      else
        pic = loadImage(fileName + ".png");
      return true;
    } catch(Exception e) {
      pic = loadImage("error.png");
      return false;
    }
  }
  
  public boolean usableBy( Job j )
  {
    for( Job job: allowedJobs )
      if( job == j )
        return true;
    return false;
  }
  
  public String shopString( int p )
  {
    return name+": "+p+" Gold  "+power+" Power";
  }
}

/*
//WEAPONS
Keep weapon power between 1 and 99
Martial Artist's fist should power up as they level
Dealing single-digit damage should only happen in the first dungeon, against special high-defense monsters, and by the mage

Barb weapons strongest
Knight/Priest
Thief/Karate
Mage, except occasionally (magic weapons can deal high damage - won't help mage)

Elemental Weapons:
Weapons will deal elemental damage if their power value contains a decimal value
X.1 - Earth
X.2 - Fire
X.3 - Wind
X.4 - ICE
X.5 - HOLY
*/
