public class MarkovGenerator<E> {
  private ArrayList<String> alphabet = new ArrayList<String>(); //arrayList for alphabet for Markov Chain
  private ArrayList<Integer> instances = new ArrayList<Integer>(); //number of times each thing in the alphabet occurs
  private ArrayList<String> generatedMarkov = new ArrayList<String>(); //whatever is generated from the Markov Chain

  //double prob = 0.0;
  
  private float[][] probabilities;
  private int[][] transitionTable;
    
  MarkovGenerator() {}
  
  ArrayList<String> getGeneratedMarkov() { //getter for the arrayList of generated values
    return generatedMarkov;
  }
  
  void setAlphabet(ArrayList<String> a) { alphabet = a; }
  void setInstances(ArrayList<Integer> i) { instances = i; }
  
  ArrayList<String> getAlphabet() { return alphabet; }
  ArrayList<Integer> getInstances() { return instances; }
  
  void printAlphabetInstances() { //unit tests for alphabet and instances
    System.out.println("alphabet: " + alphabet);
    System.out.println("instances: " + instances);
  }
  
  void createTransitionTable(ArrayList<String> elements) { //creates the transition table (trains on what follows)
    //System.out.println(elements);
    transitionTable = new int[alphabet.size()][alphabet.size()];
    int number = 0; //counts how many times the a number comes after the other

    for (int i = 0; i < alphabet.size(); i++) {
      for (int j = 0;  j < alphabet.size(); j++) {
        for (int a = 0; a < elements.size() - 1; a++) { //searches through the whole input arrayList
          if ((String)alphabet.get(i) == (String)elements.get(a) && (String)alphabet.get(j) == (String)elements.get(a+1)) {
            //System.out.println("curr: " + elements.get(a) + " i: " + alphabet.get(i) + " next: " + elements.get(a+1) + " j: " + alphabet.get(j));
            number++; //increments depending on how many times a number comes after the other
            //System.out.println("number: " + number);
          } else {
          }
        }
        transitionTable[i][j] = number;
        number = 0;
      }
    }
  }
  
  void testTransitionTable() { //unit test for transition table
    for (int i = 0; i < alphabet.size(); i++) {
      for (int j = 0;  j < alphabet.size(); j++) {
        System.out.println("transition table " + i + " " + j + " : " + transitionTable[i][j]);
      }
    }
  }
  
  void calculateProbabilities() { //calculates probabilities to use in generate
    probabilities = new float[alphabet.size()][alphabet.size()];
    int lineTotal = 0; 
    
    for (int i = 0; i < alphabet.size(); i++) {
      for (int j = 0; j < alphabet.size(); j++) {
        lineTotal = lineTotal + transitionTable[i][j];
        //System.out.println("i = " + i + " j = " + j + " total = " + lineTotal);
      }
      for (int j = 0; j < alphabet.size(); j++) {
        if (lineTotal == 0) {
        } else {
          probabilities[i][j] = ((float)transitionTable[i][j] / lineTotal);
          //System.out.println("i = " + i + " j = " + j + " probabilities" + probabilities[i][j]);
        }
      }
      lineTotal = 0;
    }
  }
  
  void testProbabilities() { //unit test for probabilities
    for (int i = 0; i < alphabet.size(); i++) {
      for (int j = 0; j < alphabet.size(); j++) {
        System.out.println("probabilities " + i + " " + j + ": "+ probabilities[i][j]);
      }
    }
  }
  
  void train(ArrayList<String> elements, ArrayList<Integer> instances) { //train function
    setAlphabet(elements);
    setInstances(instances);
    createTransitionTable(alphabet);
    calculateProbabilities();
  }
  
  void testMarkov() { //unit test statement
    printAlphabetInstances();
    //NOTE: the following functions are commented out because their print outs take up a very large space in the output
    //testTransitionTable();
    //testProbabilities();
  }
  
  String findSeed() { //finds the seed to generate from in the Markov chain
    String mostCommonValue = "";
    int commCount = 0;
    for (int i = 0; i < instances.size()-1; i++) {
      if (instances.get(i) > commCount) {
        commCount = instances.get(i);
        println("commCount" + commCount);
      }
    }
    println(commCount);
    if (commCount == 0) { //if everything has the same instance, start from the first word
      mostCommonValue  = (String) alphabet.get(0);
    } else { //else, start from the word that is the most probable to occur
      mostCommonValue = (String) alphabet.get(instances.indexOf(commCount));
    }
    return mostCommonValue; //returns the seed to generate
  }
  
  void generate(E seed) { //generates based on the seed and probabilities calculated
    double prob = 0.0;
    double numMarkov = Math.random(); //random number generator
    
    if (alphabet.contains(seed)) {
      for (int j = 0; j < alphabet.size(); j++) {
        if (prob < numMarkov && numMarkov <= (prob + probabilities[alphabet.indexOf(seed)][j])) { //checks if random number generated is within the probability
          generatedMarkov.add(alphabet.get(j)); //adds to the generated arrayList based on probability
        } else {}
        prob = prob + probabilities[alphabet.indexOf(seed)][j]; //move on
      }
    }
  }
  
  void clearVals() {
    alphabet.clear();
    instances.clear();
    generatedMarkov.clear();
  }
}
