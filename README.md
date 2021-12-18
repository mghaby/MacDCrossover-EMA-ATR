# MACD CROSSOVER EMA ATR EA

This is the source code and the compiled `.ex5` file for the MacD Crossover EMA ATR EA. This EA was made under the request of a client and thus is suited to their needs.

**DISCLAIMER THIS EA IS ONLY PROFITABLE ON CERTAIN CURRENCY PAIRS. PLEASE BACK-TEST OR MAKE CHANGES IF YOU WISH TO USE THIS**

**I AM NOT LIABLE FOR ANY PROFIT OR LOSS YOU MAY INCUR USING THIS EA**

## Description

This EA is made for the MacD Crossover + 200 EMA + ATR Value trading strategy for a client. The entry conditions follow the standard MacD cross signals however 
due to the platform this was based off of the MetaTrader 5 MacD which uses a Simple Moving Average to calculate the signal line compared to the conventional 
Exponential Moving Average for signal line definition. While there is a buy cross and price is above the EMA the Stop Loss is set to the swing low plus the current ATR value and a buy market order is executed.The Take-Profit point is set at a 2:1. Vice-versa for a sell signal. This system is profitable on select time frames and currency pairs, so contributions are welcome! 

## Getting Started

### Dependencies

* MetaTrader 5
* A Live or Demo Account with an MetaTrader 5 Supported Broker

### Installing

* How/where to download your program
* Any modifications needed to be made to files/folders

### Executing program

* How to run the program
* Step-by-step bullets
```
code blocks for commands
```

## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

1. [@mghaby](https://github.com/mghaby)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE - see the LICENSE file for details

## Acknowledgments

* [README-Template](https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc)