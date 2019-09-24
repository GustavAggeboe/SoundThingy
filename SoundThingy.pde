/**
 * REALLY simple processing sketch for using webcam input
 * This sends 100 input values to port 6448 using message /wek/inputs
 **/

import processing.video.*;
import processing.sound.*;
import oscP5.*;
import netP5.*;

int numPixelsOrig;
int numPixels;

int boxWidth = 64;
int boxHeight = 48;

int windowWidth = 1280;
int windowHeight = 960;

int numHoriz = windowWidth/boxWidth;
int numVert = windowHeight/boxHeight;

float[] grayedPixels = new float[numHoriz * numVert];

Capture video;

OscP5 oscP5;
NetAddress dest;
WekControl wekc;
SinOsc sine;

void setup() {
  // colorMode(HSB);
  size(1280, 960, P2D);

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    video = new Capture(this, 1280, 960);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    /* println("Available cameras:");
     for (int i = 0; i < cameras.length; i++) {
     println(cameras[i]);
     } */

    video = new Capture(this, 1280, 960);

    // Start capturing the images from the camera
    video.start();

    numPixelsOrig = video.width * video.height;
    loadPixels();
    noStroke();
  }

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6448);
  wekc = new WekControl(oscP5, dest);

  int[] outputNrs = new int[200];
  for (int i = 1; i <= outputNrs.length; i++) {
    outputNrs[i-1] = i;
  }
  wekc.selectInputsForOutput(1, outputNrs);
  for (int i = 201; i <= outputNrs.length * 2; i++) {
    outputNrs[i-201] = i;
  }
  wekc.selectInputsForOutput(2, outputNrs);


  sine = new SinOsc(this);
  sine.play();
}

void draw() {



  if (video.available() == true) {
    video.read();

    video.loadPixels(); // Make the pixels of video available

    int boxNum = 0;
    int tot = boxWidth*boxHeight;
    for (int x = 0; x < windowWidth; x += boxWidth) {
      for (int y = 0; y < windowHeight; y += boxHeight) {
        float red = 0, green = 0, blue = 0;

        for (int i = 0; i < boxWidth; i++) {
          for (int j = 0; j < boxHeight; j++) {
            int index = (x + i) + (y + j) * windowWidth;
            red += red(video.pixels[index]);
            green += green(video.pixels[index]);
            blue += blue(video.pixels[index]);
          }
        }

        grayedPixels[boxNum] = (red / tot + green / tot + blue / tot) / 3f;
        fill(grayedPixels[boxNum]);

        int index = x + windowWidth*y;
        red += red(video.pixels[index]);
        green += green(video.pixels[index]);
        blue += blue(video.pixels[index]);
        rect(width - boxWidth - x, y, boxWidth, boxHeight);

        // Output nr
        fill(255, 100, 0);
        textAlign(CENTER);
        text(boxNum + 1, width - (x + boxWidth / 2), y + boxHeight / 2);

        boxNum++;
      }
    }
    if (frameCount % 2 == 0) {
      sendOsc(grayedPixels);
    }

    fill(0);
    text("Sending 100 inputs to port 6448 using message /wek/inputs", 10, 10);
  }
}


/*
      C (659.25 hz)
 g (783.99 hz)
 c (1046.50 hz)
 d (1174.66 hz)
 e (1318.51 hz)
 */

void oscEvent(OscMessage theMsg) {
  if (theMsg.get(0).floatValue() == 1) {
    sine.freq(0);
  }
  if (theMsg.get(0).floatValue() == 2) {
    sine.freq(659.25);
  }
  if (theMsg.get(0).floatValue() == 3) {
    sine.freq(783.99);
  }
  if (theMsg.get(0).floatValue() == 4) {
    sine.freq(1046.50);
  }
  if (theMsg.get(0).floatValue() == 5) {
    sine.freq(1174.66);
  }
  if (theMsg.get(0).floatValue() == 6) {
    sine.freq(1318.51);
  }
}


float diff(int p, int off) {
  if (p + off < 0 || p + off >= numPixels)
    return 0;
  return red(video.pixels[p+off]) - red(video.pixels[p]) +
    green(video.pixels[p+off]) - green(video.pixels[p]) +
    blue(video.pixels[p+off]) - blue(video.pixels[p]);
}

void sendOsc(float[] px) {
  OscMessage msg = new OscMessage("/wek/inputs");
  // msg.add(px);
  for (int i = 0; i < px.length; i++) {
    msg.add(px[i]);
  }
  oscP5.send(msg, dest);
}
