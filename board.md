
[P board X 2] - 63

[power]
12v + GND a -> P1 [P2]
12v + GND a -> Adapter [P1]
3.3v + GND j -> P1 [P2]
3.3v + GND j -> pi [P1]
GND -> 100 ohm -> GND [P1]
5 12v -> PAD 12v

[inputs] - 20
20 PAD SENSOR -> inputs a
20 10k resistors d -> g
20 3.3k resistors j -> GND
10 g -> 4067 x 2

[CD74HC4067 x 2] - 4
VCC -> 3.3v
GND -> GND
S0-S3 -> P1 [P2]
S0-S3 -> pi [P1]
SIG -> pi [P1]
SIG -> pi [P2]
EN -> NC

[ULN2803A] - 9
GND -> 12v GND
5 PAD GND -> OUT

[74HC595N] - 8
VCC -> 3.3v
GND -> GND
RESET -> 3.3v
EN -> NC
Q0-Q4 -> ULN2803A IN
RCLK, SRCLK -> P1 [P2]
SER -> P1 SQ7 [P2]
RCLK, SRCLK -> pi [P1]
SER -> pi (P1)

[PI outputs] - 7
CD74HC4067 S0-S3
74HC595N RCLK, SRCLK
74HC595N SER

[PI inputs] - 9
CD74HC4067 SIG (4)
Test, service, clear, coin buttons P1/P2 (5)





PCB Pins:

[empty space]
[power header]
12v
12v
GND
GND
GND
FG
[input header]
UP
DOWN
LEFT
RIGHT
CENTER
[output header]
S0
S1
UP
DOWN
LEFT
RIGHT
CENTER
FG
GND
12v
[end]