
// Graphing sketch


// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return

// Created 20 Apr 2005
// Updated 18 Jan 2008
// by Tom Igoe
// This example code is in the public domain.

import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 124;         // bot horizontal position of the graph
int graphTop = 323;         // top horizontal position of the graph

void setup () {
  // set the window size:
  size(600, 400);        

  // List all the available serial ports
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[1], 9600);
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
    // you got the whole thing.  Put the numbers in the
    // color variables:
    if (bands.length >=14) {
      for ( int i=0; i < 14; i++) {
        // convert to an int and map to the screen height:
        bands[i] = map(bands[i], 0, 1023, 0, 255);
      }
    }


      // draw the line:
      stroke(127, 34, 255);
      strokeCap(SQUARE);
      strokeWeight(28);
      line(xPos, graphTop, xPos, graphTop - inByte);
      stroke(0, 0, 0);
      // strokeWeight(5);
      line(xPos, 49, xPos, graphTop - inByte);
    }
  }

