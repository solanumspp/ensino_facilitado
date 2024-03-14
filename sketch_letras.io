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
const int num_desafios_nivel = 5; // Número de desafios por nível
const int num_modalidades = 2; // Número de modalidades: palavras e matemática

// Modalidades
enum Modalidade {
  PALAVRAS,
  MATEMATICA
};

// Variáveis para cada modalidade
char palavras[num_niveis][num_desafios_nivel][10] =
  {
    {"casa"}, // Nível 0, Desafio 0
    {"bola"}, // Nível 0, Desafio 1
    {"gato"}, // Nível 0, Desafio 2
    ...
  },
  {
    {"escola"}, // Nível 1, Desafio 0
    {"computador"}, // Nível 1, Desafio 1
    {"banana"}, // Nível 1, Desafio 2
    ...
  },
  {
    {"alfabetização"}, // Nível 2, Desafio 0
    {"tecnologia"}, // Nível 2, Desafio 1
    {"informativo"}, // Nível 2, Desafio 2
  ...
};

int operacoes[num_niveis][num_desafios_nivel][3];
int nivel_atual[num_modalidades]; // Nível atual do jogo em cada modalidade
int desafio_atual[num_modalidades]; // Desafio atual do nível em cada modalidade
int erros[num_modalidades]; // Número de erros em cada modalidade

// Funções para cada modalidade
void jogo_palavras();
void jogo_matematica();

void setup() {
  // Inicializa o serial
  Serial.begin(9600);

  // Inicializa o display LCD
  lcd.begin(16, 2);

  // Inicializa o keypad
  keypad.begin(keys);

  // Gera as palavras e operações matemáticas para cada nível
  for (int i = 0; i < num_niveis; i++) {
    for (int j = 0; j < num_desafios_nivel; j++) {
      // Gera a palavra
      ...

      // Define os operandos e o operador de acordo com o nível de dificuldade
      ...
    }
  }

  // Inicializa as variáveis do jogo
  for (int i = 0; i < num_modalidades; i++) {
    nivel_atual[i] = 0;
    desafio_atual[i] = 0;
    erros[i] = 0;
  }
}

void loop() {
  // Mostra o menu principal
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Selecione o modo:");
  lcd.setCursor(0, 1);
  lcd.print("1 - Palavras");
  lcd.print("  2 - Matemática");

  // Lê a tecla pressionada
  char tecla = keypad.getKey();

  // Se uma tecla foi pression
