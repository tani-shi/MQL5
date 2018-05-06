//+------------------------------------------------------------------+
//|                                                    SignalSMA.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#define HISTORY_SIZE 10

#include <Signal\SignalBase.mqh>

static const int SMA_PERIOD = 12;
static const ENUM_APPLIED_PRICE SMA_APPLIED_PRICE = PRICE_CLOSE;

class SignalSMA : SignalBase {
public:
  SignalSMA(int handle)
  : SignalBase()
  , _handle(handle) {}
  
  static SignalSMA* Create(const string symbol, ENUM_TIMEFRAMES period);
  
  virtual bool Update(const MqlRates& rt);
  
private:
  bool TrendUp() const;
  bool TrendDown() const;

private:
  int _handle;
  double _ma_history[];
};

SignalSMA* SignalSMA::Create(const string symbol, ENUM_TIMEFRAMES period) {
  int handle = iMA(symbol, period, SMA_PERIOD, 0, MODE_SMA, SMA_APPLIED_PRICE);
  if (handle != INVALID_HANDLE) {
    return (new SignalSMA(handle));
  }
  return NULL;
}

bool SignalSMA::Update(const MqlRates& rt) {
  if (SignalBase::Update(rt)) {
    return true;
  }
  return false;
}

bool SignalMovingAverage::TrendUp() const {
  return false;
}

bool SignalMovingAverage::TrendDown() const {
  return false;
}
