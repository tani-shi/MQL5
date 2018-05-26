//+------------------------------------------------------------------+
//|                                            AdvancedShortCuts.mq5 |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property description "The script to add some of utility shortcuts."

#include <Utilities.mqh>

//---------------------------------------------------------
// Properties

// screen shot
static const int kScreenShotSizeWidth = 1200;
static const int kScreenShotSizeHeight = 600;
static const ENUM_TIMEFRAMES kScreenShotTimeFramesList[] = {
  PERIOD_M1,
  PERIOD_M5,
  PERIOD_M15
};

// colors
static const long kVLineColor = clrRed;
static const long kHLineColor = clrGold;

// keyboards
static const string kKeyScreenShot                 = "P";
static const string kKeyAllTimeFramesToM1          = "1";
static const string kKeyAllTimeFramesToM5          = "2";
static const string kKeyAllTimeFramesToM15         = "3";
static const string kKeyAllTimeFramesToM30         = "4";
static const string kKeyAllTimeFramesToH1          = "5";
static const string kKeyAllTimeFramesToH4          = "6";
static const string kKeyAllTimeFramesToD1          = "7";
static const string kKeyAllTimeFramesToW1          = "8";
static const string kKeyAllTimeFramesToMN1         = "9";

//----------------------------------------------------------

class ChartEventHandler {
public:
  void OnChartEventKeyDown(const long &lparam,
                           const double &dparam,
                           const string &sparam)
  {
    const string keyString = Utilities::KeyCodeToString(lparam);
    if (keyString == kKeyAllTimeFramesToM1)
      Utilities::SetAllTimeFrames(PERIOD_M1);
    else if (keyString == kKeyAllTimeFramesToM5)
      Utilities::SetAllTimeFrames(PERIOD_M5);
    else if (keyString == kKeyAllTimeFramesToM15)
      Utilities::SetAllTimeFrames(PERIOD_M15);
    else if (keyString == kKeyAllTimeFramesToM30)
      Utilities::SetAllTimeFrames(PERIOD_M30);
    else if (keyString == kKeyAllTimeFramesToH1)
      Utilities::SetAllTimeFrames(PERIOD_H1);
    else if (keyString == kKeyAllTimeFramesToH4)
      Utilities::SetAllTimeFrames(PERIOD_H4);
    else if (keyString == kKeyAllTimeFramesToD1)
      Utilities::SetAllTimeFrames(PERIOD_D1);
    else if (keyString == kKeyAllTimeFramesToW1)
      Utilities::SetAllTimeFrames(PERIOD_W1);
    else if (keyString == kKeyAllTimeFramesToMN1)
      Utilities::SetAllTimeFrames(PERIOD_MN1);
    else if (keyString == kKeyScreenShot)
      Utilities::TakeScreenShotByTimeFramesList(ChartID(), kScreenShotTimeFramesList);
  }

  void OnChartEventMouseMove(const long &lparam,
                             const double &dparam,
                             const string &sparam)
  {
    _mousePositionX = (int)lparam;
    _mousePositionY = (int)dparam;
  }

  void OnChartEventMouseClick(const long &lparam,
                              const double &dparam,
                              const string &sparam)
  {
    // do something
  }

private:
  int _mousePositionX;
  int _mousePositionY;
};

int OnInit()
{
   // enable CHART_EVENT_MOUSE_MOVE messages
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,1);

   return(INIT_SUCCEEDED);
}

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
  static ChartEventHandler eventHandler;
  switch (id)
  {
    case CHARTEVENT_KEYDOWN:
      eventHandler.OnChartEventKeyDown(lparam, dparam, sparam);
      break;
    case CHARTEVENT_CLICK:
      eventHandler.OnChartEventMouseClick(lparam, dparam, sparam);
      break;
    case CHARTEVENT_MOUSE_MOVE:
      eventHandler.OnChartEventMouseMove(lparam, dparam, sparam);
      break;
    default:
      break;
  }
}
//+------------------------------------------------------------------+
