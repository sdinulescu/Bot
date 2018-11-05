ArrayList<String> sentences = new ArrayList<String>();
Parser parser = new Parser();

public static int L = 3; //L value
public static double pMin = 0.1;
public static int r = 2;
public static int countBack = 3;
public static int times = 2;
//public static double emptyContextProb = Math.random();
public static double g = 0.01; //for manually inputting
public static double gMaxRange; //gMaxRange is 1/N, which is calculated according to the tree

void setup() {
  sentences.add("Hello my name is Bob");
  sentences.add("How is it going?");
  sentences.add("What is your name?");
  sentences.add("Bob hopped over the lazy fox");
  sentences.add("Hello, is it too soon to say I'm sorry?");
  sentences.add("Tell me a story");
  
  useMarkov();
  //useTree();
}

void useMarkov() {
  for (int i = 0; i < sentences.size(); i++) {
    parser.parse(sentences.get(i));
    parser.characterizeAlphabet();
  }
}

//void useTree() {
//  for (int i = 0; i < sentences.size(); i++) {
//    parser.parseInTree(sentences.get(i));
//    parser.printTree();
//  }
//}

void draw() {
  //parser.respond();
}

//void testString(String input, int L, double pMin, int r) {
//  System.out.println(input);
//  Tree<String> treeStruct = new Tree<String>(); //creates tree structure for desired list
//  treeStruct.search(input, L); //searches through motives to create tree structure
//  System.out.println("Tree structure before elimination: ");
//  treeStruct.list();
//  System.out.println("-------------------------------------------------------");
//  treeStruct.eliminateEmpirical(input, pMin); //first step: eliminate empirical probabilities based on pMin
//  System.out.println("Tree structure after pMin elimination: ");
//  treeStruct.list();
//  System.out.println("-------------------------------------------------------");
//  System.out.println("Conditional Probability Elimination: ");
//  treeStruct.eliminateConditional(input, r);
//  System.out.println("Tree structure after r elimination: ");
//  treeStruct.list();
//  System.out.println("-------------------------------------------------------");
//  System.out.println("Probabilities for each next: ");
//  treeStruct.calcNextProbs(input);
//  treeStruct.printProbs();
//  System.out.println("-------------------------------------------------------");
//  System.out.println("Smoothing: ");
//  gMaxRange = calcNVal(input);
//  checkGVal(g);
//  treeStruct.implementSmoothing(g);
//  treeStruct.printProbs();
//  System.out.println("-------------------------------------------------------");
//  System.out.println("Generate: ");
//  treeStruct.generateString(L);
//  System.out.println("GeneratedString: " + treeStruct.getGeneratedString());
//  System.out.println("-------------------------------------------------------");
//  System.out.println("Check infinite looping problem: ");
//  treeStruct.infiniteLoop(countBack, times);
//  System.out.println("Final generated string: " + treeStruct.getGeneratedString());
//}

//public static void checkGVal(double g) {
//  if (g <= 0 || g >= gMaxRange) { //prompt user to pick another g value
//    System.out.println("g value is not within the range of 0 to 1 divided by the input string length. Please pick a value greater than 0 and less than " + gMaxRange);
//  }
//  return;
//}

//public static double calcNVal(String input) { //calculates g and N values for smoothing purposes
//  int N = 0; 
//  N = input.length();
//  double Nval = (double)1/N;
//  //System.out.println("1/N = " + Nval);
//  return Nval;
//}
