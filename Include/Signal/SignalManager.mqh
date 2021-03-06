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
  virtual ~SignalManager();

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

SignalManager::~SignalManager() {
  for (int i = 0; i < ENUM_SIGNAL_SIZE; i++) {
    if (_signals[i] != NULL) {
      delete _signals[i];
      _signals[i] = NULL;
    }
  }
}

void SignalManager::Update(const MqlRates& rt) {
  for (int i = 0; i < ENUM_SIGNAL_SIZE; i++) {
    if (_signals[i] != NULL && (*_signals[i]).enabled()) {
      (*_signals[i]).Update(rt);
    }
  }
}

void SignalManager::Enable(ENUM_SIGNAL signal) {
  if (_signals[(int)signal] == NULL || !_signals[(int)signal].Enable()) {
    Print("failed to initialize a signal of id=", (int)signal, ".");
  }
}

ENUM_ORDER_TYPE SignalManager::Signal() const {
  ENUM_ORDER_TYPE signal = WRONG_VALUE;
  for (int i = 0; i < ENUM_SIGNAL_SIZE; i++) {
    if (_signals[i] != NULL && (*_signals[i]).enabled()) {
      if (signal == WRONG_VALUE) {
        signal = (*_signals[i]).signal();
        continue;
      }
      if ((*_signals[i]).signal() != signal) {
        return WRONG_VALUE;
      }
    }
  }
  return signal;
}
