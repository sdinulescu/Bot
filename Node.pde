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

  String getWord() {
    return word;
  }

  int getInstance() {
    return instance;
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
    println(word + " " + instance);
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
  
  public float calculateEmpProbs(String input, float total, double pMinValue) { //calculates and sets empirical probability for each node
    println("total: " + total);
    println("instance: " + instance + " word: " + word);
    float empProb = instance/total; //calculates empirical probability
    println("empProb: " + empProb);
    //System.out.println(getString() + " " + empProb);
    if (empProb < pMinValue && word!="") { //handles base case, removes node if probability is below pMin cutoff
      //System.out.println("Remove " + getString());
      //set all attributes to null
      empProb = 0.0;
      word = null;
      instance = 0;
      int index = 0;
      while (word == null && index < children.size()) { //if a motive is null, remove the children
        children.remove(index);
        //node = null; //should remove null? How do I delete the single node within this class?
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
 
  public void printProbabilities() {
    println(word + ": " + empiricalProbability);
    if (hasChildren()) {
      println("children: " + word + " " + childrenProbabilities);
    }
  }
  

//  public String generate(String curr, ArrayList<Character> singleMotives, int lvalue) { //generate string in PST node class based on probability
//    double rand = 0.0;
//    double prob = 0;
//    double nextProb = 0;
//    boolean found = false;
//    //takes in a string as input to decide on probabilities
//    //look backwards in generated string
//    String generatedStr = ""; //instantiate generatedString
//    if (curr.equals(stringMotives)) { //if the input equals the stringMotive
//      found = true;
//      //System.out.println("Found");
//      nextProb = nextProbs.get(0);
//      //calculate based on probability what comes next
//      rand = Math.random(); //generates random number
//      for (int i = 0; i < nextProbs.size() - 1; i++) { //check probability ranges
////        System.out.println("Prob: " + prob + " Rand: " + rand + " nextProb: " + nextProb); //probability ranges
//        if (prob < rand && rand < nextProb) {
//          generatedStr = singleMotives.get(i) + "";
////          System.out.println("Char added: " + generatedStr);
//          return generatedStr;
//        } else { 
//          prob = nextProbs.get(i);
//          nextProb = nextProb + nextProbs.get(i+1);
//        }
//      } 
//    } else { //search through children until it is found
//      int index = 0;
//      while (!found && index < children.size()) {
////        System.out.println("Not found");
//        children.get(index).generate(curr, singleMotives, lvalue); //search children
//        index++;
//      }
//      if (found) { 
//        //System.out.println("HELLLLLOOOOOOOOO"); 
//        return  generatedStr;   
//      }
//      else { 
//        //System.out.println("Generating from empty"); 
//        return "";  
//      }
//    }
//    return generatedStr;
//  }


  
}
