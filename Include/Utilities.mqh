//+------------------------------------------------------------------+
//|                                                    Utilities.mqh |
//|                                                Shintaro Tanikawa |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Shintaro Tanikawa"
#property link      "https://www.mql5.com"

static const string hLineName = "H-Line";
static const string vLineName = "V-Line";

static const int screenWidth = 1200;
static const int screenHeight = 600;

class Utilities {
public:
  template<typename T>
  static double GetBufferValueByHandle(int handle, int buffer_num, int start_pos, int count) {
    T buff[];
    ArrayResize(buff, count);
    if (CopyBuffer(handle, buffer_num, start_pos, count, buff) == 1) {
      return buff[0];
    }
    Print("failed to copy buffer by handle cause no data.");
    return 0;
  }

  static void TakeScreenShotByTimeFramesList(long chartId,
                                             const ENUM_TIMEFRAMES &timeframesList[])
  {
    int length = ArraySize(timeframesList);
    ENUM_TIMEFRAMES timeframes = ChartPeriod(chartId);
    for (int i = 0; i < length; ++i)
    {
      SetTimeFrames(chartId, timeframesList[i]);
      while (ChartPeriod(chartId) != timeframesList[i])
      {
        Sleep(100);
      }
      TakeScreenShot(chartId);
    }
    SetTimeFrames(chartId, timeframes);
  }

  static void TakeScreenShot(long chartId)
  {
    MqlDateTime stm;
    TimeToStruct(TimeCurrent(), stm);
    string name = StringFormat("ChartScreenShot-%s-%s-%d%02d%02d-%02d%02d.png",
                                  ChartSymbol(chartId),
                                  TimeFramesToString(ChartPeriod(chartId)),
                                  stm.year,
                                  stm.mon,
                                  stm.day,
                                  stm.hour,
                                  stm.min);

    if (ChartScreenShot(chartId, name, screenWidth, screenHeight))
      Print("Saved a screen shot of current chart. (", name, ")");
  }

  static void SetAllTimeFrames(const ENUM_TIMEFRAMES timeframes)
  {
    long chartId = ChartFirst();
    for (int i = 0; i < CHARTS_MAX; ++i)
    {
      SetTimeFrames(chartId, timeframes);
      chartId = ChartNext(chartId);
    }
  }

  static void SetTimeFrames(long chartId, const ENUM_TIMEFRAMES timeframes)
  {
    if (ChartPeriod(chartId) != timeframes)
    {
      ChartSetSymbolPeriod(chartId, ChartSymbol(chartId), timeframes);
    }
  }

  static void CreateHLine(const long chartId,
                          const int &x,
                          const int &y,
                          const long& clr)
  {
    datetime dt = 0;
    double price = 0;
    int window = 0;
    if (ChartXYToTimePrice(ChartID(), x, y, window, dt, price))
    {
      if (ObjectFind(chartId, hLineName))
      {
        ObjectDelete(chartId, hLineName);
      }

      if (ObjectCreate(chartId, hLineName, OBJ_HLINE, 0, dt, price))
      {
        ObjectSetInteger(chartId, hLineName, OBJPROP_COLOR, clr);

        ChartRedraw(ChartID());
      }
    }
  }

  static void CreateVLine(const long chartId,
                          const int &x,
                          const int &y,
                          const long& clr)
  {
    datetime dt = 0;
    double price = 0;
    int window = 0;
    if (ChartXYToTimePrice(ChartID(), x, y, window, dt, price))
    {
      if (ObjectFind(chartId, vLineName))
      {
        ObjectDelete(chartId, vLineName);
      }

      if (ObjectCreate(chartId, vLineName, OBJ_VLINE, window, dt, price))
      {
        ObjectSetInteger(chartId, vLineName, OBJPROP_COLOR, clr);

        ChartRedraw(ChartID());
      }
    }
  }

  static void CreateTextLabel(const long chartId,
                              const int &x,
                              const int &y,
                              const long& clr,
                              const string font,
                              const int fontSize)
  {
    datetime dt = 0;
    double price = 0;
    int window = 0;
    if (ChartXYToTimePrice(ChartID(), x, y, window, dt, price))
    {
      const string name = TimeToString(TimeCurrent(), TIME_DATE | TIME_SECONDS);
      if (ObjectCreate(chartId, name, OBJ_LABEL, window, dt, price))
      {
        ObjectSetInteger(chartId, name, OBJPROP_COLOR, clr);
        ObjectSetString(chartId, name, OBJPROP_FONT, font);
        ObjectSetInteger(chartId, name , OBJPROP_FONTSIZE, fontSize);

        ChartRedraw(chartId);
      }
    }
  }

  static string KeyCodeToString(const long &key)
  {
    switch ((int)key)
    {
      case 49: // Pressed Key 1
        return "1";
      case 50: // Pressed Key 2
        return "2";
      case 51: // Pressed Key 3
        return "3";
      case 52: // Pressed Key 4
        return "4";
      case 53: // Pressed Key 5
        return "5";
      case 54: // Pressed Key 6
        return "6";
      case 55: // Pressed Key 7
        return "7";
      case 56: // Pressed Key 8
        return "8";
      case 57: // Pressed Key 9
        return "9";
      case 65: // Pressed Key A
        return "A";
      case 66: // Pressed Key B
        return "B";
      case 67: // Pressed Key C
        return "C";
      case 68: // Pressed Key D
        return "D";
      case 69: // Pressed Key E
        return "E";
      case 70: // Pressed Key F
        return "F";
      case 71: // Pressed Key G
        return "G";
      case 72: // Pressed Key H
        return "H";
      case 73: // Pressed Key I
        return "I";
      case 74: // Pressed Key J
        return "J";
      case 75: // Pressed Key K
        return "K";
      case 76: // Pressed Key L
        return "L";
      case 77: // Pressed Key M
        return "M";
      case 78: // Pressed Key N
        return "N";
      case 79: // Pressed Key O
        return "O";
      case 80: // Pressed Key P
        return "P";
      case 81: // Pressed Key Q
        return "Q";
      case 82: // Pressed Key R
        return "R";
      case 83: // Pressed Key S
        return "S";
      case 84: // Pressed Key T
        return "T";
      case 85: // Pressed Key U
        return "U";
      case 86: // Pressed Key V
        return "V";
      case 87: // Pressed Key W
        return "W";
      case 88: // Pressed Key X
        return "X";
      case 89: // Pressed Key Y
        return "Y";
      case 90: // Pressed Key Z
        return "Z";
      default:
        return "";
    }
  }

  static bool IsKeyCodeNumber(const long &keyCode)
  {
    return (keyCode >= 49 && keyCode <= 57);
  }

  static bool IsKeyCodeAlphabet(const long &keyCode)
  {
    return (keyCode >= 65 && keyCode <= 90);
  }

  static string TimeFramesToString(ENUM_TIMEFRAMES timeframes)
  {
    switch (timeframes)
    {
      case PERIOD_M1:
        return "M1";
      case PERIOD_M5:
        return "M5";
      case PERIOD_M15:
        return "M15;";
      case PERIOD_M30:
        return "M30";
      case PERIOD_H1:
        return "H1";
      case PERIOD_H4:
        return "H4";
      case PERIOD_D1:
        return "D1";
      case PERIOD_W1:
        return "W1";
      case PERIOD_MN1:
        return "MN";
      default:
        return "";
    }
  }
};
//+------------------------------------------------------------------+
