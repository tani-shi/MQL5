//+------------------------------------------------------------------+
//|                                                    SignalSMA.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <Signal\SignalBase.mqh>
#include <Definications.mqh>
#include <Utilities.mqh>

class SignalSMA : SignalBase {
public:
  SignalSMA(const string symbol)
  : SignalBase(symbol)
  , _handle(INVALID_HANDLE)
  , _prev_trend(TREND_NONE) {
    _isUpdateWhenOnlyFirstTickVolume = true;
  }

  virtual bool Update(const MqlRates& rt);
  
protected:
  virtual bool Initialize() override;

private:
  int _handle;
  double _ma_history[SMA_MA_HISTORY_MAXIMUM];
  ENUM_TREND _prev_trend;
};

bool SignalSMA::Initialize() {
  if (SignalBase::Initialize()) {
    _handle = iMA(_symbol, SMA_PERIOD, SMA_MA_PERIOD, 0, MODE_SMA, SMA_APPLIED_PRICE);
    if (_handle != INVALID_HANDLE) {
      return true;
    }
  }
  
  return false;
}

bool SignalSMA::Update(const MqlRates& rt) {
  if (SignalBase::Update(rt)) {
    double ma = Utilities::GetBufferValueByHandle<double>(_handle, 0, 0, 1);
    // ENUM_TREND trend = Trend(ma);
    // TODO: queueをつくる
    return true;
  }
  return false;
}
