class Equipment extends Item
{
  Job allowedJobs[] = new Job[6];
  boolean isWeapon;
  int power;
  
  public Equipment()
  {
    this( "None", 1, true, 1 );
  }
  
  //Constructors for assigning a piece of equipment to
  //certain classes. The rest become Job.NONE
  public Equipment( String n, int v, boolean IW, int p ){this( n, v, IW, p, Job.NONE );}
  public Equipment( String n, int v, boolean IW, int p, Job j ){this( n, v, IW, p, j, Job.NONE );}
  public Equipment( String n, int v, boolean IW, int p, Job j, Job j2 ){this( n, v, IW, p, j, j2, Job.NONE );}
  public Equipment( String n, int v, boolean IW, int p, Job j, Job j2, Job j3 ){this( n, v, IW, p, j, j2, j3, Job.NONE );}
  public Equipment( String n, int v, boolean IW, int p, Job j, Job j2, Job j3, Job j4 ){this( n, v, IW, p, j, j2, j3, j4, Job.NONE );}
  public Equipment( String n, int v, boolean IW, int p, Job j, Job j2, Job j3, Job j4, Job j5 ){this( n, v, IW, p, j, j2, j3, j4, j5, Job.NONE );}
  
  public Equipment( String n, int v, boolean IW, int p, Job j0, Job j1, Job j2, Job j3, Job j4, Job j5 )
  {
    super( n, v );
    isWeapon = IW;
    power = p;
    
    allowedJobs[0]=j0;
    allowedJobs[1]=j1;
    allowedJobs[2]=j2;
    allowedJobs[3]=j3;
    allowedJobs[4]=j4;
    allowedJobs[5]=j5;
  }
}
