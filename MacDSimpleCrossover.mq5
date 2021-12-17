//+------------------------------------------------------------------+
//|                                             MacdDSimpleCrossover |
//|                                      Copyright 2021, Mark Ghaby  |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

CTrade trade;

void OnTick()
  {

// Variables
   string signal = "";
   double equity = AccountInfoDouble(ACCOUNT_EQUITY);
   int macdDefinition = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);
   int ema200Definition = iMA(_Symbol, _Period, 200, 0, MODE_EMA, PRICE_CLOSE);
   int atrDefiniton = iATR(_Symbol, _Period, 14);
   int macdSignal = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);
   double ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   double lastPrice = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_LAST), _Digits);
   double highestCandleArray = iHighest(_Symbol, _Period, MODE_HIGH, 5, 0);
   double lowestCandleArray = iLowest(_Symbol, _Period, MODE_LOW, 5, 0);
   double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double macdPriceArray[];
   double emaPriceArray[];
   double atrArray[];
   double macdSignalArray[];

//Sorting
   ArraySetAsSeries(macdPriceArray, true);
   ArraySetAsSeries(emaPriceArray, true);
   ArraySetAsSeries(atrArray, true);
   ArraySetAsSeries(macdSignalArray, true);

// Copies
   CopyBuffer(macdDefinition, 0, 0, 3, macdPriceArray);
   CopyBuffer(ema200Definition, 0, 0, 3, emaPriceArray);
   CopyBuffer(atrDefiniton, 0, 0, 3, atrArray);
   CopyBuffer(macdSignal, 1, 0, 3, macdSignalArray);

// Current Candles
   double macdValue = macdPriceArray[0];
   double emaValue = emaPriceArray[0];
   double atrValue = NormalizeDouble(atrArray[0], 5);
   double highestCandle = iHigh(_Symbol, _Period, highestCandleArray);
   double lowestCandle = iLow(_Symbol, _Period, lowestCandleArray);

// Setting Buy Signal
   if((macdValue < 0) && (lastPrice > emaValue) && isCrossBuy(macdPriceArray, macdSignalArray))
     {
      signal = "buy";
     }

// Setting Sell Signal
   if((macdValue > 0) && (lastPrice < emaValue) && isCrossSell(macdPriceArray, macdSignalArray))
     {
      signal = "sell";
     }

// Actual Buy
   if(tradeCheck())
     {
      if(signal == "buy")
        {
         trade.Buy(setPositionSizeBuy(equity, lastPrice, lowestCandle, atrValue, minLot, maxLot), NULL, ask, setStopLossBuy(lowestCandle, atrValue), setTakeProfitBuy(lowestCandle, atrValue, lastPrice), NULL);
        }
     }

// Actual Sell
   if(tradeCheck())
     {
      if(signal == "sell")
        {
         trade.Sell(setPositionSizeSell(equity, lastPrice, highestCandle, atrValue, minLot, maxLot), NULL, bid, setStopLossSell(highestCandle, atrValue), setTakeProfitSell(highestCandle, atrValue, lastPrice), NULL);
        }
     }
  }  

//+------------------------------------------------------------------+
//| MACD Crosses                                                     |
//+------------------------------------------------------------------+
bool isCrossBuy(double& macd[], double& signal[])
  {
   if((macd[0] > signal[0]) && (macd[1] <= signal[1]))
     {
      return true;
     }
   else
     {
      return false;
     }
  }

bool isCrossSell(double& macd[], double& signal[])
  {
   if((macd[0] < signal[0]) && (macd[1] >= signal[1]))
     {
      return true;
     }
   else
     {
      return false;
     }
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Setting Position Price                                           |
//+------------------------------------------------------------------+

double setPositionSizeBuy(double accSize, double lp, double lCandle, double atLizzie, double min, double max)
  {
   double x = lCandle - atLizzie;
   double y = (lp - x)* pow(10,SymbolInfoInteger(_Symbol,SYMBOL_DIGITS)) / 10;
   double z = (((accSize * 0.02) / (y))) / 10; // divided by 10 for mini lot 
   double abc = NormalizeDouble(z, 2);

   if (abc > max ){
      return max;
    } else if (abc < min){
      return min;
   } else {
      return abc;
   }
  }

double setPositionSizeSell(double accSize, double lp, double hCandle, double atLizzie, double min, double max)
  {
   double x = hCandle + atLizzie;
   double y = (x - lp) * pow(10,SymbolInfoInteger(_Symbol,SYMBOL_DIGITS)) / 10;
   double z = (((accSize * 0.02) / (y))) / 10; // divided by 10 for mini lot 
   double abc = NormalizeDouble(z, 2);
   
   if (abc > max ){
      return max;
    } else if (abc < min){
      return min;
   } else {
      return abc;
   } 
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Setting Take Profits                                             |
//+------------------------------------------------------------------+
double setTakeProfitBuy(double lCandle, double atLizzie, double lp)
  {
   double x = lp - (lCandle - atLizzie);
   return lp + (x * 2);
  }

double setTakeProfitSell(double hCandle, double atLizzie, double lp)
  {
   double x = (hCandle + atLizzie) - lp;
   return lp - (x * 2);
  }
  
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Setting Stop Losses                                              |
//+------------------------------------------------------------------+
double setStopLossBuy(double lCandle, double atLizzie)
  {
   return lCandle - atLizzie;
  }

double setStopLossSell(double hCandle, double atLizzie)
  {
   return hCandle + atLizzie;
  }

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Trades per Account / Trades per Pair                             |
//+------------------------------------------------------------------+
bool tradeCheck()
  {
   string symbol;
   bool check;

// Checks for Current Symbol
   for(int i = PositionsTotal() -1; i>= 0; i--)
     {
      symbol = PositionGetSymbol(i);
      if(_Symbol == symbol)
         break;
     }

// Check Setter
   if(_Symbol == symbol)
     {
      check = false;
     }
   else
     {
      check = true;
     }

// Core Logic
   if(PositionsTotal() < 3 && check)
     {
      return true;
     }
   else
     {
      return false;
     }
  }
//+------------------------------------------------------------------+