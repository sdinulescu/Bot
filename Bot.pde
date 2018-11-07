ArrayList<String> sentences = new ArrayList<String>();
Parser parser = new Parser();

void readFile() {
  String[] lines = loadStrings("text.txt"); //each line of text file becomes a slot in the array
  for (int i = 0; i < lines.length; i++) {
    sentences.add(lines[i]);
  }
}

void setup() {
  readFile();
  
  for ( int i = 0; i < sentences.size(); i++ ) {
    println(sentences.get(i));
  }
  
  train();
}

void train() {
  for (int i = 0; i < sentences.size(); i++) {
    parser.parse(sentences.get(i));
    parser.characterizeAlphabet(parser.tree.getNodes());
    println("-----------------------------------------------------");
  }
  parser.printTree();
  for (int i = 0; i < sentences.size(); i++) {
    parser.train();
  }

 println("-----------------------------------------------------");
  parser.respond();
}

void draw() {
  
}
