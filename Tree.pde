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
    String word = "";

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
    pickWord("subject");
   
    return sentence;
  }
  
}
