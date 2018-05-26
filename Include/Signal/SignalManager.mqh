//+------------------------------------------------------------------+
//|                                                SignalManager.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#define SIGNAL_MAXIMUM 0xff

#include <Signal\SignalSAR.mqh>
#include <Signal\SignalSMA.mqh>

enum ENUM_SIGNAL {
  SIGNAL_SAR = 0,
  SIGNAL_SMA,
  ENUM_SIGNAL_SIZE
};

class SignalManager {
public:
  SignalManager(const string symbol);

  void Update(const MqlRates& rt);
  void Enable(ENUM_SIGNAL signal);
  ENUM_ORDER_TYPE Signal() const;

private:
  SignalBase* _signals[SIGNAL_MAXIMUM];
};

SignalManager::SignalManager(const string symbol) {
  for (int i = 0; i < ENUM_SIGNAL_SIZE; i++) {
    switch ((ENUM_SIGNAL)i) {
      case SIGNAL_SAR:
        _signals[i] = (SignalBase*)(new SignalSAR(symbol));
        break;
      case SIGNAL_SMA:
        _signals[i] = (SignalBase*)(new SignalSMA(symbol));
        break;
      default:
        break;
    }
  }
}

void SignalManager::Update(const MqlRates& rt) {
  for (int i = 0; i < SIGNAL_MAXIMUM; i++) {
    (*_signals[i]).Update(rt);
  }
}

void SignalManager::Enable(ENUM_SIGNAL signal) {
  if (!_signals[(int)signal].Initialize()) {
    Print("failed to initialize a signal of id=", (int)signal, ".");
  }
}

ENUM_ORDER_TYPE SignalManager::Signal() const {
  ENUM_ORDER_TYPE signal = _signals[0].signal();
  for (int i = 1; i < SIGNAL_MAXIMUM; i++) {
    if ((*_signals[i]).signal() != signal) {
      return WRONG_VALUE;
    }
  }
  return signal;
}
