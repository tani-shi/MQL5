//+------------------------------------------------------------------+
//|                                                SignalManager.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#define SIGNAL_MAXIMUM 0xff

#include <Arrays\ArrayObj.mqh>
#include <Signal\SignalBase.mqh>

class SignalManager {
public:
  void Update(const MqlRates& rt);
  void Add(CObject* signal);

private:
  CArrayObj _signals;
};

void SignalManager::Update(const MqlRates& rt) {
  for (int i = 0; i < _signals.Total(); i++) {
    (*(SignalBase*)(_signals.At(i))).Update(rt);
  }
}

void SignalManager::Add(CObject* signal) {
  _signals.Add(signal);
}