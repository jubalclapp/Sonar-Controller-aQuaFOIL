# Sonar Controller-aQuaFOIL
FPGA firmware for a 40KHz ultrasonic ride-height sensor on a foiling moth designed by aQuaFOIL. runs on a Tang Nano 20k, measures sonar time of flight, and streams calculated ride heigh to a Raspberry Pi over USB serial.
## Status
- [x] uart_tx: 8N1 serial at 115200 baud verified in simulation
## Layout
src/          SystemVerilog design, one module per file <br>
tb/           testbenches<br>
constraits/   pin and timing files

## Author
Jubal Clapp, Sonar and Control team lead @ aQuaFOIL 