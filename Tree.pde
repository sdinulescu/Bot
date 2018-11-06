class Tree {
  private ArrayList<Node> nodes = new ArrayList<Node>();
  
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
      if (nodes.get(i).getWord() == null) {
        if (nodes.get(i).hasChildren()) {
          for (int a = 0; a < nodes.get(i).getChildren().size(); a++) {
            if (nodes.get(i).getChildren().get(a).getWord() == null) {
              nodes.get(i).getChildren().remove(a);
            }
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
  
  public String generate() {
    String sentence = "";
    float rand = random(0, 1);
    
    
    return sentence;
  }
  
}
