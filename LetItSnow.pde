color DEFAULT_COLOR = color(153, 204, 255);

int numSnowflakes = 15;
PVector[] snowflakes = new PVector[numSnowflakes];
int[] snowSpeeds = new int[numSnowflakes];
float snowflakeWidth = 100;

int numIter = 4;
int maxFallSpeed = 15;

void setup()
{
  colorMode(RGB);
  size(1400,1500);
  background(255,255,255);
  strokeWeight(2);
  
  PVector center = new PVector(width / 6, height / 3);
  PVector v1 = new PVector(2 * width / 3, 0);
  stroke(DEFAULT_COLOR);
  //drawKochTriangle(center, v1, numIter);
  
  for(int i = 0; i < numSnowflakes; i++)
  {
    makeNewSnowflake(i);
  }
}

void draw()
{
  background(255);
  PVector size = new PVector(snowflakeWidth, 0);
  for(int i = 0; i < numSnowflakes; i++)
  {
    drawKochTriangle(snowflakes[i], size, numIter);
    snowflakes[i].y += snowSpeeds[i];
    if(snowflakes[i].y >= height)
    {
      makeNewSnowflake(i);
    }
  }
}

void makeNewSnowflake(int i)
{
  int xCoord = (int) random(width - snowflakeWidth);
  snowflakes[i] = new PVector(xCoord, 0);
  int speed = (int) random(2, maxFallSpeed);
  snowSpeeds[i] = speed;
}

void drawTriangle(PVector origin, PVector v1)
{
  PVector p1 = new PVector(0, 0);
  PVector p2 = v1.copy();
  v1.rotate(-THIRD_PI);
  PVector p3 = v1.copy();
  
  drawLine(origin, p1, p2); //<>//
  drawLine(origin, p1, p3);
  drawLine(origin, p2, p3); //<>//
}

void drawKochTriangle(PVector origin, PVector v1, int numIter)
{
  PVector p1 = origin.copy();
  PVector v2 = v1.copy().rotate(-2*THIRD_PI);
  PVector p2 = origin.copy().add(v1);
  PVector v3 = v1.copy().rotate(-2*THIRD_PI);
  PVector p3 = origin.copy().sub(v3);
  
  drawKoch(p1, v1, numIter);
  //DEFAULT_COLOR = color(255, 0, 0);
  drawKoch(p2, v2.mult(-1).rotate(THIRD_PI), numIter);
  //DEFAULT_COLOR = color(0, 255, 0);
  drawKoch(p3, v3, numIter);
}

void drawLine(PVector origin, PVector p1, PVector p2)
{
  line(origin.x + p1.x, origin.y + p1.y, origin.x + p2.x, origin.y + p2.y); 
}

void drawKoch(PVector center, PVector v1, int numIter)
{
  if(numIter == 1) {
    drawLine(center, new PVector(0, 0), v1);
    return;
  }
  PVector v_partial_1 = v1.copy().mult(1.0/3.0);
  drawLine(center, new PVector(0, 0), v_partial_1);
  PVector v_partial_2 = v1.copy().sub(v_partial_1);
  drawLine(center, v1, v_partial_2);
  
  stroke(255, 255, 255);
  strokeWeight(5);
  drawLine(center, v_partial_1, v_partial_2);
  strokeWeight(2);
  stroke(DEFAULT_COLOR);
  
  PVector center_2 = center.copy().add(v_partial_1);
  PVector delta_2 = v_partial_1.copy().rotate(-THIRD_PI);
  drawKoch(center_2, delta_2, numIter - 1);
  
  PVector center_3 = center_2.copy().add(delta_2);
  PVector delta_3 = v_partial_1.copy().rotate(THIRD_PI);
  drawKoch(center_3, delta_3, numIter - 1);
  
  PVector center_4 = center.copy();
  PVector delta_4 = v_partial_1.copy();
  drawKoch(center_4, delta_4, numIter - 1);
  
  PVector center_5 = center.copy().add(v_partial_2);
  PVector delta_5 = v_partial_1.copy();
  drawKoch(center_5, delta_5, numIter - 1);
}