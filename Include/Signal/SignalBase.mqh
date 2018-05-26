//+------------------------------------------------------------------+
//|                                                   SignalBase.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

enum ENUM_TREND {
  TREND_NONE,
  TREND_UP,
  TREND_DOWN
};

class SignalBase {
public:
  SignalBase(const string symbol)
  : _signal(WRONG_VALUE)
  , _symbol(symbol)
  , _enabled(false)
  , _isUpdateWhenOnlyFirstTickVolume(false) {}

  virtual bool Initialize();
  virtual bool Update(const MqlRates& rt);
  
  void Enable();
  
  ENUM_ORDER_TYPE signal() const {
    return _signal;
  }
  bool enabled() const {
    return _enabled;
  }

protected:
  ENUM_ORDER_TYPE _signal;
  string _symbol;
  ENUM_TIMEFRAMES _period;
  bool _isUpdateWhenOnlyFirstTickVolume;
  
private:
  bool _enabled;
};

bool SignalBase::Initialize() {
  return true;
}

bool SignalBase::Update(const MqlRates& rt) {
  if (_enabled) {
    if (rt.tick_volume <= 1 || !_isUpdateWhenOnlyFirstTickVolume) {
      return true;
    }
  }
  return false;
}

void SignalBase::Enable() {
  if (Initialize()) {
    _enabled = true;
  }
}
