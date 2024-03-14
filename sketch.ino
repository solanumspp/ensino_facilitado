# adaptação de código aberto utilizado em aulas com arduíno r3

#include <Keypad.h> 
#include <LiquidCrystal.h> 
#include "pitches.h" // Musical Notes

//keyPad definitions
const byte numRows= 4; //number of rows on the keypad
const byte numCols= 4; //number of columns on the keypad
char keyMap[numRows][numCols]=
{
  {'1', '2', '3', 'A'},
  {'4', '5', '6', 'B'},
  {'7', '8', '9', 'C'},
  {'*', '0', '#', 'D'}
  };
byte rowPins[numRows] = {9,8,7,6}; //Rows 0 to 3
byte colPins[numCols]= {5,4,3,2}; //Columns 0 to 3
Keypad keyPad= Keypad(makeKeymap(keyMap), rowPins, colPins, numRows, numCols);

//LCD Display
LiquidCrystal lcd(A0, A1, A2, A3, A4, A5);

//Buzzer
int buzzPin = 10; //connect a 100ohms resistor on this pin

void setup() {
  lcd.begin(16, 2);
  pinMode(buzzPin,OUTPUT); //Buzzer pin
  randomSeed(analogRead(7));//Starts the random number generator on this analogic pin
}

void loop() {
  lcd.clear();
  lcd.setCursor(0, 0);
  //Choose two numbers and displays them on the LCD
  int num1 = random(2, 11);
  int num2 = random(2, 11);
  int result = num1 * num2; 
  String mult = String(num1) + " x " + String(num2) + " = ";
  lcd.print(mult);
  // Waiting for user response and evaluates the result
  int hit = readVal().toInt();
  lcd.setCursor(0, 1);
  if (result == hit){ 
    lcd.print(":-)");
    playHappy();
  }
  else {
    lcd.print(":-(     " + String(result));
    playAlarm();
  }
  hit = readVal().toInt(); //Just waiting for you to press any key to continue
}

//Data input: Enter the values and press "#"
String readVal(){
  String myString = "";
  char keyPressed = keyPad.getKey();
  while (keyPressed != '#'){
    keyPressed = keyPad.getKey();
    if ((keyPressed != NO_KEY) && (keyPressed != '#')) {
      myString.concat(keyPressed); 
      lcd.print(keyPressed);
      playTone();
      }   
    }  
  return(myString);  
  }

//Success: Play "Happy Birthday"
void playHappy(){
  int melody[] = {NC4,NC4,ND4,NC4,NF4,NE4,
                NC4,NC4,ND4,NC4,NG4,NF4,
                NC4,NC4,NC5,NA4,NF4,NE4,ND4,
                NAS4,NAS4,NA4,NF4,NG4,NF4  
                 };
  int noteDurations[] = {6,12,4,4,4,2,
                       6,12,4,4,4,2,
                       6,12,4,4,4,4,2,
                       6,12,4,4,4,2,    
                       };
  for (int thisNote = 0; thisNote < 12; thisNote++) {
    int noteDuration = 1000/noteDurations[thisNote];
    tone(buzzPin, melody[thisNote],noteDuration);
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    noTone(buzzPin); 
  }
}

//Error: Play a alarm 
void playAlarm(){
for (int thisNote = 150; thisNote < 1000; thisNote += 1) 
  {
    tone(buzzPin, thisNote, 10); 
    delay(1);
  }
  for (int thisNote = 1000; thisNote > 150; thisNote -= 1) 
  {
    tone(buzzPin, thisNote, 10); 
    delay(1);
  }
}

//Beeps on key presses
void playTone(){
  tone(buzzPin, 150, 10); 
  }


