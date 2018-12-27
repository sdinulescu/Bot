class Tree {
  private ArrayList<Node> nodes = new ArrayList<Node>();
  
  String sentence = "";
  
  Tree() {}
  
  void addNodes(Node n) {
    nodes.add(n);
  }
  
  ArrayList<Node> getNodes() {
    return nodes;
  }
  
  void eliminateEmpirical(double pMinValue) { //eliminates nodes based on pMin Value
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).calculateEmpProbs(nodes.get(i).getWord(), nodes.size(), pMinValue); //calls the calculate probability function in node class
    }
    for (int i = 0; i < nodes.size(); i++) { //removes null values from tree structure
      if (nodes.get(i).getWord().equals("") ) {
        //remove its children first
        if (nodes.get(i).hasChildren()) {
          for (int a = 0; a < nodes.get(i).getChildren().size(); a++) {
            //if (nodes.get(i).getChildren().get(a).getWord().equals("") ) {
              nodes.get(i).getChildren().remove(a);
            //}
          }
        }
        nodes.remove(i);
      }
    }
  }
  
  void printProbabilities() {
    for (int i = 0; i < nodes.size(); i++) {
      nodes.get(i).printProbabilities();
    }
  }
  
  void implementSmoothing(double gVal) { //implements smoothing
    for (int i = 0; i < nodes.get(i).getChildren().size(); i++) {
      nodes.get(i).getChildren().get(i).calcSmoothing(gVal);
      if (nodes.get(i).getChildren().get(i).hasChildren()) {
        for (int j = 0; j < nodes.get(i).getChildren().get(i).getChildren().size(); j++) {
          nodes.get(i).getChildren().get(i).getChildren().get(j).calcSmoothing(gVal);
        }
      }
    }
  }
  

  
  public void pickWord(String tense) {
    float rand = random(0, 0.1);
    for(int i = 0; i < nodes.size() - 1; i++) {
      if (  nodes.get(i).getType().equals(tense) && ( nodes.get(i).getEmpiricalProbability() < rand && rand < nodes.get(i+1).getEmpiricalProbability() )  ) {
        sentence = sentence + nodes.get(i).getWord() + " ";
        //println("word " + word);
      }
    }
  }
  
  public String generate() {
    sentence = "";
    String word = "";
    int r = (int)random(0, 3);
    
    switch(r) {
      case 0:  //normal subject verb
        //generate subject
        pickWord("name");
        if (word.equals("")) {
          pickWord("subject");
        }
        //sentence = sentence + word + " ";
        //generate verb
        pickWord("verb");
        //generate rest of sentence
        pickWord("adjective");
        pickWord("noun");
        break;
      case 1: //make a gerund phrase
        pickWord("verb");
        if (sentence.length() != 0 ){
        sentence = sentence.substring(0, sentence.length() - 1);
        sentence = sentence + "ing ";
        }
        pickWord("adjective");
        pickWord("subject"); 
        pickWord("noun");
        break;
      case 2:
        pickWord("subject");
        pickWord("verb");
        break;
      case 3:
        pickWord("other");
        pickWord("subject");
        pickWord("adjective");
        pickWord("verb");
        break;
    }
        
    
    
    
   
    return sentence;
  }
  
}
