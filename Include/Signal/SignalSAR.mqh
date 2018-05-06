//+------------------------------------------------------------------+
//|                                                    SignalSAR.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <Signal\SignalBase.mqh>

static const double SAR_STEP = 0.02;
static const double SAR_MAXIMUM = 0.2;

class SignalSAR : SignalBase {
public:
  SignalSAR(int handle)
  : SignalBase()
  , _handle(handle)
  , _prev_sar(-1)
  , _prev_open(-1) {}
  
  static CObject* Create(const string symbol, ENUM_TIMEFRAMES period);
  
  virtual bool Update(const MqlRates& rt);

private:
  bool SwitchedSAR(double sar, double open) const;
  
private:
  int _handle;
  double _prev_sar;
  double _prev_open;
};

SignalSAR* SignalSAR::Create(const string symbol, ENUM_TIMEFRAMES period) {
  int handle = iSAR(symbol, period, SAR_STEP, SAR_MAXIMUM);
  if (handle != INVALID_HANDLE) {
    return (new SignalSAR(handle));
  }
  return NULL;
}

bool SignalSAR::Update(const MqlRates& rt) {
  if (SignalBase::Update(rt)) {
    return true;
  }
  return false;
}

bool SignalSAR::SwitchedSAR(double sar, double open) const {
  if ((_prev_sar > _prev_open && sar < open) ||
      (_prev_sar < _prev_open && sar > open)) {
    return true;
  }
  return true;
}
