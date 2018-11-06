public class Parser {
  private Tree tree = new Tree();
  private ArrayList<String> alphabet = new ArrayList<String>();
  private ArrayList<Integer> generatedMarkov = new ArrayList<Integer>();

  private ArrayList<String> verbs = new ArrayList<String>();
  private ArrayList<String> nouns = new ArrayList<String>();
  private ArrayList<String> adjectives = new ArrayList<String>();
  private ArrayList<String> subjects = new ArrayList<String>();
  private ArrayList<String> names = new ArrayList<String>();
  private ArrayList<String> greetings = new ArrayList<String>();
  private ArrayList<String> possessions = new ArrayList<String>();
  private String word = "";

  MarkovGenerator mg = new MarkovGenerator();

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
      println("node: " + tree.getNodes().get(i).getWord() + " " + tree.getNodes().get(i).getInstance());
      for (int j = 0; j < tree.getNodes().get(i).getChildren().size(); j++) {
        tree.getNodes().get(i).listChildren(1);
      }
    }
    println(alphabet);
  }

  void characterizeAlphabet() {
    for (int i = 0; i < tree.getNodes().size(); i++) {
      
    }
    for (String str : alphabet) {
      if (isGreeting(str)) { 
        greetings.add(str);
        println("greeting: " + str );
      } else if (isSubject(str)) {  
        subjects.add(str);  
        println("subject: " + str );
      } else if (isName(str)) { 
        names.add(str); 
        println("name: " + str );
      } else if (isPossesive(str)) { 
        possessions.add(str); 
        println("possessive: " + str );
      } else if (isNoun(str)) {  
        nouns.add(str);  
        println("noun: " + str );
      } else if (isVerb(str)) {  
        verbs.add(str);  
        println("verb: " + str );
      } else if (isAdjective(str)) {  
        adjectives.add(str);  
        println("adjective: " + str );
      } else if (isOther(str)) { 
        println("other: " + str );
      }
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
    if ( word.equals("my") || word.equals("hers") || word.equals("his") || word.equals("theirs") ) { 
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
    if ( Character.isUpperCase(  word.charAt(0)  ) == true && word.length() > 0 &&  isGreeting(word) == false ) { 
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

  boolean isOther( String word ) {
    if (  !isVerb(word) && !isNoun(word) && !isAdjective(word) && !isSubject(word)  ) {  
      return true;
    } else {  
      return false;
    }
  }
  
  void train() {
    tree.eliminateEmpirical(0.05);
    println("-----------------------------------------------------");
    tree.printProbabilities();
  }

  void respond() {
    
  }
  
  void useMarkov() {
    //mg.train(alphabet, instances);
    //mg.testMarkov();
    //String seed = mg.findSeed();
    //println(seed);
    //mg.generate(seed);
    //generatedMarkov = mg.getGeneratedMarkov();
    //println(generatedMarkov);
  }
}
