#ifndef Handle_BaseHandler
#define Handle_BaseHandler

#property copyright "Shintaro Tanikawa"

class BaseHandleWrapper {
public:
  BaseHandleWrapper(const string symbol, ENUM_TIMEFRAMES period)
  : _symbol(symbol)
  , _handle(INVALID_HANDLE)
  , _period(period) {}
  
  virtual ~BaseHandleWrapper()
  {
    if (_handle != INVALID_HANDLE) {
      IndicatorRelease(_handle);
      _handle = INVALID_HANDLE;
    }
  }
  
  int handle() const { return _handle; }

protected:
  int _handle;
  string _symbol;
  ENUM_TIMEFRAMES _period;
};

class BaseHandler {
public:
  BaseHandler()
  : _handle_count(0) {}

protected:
  void AddHandle(BaseHandleWrapper *handle);

protected:
  BaseHandleWrapper *_handles[];
  int _handle_count;
};

void BaseHandler::AddHandle(BaseHandleWrapper *handle)
{
  ArrayResize(_handles, ++_handle_count);
  _handles[_handle_count - 1] = handle;
}

#endif /* Handle_BaseHandler */
