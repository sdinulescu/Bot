ArrayList<String> sentences = new ArrayList<String>();
Parser parser = new Parser();

void setup() {
  sentences.add("Hello my name is Bob");
  sentences.add("How is it going?");
  sentences.add("What is your name?");
  sentences.add("Bob hopped over the lazy fox");
  sentences.add("Hello, is it too soon to say I'm sorry?");
  sentences.add("Tell me a story");
  
  train();
}

void train() {
  for (int i = 0; i < sentences.size(); i++) {
    parser.parse(sentences.get(i));
    parser.characterizeAlphabet();
    println("--------------------");
  }
  parser.printTree();
  for (int i = 0; i < sentences.size(); i++) {
    parser.train();
  }
  
}

void draw() {
  //parser.respond();
}
