/**********************************************
Logbook Class
Keeps a list of the strings given to it, each
of which is chopped up into pieces of pre-determined
length. Will not chop words unless they exceed
the predetermined line length.

This class is meant for text boxes in a game,
where messages might exceed the length of the
text box.

The parameter of the constructor is the maximum
length of each line.

Words that exceed the line length can cause
odd behavior.

Expects a monospaced font.
**********************************************/

class Logbook
{
  ArrayList<String> messages = new ArrayList<String>();
  int lineLength;
  int currentMessage;

  public Logbook( int lineLength )
  {
    this.lineLength = lineLength;
  }
  
  public void addMessage( String newText )
  {
    String buffer = ""; //holds the next word
    String textToAdd = ""; //the string that will be added to the log
    
    int i = 0; //progress parsing through string
    int quickFix = 0; //have to increse the condition on all but the first iteration. Hate it but I want this to start working now please.
    
    while( i < newText.length() ) //iterate through the message, cutting it into appropriately sized pieces
    {
      buffer += newText.charAt(i); //add next character to buffer
      i++;
      if( i == newText.length() || newText.charAt(i) == ' ' ) //reached a space or end of string //<>//
      {
        textToAdd += buffer + ""; //add buffer to current message line
        buffer = "";
      }
      if( textToAdd.length() != 0 && (buffer.length()+textToAdd.length()) == lineLength+quickFix ) //get line to pre-determined size, then add it to the messages
      {                                                                                             //quickFix used here
        if( textToAdd.equals("") ) //occurs if a large word is in the buffer
        {
          textToAdd = buffer.substring(0,lineLength);
          buffer = buffer.substring(lineLength);
        }
        while( textToAdd.charAt(0) == ' ' ) //shave off leading spaces
          textToAdd = textToAdd.substring(1);
        //println( textToAdd.length() + ": "+textToAdd );
        messages.add(textToAdd);
        textToAdd = buffer;
        buffer = "";
        if( quickFix < 1 ) quickFix = 1;
      }
    }
    if( i % lineLength != 0 ) //if we didn't just add...
    {
      while( textToAdd.length() > 0 && textToAdd.charAt(0) == ' ' ) //shave off leading spaces
        textToAdd = textToAdd.substring(1);
      messages.add(textToAdd); //add what's left over in the buffer
    }
  }
  
  public String message( int index )
  {
    if( index < messages.size() )
      return messages.get(index);
    else
      return "ERROR: Index out of bounds";
  }
  
  public String message() //prints the next string and increses the index
  {
    if( currentMessage < messages.size() )
    {
      currentMessage++;
      return messages.get(currentMessage-1);
    }
    return "NO MORE MESSAGES";
  }
  
  public int logSize()
  {
    return messages.size();
  }
  
  public boolean isEmpty()
  {
    if( messages.size() == currentMessage )
      return true;
    return false;
  }
}
