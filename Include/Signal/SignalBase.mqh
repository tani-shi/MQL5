//+------------------------------------------------------------------+
//|                                                   SignalBase.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <Object.mqh>

class SignalBase : CObject {
public:
  SignalBase()
  : _signal(WRONG_VALUE) {}

  virtual bool Update(const MqlRates& rt);
  ENUM_ORDER_TYPE signal() const {
    return _signal;
  }

protected:
  ENUM_ORDER_TYPE _signal;
};

bool SignalBase::Update(const MqlRates& rt) {
  if (rt.tick_volume <= 1) {
    return true;
  }
  return false;
}
