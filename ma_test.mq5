//+------------------------------------------------------------------+
//|                                                      MA_Test.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#include <Indicators\Trend.mqh>
#property indicator_buffers 1
#property indicator_plots   1

#property indicator_label1  "MA"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

//--- Parameters MA
input int ma1_period = 20;
input int ma1_shift = 0;
input ENUM_MA_METHOD ma1_method = MODE_SMA;
input ENUM_APPLIED_PRICE ma1_price = PRICE_CLOSE;
int ma_handle;
double ma_value[];
double MA_Buffer[];
CiMA ma;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   
   //--- if the indicator is not created
   if(!ma.Create(_Symbol,PERIOD_CURRENT,ma1_period,ma1_shift,ma1_method,ma1_price))
     {
      //--- tell about the failure and output the error code
      PrintFormat("Failed to create of the iMA indicator H1 for the symbol %s/%s, error code %d",
                  Symbol(),
                  EnumToString(PERIOD_CURRENT),
                  GetLastError());
      //--- the indicator is stopped early
      return(INIT_FAILED);
     }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   ma.Refresh();
   Comment(ma.Main(0));
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
