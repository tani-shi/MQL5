#ifndef Handle_SARHandler
#define Handle_SARHandler

#property copyright "Shintaro Tanikawa"

#include <Handle\BaseHandler.mqh>

class SARHandleWrapper : BaseHandleWrapper {
public:
  SARHandleWrapper(const string symbol, ENUM_TIMEFRAMES period, double step, double maximum)
  : BaseHandleWrapper(symbol, period)
  , _step(step)
  , _maximum(maximum)
  {
    int handle = iSAR(symbol, period, step, maximum);
    if (handle != INVALID_HANDLE) {
      _handle = handle;
    }
  }
  
  bool IsSame(const string symbol, ENUM_TIMEFRAMES period, double step, double maximum)
  {
    if (symbol == _symbol &&
        period == _period &&
        step == _step &&
        maximum == _maximum) {
      return true;
    }
    return false;
  }

  double _step;
  double _maximum;
};

class SARHandler : BaseHandler {
public:
  static SARHandler *Instance() {
    static SARHandler instance;
    return &instance;
  }
  
  int CreateHandle(const string symbol, ENUM_TIMEFRAMES period, double step, double maximum)
  {
    // find a handle already created
    for (int i = 0; i < _handle_count; i++) {
      if ((*(SARHandleWrapper*)_handles[i]).IsSame(symbol, period, step, maximum)) {
        int handle = (*_handles[i]).handle();
        if (handle != INVALID_HANDLE) {
          return handle;
        } else {
          delete _handles[i];
          handle = NULL;
        }
      }
    }
    
    // if no matching, create new handle
    BaseHandleWrapper *newHandle = (BaseHandleWrapper*)new SARHandleWrapper(symbol, period, step, maximum);
    AddHandle(newHandle);
    return (*newHandle).handle();
  }
};

#endif /* Handle_SARHandler */
