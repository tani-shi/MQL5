#ifndef Handle_BaseHandler
#define Handle_BaseHandler

#property copyright "Shintaro Tanikawa"

class BaseHandleWrapper {
public:
  int id;
  int handle;
};

class BaseHandler {
public:
  BaseHandler()
  : _handle_count(0) {}

  int GetHandle(int id);

protected:
  void AddHandle(BaseHandleWrapper *handle);

protected:
  BaseHandleWrapper *_handles[];
  int _handle_count;
};

int BaseHandler::GetHandle(int id)
{
  for (int i = 0; i < _handle_count; i++) {
    if (_handles[0] != NULL) {
      return (*_handles[0]).handle;
    }
  }
  return WRONG_VALUE;
}

void BaseHandler::AddHandle(BaseHandleWrapper *handle)
{
  ArrayResize(_handles, ++_handle_count);
  _handles[_handle_count - 1] = handle;
}

#endif /* Handle_BaseHandler */
