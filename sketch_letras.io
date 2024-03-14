#include <LiquidCrystal.h>
#include <Keypad.h>

// Configurações do display LCD
const int lcd_rs = 12;
const int lcd_en = 11;
const int lcd_d4 = 5;
const int lcd_d5 = 4;
const int lcd_d6 = 3;
const int lcd_d7 = 2;
LiquidCrystal lcd(lcd_rs, lcd_en, lcd_d4, lcd_d5, lcd_d6, lcd_d7);

// Configurações do keypad
const byte rows = 4; // Número de linhas do keypad
const byte cols = 4; // Número de colunas do keypad
char keys[rows][cols] = {
  {'1', '2', '3', 'A'},
  {'4', '5', '6', 'B'},
  {'7', '8', '9', 'C'},
  {'*', '0', '#', 'D'}
};
byte rowPins[rows] = {7, 6, 5, 4}; // Pinos das linhas do keypad
byte colPins[cols] = {A0, A1, A2, A3}; // Pinos das colunas do keypad
Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, rows, cols);

// Variáveis do jogo
const int num_niveis = 3; // Número de níveis de dificuldade
const int num_palavras_nivel = 5; // Número de palavras por nível
char palavras[num_niveis][num_palavras_nivel][10] = {
  {
    {"casa"},
    {"bola"},
    {"gato"},
    {"mesa"},
    {"livro"}
  },
  {
    {"escola"},
    {"computador"},
    {"banana"},
    {"janela"},
    {"arvore"}
  },
  {
    {"dificil"},
    {"programacao"},
    {"eletronica"},
    {"arduino"},
    {"tecnologia"}
  }
};
int nivel_atual = 0; // Nível atual do jogo
int palavra_atual = 0; // Palavra atual do nível
int erros = 0; // Número de erros

void setup() {
  // Inicializa o serial
  Serial.begin(9600);

  // Inicializa o display LCD
  lcd.begin(16, 2);

  // Inicializa o keypad
  keypad.begin();
}

void loop() {
  // Lê a tecla pressionada
  char tecla = keypad.getKey();

  // Se uma tecla foi pressionada
  if (tecla != NO_KEY) {
    // Verifica se a tecla é a letra correta
    if (tecla == palavras[nivel_atual][palavra_atual][erros]) {
      // Se a letra estiver correta, aumenta o número de
