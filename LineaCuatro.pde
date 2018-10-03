color blanco = #BBC8EE  ;
color azul2 = color(104, 143, 235);//
color azul1 = #2F2D53;
color gris =  color(47, 45, 83, 100);

color rojo1 = #F75889;
color rojo2 = rojo1;//#c11b17;
color amarillo1 =color(249, 208, 84);
color amarillo2 = amarillo1;//color(234, 193, 23);
color purpura = #B73FF3;
color cyan = gris;
color newcolor = azul2;//color(0, 224, 201);//blanco;//#3B2C60;
//color blue3 = #2B294F;

color black = #000000;
/*color blanco = #FFFFFF;
 color rojo1 = #F62217;
 color rojo2 = #c11b17;
 color amarillo1 =#FDD017;
 color amarillo2 = color(234, 193, 23);
 color azul1 = #2554c7; 
 color azul2 = color(0, 0, 160);
 color gris = color(229, 228, 226);
 color black = #000000;*/
boolean drop = false;

String t = "";

int turn = 1;

boolean run = true;

int dropx, 
  dropy;

int velocidadCaida;

int winRojo =0;
int winAmarillo =0;
int filas = 6;
int columnas = 7;

  int[][] game = new int[8][7];




void setup() {
 size(700, 800);
 // fullScreen();
  textAlign(CENTER);
  noCursor();
  strokeCap(ROUND);
}

void draw() {
background(newcolor);
  if (run == true) {
    Win();
    
    if (drop == false) {
      Tablero();
    } else {

      Animacion(dropx, dropy);
    }
    stroke(255);
    noFill();
    ellipse(mouseX, mouseY, 20, 20);
  } else
  {
    Tablero();
    stroke(255);
    noFill();
    ellipse(mouseX, mouseY, 20, 20);
  }

  //Marcador Global
  noStroke();
  textSize(50);
  fill(blanco);
  text(winAmarillo, 100, height-50);
  text(winRojo, width-100, height-50);
  fill(amarillo1);
  rect(140, height-80, 200, 40, 0, 0, 0, 200);
  fill(rojo1);
  rect(width-340, height-80, 200, 40, 0, 0, 200, 0);

  //Mensaje del ganador
  fill(black, 100);
  textSize(100);
  text(t, width/2 +3, height/2 -3);
  if (t.equals("¡ROJO GANA!"))
  {
    fill(rojo1, 200);
  } else 
  {
    fill(amarillo1, 200);
  }
  textSize(100);
  text(t, width/2, height/2);
  strokeWeight(2);
}


void mousePressed() {
  if (drop == false) {
    int x = floor(mouseX/100);
    int yObjetivo = -1;
    for (int y = 0; y < filas; y++) {
      if (game[y][x] == 0) {
        yObjetivo +=1;
      }
    }
    if (yObjetivo != -1) {
      dropx = x;
      dropy = yObjetivo;

      velocidadCaida = 0;

      drop = true;
    }
  }
}

void keyPressed()
{
  if (keyCode == 'r' || keyCode == 'R')
  {
    reset();
  }
}

void reset()
{
  t = "";
  for (int x = 0; x < columnas; x++) {
    for (int y = 0; y < filas; y++) {
      game[y][x] = 0;
    }
  }
  run = true;
}


void Animacion(int fx, int fy)
{
  fill(azul1);
  noStroke();
  rect(0, 100, 700, 700);


  strokeWeight(5);
  for (int x = 0; x < columnas; x++) {
    fill(blanco);
    stroke(gris);
    ellipse(50 + x*100, 50, 80, 80);
  }

//ficha estatica
  stroke(azul2);  
  for (int x = 0; x < columnas; x++) {
    for (int y = 0; y < filas; y++) {
      if (game[y][x] == 1) {
        fill(rojo1);
      } else if (game[y][x] == -1) {
        fill(amarillo1);
      } else {
        fill(blanco);
      }
      ellipse(50 + x*100, 150 + y*100, 80, 80);
    }
  }
  
//ficha cayendo
  if (turn == 1) {
    stroke(rojo1, 100);
    fill(rojo1);
  } else {
    stroke(amarillo1, 100);
    fill(amarillo1);
  }
  ellipse(50+ fx*100, 50 + velocidadCaida, 80, 80); 
  velocidadCaida +=20;//Velocidad de la caida

//En donde caen las fichas--------------------------------
  if (velocidadCaida >= fy * 100 + 100) {
    game[fy][fx] = turn;
    drop = false;
    if (turn == 1) {
      turn = -1;
    } else {
      turn = 1;
    }
  }
}



void Tablero() {

  fill(azul1);
  noStroke();
  rect(0, 100, 700, 700);
  strokeWeight(5);

  for (int x = 0; x < columnas; x++) { //Circulos transparentes parte superior
    if (run == true) {
      if (mouseX >= 100*x && mouseX < 100*(x+1)) {
        if (turn == 1) {
          fill(rojo1);
        } else {
          fill(amarillo1);
        }
      } else {
        fill(blanco);
      }
    } else {
      fill(blanco);
    }
    stroke(cyan, 100);
    ellipse(50 + x*100, 50, 80, 80);
  }

//Ficha fija
  stroke(azul2);  
  for (int x = 0; x < columnas; x++) {
    for (int y = 0; y < filas; y++) {
      if (game[y][x] == 1) {
        fill(rojo1);
      } else if (game[y][x] == -1) {
        fill(amarillo1);
      } else {  
        fill(blanco);
      }
      ellipse(50 + x*100, 150 + y*100, 80, 80);
    }
  }
}




void Win() {

  //Verifica Vertical
  for (int x = 0; x < columnas; x++) {
    for (int y = 0; y < 3; y++) {
      if (game[y][x] + game[y+1][x] + game[y+2][x] + game[y+3][x] == 4) {
        t = ("¡ROJO GANA!");
        winRojo += 1;
        run = false;
      }
      if (game[y][x] + game[y+1][x] + game[y+2][x] + game[y+3][x] == -4) {
        t = ("¡AMARILLO"+"\n"+"GANA!");
        winAmarillo += 1;
        run = false;
      }
    }
  }
  //Verifica Horizontal
  for (int x = 0; x < 4; x++) {
    for (int y = 0; y < filas; y++) {
      if (game[y][x] + game[y][x+1] + game[y][x+2] + game[y][x+3] == 4) {
        t = ("¡ROJO GANA!");
        winRojo += 1;
        run = false;
      }
      if (game[y][x] + game[y][x+1] + game[y][x+2] + game[y][x+3] == -4) {
        t = ("¡AMARILLO"+"\n"+"GANA!");
        winAmarillo += 1;
        run = false;
      }
    }
  }
  //Diagonal pendiente positiva
  for (int x = 0; x < 4; x++) {
    for (int y = 3; y < filas; y++) {
      if (game[y][x] + game[y-1][x+1] + game[y-2][x+2] + game[y-3][x+3] == 4) {
        t = ("¡ROJO GANA!");
        winRojo += 1;
        run = false;
      }
      if (game[y][x] + game[y-1][x+1] + game[y-2][x+2] + game[y-3][x+3] == -4) {
        t = ("¡AMARILLO"+"\n"+"GANA!");
        winAmarillo += 1;
        run = false;
      }
    }
  }

  //Diagonal pendiente negativa
  for (int x = 3; x < columnas; x++) {
    for (int y = 3; y < filas; y++) {
      if (game[y][x] + game[y-1][x-1] + game[y-2][x-2] + game[y-3][x-3] == 4) {
        t = ("¡ROJO GANA!");
        winRojo += 1;
        run = false;
      }
      if (game[y][x] + game[y-1][x-1] + game[y-2][x-2] + game[y-3][x-3] == -4) {
        t = ("¡AMARILLO"+"\n"+"GANA!");
        winAmarillo += 1;
        run = false;
      }
    }
  }
}