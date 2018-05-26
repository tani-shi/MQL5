#include <Trade\Trade.mqh>
#include <Signal\SignalManager.mqh>
#include <Definications.mqh>

SignalManager *_signal_manager;
CTrade _trade;

int OnInit() {
  _signal_manager = new SignalManager(_Symbol);
  (*_signal_manager).Enable(SIGNAL_SAR);
  
  return INIT_SUCCEEDED;
}

void OnDeinit(const int reason) {
  if (_signal_manager != NULL) {
    delete _signal_manager;
    _signal_manager = NULL;
  }
}

void OnTick() {
  MqlRates rt[1];
  if (CopyRates(_Symbol, _Period, 0, 1, rt) != 1) {
    Print("failed to copy a rate to buffer since no rate data.");
    return;
  }
  
  (*_signal_manager).Update(rt[0]);
  
  ENUM_ORDER_TYPE signal = (*_signal_manager).Signal();
  if (signal != WRONG_VALUE) {
    double price = SymbolInfoDouble(_Symbol, signal == ORDER_TYPE_SELL ? SYMBOL_BID:SYMBOL_ASK);
    double tp = 0; // price to take profit
    if (DIFF_TO_TAKE_PROFIT > 0) {
      tp = price + (DIFF_TO_TAKE_PROFIT * (signal == ORDER_TYPE_SELL ? -1.0 : 1.0));
    }
    double sl = 0; // price to stop losses
    if (DIFF_TO_STOP_LOSS > 0) {
      sl = price + (DIFF_TO_STOP_LOSS * (signal == ORDER_TYPE_SELL ? 1.0 : -1.0));
    }
    _trade.PositionOpen(_Symbol, signal, 0.01, price, sl, tp);
  }
}
