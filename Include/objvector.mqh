//+------------------------------------------------------------------+
//|                                                    objvector.mqh |
//|                                                      nicholishen |
//|                                   www.reddit.com/u/nicholishenFX |
//+------------------------------------------------------------------+
#property copyright "nicholishen"
#property link      "www.reddit.com/u/nicholishenFX"
#property version   "1.00"
#property strict
#include <Arrays\ArrayObj.mqh>

template<typename T>
class objvector : public CArrayObj
{
public:
   T operator[](const int index) const { return At(index); }
};

