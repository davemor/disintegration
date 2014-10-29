// import the kinect library
import org.openkinect.*;
import org.openkinect.processing.*;

// import the physics libraray
import shiffman.box2d.*;

// declare the kinect
KinectTracker tracker;
Kinect kinect;

// declare the physics simulator
Box2DProcessing box2d;

// declare a list of particles
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(1280, 720);

  // initalise the kinect
  kinect = new Kinect(this);
  
  
  // initalise the tracker
  tracker = new KinectTracker();
  
  // initalise the physics library
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -100);

  // create the empty list
  particles = new ArrayList<Particle>();
}


void draw() {
  // update the simulation
  box2d.step();

  // clear the screen
  background(#585858);

  // 
  tracker.track();
  tracker.display();

  for (int i = particles.size ()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    if (p.done()) {
      particles.remove(i);
    }
  }

  timer ++;
  if (isRunning) {
    if (timer > SECONDS_TO_DROP) {
      disintegrate();
      isRunning = false;
      timer = 0;
    }
  } else {
    if (timer > SECONDS_TO_RESET) {
      reset();
      isRunning = true;
      timer = 0;
    }
  }
}



int SECONDS_TO_DROP = 10 * 60;
int SECONDS_TO_RESET = 1 * 60;

boolean isRunning = true;
int timer = 0;

void disintegrate() {
  particles = tracker.disintegrate();
  noStroke();
}
void reset() {
  tracker.reset();
}

void keyPressed() {
  int t = tracker.getThreshold();
  if (key == 'q') {
    tracker.pointSize += 1;
  } else if (key == 'a') {
    tracker.pointSize -= 1;
  } else if (key == 'w') {
    particles = tracker.disintegrate();
    noStroke();
  } else if (key == 'e') {
    t+=5;
    tracker.setThreshold(t);
  } else if (key == 'd') {
    t-=5;
    tracker.setThreshold(t);
  }
}

void stop() {
  tracker.quit();
  super.stop();
}

