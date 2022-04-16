#property  copyright "Copyright © 2021, Rythm Capital" 
#property  link      "http://www.rythm.io/" 
#property description "Rythm | Perfect Order 1.0" 

//+------------------------------------------------------------------+ 

#include <stdlib.mqh>
#include <WinUser32.mqh>  
 
input ENUM_TIMEFRAMES   Trigger_Period       = 0 ;

extern string           myHHMM               = "00:00" ;  
extern string           myHHMM_StartTrading  = "00:01" ;  
extern string           myHHMM_StopTrading   = "23:00" ; 
 
extern double 
         StopLoss          = 15.0 ,
         TakeProfit        = 50.0,
         TrailingStop      = 0.0;
         
extern string  
         Order_Setting     = "---------- Order Setting";
         
extern int
         MaxTrades         = 20,
         MaxTradesLong     = 1,
         MaxTradesShort    = 1,
         MagicNumber       = 1500;
         
extern double 
         Lots              = 0.01;

extern int 
         Risk              = 10; //10%
 
extern bool
         Die               = true,
         Show_Settings     = true;

extern bool    QuickInit      = true ;
extern bool    UseSmallest    = false ;

extern double MinBoxMovePoints = 0.0 ;

//=======================================================================

 extern string ma_set = "///////////////////Main settings///////////////////";
extern string pairs = "";
 
extern int update_seconds = 0;
extern ENUM_BASE_CORNER corner = CORNER_RIGHT_UPPER;
extern bool redraw_objects = false;
extern bool draw_data = true;
extern int window = 0;
 
extern string TFs = "640-538-160-40-33-10";
extern string DRs = "U-D-U-D-U-D-U";

string identif="EA_TRO_RS_SCALPER_9BOXES";
string spliter = "-";
string pairs_b[];
string TFs_b[]; // DOUBLE
string DRs_b[]; //  

 int overall_rectangles;
 int one_line_rectangles;
string str_spl_tf[];
string str_spl_dr[];

string str_spl_triggers[];

bool first_chek=false;
bool testing;
int Rectangle_X_real;
int Rectangle_Y_real;
int main_chart_width_pix_;
int main_chart_height_pix_;

double Triggers_b[];

int TriggerSets, TriggerArraySize ;

int      nHH, nLL, nHH1, nLL1, minHHLL;
double   HH, LL, HH1, LL1, RNG, RNG1 ,MODEBID,MODEASK  ;  

double point ;
string symbol , TAG, ShortName, DEBUGMSG, TRADEMSG;  
int    digits,p,q,j,n ;
 
double RngHigh[100][100], RngLow[100][100], RngSize[100][100], C, theBoxSize, LocationMax[100][100];  
double Location[100][100], BoxSizePoints[100];

color  Color[100][100], BoxColor ; 
 
bool   BoxMovedUp[100][100], BoxMovedDn[100][100] ;  
bool   QuickInitDone ;
datetime TriggerTime ;
//+------------------------------------------------------------------+
 
static int 
         TimeFrame         = 0;
string
         TicketComment     = "Rythm | Perfect Order",
         LastTrade;
bool
         TradeAllow        = true,
         EntryAllow        = true,
         LongEntryAllow    = true,         
         ShortEntryAllow   = true;  
   
        
datetime var1, START_TRADING, STOP_TRADING ;

string   yymmddms, OK, TRADE_MESSAGE,ORDER_MESSAGE, SP, TIMELOADED, TMHEAD, tTrigger_Period  ;
 
double   STOPLOSS,STOPLOSS_L,STOPLOSS_S, TAKEPROFIT, TAKEPROFIT_L,TAKEPROFIT_S,TAKEPROFITAMOUNT, STOPLOSSAMOUNT_L, TAKEPROFITAMOUNT_L, STOPLOSSAMOUNT , STOPLOSSAMOUNT_S, TAKEPROFITAMOUNT_S ; 
 

bool      TRADELONG, TRADESHORT, OK2TRADELong, OK2TRADEShort ;

int      period ,bs, ticket, total, MAGICNUMBER , TOTALTRADES ,  TradesThisBar, TOTALTRADES_LONG, TOTALTRADES_SHORT;   

    
double    BuyLevel, SellLevel; 

string sComment   = "";
string sp         = "----------------------------------------\n";
string NL         = "\n";
string eMode, TradeMessage ;   

int err  ; 
 
int LASTHOUR, THISHOUR ;   
datetime DATETIME;
 
int   numboxes;

bool  LastTradeLong ;
   
bool  TDIRL[14],TDIRS[14];   
   
//+------------------------------------------------------------------+
int OnInit()
{
   period       = Period() ;   
   symbol       = Symbol() ;
   digits       =  Digits ;
   point        =  Point ;
   
   if(digits == 5 || digits == 3) { digits = digits - 1 ; point = point * 10 ; }   
      
   tTrigger_Period=  TimeFrameToString(Trigger_Period);
   
   TIMELOADED     =  TimeToStr(Time[0]) ;
   
   ORDER_MESSAGE  = "";
   
   SP             = " ";

   eMode          = "TRORSSCALPER9BOXES" ;

   yymmddms = TimeYear(Time[0]) + "." + TimeMonth(Time[0]) + "." + TimeDay(Time[0]) + " " + myHHMM   ;   

   var1     = StrToTime(yymmddms); 

   bs       = iBarShift(symbol,PERIOD_H1,var1,false) ;
      

   MAGICNUMBER    = subGenerateMagicNumber(MagicNumber, Symbol(), Period());
	

   if(StopLoss == 0.0 ) { STOPLOSS = 0.0 ; STOPLOSSAMOUNT  = 0.0 ; } else { STOPLOSSAMOUNT  = StopLoss*Point  ; }
  
   if(TakeProfit == 0.0 ) { TAKEPROFIT = 0.0 ; TAKEPROFITAMOUNT  = 0.0 ; } else { TAKEPROFITAMOUNT  = TakeProfit*Point ; }
   
  
   
   LASTHOUR = -9 ;
   
   OnTimer();
   EventSetTimer(1); 

  //update seconds or every tick
  if(update_seconds>0) EventSetTimer(update_seconds);
   
  
  //is it testing
  testing=IsTesting();
  
  //pairs and TFs cut to buffs
  pairs_to_buf_f();
     
  TFs_to_buf_f();
  
     
  //overall rectangles and rectangles in one line
   overall_rectangles=ArraySize(TFs_b)*ArraySize(pairs_b);
   one_line_rectangles=ArraySize(pairs_b);

   numboxes = ArraySize(TFs_b);

 //pairs to market watch
 add_symbols_market_watch_f();
 
   QuickInitDone = false ;

 
   
 //  Comment("INIT 99 ",TimeToString(TimeCurrent(),TIME_SECONDS));
   
  
   return(INIT_SUCCEEDED);
}

    
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   EventKillTimer();
   TimeFrame=Period(); 
  
}
  
//+------------------------------------------------------------------+
void Part001( string bSymbol )
{   
//   Comment(TimeToString(TimeCurrent(),TIME_SECONDS) );
                     
   TRADE_MESSAGE  = "" ;
   
   EntryAllow     = false ;
   

   yymmddms = TimeYear(Time[0]) + "." + TimeMonth(Time[0]) + "." + TimeDay(Time[0]) + " " + myHHMM_StopTrading   ;   
  
   STOP_TRADING    = StrToTime(yymmddms); 
  
   yymmddms = TimeYear(Time[0]) + "." + TimeMonth(Time[0]) + "." + TimeDay(Time[0]) + " " + myHHMM_StartTrading   ;   
  
   START_TRADING    = StrToTime(yymmddms); 
  
   
   yymmddms = TimeYear(Time[0]) + "." + TimeMonth(Time[0]) + "." + TimeDay(Time[0]) + " " + myHHMM   ;   

   var1     = StrToTime(yymmddms); 
   
  
   if( iTime(bSymbol,PERIOD_M1,0) < START_TRADING || iTime(bSymbol,PERIOD_M1,0) >= STOP_TRADING ) 
   { 
      TRADE_MESSAGE = "WAITING FOR " + START_TRADING ;
     
      return  ; 
   } 

   EntryAllow        = false;
   TRADESHORT        = false;
   ShortEntryAllow   = false ;
   EntryAllow        = false;
   TRADELONG         = false; 
   LongEntryAllow    = false ;                  

//Comment(bSymbol, " Part001 99 ", TimeToString(TimeCurrent(),TIME_SECONDS));
   
   return;
}

 
 
//+------------------------------------------------------------------+
void Part002(string bSymbol, string bMessage)
{   

if(bSymbol != Symbol()) { Comment( "Part002 pair error", bSymbol, " ", Symbol() ); return; }
 
	TicketComment  = "";  
	ORDER_MESSAGE  = ""; 
 
 
   if(STOPLOSS == 0.0) 
   {
      STOPLOSS    = 5.0  ; 
      STOPLOSS_L  = BuyLevel  - STOPLOSS ;
      STOPLOSS_S  = SellLevel + STOPLOSS ;
   }


   if(TAKEPROFIT == 0.0) 
   {
      TAKEPROFIT    = 2.7  ; 
      TAKEPROFIT_L  = BuyLevel  + TAKEPROFIT ;
      TAKEPROFIT_S  = SellLevel - TAKEPROFIT ;
   }
  
   RefreshRates();
   
   MODEBID     = MarketInfo(bSymbol,MODE_BID);
   MODEASK     = MarketInfo(bSymbol,MODE_ASK);
   
   
   if(EntryAllow) 
   {
      TRADE_MESSAGE  = "<OK TO TRADE> "  ;

      if(STOPLOSSAMOUNT > 0.0 ) { STOPLOSS_L      = MODEASK-STOPLOSSAMOUNT ; }
      if(TAKEPROFITAMOUNT > 0.0){ TAKEPROFIT_L    = MODEASK+TAKEPROFITAMOUNT ; }

      if(STOPLOSSAMOUNT > 0.0 ) { STOPLOSS_S      = MODEBID+STOPLOSSAMOUNT ; }
      if(TAKEPROFITAMOUNT > 0.0){ TAKEPROFIT_S    = MODEBID-TAKEPROFITAMOUNT ; }
              
   }
   else      
   {     
      EntryAllow        = false; 
      ShortEntryAllow   = false ; 
      LongEntryAllow    = false ;  
      TRADE_MESSAGE     = TRADE_MESSAGE + " <NO TRADE> "  ;     
   }

   TOTALTRADES = subTotalTrade();
   
//   if(NewBar())

   DATETIME = iTime(bSymbol,PERIOD_M1,0) ;
   THISHOUR = TimeMinute(DATETIME) ;
   
   if(THISHOUR > LASTHOUR)
   { 
 //     if(TOTALTRADES > 0 ) { MoveStop() ; } // else { subDeleteOrder() ; }
      TradesThisBar = 0 ; 
      LASTHOUR       =  THISHOUR ;
   }   
 


   if(TradeAllow  )
   {
   

      if(total == 0 &&TOTALTRADES < MaxTrades && EntryAllow) 
      {
	      TicketComment  = StringConcatenate(bMessage , yymmddms, "-", bSymbol, "-", period );
             
         TMHEAD = TimeToStr(Time[0]) + SP + bSymbol + SP ;
 
         if(TOTALTRADES_SHORT < MaxTradesShort && TRADESHORT && ShortEntryAllow)                 
         {
            ticket = OrderSend(symbol,OP_SELL,Lots,SellLevel,STOPLOSS_S,TAKEPROFIT_S,TicketComment,MAGICNUMBER,0,Red);
//ORDER_MESSAGE = TMHEAD + " RED SELL " + myHHMM+  " tp=" + DoubleToStr(TAKEPROFIT_S,Digits );   
            if(ticket < 0) 
            {         
               err=GetLastError();
               Print(TimeToStr(Time[0])+": "+bSymbol," Error in SendTrade(): order send failed with error(",err,")");
            }
            else
            {
               ORDER_MESSAGE = TMHEAD + " RED SELL " + myHHMM+  " tp=" + DoubleToStr(TAKEPROFIT_S,Digits );  
               TradesThisBar = TradesThisBar + 1 ;
               LastTradeLong = false; 
               Print("");
               Print(ORDER_MESSAGE);  
               subOrderModify(OP_SELL) ;          
            }     
         }
    
         
         if(TOTALTRADES_LONG < MaxTradesLong && TRADELONG && LongEntryAllow)  
         {
            ticket = OrderSend(symbol,OP_BUY,Lots,BuyLevel,STOPLOSS_L,TAKEPROFIT_L,TicketComment,MAGICNUMBER,0,Green);          
//ORDER_MESSAGE = ORDER_MESSAGE + "\n" +TMHEAD + " GREEN BUY "+myHHMM+  " tp=" + DoubleToStr(TAKEPROFIT_L,Digits ); 

            if(ticket < 0) 
            {         
               err=GetLastError();
               Print(TimeToStr(Time[0])+": "+bSymbol," Error in SendTrade(): order send failed with error(",err,")");
            }
            else
            {
               ORDER_MESSAGE = ORDER_MESSAGE + "\n" +TMHEAD + " GREEN BUY "+myHHMM+  " tp=" + DoubleToStr(TAKEPROFIT_L,Digits ); 
               TradesThisBar = TradesThisBar + 1 ; 
               LastTradeLong = true; 
               Print("");
               Print(ORDER_MESSAGE);      
               subOrderModify(OP_BUY);                 
            } // if
         } // if  
         

//Comment(bSymbol, " Part002 90 ",TimeToString(TimeCurrent(),TIME_SECONDS)); 
         
      }// if
 
   } // if      

//Comment(bSymbol, " Part002 99 ",TimeToString(TimeCurrent(),TIME_SECONDS));  
   return;
}
  
  
//+------------------------------------------------------------------+
void Part003(string bSymbol)
{   

//----------------------- TRAILING STOP SECTION
   if(TrailingStop>0 && subTotalTrade()>0)
   {
      total = OrdersTotal();
      
      for(int cnt=0;cnt<total;cnt++)
      {
         if(OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) { OK= "ok" ; }

         if(OrderType()<=OP_SELL &&
            OrderSymbol()==bSymbol &&
            OrderMagicNumber()==MAGICNUMBER)
         {
            subTrailingStop(OrderType());
            return ;
         }
      }
   }   
 
//Comment(bSymbol, " Part003 99 ",TimeToString(TimeCurrent(),TIME_SECONDS)); 
   return;
}
  
  
//+------------------------------------------------------------------+
void Part004(string bSymbol)
{   
 
// https://www.mql5.com/en/forum/120736 
// this will remove expert from chart


   if( TOTALTRADES >= MaxTrades && Die )
   {
      TMHEAD         = TimeToStr(Time[0]) + SP + bSymbol + SP + TicketComment + myHHMM  ;
      TRADE_MESSAGE  = TMHEAD + SP + "Pending Orders Placed - EA removed from chart" ;  
      
      Print(TRADE_MESSAGE);
      PostMessageA( WindowHandle( Symbol(), Period()), WM_COMMAND, 33050, 0);  
   }
   

//Comment(bSymbol, " Part004 99 ",TimeToString(TimeCurrent(),TIME_SECONDS));    
   return;
}
 
//+------------------------------------------------------------------+
int subTotalTrade()
{
   int cnt, stotal ;
   string OT;

   stotal            = 0;
   TOTALTRADES_LONG  = 0; 
   TOTALTRADES_SHORT = 0;

   for(cnt=0;cnt<OrdersTotal();cnt++)
   {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) { OK= "ok" ; }
          
      if( OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICNUMBER) 
      {
         //Print(OrderComment()); 
         
         stotal++;
         
         OT = OrderType() ;
         
         if( OT == OP_BUYSTOP || OT == OP_BUYLIMIT || OT == OP_BUY )  { TOTALTRADES_LONG++ ; }
         
         if( OT == OP_SELLSTOP || OT == OP_SELLLIMIT ||  OT == OP_SELL ) { TOTALTRADES_SHORT++ ; }
      }
      
   }
   
   return(stotal);
}


//+------------------------------------------------------------------+
void subDeleteOrder()
{
   int
      cnt, 
      stotal = 0;

   stotal = OrdersTotal();
   for(cnt=stotal-1;cnt>=0;cnt--)
   {
      if(OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES))  { OK= "ok" ; }

      if(OrderSymbol()==Symbol() &&
         OrderMagicNumber()==MAGICNUMBER)
      {
         switch(OrderType())
         {
            case OP_BUYLIMIT :
            case OP_BUYSTOP  :
            case OP_SELLLIMIT:
            case OP_SELLSTOP :
               if(OrderDelete(OrderTicket()))  { OK= "ok" ; }
         }
      }
   }      
}
//+------------------------------------------------------------------+
void subOrderModify(int Type) 
{
   if(Type==OP_BUY)   // buy position is opened   
   {
     
         if(OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+TAKEPROFIT,0,Green)) { OK= "ok" ; }
         return;
     
   }

   if(Type==OP_SELL)   // sell position is opened   
   {
 
         if(OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-TAKEPROFIT,0,Red)) { OK= "ok" ;  }
         return;
    
   }
}

//+------------------------------------------------------------------+
void subTrailingStop(int Type)
{
   if(Type==OP_BUY)   // buy position is opened   
   {
      if(Bid-OrderOpenPrice()>Point*TrailingStop &&
         OrderStopLoss()<Bid-Point*TrailingStop)
      {
         if(OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*TrailingStop,OrderTakeProfit(),0,Green)) { OK= "ok" ; }
         return;
      }
   }

   if(Type==OP_SELL)   // sell position is opened   
   {
      if(OrderOpenPrice()-Ask>Point*TrailingStop)
      {
      if(OrderStopLoss()>Ask+Point*TrailingStop || OrderStopLoss()==0)
      {
         if(OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*TrailingStop,OrderTakeProfit(),0,Red)) { return;  }
         return;
      }
      }
   }
}


//+------------------------------------------------------------------+
int subGenerateMagicNumber(int xMagicNumber, string gsymbol, int timeFrame)
{
   int isymbol = 0;
   if (gsymbol == "EURUSD")       isymbol = 1;
   else if (gsymbol == "GBPUSD")  isymbol = 2;
   else if (gsymbol == "USDJPY")  isymbol = 3;
   else if (gsymbol == "USDCHF")  isymbol = 4;
   else if (gsymbol == "AUDUSD")  isymbol = 5;
   else if (gsymbol == "USDCAD")  isymbol = 6;
   else if (gsymbol == "EURGBP")  isymbol = 7;
   else if (gsymbol == "EURJPY")  isymbol = 8;
   else if (gsymbol == "EURCHF")  isymbol = 9;
   else if (gsymbol == "EURAUD")  isymbol = 10;
   else if (gsymbol == "EURCAD")  isymbol = 11;
   else if (gsymbol == "GBPUSD")  isymbol = 12;
   else if (gsymbol == "GBPJPY")  isymbol = 13;
   else if (gsymbol == "GBPCHF")  isymbol = 14;
   else if (gsymbol == "GBPAUD")  isymbol = 15;
   else if (gsymbol == "GBPCAD")  isymbol = 16;
   else                          isymbol = 17;
   if(isymbol<10) MAGICNUMBER = xMagicNumber * 10;
   return (StrToInteger(StringConcatenate(MAGICNUMBER, isymbol, timeFrame)));
}


//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
string subBoolToStr ( bool value)
{
   if(value) return ("True");
   else return ("False");
}


//+------------------------------------------------------------------+
string TimeFrameToString(int tf)
  {
   string tfs;
   switch(tf) 
     {
      case PERIOD_M1:  tfs="M1"; break;
      case PERIOD_M5:  tfs="M5"; break;
      case PERIOD_M15: tfs="M15"; break;
      case PERIOD_M30: tfs="M30"; break;
      case PERIOD_H1:  tfs="H1"; break;
      case PERIOD_H4:  tfs="H4"; break;
      case PERIOD_D1:  tfs="D1"; break;
      case PERIOD_W1:  tfs="W1"; break;
      case PERIOD_MN1: tfs="MN"; break;
      case 525600:     tfs="YR"; break;
     }
   return(tfs);
  }
  
//+------------------------------------------------------------------+

void DoCalcBox( int a, int b, double bBoxSize)
{  

   double   dpoint, theMoveSize;

   dpoint     = MarketInfo(pairs_b[a],MODE_POINT);
   
   theBoxSize = bBoxSize * dpoint ;
   
   theMoveSize = MinBoxMovePoints * dpoint ;
   
   if(theBoxSize == 0.0) { return; }
   
   RngSize[a][b]  = RngHigh[a][b] - RngLow[a][b] ;

// build first box
 
   if(!QuickInit)
   {          
      if( RngSize[a][b] < theBoxSize)
      {
         if( C > RngHigh[a][b])
         {
            RngHigh[a][b] = C ;
         }
         else
         if( C < RngLow[a][b])
         {
            RngLow[a][b] = C ;
         }  
                   
         return;
      }
   }
   else
   {
      if(!QuickInitDone)
      {        
         for(int w=0; w<2000; w++)
         {
            nHH =  iHighest(pairs_b[a], PERIOD_M1,MODE_HIGH,w+1,0);   
            HH  =  iHigh(pairs_b[a], PERIOD_M1,nHH);         
         
            nLL =  iLowest(pairs_b[a], PERIOD_M1,MODE_LOW,w+1,0);   
            LL  =  iLow(pairs_b[a], PERIOD_M1,nLL);  
         
            RNG = (HH-LL);
            if( RNG >= theBoxSize ) {break;}
         
         }

         minHHLL = MathMax(nHH,nLL);
         
         for( w=0; w<2000; w++)
         {
            nHH1 =  iHighest(pairs_b[a], PERIOD_M1,MODE_HIGH,w+1,minHHLL);   
            HH1  =  iHigh(pairs_b[a], PERIOD_M1,nHH1);         
         
            nLL1 =  iLowest(pairs_b[a], PERIOD_M1,MODE_LOW,w+1,minHHLL);   
            LL1  =  iLow(pairs_b[a], PERIOD_M1,nLL1);  
            
            RNG1 = (HH1-LL1);
            if( RNG1 >= theBoxSize ) {break;}
            
         }  
 
         if(HH>HH1)
         {
            RngHigh[a][b] = HH ;  
            RngLow[a][b]  = HH - theBoxSize ;
            BoxMovedUp[a][b]  = true ;
            BoxMovedDn[a][b]  = false ;  
            LastTradeLong     = true ;                 
         }
         else
         { 
            RngLow[a][b]  = LL  ;
            RngHigh[a][b]= LL + theBoxSize ; 
            BoxMovedUp[a][b]  = false ;
            BoxMovedDn[a][b]  = true ;
            LastTradeLong     = false ;                                                    
         } // if      
                 
         RngSize[a][b] = theBoxSize;
         
      } // if
   }   
   
    
// test for new box

   if( C > RngHigh[a][b] + theMoveSize)
   {
      RngHigh[a][b]     = C ;
      RngLow[a][b]      = RngHigh[a][b] - theBoxSize ;
      BoxMovedUp[a][b]  = true ;
      BoxMovedDn[a][b]  = false ;
      LocationMax[a][b] = 0.0 ;  
   }
   else
   if( C < RngLow[a][b] - theMoveSize)
   {
      RngLow[a][b]      = C ;
      RngHigh[a][b]     = RngLow[a][b] + theBoxSize ;
      BoxMovedUp[a][b]  = false ;
      BoxMovedDn[a][b]  = true ;
      LocationMax[a][b] = 0.0 ;            
   }  
     
// calc location in box

   BoxColor = clrDimGray ;

   if( RngSize[a][b] != 0.0 )
   {
      Location[a][b] = 100.0 * ( C - RngLow[a][b]) / ( RngSize[a][b]  ) ;
      
      if(BoxMovedDn[a][b] == true) 
      {  
         
         if( Location[a][b] > LocationMax[a][b] ) { LocationMax[a][b] = Location[a][b] ; }
                    
      } // if
      else
      {
      if(BoxMovedUp[a][b] == true) 
      {  
         Location[a][b] = 100.0 - Location[a][b] ;
         
         if( Location[a][b] > LocationMax[a][b] ) { LocationMax[a][b] = Location[a][b] ; }
            
      } // if    
    
      } // if
   }// if   

//Comment(pairs_b[a], " DoCalcBox 99 ",TimeToString(TimeCurrent(),TIME_SECONDS));    
   return;
}
  
//////////////////////////////////////////////////////
 
void OnTimer()
{
   All();
   
}
 
////////////////////////////////////////////////////////////////////////
void All()
{   
    //variables 
   int tf_count=0;
   int pair_count=0;
   bool first_raw_chaked=false;
   int      bdigits; 
   
   ////main
   
   DEBUGMSG = "";
     
   for(int k=0;k<ArraySize(pairs_b );k++)
   {
      for(int m=0;m<ArraySize(TFs_b) ;m++)
      {         
    
         RefreshRates();
          
         bdigits     = int(MarketInfo(pairs_b[k],MODE_DIGITS));
         MODEBID     = MarketInfo(pairs_b[k],MODE_BID);
         MODEASK     = MarketInfo(pairs_b[k],MODE_ASK);

         double data=0.0;

//Comment("pairs_b[k]:", pairs_b[k], " ALL 100 ",DoubleToStr(MODEBID,0), " ",TimeToString(TimeCurrent(),TIME_SECONDS)); 

   
         C     =  iClose(pairs_b[k],PERIOD_M1,0);
         data  =  data_get_f(pairs_b[k],k,m,BoxSizePoints[m]);

      } // for

      QuickInitDone = true ;
      

      DoCheckForTrade( "UDDDUDDDU" );

 
      
   }  // for
}   
 
//+------------------------------------------------------------------+

void DoCheckForTrade( string alertname    )
{
 
//Comment(" DoCheck03 00 ",alertname," ",TimeToString(TimeCurrent(),TIME_SECONDS));    
      double   ddigits, dclose ;
      
      string   alertvalues;
 
      
      for(int k=0;k<ArraySize(pairs_b );k++)
      {
   
         Part001(pairs_b[k]) ;
         
         RefreshRates();
         
         ddigits     = MarketInfo(pairs_b[k],MODE_DIGITS);
         dclose      = iClose(pairs_b[k],PERIOD_CURRENT,0) ;
         MODEBID     = MarketInfo(pairs_b[k],MODE_BID);
         MODEASK     = MarketInfo(pairs_b[k],MODE_ASK);

         TRADELONG   = true;
         TRADESHORT  = true;
         
         for(int t=0;t<numboxes;t++)
         {
            if( BoxMovedUp[k][t] != TDIRL[t] ) { TRADELONG  = false; } 
            if( BoxMovedUp[k][t] != TDIRS[t] ) { TRADESHORT = false; }        
         }
         
         if(TRADELONG)
         {
         
            alertvalues = "L" ;
            
 //           DoAlert( pairs_b[k] + " BUY " +  alertname + " " +  DoubleToString(dclose,int(ddigits) ), alertvalues ) ;
            
            BuyLevel          = MODEASK ;
            EntryAllow        = true;
            LongEntryAllow    = true ;  
            //Comment(" DoCheck03 BUY ",alertname," ",TimeToString(TimeCurrent(),TIME_SECONDS));     
            
         }// if  
         else
         {
            if(TRADESHORT)
            {
               alertvalues = "S"  ;
            
 //             DoAlert( pairs_b[k] + " SELL " + alertname + " " + DoubleToString(dclose,int(ddigits) ), alertvalues ) ;
               
               SellLevel         = MODEBID ;
               EntryAllow        = true;               
               ShortEntryAllow   = true ; 
            
            //Comment(" DoCheck03 SELL ",pairs_b[k]," ",alertname," ",TimeToString(TimeCurrent(),TIME_SECONDS));                    
            }// if           
         } //if            
    
         
         Part002(pairs_b[k],TFs) ;
         Part003(pairs_b[k]) ;
         Part004(pairs_b[k]) ;

      }
    

} 
//+------------------------------------------------------------------+
 
///////////////////////funcs
/////////////////////////////////////////////////////////////////////////
double data_get_f(string myPair, int a, int b, double bBoxSize)
{
   double value=0;


 DoCalcBox(a, b, bBoxSize ); 
 value = Location[a][b];
 
return(value);
}

////////////////////////////////////////////////////////////////////////
void pairs_to_buf_f()
{
   string str_spl[];
   
   if(pairs == "") { pairs = Symbol() ; } // TRO
   
   int size=StringSplit(pairs,StringGetCharacter(spliter,0),str_spl);
   
   ArrayResize(pairs_b,size);
   
   for(int i=0;i<size;i++)
   {
      pairs_b[i]=str_spl[i];
   }

DEBUGMSG = "pairs:"+ pairs+ " pairs_b[0]:"+ pairs_b[0]+" str_spl[0]:"+ str_spl[0] + NL;
DEBUGMSG = DEBUGMSG + " pairs_b[1]:"+ pairs_b[1]+" str_spl[1]:"+ str_spl[1] + NL;
//Comment(DEBUGMSG);
}

////////////////////////////////////////////////////////////////////////
void TFs_to_buf_f()
{
   int size=StringSplit(TFs,StringGetCharacter(spliter,0),str_spl_tf);
 
   ArrayResize(TFs_b,size);
   ArrayResize(BoxSizePoints,size);
   ArrayResize(RngHigh,size);
   ArrayResize(RngLow,size);
   ArrayResize(RngSize,size);
   ArrayResize(BoxMovedUp,size);
   ArrayResize(BoxMovedDn,size);
   ArrayResize(Location,size);
   ArrayResize(LocationMax,size);
 
   for(int i=0;i<size;i++)
   {
   //   TFs_b[i]=String_to_TF(str_spl_tf[i]);
      TFs_b[i]= int(str_spl_tf[i]);
      
      BoxSizePoints[i] = StrToDouble(str_spl_tf[i]) ;
   }
   
   int sizeDR=StringSplit(DRs,StringGetCharacter(spliter,0),str_spl_dr);
   
   ArrayResize(DRs_b,sizeDR);
 
   for( i=0;i<sizeDR;i++)
   { 
      DRs_b[i]= str_spl_dr[i];      
      
      if(DRs_b[i] == "U") 
           { TDIRL[i] = true; TDIRS[i] = false;} 
      else { TDIRS[i] = true; TDIRL[i] = false; } 
 //     DEBUGMSG = DEBUGMSG + " TDIRL[i] " +TDIRL[i]+ NL;   
   } 

}

////////////////////////////////////////////////////////////////////
string symb_cut_f(string symb,short half)
{
   string cutted_symb=symb;
   
   if(half==1) cutted_symb=StringSubstr(symb,0,3);
   if(half==2) cutted_symb=StringSubstr(symb,3,3);
   
   
   return(cutted_symb);
}
 ///////////////////////////////////////////////////////////////////
void add_symbols_market_watch_f()
{
   string pair_name;
   
   for(int i=0;i<ArraySize(pairs_b);i++)
   {
      pair_name=pairs_b[i];
      if(!SymbolInfoInteger(pair_name,SYMBOL_SELECT)) SymbolSelect(pair_name,true);
   }

} 
//+------------------------------------------------------------------+
