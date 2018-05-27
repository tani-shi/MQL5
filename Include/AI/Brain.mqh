#ifndef AI_BRAIN
#define AI_BRAIN

#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

#include <AI\BaseLogic.mqh>

enum LOGIC_TYPE {
  LOGIC_TYPE_MAXIMUM
};

class Brain {
public:
  Brain();
  virtual ~Brain();
  
  void Update();
  void SetTradingLogic(BaseLogic *logic);

private:
  BaseLogic *_logics[];
  BaseLogic *_trading_logic;
};

Brain::Brain()
{
  for (int i = 0; i < LOGIC_TYPE_MAXIMUM; i++) {
    switch ((LOGIC_TYPE)i) {
      default: break;
    }
  }
}

Brain::~Brain()
{
  if (_trading_logic != NULL) {
    delete _trading_logic;
    _trading_logic = NULL;
  }
  
  for (int i = 0; i < LOGIC_TYPE_MAXIMUM; i++) {
    delete _logics[i];
    _logics[i] = NULL;
  }
}

void Brain::Update()
{
  MarketInformation info;
  // update only one logic when it's trading
  if (_trading_logic != NULL) {
    (*_trading_logic).Update(info);
    if (!(*_trading_logic).IsTrading()) {
      SetTradingLogic(NULL);
    }
  // update all logics
  } else {
    for (int i = 0; i < LOGIC_TYPE_MAXIMUM; i++) {
      if (_logics[i] != NULL) {
        (*_logics[i]).Update(info);
        if ((*_logics[i]).IsTrading()) {
          SetTradingLogic(_logics[i]);
        }
      }
    }
  }
}

void Brain::SetTradingLogic(BaseLogic *logic)
{
  if (_trading_logic != NULL) {
    delete _trading_logic;
    _trading_logic = NULL;
  }
  
  if (logic != NULL) {
    _trading_logic = logic;
  }
}

#endif /* AI_BRAIN */
