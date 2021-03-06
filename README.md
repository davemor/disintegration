Disintegration
==============

An interactive toy that uses the Kinect to track the players body and transform them into a grid of circles.  After a time, the circles transform into physics objects and the players body appears to fall apart under gravity.  

Made at [Tiree Tech Wave](http://tireetechwave.org/) with help from [Adam van Sertima](http://tag.hexagram.ca/people/adam-van-sertima/) from [TAG](http://tag.hexagram.ca/).  Built using [Processing](http://www.processing.org) and [Open Kinect](http://openkinect.org/wiki/Main_Page).  Makes use of [Daniel Shiffman](http://shiffman.net/)'s [Open Kinect](http://shiffman.net/p5/kinect/) and [Box2d](https://github.com/shiffman/Box2D-for-Processing) bindings for Processing.

There is a [video of the project](https://vimeo.com/110350416) on Vimeo.

Installation
------------
To install on OSX, download and install Processing from [here](https://processing.org/download/).

Install Homebrew using the instructions [here](http://brew.sh/).

Use Homebrew to install Open Kinect's [libfreenect](https://github.com/OpenKinect/libfreenect).

```
brew install libfreenect
```
Clone or download this repository (see the right hand sidebar on Github) and open the sketch in Processing by double clicking on the file called Disintegration.pde.

Install the Open Kinect and Box2d bindings for Processing by opening the Libraries Manager.  Inside Processing, open the menu:
```
Sketch -> Import Library -> Add Library
```
Install "Box2D for Processing" and "Open Kinect for Processing".

You should now be able to run the sketch using the run button in the top left of the Processing window.