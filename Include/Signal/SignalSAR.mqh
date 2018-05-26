//+------------------------------------------------------------------+
//|                                                    SignalSAR.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <Signal\SignalBase.mqh>
#include <Definications.mqh>
#include <Utilities.mqh>

class SignalSAR : SignalBase {
public:
  SignalSAR(const string symbol)
  : SignalBase(symbol)
  , _handle(INVALID_HANDLE)
  , _prev_trend(TREND_NONE) {}
  
  virtual bool Initialize() override;
  virtual bool Update(const MqlRates& rt) override;

private:
  ENUM_TREND Trend(double sar, double open) const;
  
private:
  int _handle;
  ENUM_TREND _prev_trend;
};

bool SignalSAR::Initialize() {
  _handle = iSAR(_symbol, SAR_PERIOD, SAR_STEP, SAR_MAXIMUM);
  if (_handle != INVALID_HANDLE) {
    return true;
  }
  return false;
}

bool SignalSAR::Update(const MqlRates& rt) {
  if (SignalBase::Update(rt)) {
    double sar = Utilities::GetBufferValueByHandle<double>(_handle, 0, 0, 1);
    ENUM_TREND trend = Trend(sar, rt.open);
    if (trend != TREND_NONE && _prev_trend != TREND_NONE && trend != _prev_trend) {
      switch (trend) {
        case TREND_UP:
          _signal = ORDER_TYPE_BUY;
          break;
        case TREND_DOWN:
          _signal = ORDER_TYPE_SELL;
          break;
        default:
          _signal = WRONG_VALUE;
          break;
      }
    } else {
      _signal = WRONG_VALUE;
    }
    _prev_trend = trend;
    return true;
  }
  return false;
}

ENUM_TREND SignalSAR::Trend(double sar, double open) const {
  if (sar > open) {
    return TREND_DOWN;
  } else {
    return TREND_UP;
  }
}
