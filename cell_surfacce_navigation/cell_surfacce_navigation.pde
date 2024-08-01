int gridResolution = 10;  
int rows, cols;
float[][] x, y, z;  
int currentRow = 0, currentCol = 0;  

void setup() {
  size(800, 800, P3D);
  updateGrid();
}

void draw() {
  background(0);
  lights();
  translate(width/2, height/2);
  
  fill(255);
  textSize(20);
  text("WASD: move", -350, -250);
  text("UP/DOWN (Resolution): " + gridResolution, -350, -230);
  
  rotateX(PI/3);
  rotateZ(PI/6);
  stroke(255);
  noFill();

  for (int i = 0; i < rows-1; i++) {
    for (int j = 0; j < cols-1; j++) {
      beginShape();
      vertex(x[i][j], y[i][j], z[i][j]);
      vertex(x[i+1][j], y[i+1][j], z[i+1][j]);
      vertex(x[i+1][j+1], y[i+1][j+1], z[i+1][j+1]);
      vertex(x[i][j+1], y[i][j+1], z[i][j+1]);
      endShape(CLOSE);
    }
  }
  
  fill(255);
  beginShape();
  vertex(x[currentRow][currentCol], y[currentRow][currentCol], z[currentRow][currentCol]);
  vertex(x[currentRow+1][currentCol], y[currentRow+1][currentCol], z[currentRow+1][currentCol]);
  vertex(x[currentRow+1][currentCol+1], y[currentRow+1][currentCol+1], z[currentRow+1][currentCol+1]);
  vertex(x[currentRow][currentCol+1], y[currentRow][currentCol+1], z[currentRow][currentCol+1]);
  endShape(CLOSE);

  
}

void updateGrid() {
  rows = cols = gridResolution;
  x = new float[rows][cols];
  y = new float[rows][cols];
  z = new float[rows][cols];
  generateSurface();
  
  currentRow = constrain(currentRow, 0, rows - 2);
  currentCol = constrain(currentCol, 0, cols - 2);
}

void generateSurface() {
  float cellWidth = width / (float)gridResolution;
  float cellHeight = height / (float)gridResolution;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float u = map(i, 0, rows-1, -PI, PI);
      float v = map(j, 0, cols-1, -PI, PI);
      x[i][j] = u * 100;
      y[i][j] = v * 100;
      z[i][j] = 50 * sin(u) * sin(v);
    }
  }
}

void adjustResolution(int change) {
  gridResolution = constrain(gridResolution + change, 2, 50);
  updateGrid();
}

void keyPressed() {
  if (key == 'w' && currentRow > 0) currentRow--;
  if (key == 's' && currentRow < rows - 2) currentRow++;
  if (key == 'a' && currentCol > 0) currentCol--;
  if (key == 'd' && currentCol < cols - 2) currentCol++;
  if (keyCode == UP) adjustResolution(1);
  if (keyCode == DOWN) adjustResolution(-1);
}
