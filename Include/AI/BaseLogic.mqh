#ifndef AI_BASELOGIC
#define AI_BASELOGIC

#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <AI\MarketInformation.mqh>

class BaseLogic {
public:
  BaseLogic(const string symbol);
  virtual ~BaseLogic();
  
  virtual bool Update(const MarketInformation& info);
  virtual void ClearCache();
  
  bool IsTrading() const;
  
private:
  bool _is_trading;
  string _symbol;
};

BaseLogic::BaseLogic(const string symbol)
: _is_trading(false)
, _symbol(symbol)
{
}

BaseLogic::~BaseLogic()
{
}

bool BaseLogic::Update(const MarketInformation &info)
{
  // deny to update if already someone has started trading
  if (!PositionSelect(_symbol) || _is_trading) {
    return true;
  }
  return false;
}

void BaseLogic::ClearCache()
{
}

#endif /* AI_BASELOGIC */
