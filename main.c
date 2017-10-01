#include <stdio.h>    // Used for printf() statements
#include <wiringPi.h> // Include WiringPi library!

// Pin number declarations. We're using the Broadcom chip pin numbers.
const int ledPin = 23; // Regular LED - Broadcom pin 23, P1 pin 16
const int pirPin = 17; // Active-high PIR - Broadcom pin 17, P1 pin 11

int main(void)
{
    // Setup stuff:
    wiringPiSetupGpio();            // Initialize wiringPi -- using Broadcom pin numbers

    pinMode(ledPin, OUTPUT);        // Set regular LED as output
    digitalWrite(ledPin, HIGH);     // Turn LED ON

    printf("Hello world\n");

    return 0;
}
