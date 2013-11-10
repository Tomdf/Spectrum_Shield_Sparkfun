// Sparkfun Spectrum Shield Okudagram Visulizer
// Written using Arduino IDE v1.0.5 and Processing v2.0.3 on Nov 3rd, 2013 by Tom Flock

// This code is a mash-up of the Arduino communication examples
// "Graph" and "Virtual Color Mixer" by Tom Igoe

// The program receives 14 byte ASCII-encoded string from a Sparfun Spectrum Shield connected to 
// the serial port at 115200 baud and graphs them on top of a static PNG image.
// The values of the string are comma seperated and terminated by a newline.

// This code is in the public domain and may be used, modified, mangled and/or maimed
// at your discretion with or without attribution.

import processing.serial.*;

Serial myPort;        // The serial port
int graphTop = 323;   // top horizontal position of the graph
int xPosLeft = 124;
int xPosRight = 350;

void setup () {
  // set the window size to match the PNG image:
  size(600, 400);        

  // List all the available serial ports
  println(Serial.list());
  // I know that the second port on my PC
  // is always my  Arduino, so I open Serial.list()[1].
  // You may need to change this whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[1], 115200);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  // set inital background:
  PImage img;
  img = loadImage("background.png");
  background(img);
}

void draw () {
  // everything happens in the serialEvent()
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // split the string on the commas and convert the
    // resulting substrings into an integer array:
    float[] bands = float(split(inString, ","));

    // if the array has at least fourteen elements, you know
    // you got the whole thing.  Map each of those bands
    // into a range equal to the pixel height of a bar:
    if (bands.length >=14) {
      for ( int i=0; i < 14; i++) {
        // convert to an int and map to the bar height:
        bands[i] = map(bands[i], 0, 1023, 0, 274);
      }
      for (int i=0; i < 7; i++) { 
        // set the bar attributes
        stroke(127, 34, 255);   // RGB values for the bar color
        strokeCap(SQUARE);      // puts a flat end on the stroke
        strokeWeight(28);       // set the line width to 28 pixels
        // draw the left channel lines (firstX, firstY, secondX, SecondY - sequential band values)
        line(xPosLeft, graphTop, xPosLeft, graphTop - bands[i]);
        // draw the second line. Did I not mention the second line?
        // well, every time the screen refreshes another line is drawn from
        // the top of the graph down to the height of the bar. 
        // this line is set to black to match the background and
        // is needed to erase, or rather draw over, the previously
        // drawn purple line. Without this the bars will look like
        // they are not moving.
        stroke(0, 0, 0);
        line(xPosLeft, 49, xPosLeft, graphTop - bands[i]);
        // move each of left channel bands over 29 pixels
        // when the eighth value is reached, start over at 124 pixels
        if (i < 6) {
          xPosLeft += 29;
        }
        else {
          xPosLeft = 124;
        }
      }
      // draw the right channel values
      for (int i=7; i < 14; i++) {
        // draw the line:
        stroke(127, 34, 255);
        strokeCap(SQUARE);
        strokeWeight(28);
        line(xPosRight, graphTop, xPosRight, graphTop - bands[i]);
        stroke(0, 0, 0);
        // strokeWeight(5);
        line(xPosRight, 49, xPosRight, graphTop - bands[i]);  
        if (i < 13) {
          xPosRight += 29;
        }
        else {
          xPosRight = 350;
        }
      }
    }
  }
}
