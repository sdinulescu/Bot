public class Parser {
  
  //TO DO: use a 2D ArrayList?
  //private Tree<String> tree = new Tree<String>();
  private ArrayList<String> alphabet = new ArrayList<String>();
  private ArrayList<Integer> instances = new ArrayList<Integer>();
  private ArrayList<Integer> generatedMarkov = new ArrayList<Integer>();
  
  private ArrayList<String> verbs = new ArrayList<String>();
  private ArrayList<String> nouns = new ArrayList<String>();
  private ArrayList<String> adjectives = new ArrayList<String>();
  private ArrayList<String> subjects = new ArrayList<String>();
  private ArrayList<String> names = new ArrayList<String>();
  private ArrayList<String> greetings = new ArrayList<String>();
  private ArrayList<String> possessions = new ArrayList<String>();
  private String word = "";
  private boolean isQuestion = false;
  
  MarkovGenerator mg = new MarkovGenerator();
  
  void parse(String sentence) {
    isQuestion = false;
    if (sentence.charAt(sentence.length() - 1) == '?') { 
      isQuestion = true; 
      sentence = sentence.substring(0, sentence.length() - 1);
      println("new sentence: " + sentence);
    }
    sentence = sentence + " ";
    println("new new sentence: " + sentence);
    for (int i = 0; i < sentence.length(); i++) { //parse through the sentence
      if (sentence.charAt(i) != ' ') {
        if ( sentence.charAt(i) != '.' && sentence.charAt(i) != ',' && sentence.charAt(i) != ';' && sentence.charAt(i) != ':' && sentence.charAt(i) != '#') {
          word = word + sentence.charAt(i);
        } else { //do nothing, keep going
          //if (sentence.charAt(i) == '?') {
          //  isQuestion = true;
          //  println("is it a question? " + isQuestion);
          //  //don't add it to the word
          //}
        }
      } //concatinate the characters to form the word
      
      if (  sentence.charAt(i) == ' '   ){  
        //println(word);
        if (!alphabet.contains(word)) {
          alphabet.add(word); 
          println("added: " + word);
          instances.add(1);
          word = "";  
        } else { 
          instances.set(alphabet.indexOf(word), instances.get(alphabet.indexOf(word)) + 1);
          word = "";
        }
      }
    }
    println("alphabet: " + alphabet);
  }
  
  String handleQuestion(String sentence) {
    String s = sentence;
    isQuestion = false;
    if (sentence.charAt(sentence.length() - 1) == '?') { 
      isQuestion = true; 
      s = s.substring(0, s.length() - 1);
      println("new sentence: " + s);
    }
    s = s + " ";
    println("new new sentence: " + s);
    return s;
  }
  
  void characterizeAlphabet() {
    for (String str : alphabet) {
      if (isGreeting(str)) { greetings.add(str); println("greeting: " + str ); }
      else if (isSubject(str)) {  subjects.add(str);  println("subject: " + str ); }
      else if (isName(str)) { names.add(str); println("name: " + str ); }
      else if (isPossesive(str)) { possessions.add(str); println("possessive: " + str ); }
      else if (isNoun(str)) {  nouns.add(str);  println("noun: " + str ); }
      else if (isVerb(str)) {  verbs.add(str);  println("verb: " + str ); }
      else if (isAdjective(str)) {  adjectives.add(str);  println("adjective: " + str ); }
      else if (isOther(str)) { println("other: " + str ); }
    }
  }
  
  boolean isSubject( String word ) {
    if (  word.equals("I") || word.equals("she") || word.equals("he") || word.equals("they")  ) {  return true;  }
    else {  return false;  }
  }
  
  boolean isPossesive( String word ) {
    if ( word.equals("my") || word.equals("hers") || word.equals("his") || word.equals("theirs") ) { return true; }
    else { return false; }
  }
  
  boolean isNoun( String word ) {
    if (  isVerb( word)  == false ) { return true; }
    else { return false; }
  }
 
  boolean isVerb( String word ) {
    if ( word.equals("is") || word.equals("are") || word.equals("am") ) {  return true;  }
    if ( word.contains("ing") ) { return true; }
    //if (  ( word != alphabet.get(0) ) && !isNoun( word )  ) {  return true;  } //if it is not the first word or if it is not a noun, then it is a verb
    else { return false; }
  }
  
  boolean isAdjective( String word ) {
    if ( isNoun( word ) == false && isVerb( word ) == false ) { return true; }
    else { return false;  }
  } 
  
  boolean isName( String word ) {
    if ( Character.isUpperCase(  word.charAt(0)  ) == true && word.length() > 0 &&  isGreeting(word) == false ) { return true; }
    else { return false; }
  }
  
  boolean isGreeting( String word ) {
    String w = word.toLowerCase();
    if ( w.equals("hello") || w.equals("hi") || w.contains("good") ) { return true; }
    else { return false; }
  }
  
  boolean isOther( String word ) {
    if (  !isVerb(word) && !isNoun(word) && !isAdjective(word) && !isSubject(word)  ) {  return true;  } 
    else {  return false;  }
  }
  
  void respond() {
    mg.train(alphabet, instances);
    mg.testMarkov();
    String seed = mg.findSeed();
    println(seed);
    mg.generate(seed);
    generatedMarkov = mg.getGeneratedMarkov();
    println(generatedMarkov);
  }
 
}
