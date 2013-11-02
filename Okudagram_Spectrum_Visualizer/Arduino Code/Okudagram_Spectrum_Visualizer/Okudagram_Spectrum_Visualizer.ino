
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
	
// Example 48.1 - tronixstuff.com/tutorials > chapter 48 - 30 Jan 2013
// MSGEQ7 spectrum analyser shield - basic demonstration
int strobe = 4; // strobe pins on digital 4
int res = 5; // reset pins on digital 5
int left[7]; // store band values in these arrays
int right[7];
int band;
void setup()
{
Serial.begin(115200);
pinMode(res, OUTPUT); // reset
pinMode(strobe, OUTPUT); // strobe
digitalWrite(res,LOW); // reset low
digitalWrite(strobe,HIGH); //pin 5 is RESET on the shield
}
void readMSGEQ7()
// Function to read 7 band equalizers
{
digitalWrite(res, HIGH);
digitalWrite(res, LOW);
for(band=0; band <7; band++)
{
digitalWrite(strobe,LOW); // strobe pin on the shield - kicks the IC up to the next band
delayMicroseconds(30); //
left[band] = analogRead(0); // store left band reading
right[band] = analogRead(1); // ... and the right
digitalWrite(strobe,HIGH);
}
}
void loop()
{
readMSGEQ7();
// display values of left channel on serial monitor
for (band = 0; band < 7; band++)
{
Serial.print(left[band]);
Serial.print(" ");
}
Serial.println();
// display values of right channel on serial monitor
for (band = 0; band < 7; band++)
{
Serial.print(right[band]);
Serial.print(" ");
}
Serial.println();
}

