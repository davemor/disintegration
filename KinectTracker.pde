// this defines an array of colors to
// cycle though when drawing the dots
color [] colors = {
  #FADD72, 
  #FA7872, 
  #EEFA72, 
  #FA72B1, 
  #72FAB0
};

class KinectTracker {
  // pointSize defines the size of the dots in pixels
  // changing it effectively changes the resolution
  // of the image
  public int pointSize = 19;

  // size of kinect image
  int kw = 640;
  int kh = 480;
  int threshold = 830;

  PVector loc;
  PVector lerpedLoc;
  int[] depth;

  PImage display;

  KinectTracker() {
    kinect.start();
    kinect.enableDepth(true);

    kinect.processDepthImage(true);

    display = createImage(kw, kh, PConstants.RGB);

    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
  }

  void track() {
    depth = kinect.getRawDepth();
    if (depth == null) return;
    float sumX = 0;
    float sumY = 0;
    float count = 0;
    for (int x = 0; x < kw; x++) {
      for (int y = 0; y < kh; y++) {
        int offset = kw-x-1+y*kw;
        int rawDepth = depth[offset];
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    if (count != 0) {
      loc = new PVector(sumX/count, sumY/count);
    }
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }

  PVector getPos() {
    return loc;
  }

  PImage img;

  void display() {
    if (isDrawing) {

      PImage img = kinect.getDepthImage();

      stroke(#FF7B74);
      strokeWeight(pointSize * scale);

      int colorIdx = 0;

      for (int x = 0; x < kw; x++) {
        for (int y = 0; y < kh; y++) {
          colorIdx ++;
          colorIdx %= colors.length;

          if ( x % pointSize == 0 && y % pointSize == 0 ) {

            // mirroring image
            int offset = kw-x-1+y*kw;

            // Raw depth
            int rawDepth = depth[offset];

            if (rawDepth < threshold) {

              strokeWeight(pointSize * ((noise(x, y)+0.3)));
              stroke( colors[colorIdx] );
              point(xOffset + x * scale, y * scale);
            }
          }
        }
      }
    }
  }

  void reset() {
    isDrawing = true;
  }

  boolean isDrawing = true;

  ArrayList<Particle> disintegrate() {
    isDrawing = false;
    ArrayList<Particle> rtn = new ArrayList<Particle>();

    int colorIdx = 0;
    for (int x = 0; x < kw; x++) {
      for (int y = 0; y < kh; y++) {
        colorIdx ++;
        colorIdx %= colors.length;

        if ( x % pointSize == 0 && y % pointSize == 0 ) {
          int offset = kw-x-1+y*kw;
          int rawDepth = depth[offset];
          
          if (rawDepth < threshold) {
            float pSize = pointSize * (noise(x, y)+0.3) * 0.5;
            Particle p = new Particle(xOffset + x * scale, y * scale, pSize, colors[colorIdx]);
            rtn.add(p);
            p.applyRandomImpulse();
          }
        }
      }
    }
    return rtn;
  }

  float xOffset = 150.0;
  float scale = 1.5;

  void quit() {
    kinect.quit();
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}

