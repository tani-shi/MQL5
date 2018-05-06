#include <Trade\Trade.mqh>
#include <Signal\SignalManager.mqh>
#include <Signal\SignalSAR.mqh>
#include <Signal\SignalSMA.mqh>

SignalManager _signal_manager;
SignalSAR _signal_sar;
SignalSMA _signal_sma;

int OnInit() {
  return INIT_SUCCEEDED;
}

void OnTick() {
  MqlRates rt[1];
  if (CopyRates(_Symbol, _Period, 0, 1, rt) != 1) {
    Print("failed to copy a rate to buffer since no rate data.");
    return;
  }
  
  _signal_manager.Update(rt[0]);
}

/*
void OnTick() {
  MqlRates rt[1];
  if(CopyRates(_Symbol, _Period, 0, 1, rt) != 1) {
    Print("failed to copy a rate to buffer since no rate data");
    return;
  }
  
  if (rt[0].tick_volume > 1) {
    return;
  }
  
  // Move Average
  double buff[1];
  double ma[MA_COUNT] = {0};
  for (int i = 0; i < MA_COUNT; i++) {
    if (CopyBuffer(_ma_handle[i], 0, 0, 1, buff) != 1) {
      Print("failed to copy a buffer since no data of moving average-", MA_PERIOD[i], ".");
      return;
    }
    ma[i] = buff[0];
  }
  
  // SAR
  if (CopyBuffer(_sar_handle, 0, 0, 1, buff) != 1) {
    Print("faield to copy a buffer since no data of SAR.");
    return;
  }
  double sar = buff[0];
  
  if (SwitchedSAR(sar, rt[0].open)) {
    if (PositionSelect(_Symbol)) {
      _trade.PositionClose(_Symbol);
    } else {
      ENUM_ORDER_TYPE signal = WRONG_VALUE;
      if ((sar < rt[0].open || !USE_SAR) &&
          (TrendUpMA(ma) || !USE_MA)) {
        signal = ORDER_TYPE_BUY;
      } else if ((sar > rt[0].open || !USE_SAR) &&
                 (TrendDownMA(ma) || !USE_MA)) {
        signal = ORDER_TYPE_SELL;
      }
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
        
        _trade.PositionOpen(_Symbol, signal, TradeSizeOptimized(LOT_SIZE), price, sl, tp);
      }
    }
  }
}
*/