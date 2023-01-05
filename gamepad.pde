import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

ControlDevice stick;
ControlIO control;

float x;
float y;
float z;

void setup() {
  size(200, 200);
  
  x = 0;
  y = 0;
  z = 0;
  
  control = ControlIO.getInstance(this);
  stick = control.getMatchedDevice("stick");
  print(stick);
  
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
}

void draw() {
  getUserInput();
  //println(value);
}

public void getUserInput() {
  x = stick.getSlider("X").getValue();
  y = stick.getSlider("Y").getValue();
  z = stick.getSlider("Z").getValue();
  sendOsc();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(x); 
  msg.add(y);
  msg.add(z);
  oscP5.send(msg, dest);
}
