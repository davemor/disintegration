// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

class Particle {
  Body body;
  float r;
  color col;

  Particle(float x, float y, float r_, color c) {
    r = r_;
    col = c;
    makeBody(x, y, r);
    body.setUserData(this);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  void applyRandomImpulse() {
    float xImp = (random(-20.0, 20.0) - 5.0) * 10.0;
    float yImp = (random(-20.0, 2.0) - 5.0) * 10.0;
    body.applyLinearImpulse( new Vec2(xImp, yImp), body.getPosition(), true );
  }

  // 
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    fill(col);
    strokeWeight(r*2);
    stroke( col );
    point(pos.x, pos.y);
    popMatrix();
  }

  void makeBody(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;
    body.createFixture(fd);
    body.setAngularVelocity(random(-10, 10));
  }
}

