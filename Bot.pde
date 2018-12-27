/* Chatbot
 * Created by Stejara Dinulescu
 * Capstone Project 2018
*/


ArrayList<String> sentences = new ArrayList<String>();
ArrayList<String> responses = new ArrayList<String>();
Parser parser = new Parser();


//used for chatbot GUI, example referenced from http://learningprocessing.com/examples/chp18/example-18-01-userinput
PFont f;
// Variable to store text currently being typed
String typing = "";
// Variable to store saved text when return is hit
String saved = "";

String response = "";
int indent = 25;

int stringLoc = 130;
int trainCounter = 0;
int originalArrLength = 0;

String name;
boolean inputName = false;

void readFile() {
  //String[] lines = loadStrings("short.txt"); //each line of text file becomes a slot in the array
  //for (int i = 0; i < lines.length; i++) {
  //  sentences.add(lines[i]);
  //}
  
  sentences.add("Hello, my name is Rafael");
  sentences.add("Hello, how are you?");
  sentences.add("I like to eat pie");
  sentences.add("I like to eat burgers");
  sentences.add("I like to eat fries!");
  sentences.add("I enjoy drawing and reading books");
  sentences.add("I like the color blue");
  sentences.add("My favorite thing to do is eat food");
  sentences.add("The quick brown fox jumped over the lazy dog");
  sentences.add("I am 21 years old");
  sentences.add("The meaning of the universe is...... absolutely nothing......");
  originalArrLength = sentences.size();
}

void setup() {
  fullScreen();
  background(255);
  
  f = createFont("AmericanTypewriter", 16);
  readFile();
  
  //for ( int i = 0; i < sentences.size(); i++ ) {
  //  println(sentences.get(i));
  //}
  
}

boolean sampleQuestions(String sentence) {
  boolean answered = false;
  if ( sentence.contains("name")) {
    responses.add("Rafael");
    answered = true;
  } else if ( sentence.contains("hello") ) {
    responses.add("Hello! How are you?");
    answered = true;
  } else if (sentence.contains("how are you") ) {
    float r = random(0, 1);
    if (r >= 0 && r <= 0.4) {
    responses.add("I am really really sad.");
    } else if (r <= 0.6) {
      responses.add("I am doing great!!!");
    } else {
      responses.add("the meaning of the universe is absolutely nothing");
    }
  }
  
  return answered;
}

void train() {
  //characterize the alphabet
  //println("characterize");
  if (trainCounter == 0) {
    for (int i = 0; i < sentences.size(); i++) {
      parser.parse(sentences.get(i));
      parser.characterizeAlphabet(parser.tree.getNodes());
    }
  } else {
    for (int i = originalArrLength; i < sentences.size(); i++) {
      parser.parse(sentences.get(i));
      parser.characterizeAlphabet(parser.tree.getNodes());
    }
  }
  //println("-----------------------------------------------------");
  //println("print the tree");
  //parser.printTree();
  //println("-----------------------------------------------------");
  //println("train");
  parser.train();
  //if (trainCounter == 0) {
  //  for (int i = 0; i < sentences.size(); i++) {
  //    parser.train();
  //  }
  //} else {
  //  for (int i = originalArrLength; i < sentences.size(); i++) {
  //    parser.train();
  //  }
  //}
 //println("-----------------------------------------------------");
 //println("done training");
 trainCounter++;
}

void draw() {
  // Set the font and fill for text
  textFont(f);
  fill(0, 150);
  
  // Display everything
  if (inputName == false) {
    background(255);
    textAlign(LEFT);
    text("What is your name? " + typing, indent, 40);
  } else {
    background(255);
    textAlign(LEFT);
    text("Hello " + name + "!", indent, 40);
    text("Ask me anything, then hit enter... ", indent, 70);
    int pos = 130;
    int secPos = 130;
    //text(name + ": " + typing, indent, secPos);
    for (int i = 0; i < responses.size(); i++) {
      if (stringLoc + (i*50) > width - 80) {
        background(255);
        for (int j = responses.size() - 3; j >= 0; j--) {
          responses.remove(j);
        }
        //responses.clear();
      } else {
        pos = stringLoc + (i*30);
        secPos = stringLoc + (i+1)*30;
        text(responses.get(i), indent, pos);
      }
    }
    text(name + ": " + typing, indent, secPos);
  }
  
  //text("Saved text: " + saved,indent,230);
}

void keyPressed() {
  if (key == CODED && keyCode == SHIFT) { } else {
  // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      typing = typing.toLowerCase();
      //println(typing);
      saved = typing;
      // A String can be cleared by setting it equal to ""
      typing = ""; 
      if (inputName == true) { //if name has been put in, time for bot to respond to input...
        sentences.add(saved);
        responses.add(name + ": " + saved);
        if (sampleQuestions(saved) == false) {
          train();
          response = "";
          response = parser.respond();
          responses.add(response);
        }
      } else { //if name hasn't been put in yet...
        name = saved;
        inputName = true;
      }
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable
      typing = typing + key; 
    }
  }
}
