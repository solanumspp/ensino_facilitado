// Biblioteca para controle do display de LED de sete segmentos
#include <SevSeg.h>

// Pino do botão
#define BOTAO_PINO 2

// Pinos do display de LED de sete segmentos
#define SEGMENTO_A 3
#define SEGMENTO_B 4
#define SEGMENTO_C 5
#define SEGMENTO_D 6
#define SEGMENTO_E 7
#define SEGMENTO_F 8
#define SEGMENTO_G 9
#define DIGITO_1 10
#define DIGITO_2 11

// Inicializa o objeto SevSeg para controlar o display de LED de sete segmentos
SevSeg display;

// Palavras para cada nível de dificuldade
const char* palavras[3][3] = {
    {"gato", "cachorro", "elefante"},
    {"sol", "lua", "estrela"},
    {"maçã", "banana", "laranja"}
};

// Nível de dificuldade atual
int nivelAtual = 0;

// Índice da palavra atual
int indicePalavraAtual = 0;

void setup() {
    // Configura o botão como entrada com pull-up interno
    pinMode(BOTAO_PINO, INPUT_PULLUP);

    // Configura os pinos do display de LED de sete segmentos
    byte digitos[] = {DIGITO_1, DIGITO_2};
    byte segmentos[] = {SEGMENTO_A, SEGMENTO_B, SEGMENTO_C, SEGMENTO_D, SEGMENTO_E, SEGMENTO_F, SEGMENTO_G};
    display.begin(COMMON_CATHODE, sizeof(digitos), digitos, segmentos);
    display.setBrightness(90); // Define o brilho do display
}

void loop() {
    // Exibe a palavra atual no display
    display.setChars(palavras[nivelAtual][indicePalavraAtual]);
    display.refreshDisplay();

    // Verifica se o botão foi pressionado
    if (digitalRead(BOTAO_PINO) == LOW) {
        // Avança para a próxima palavra
        indicePalavraAtual++;
        if (indicePalavraAtual >= 3) {
            indicePalavraAtual = 0;
            nivelAtual++;
            if (nivelAtual >= 3) {
                nivelAtual = 0;
            }
        }
        delay(500); // Debounce
    }
}
