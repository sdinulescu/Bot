public class Parser {
  private Tree tree = new Tree();
  private ArrayList<String> alphabet = new ArrayList<String>();

  private ArrayList<String> verbs = new ArrayList<String>();
  private ArrayList<String> nouns = new ArrayList<String>();
  private ArrayList<String> adjectives = new ArrayList<String>();
  private ArrayList<String> subjects = new ArrayList<String>();
  private ArrayList<String> names = new ArrayList<String>();
  private ArrayList<String> greetings = new ArrayList<String>();
  private ArrayList<String> possessions = new ArrayList<String>();
  
  private String word = "";
  private String sentence = "";
  
  ArrayList<String> getAlphabet() {
    return alphabet;
  }
  ArrayList<String> getVerbs() {
    return verbs;
  }
  ArrayList<String> getNouns() {
    return nouns;
  }
  ArrayList<String> getAdjectives() {
    return adjectives;
  }
  ArrayList<String> getSubjects() {
    return subjects;
  }
  ArrayList<String> getNames() {
    return names;
  }
  ArrayList<String> getGreetings() {
    return greetings;
  }
  ArrayList<String> getPossessions() {
    return possessions;
  }

  String handleQuestion(String sentence) {
    String s = sentence;
    if (sentence.charAt(sentence.length() - 1) == '?') { 
      s = s.substring(0, s.length() - 1);
      //println("new sentence: " + s);
    }
    s = s + " ";
    //println("new new sentence: " + s);
    return s;
  }

  void parse(String sentence) {
    String s = handleQuestion(sentence);
    for (int i = 0; i < s.length(); i++) { //parse through each character of the sentence
      if (s.charAt(i) != ' ') { //if it is a letter, store the word
        if ( s.charAt(i) != '.' && s.charAt(i) != ',' && s.charAt(i) != ';' && s.charAt(i) != ':' && s.charAt(i) != '#') { //handle symbols
          word = word + sentence.charAt(i);
        } else {
        }//do nothing, keep going
      } //concatinate the characters to form the word

      else if (  s.charAt(i) == ' '   ) {  //if the end of the word
        if (!alphabet.contains(word)) { //does the first dimension contain the word
          alphabet.add(word);
          Node n = new Node(word, 1);
          tree.addNodes(n);
          word = "";
        } else {
          //search through the tree
          for (int j = 0; j < tree.getNodes().size(); j++) {
            tree.getNodes().get(j).search(word);
          }
          word = "";
        }
      }
    }
  }

  void printTree() {
    for (int i = 0; i < tree.getNodes().size(); i++) 
    {
      println("node: " + tree.getNodes().get(i).getWord() + " " + tree.getNodes().get(i).getInstance() + " " + tree.getNodes().get(i).getType());
      for (int j = 0; j < tree.getNodes().get(i).getChildren().size(); j++) {
        tree.getNodes().get(i).listChildren(1);
      }
    }
  }

  void characterizeAlphabet(ArrayList<Node> n) {
    String str = "";
    for (int i = 0; i < n.size(); i++) {
      str = n.get(i).getWord();
      n.get(i).characterize(str);
      if (n.get(i).hasChildren() ) {
        for (int j = 0; j < n.get(i).getChildren().size(); j++) {
          characterizeAlphabet(n.get(i).getChildren());
        }
      }
    }
  }

  void train() {
    tree.eliminateEmpirical(0);
    tree.printProbabilities();
  }

  void respond() {
    sentence = tree.generate();
    println(sentence);
  }
 
}
