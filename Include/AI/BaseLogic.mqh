#ifndef AI_BASELOGIC
#define AI_BASELOGIC

#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <AI\MarketInformation.mqh>

class BaseLogic {
public:
  BaseLogic();
  virtual ~BaseLogic();
  
  virtual void Update(const MarketInformation& info);
  virtual void ClearCache();
  
  bool IsTrading() const;
  
private:
  bool _is_trading;
};

BaseLogic::BaseLogic()
: _is_trading(false)
{
}

BaseLogic::~BaseLogic()
{
}

void BaseLogic::Update(const MarketInformation &info)
{
}

void BaseLogic::ClearCache()
{
}

#endif /* AI_BASELOGIC */
