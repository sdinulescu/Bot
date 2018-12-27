class Node {
  //attributes of a node
  private String word;
  private String type;
  private int instance;
  
  private ArrayList<Node> children = new ArrayList<Node>();
  private ArrayList<Float> childrenProbabilities = new ArrayList<Float>(); //holds probabilities of what follows the node

  
  //Node child = this;
  
  //probability calcs
  private float empiricalProbability; //stores empirical probability


  Node(String w, int i) {
    word = w;
    instance = i;
  }
  
  void setType(String t) {
    type = t;
  }
  
  String getWord() {
    return word;
  }

  int getInstance() {
    return instance;
  }
  
  String getType() {
    return type;
  }

  void incrementInstance() {
    instance++;
  }
  
  float getEmpiricalProbability() {
    return empiricalProbability;
  }
  
  ArrayList<Float> getChildrenProbabilities() {
    return childrenProbabilities;
  }

  public ArrayList<Node> getChildren() { //gets the arrayList pertaining to that motive
    return children;
  }

  public boolean hasChildren() {
    if (children.size() != 0) {
      return true;
    } else { 
      return false;
    }
  }

  public void listChildren(int level) {
    print("children: ");
    println(word + " " + instance + " " + type);
    for (int i = 0; i < children.size(); i++) {
      children.get(i).listChildren(level+1);
    }
  }

  public void addChild(String w, int i) {
    children.add(new Node(w, i));
  }

  public boolean search(String input) {
    if (word.equals(input)) {
      instance++;
      return true;
    } else {
      int index = 0;
      boolean found = false;
      while (!found && index < children.size()) { //searches through children
        found = children.get(index).search(input); 
        index++;
      }
      if (found == false) { //add if node hasn't been found
        addChild(input, 1);
        return true;
      } else { 
        return true; 
      }
    } 
  }
  
  void characterize(String str) {
    str = word;
    if (isGreeting(str)) { 
      //greetings.add(str);
      type = "greeting";
      //println("greeting: " + str);
    } else if (isSubject(str)) {  
      type = "subject";
      //println("subject: " + str );
    } else if (isName(str)) { 
      type = "name";
      //println("name: " + str );
    } else if (isPossesive(str)) { 
      type = "possessive";
      //println("possessive: " + str );
    } else if (isNoun(str)) {  
      type = "noun";
      //println("noun: " + str );
    } else if (isVerb(str)) {  
      type = "verb";
      //println("verb: " + str );
    } else if (isAdjective(str)) {  
      type = "adjective";
      //println("adjective: " + str );
    } else { 
      type = "other";
      //println("other: " + str );
    }
    
  }
  
  boolean isSubject( String word ) {
    if (  word.equals("I") || word.equals("she") || word.equals("he") || word.equals("they")  ) {  
      return true;
    } else {  
      return false;
    }
  }

  boolean isPossesive( String word ) {
    if ( word.equals("my") || word.equals("hers") || word.equals("his") || word.equals("theirs") || word.equals("mine") || word.equals("yours") ) { 
      return true;
    } else { 
      return false;
    }
  }

  boolean isNoun( String word ) {
    if (  isVerb( word)  == false ) { 
      return true;
    } else { 
      return false;
    }
  }

  boolean isVerb( String word ) {
    if ( word.equals("is") || word.equals("are") || word.equals("am") ) {  
      return true;
    }
    if ( word.contains("ing") ) { 
      return true;
    }
    if ( word.length() > 2 && word.substring(word.length()-2, word.length()).equals("ed") ) {
      return true;
    } 
    //if (  ( word != alphabet.get(0) ) && !isNoun( word )  ) {  return true;  } //if it is not the first word or if it is not a noun, then it is a verb
    else { 
      return false;
    }
  }

  boolean isAdjective( String word ) {
    if ( isNoun( word ) == false && isVerb( word ) == false ) { 
      return true;
    } else { 
      return false;
    }
  } 

  boolean isName( String word ) {
    if ( word.length() > 0 && Character.isUpperCase(  word.charAt(0)  ) == true && word.length() > 0 &&  isGreeting(word) == false ) { 
      return true;
    } else { 
      return false;
    }
  }

  boolean isGreeting( String word ) {
    String w = word.toLowerCase();
    if ( w.equals("hello") || w.equals("hi") || w.contains("good") ) { 
      return true;
    } else { 
      return false;
    }
  }
  
  public float calculateEmpProbs(String input, float total, double pMinValue) { //calculates and sets empirical probability for each node
    //println("total: " + total);
    //println("instance: " + instance + " word: " + word);
    float empProb = instance/total; //calculates empirical probability
    //println("empProb: " + empProb);
    //System.out.println(getString() + " " + empProb);
    if (empProb < pMinValue && word!="") { //handles base case, removes node if probability is below pMin cutoff
      //System.out.println("Remove " + getString());
      //set all attributes to null
      empProb = 0.0;
      word = "";
      instance = 0;
      int index = 0;
      while (word.equals("") && index < children.size()) { //if a motive is null, remove the children
        children.remove(index);
      }
    } else { 
      empiricalProbability = empProb; 
    }
    
    for (int i = 0; i < children.size(); i++) { //do this for children as well
      float f = children.get(i).calculateEmpProbs(input, total, pMinValue);
      childrenProbabilities.add(f);
    }
    
    return empProb;
  }
  
  public void calcSmoothing(double gval) { //smoothing algorithm
    //System.out.println(getNextProbs());
    for (int i = 0; i < childrenProbabilities.size(); i++) {
      childrenProbabilities.set(i, (float)((1 - (gval * instance))* childrenProbabilities.get(i) + gval)) ;
    }
    //System.out.println("New probs: " + nextProbs);
  }
 
  public void printProbabilities() {
    println(word + ": " + empiricalProbability);
    if (hasChildren()) {
      println("children: " + word + " " + childrenProbabilities);
    }
  }
 
}
