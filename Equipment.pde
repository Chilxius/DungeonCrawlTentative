class Equipment extends Item
{
  Job allowedJobs[] = new Job[9];
  boolean isWeapon;
  float power;
  PImage pic;
  String imageName;
  AttackType element;
  Debuff status;
  
  public Equipment()
  {
    this( "None", "error.png", 1, true, 0, Job.KNIGHT );
  }
  
  public Equipment( Equipment e )
  {
    super( e.name, e.value );
    isWeapon = e.isWeapon;
    element = determineElement(e.power);
    status = determineStatus(e.power);
    power = e.power;
    imageName = e.imageName;
    pic = e.pic;
    
    allowedJobs[0]=e.allowedJobs[0];
    allowedJobs[1]=e.allowedJobs[1];
    allowedJobs[2]=e.allowedJobs[2];
    allowedJobs[3]=e.allowedJobs[3];
    allowedJobs[4]=e.allowedJobs[4];
    allowedJobs[5]=e.allowedJobs[5];
    allowedJobs[3]=e.allowedJobs[6];
    allowedJobs[4]=e.allowedJobs[7];
    allowedJobs[5]=e.allowedJobs[8];
  }
  
  //For all class use, excepting weapons for monks and armor for saurians
  public Equipment( String n, String picN, int v, boolean IW, float p, boolean allClasses )
  {
    super( n, v );
    isWeapon = IW;
    element = determineElement(p);
    status = determineStatus(p);
    power = p;
    
    imageName = picN;
    
    try{pic = loadImage(picN);}
    catch(Exception e){pic=loadImage("error.png");}
    pic.resize(56,0);
    
    allowedJobs[0]=Job.KNIGHT;
    allowedJobs[1]=Job.BARBARIAN;
    allowedJobs[2]=Job.BARD;
    allowedJobs[3]=Job.THIEF;
    allowedJobs[4]=Job.DRUID;
    allowedJobs[5]=Job.PRIEST;
    allowedJobs[6]=Job.MAGE;
    allowedJobs[7]=Job.NONE;
    if(IW)
      allowedJobs[8]=Job.SAURIAN;
    else
      allowedJobs[8]=Job.KARATE;
  }
  
  //Constructors for assigning a piece of equipment to
  //certain classes. The rest become Job.NONE.
  public Equipment( String n, String picN, int v, boolean IW, float p ){this( n, picN, v, IW, p, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j ){this( n, picN, v, IW, p, j, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2 ){this( n, picN, v, IW, p, j, j2, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3 ){this( n, picN, v, IW, p, j, j2, j3, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4 ){this( n, picN, v, IW, p, j, j2, j3, j4, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4, Job j5 ){this( n, picN, v, IW, p, j, j2, j3, j4, j5, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4, Job j5, Job j6 ){this( n, picN, v, IW, p, j, j2, j3, j4, j5, j6, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4, Job j5, Job j6, Job j7 ){this( n, picN, v, IW, p, j, j2, j3, j4, j5, j6, j7, Job.NONE );}
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j, Job j2, Job j3, Job j4, Job j5, Job j6, Job j7, Job j8 ){this( n, picN, v, IW, p, j, j2, j3, j4, j5, j6, j7, j8, Job.NONE );}
  
  public Equipment( String n, String picN, int v, boolean IW, float p, Job j0, Job j1, Job j2, Job j3, Job j4, Job j5, Job j6, Job j7, Job j8 )
  {
    super( n, v );
    isWeapon = IW;
    element = determineElement(p);
    status = determineStatus(p);
    power = p;
    
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
    allowedJobs[6]=j6;
    allowedJobs[7]=j7;
    allowedJobs[8]=j8;
  }
  
  public AttackType determineElement( float p )
  {
    switch( (int)((p*10)%10) ) //can't switch on floats; I learned something today
    {
      case 1:  return AttackType.EARTH;   //Captain Planet
      case 2:  return AttackType.FIRE;    //ordering to
      case 3:  return AttackType.WIND;    //help remember
      case 4:  return AttackType.ICE;
      case 5:  return AttackType.HOLY;
      default: return AttackType.NONE;
    }
  }
  
  public Debuff determineStatus( float p )
  {    
    switch( (int)((p*100)%10) )
    {
      case 1:  return Debuff.POISON;
      case 2:  return Debuff.SLEEP;
      case 3:  return Debuff.PARA;
      case 4:  return Debuff.WEAK;
      case 5:  return Debuff.CURSE;
      default: return Debuff.NONE;
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
    return name+": "+p+" Gold  "+(int)power+" Power";
  }
  
  public int getPower()
  {
    return (int)power;
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

Status-inducing Weapons:
Weapons will inflict status if their power value has a hundreds-place digit
X.01 - Poison
X.02 - Sleep
X.03 - Paralysis
X.04 - Weakness
X.05 - Curse
*/
