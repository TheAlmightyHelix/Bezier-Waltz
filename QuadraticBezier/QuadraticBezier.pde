// @Author Yuheng Chen
// Inspired by Ben Orozco

// Parameters

//float lineWeight = 3;
//float duration = 5.0;
//float refreshRate = 30;
//Point p0 = new Point(100, 600);
//Point p1 = new Point(900, 700);
//Point p2 = new Point(1200, 200);

float lineWeight = 5;
float duration = 3.0;
float refreshRate = 144;
Point p0 = new Point(50, 240);
Point p1 = new Point(400, 120);
Point p2 = new Point(900, 700);

// Objects
ArrayList<Point> bezCurve = new ArrayList<Point>();


void setup(){
  //size(500,500);
  fullScreen();
}

void draw(){
  animationLength(duration,refreshRate);
  println(frameCount);

  // Geometry
  float t = frameCount/(duration*refreshRate);
  Point b1 = bez(p0, p1, t);
  Point b2 = bez(p1, p2, t);
  Point b = bez(b1, b2, t);
  bezCurve.add(b);

  // Background
  fill(0,200);
  noStroke();
  rect(0,0,width,height);

  // Line segments P0P1 and P1P2
  stroke(#777777);
  strokeWeight(lineWeight);
  line(p0.x, p0.y, p1.x, p1.y);
  line(p1.x, p1.y, p2.x, p2.y);

  // Draws the set of points so far on the curve
  stroke(#ff99cc);
  for(Point p : bezCurve) 
    ellipse(p.x, p.y, lineWeight, lineWeight);
  // The line formed by b1 and b2
  stroke(#ff9933);
  line(b1.x, b1.y, b2.x, b2.y);
  // Control points B1, B2 and resulting point B on the curve
  noStroke();
  fill(#ff007f);
  ellipse(b1.x, b1.y, lineWeight * 2, lineWeight * 2);
  ellipse(b2.x, b2.y, lineWeight * 2, lineWeight * 2);
  fill(#ffff66);
  ellipse(b.x, b.y, lineWeight * 2, lineWeight * 2);

  // Control points P0, P1, P2
  fill(#cc0000);
  ellipse(p0.x, p0.y, lineWeight *2 , lineWeight * 2);
  fill(#80ff00);
  ellipse(p1.x, p1.y, lineWeight * 2, lineWeight * 2);
  fill(#3399ff);
  ellipse(p2.x, p2.y, lineWeight * 2, lineWeight * 2);
}

// HELPER METHODS
// Sets the duration(seconds) and refresh rate(fps) of the animation
void animationLength(float duration, float refreshRate){
  frameRate(refreshRate);
  if (frameCount >= duration * refreshRate) {
    frameCount = 0;
    bezCurve = new ArrayList<Point>();
    
  }
}

// Generates a point on Bezier curve with control points a, b at given time
Point bez(Point a, Point b, float time){
  float x = (b.x - a.x) * time + a.x; 
  float y = (b.y - a.y) * time + a.y; 
  return new Point(x, y);
}
