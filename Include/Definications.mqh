//+------------------------------------------------------------------+
//|                                                Definications.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

//------------------------
// SignalSAR
#define SAR_PERIOD PERIOD_H1
#define SAR_STEP 0.02
#define SAR_MAXIMUM 0.2

//------------------------
// SignalSMA
#define SMA_PERIOD PERIOD_H1
#define SMA_MA_HISTORY_MAXIMUM 2
#define SMA_MA_PERIOD 12
#define SMA_APPLIED_PRICE PRICE_CLOSE
