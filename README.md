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

* This EA can be cloned using:
```
git clone https://github.com/mghaby/MacDCrossover-EMA-ATR.git
```
* The source code can also be copied and pasted directly into a template file in the MetaTrader 5 IDE and compiled to avoid glitches in the MetaTrader 5 software

### Executing program

1. Once cloned place the source code file and the compiled `.ex5` into the `/Experts` directory in your MetaTrader 5 installation
2. In the main MetaTrader 5 panel once logged in with a broker you can access the strategy tester in which you can follow the prompts to test this EA

## Help

```
Inside the MetaTrader 5 IDE, you can highlight anything and press `F2` for more details
```

## Authors

1. Mark Ghaby
  * [Github](https://github.com/mghaby)
  * [LinkedIn](https://www.linkedin.com/in/mghaby/)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the GNU General Public License - see the LICENSE file for details

## Acknowledgments

* [README-Template](https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc)