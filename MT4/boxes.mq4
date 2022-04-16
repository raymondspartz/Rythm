//+------------------------------------------------------------------+ 

#property indicator_chart_window
//#property indicator_buffers 4


extern int     Indicator_Tag  =  0;
 
extern bool    WriteGlobals   = false ;

extern bool    QuickInit      = true ;
 
extern double myBoxSizePoints0 = 180.0 ;
extern double myBoxSizePoints1 = 127.0 ;
extern double myBoxSizePoints2 = 90.0 ;
extern double myBoxSizePoints3 = 63.0 ;
extern double myBoxSizePoints4 = 45.0 ;
extern double myBoxSizePoints5 = 32.0 ;
extern double myBoxSizePoints6 = 23.0 ;
extern double myBoxSizePoints7 = 16.0 ;
extern double myBoxSizePoints8 = 11.0 ;

extern bool   Show_Comment       = false ; 
extern bool   Show_Signals       = false ; 
 
extern bool   Show_Labels        = false ;
extern bool   Show_Boxes         = false ;
extern bool   Show_Level         = false ;
extern bool   Show_Side_Markers  = false ; 
 

extern bool   AllLinesBackground = true ;   
input ENUM_LINE_STYLE    Line_Style    = STYLE_SOLID ;
extern int    Line_Width               = 1 ;

extern color  Line_Color_0    = clrBlue ;
extern color  Line_Color_1    = clrBrown ; 
extern color  Line_Color_2    = clrRed ;
extern color  Line_Color_3    = clrGreen ;
extern color  Line_Color_4    = clrOrange;  

extern color  Color_Up        = clrGreen;
extern color  Color_Dn        = clrRed;  

extern color colorHead        = clrDodgerBlue ;
extern color colorText        = clrOrange ;

extern color MaxColor         = clrMagenta;
extern color ThresholdColor   = clrBlack;

extern int myChartX   = 10 ;
extern int myChartY   = 10 ;  


double point ;
string symbol ,  ShortName, DEBUGMSG, TRADEMSG;  
int    digits ;
 
double RngHigh[5], RngLow[5], RngSize[5], C, theBoxSize, Position ;  
double Location[5],LocationMax[5] ;
 
color  Color[5],ColorUp[5],ColorDn[5] ; 
 
bool   BoxMovedUp[5], BoxMovedDn[5], Fib6080[5];  
bool   QuickInitDone ;


int      nHH, nLL, nHH1, nLL1, minHHLL;
double   HH, LL, HH1, LL1, RNG, RNG1   ;  
datetime STARTTIME;    
double   PRICEMAX, PRICEMIN;    
string   sBoxSize;

color  Color1, Color2 ; 
int    numboxes = 10;
string   sDirMsg ;

int    BSP[5];
double curr[11], prev[11] ;

string lbl[100], lbl2[100];
int    n , j  ; 
int FillAmt = 100 , x001, x002, x003, x004, x005, x006, x007 ;   
color  pColor ;
bool   TradeLong, TradeShort, LongTriggerArray[9],ShortTriggerArray[9]  ;
 
int    myStartTrigger   = 0;
int    myEndTrigger     = 8; 
  
double VALUE;  
 
string sComment   = "";
string sp         = "----------------------------------------\n";
string NL         = "\n";
  
//+------------------------------------------------------------------+
int init()
{
/*
   SetIndexStyle(0,DRAW_NONE);  
   SetIndexStyle(1,DRAW_NONE); 
   SetIndexBuffer(1,curr);
   SetIndexBuffer(2,prev); 
   SetIndexEmptyValue(1,0.0);
   SetIndexEmptyValue(2,0.0);    
 */  

   symbol       =  Symbol() ;
   digits       =  Digits ;
   point        =  Point ;
 
   if(digits == 5 || digits == 3) { digits = digits - 1 ; point = point * 10 ; }   
 
   
   ShortName    =  "boxes"+Indicator_Tag  ;
 
     
   ArrayResize(RngHigh , numboxes) ;
   ArrayResize( RngLow, numboxes) ;
   ArrayResize(RngSize , numboxes) ;
   ArrayResize( Location, numboxes) ;
   ArrayResize( LocationMax, numboxes) ;
   ArrayResize(Color , numboxes) ;
   ArrayResize( ColorUp, numboxes) ;
   ArrayResize(ColorDn , numboxes) ;
   ArrayResize(BoxMovedUp , numboxes) ;
   ArrayResize(BoxMovedDn , numboxes) ;
   ArrayResize(Fib6080 , numboxes) ;
   ArrayResize(BSP , numboxes) ;
   
       
   for(int i; i<numboxes; i++)
   {
      RngHigh[i]     = Close[0] ;
      RngLow[i]      = Close[0] ;
      BoxMovedUp[i]  = false ;
      BoxMovedDn[i]  = false ; 
   }
   
   Color[0] = Line_Color_0 ;
   Color[1] = Line_Color_1 ;
   Color[2] = Line_Color_2 ;
   Color[3] = Line_Color_3 ;
   Color[4] = Line_Color_4 ;

/*
   ColorUp[0] = clrDarkGreen ;
   ColorUp[1] = clrMediumSeaGreen ;
   ColorUp[2] = clrGreen ;
   ColorUp[3] = clrLime ;
   ColorUp[4] = clrLimeGreen ;
 
 
   ColorDn[0] = clrMaroon ;
   ColorDn[1] = clrCrimson ;
   ColorDn[2] = clrRed ;
   ColorDn[3] = clrDarkRed ;
   ColorDn[4] = clrFireBrick ; 
*/
 
   ColorUp[0] = clrGreen ;
   ColorUp[1] = clrGreen ;
   ColorUp[2] = clrGreen ;
   ColorUp[3] = clrGreen ;
   ColorUp[4] = clrGreen ;
 
 
   ColorDn[0] = clrRed ;
   ColorDn[1] = clrRed ;
   ColorDn[2] = clrRed ;
   ColorDn[3] = clrRed ;
   ColorDn[4] = clrRed ; 
   
   BSP[0]    = int(myBoxSizePoints0);
   BSP[1]    = int(myBoxSizePoints1);
   BSP[2]    = int(myBoxSizePoints2);
   BSP[3]    = int(myBoxSizePoints3);
   BSP[4]    = int(myBoxSizePoints4);
   BSP[5]    = int(myBoxSizePoints5);
   BSP[6]    = int(myBoxSizePoints6);
   BSP[7]    = int(myBoxSizePoints7);
   BSP[8]    = int(myBoxSizePoints8);
 
     
   QuickInitDone = false ;

   
  
      
   deinit() ;

   LongTriggerArray[0] = true  ;
   LongTriggerArray[1] = false ;
   LongTriggerArray[2] = false ;
   LongTriggerArray[3] = false ;
   LongTriggerArray[4] = true ;
   LongTriggerArray[5] = false ;
   LongTriggerArray[6] = false ;
   LongTriggerArray[7] = false ;
   LongTriggerArray[8] = true ;   
   
   ShortTriggerArray[0] = false  ;
   ShortTriggerArray[1] = true ;
   ShortTriggerArray[2] = true ;
   ShortTriggerArray[3] = true ;
   ShortTriggerArray[4] = false ;
   ShortTriggerArray[5] = true ;
   ShortTriggerArray[6] = true ;
   ShortTriggerArray[7] = true ;
   ShortTriggerArray[8] = false ; 
 
   return(0);
}
  

//+------------------------------------------------------------------+

void ObDeleteObjectsByPrefix(string Prefix)
{
   int ll = StringLen(Prefix);
   int ii = 0; 
   while(ii < ObjectsTotal())
     {
       string ObjName = ObjectName(ii);
       if(StringSubstr(ObjName, 0, ll) != Prefix) 
         { 
           ii++; 
           continue;
         }
       ObjectDelete(ObjName);
     }
}  
    
//+------------------------------------------------------------------+
int deinit()
{
     
   ObDeleteObjectsByPrefix(ShortName);   
   Comment("");   
   

   return(0);
}
  
//+------------------------------------------------------------------+
int start()
{
   DEBUGMSG = "";
   
   ObDeleteObjectsByPrefix(ShortName);;
   
   C        = Close[0];

   DoCalcBox( 0, myBoxSizePoints0 ); 
  
   DoCalcBox( 1, myBoxSizePoints1 ); 
 
   DoCalcBox( 2, myBoxSizePoints2 ); 
 
   DoCalcBox( 3, myBoxSizePoints3 ); 
   
   DoCalcBox( 4, myBoxSizePoints4 );
   DoCalcBox( 5, myBoxSizePoints5 ); 
   DoCalcBox( 6, myBoxSizePoints6 ); 
   DoCalcBox( 7, myBoxSizePoints7 ); 
   DoCalcBox( 8, myBoxSizePoints8 ); 
 
    
   DoCalcTrade(); 
  
  

   QuickInitDone = true ;

 
   for( int  i=0; i<numboxes+1; i++)
   {
      curr[i+1] = BSP[i] ;
      
   }   

   for(int g=0; g<100; g++) 
   {
      lbl2[g]  = "" ;
   }
        
   n       = 10;
   j       = 1 ;
 
    

   TradeLong  = true; 
   TradeShort = true; 
  
   for( g=myStartTrigger; g<=myEndTrigger; g++) 
   {   
      if( BoxMovedDn[g] != ShortTriggerArray[g]) { TradeShort = false;  }
      if( BoxMovedUp[g] != LongTriggerArray[g])  { TradeLong  = false;  }
   }
    
   if(TradeLong)
   {
      j = j + 1 ;
      lbl[j]  = ShortName+j;
      lbl2[j] = "TradeLong:"    ;
      DoShow(j , colorHead) ;
      Print(lbl2[j]);
   }
   
   if(TradeShort)
   {    
      j = j + 1 ;
      lbl[j]  = ShortName+j;
      lbl2[j] = "TradeShort:"  ;
      DoShow(j , colorHead) ;
      Print(lbl2[j]);
   }
 
   if(Show_Signals)
   { 
     for( g=0; g<9; g++) 
      {   
         if(BSP[g] > 0.0)
         {
            pColor = colorHead ;
            
            if( BoxMovedDn[g] == ShortTriggerArray[g] && ShortTriggerArray[g] == true) 
            { pColor = clrFireBrick ; } 
           
            if( BoxMovedUp[g] == LongTriggerArray[g] && LongTriggerArray[g] == true) 
            { pColor = clrDarkGreen ; }       
            
            j = j + 1 ;
            lbl[j]  = ShortName+j;
            lbl2[j] = int(BSP[g])+" BoxMovedUp:"+BoxMovedUp[g]+" LTA:" + LongTriggerArray[g] + " | BoxMovedDn:" +BoxMovedDn[g]+ " STA:"+ ShortTriggerArray[g];
            DoShow(j , pColor) ;
         } // if
   
      } // for
   } // if
    
 /*  
   sComment = "";
   
   for(int s=0;s<numboxes;s++)
   {
      sComment = sComment + BSP[s]+ " | " + BoxMovedUp[s] + " | " + DoubleToStr(Location[s],0)+"%" + NL;
   }
      
   Comment(sComment); 
 */          
   return(0);
}
  


//+------------------------------------------------------------------+

void DoCalcTrade(  )
{ 
   TRADEMSG = "*** WAIT ***" ;

   if( BoxMovedDn[3] == true )
   { 
      for( int d=0; d<4; d++)
      {
         Fib6080[d] = Location[d] <= 40.0 && Location[d] >= 20.0 ;
      }
      
      if( Fib6080[0] && Fib6080[1] && Fib6080[2] )
      {
         TRADEMSG = "*** BUY ***" ;
         return;
      }
      
   } // if

   if( BoxMovedUp[3] == true )
   { 
      for(   d=0; d<numboxes; d++)
      {
         Fib6080[d] = Location[d] <= 80.0 && Location[d] >= 60.0 ;
      }
      
      if( Fib6080[0] && Fib6080[1] && Fib6080[2] )
      {
         TRADEMSG = "*** SHORT ***" ;
         return;
      }
      
   } // if
 
   return;   
}

//+------------------------------------------------------------------+

void DoCalcBox( int b, double bBoxSize)
{  
  
  theBoxSize = bBoxSize * Point ;

  if(theBoxSize == 0.0) { return; }
   
  RngSize[b]  = RngHigh[b] - RngLow[b] ;
   
// build first box
 
   if(!QuickInit)
   {          
      if( RngSize[b] < theBoxSize)
      {
         if( C > RngHigh[b])
         {
            RngHigh[b] = C ;
         }
         else
         if( C < RngLow[b])
         {
            RngLow[b] = C ;
         }  
         
//         DoShowComment(1) ;
                       
         return;
      }
   }
   else
   {
 
      
      if(!QuickInitDone)
      {
         
// build first box     
  
         for(int w=0; w<6000; w++)
         {
            nHH =  iHighest(symbol, PERIOD_M1,MODE_HIGH,w+1,0);   
            HH  =  iHigh(symbol, PERIOD_M1,nHH);         
         
            nLL =  iLowest(symbol, PERIOD_M1,MODE_LOW,w+1,0);   
            LL  =  iLow(symbol, PERIOD_M1,nLL);  
         
            RNG = (HH-LL);
            if( RNG >= theBoxSize ) {break;}
         
         } // for

         minHHLL = MathMax(nHH,nLL);
         
         for(w=0; w<6000; w++)
         {
            nHH1 =  iHighest(symbol, PERIOD_M1,MODE_HIGH,w+1,minHHLL);   
            HH1  =  iHigh(symbol, PERIOD_M1,nHH1);         
         
            nLL1 =  iLowest(symbol, PERIOD_M1,MODE_LOW,w+1,minHHLL);   
            LL1  =  iLow(symbol, PERIOD_M1,nLL1);  
            
            RNG1 = (HH1-LL1);
            if( RNG1 >= theBoxSize ) {break;}
            
         }  // for
               
         if(HH>HH1)
         {
            RngHigh[b]        = HH ;  
            RngLow[b]         = HH - theBoxSize ;  
            LocationMax[b] = 0.0 ;   
            Location[b]    = 0.0 ;                     
            BoxMovedUp[b]  = true ;
            BoxMovedDn[b]  = false ;
         }
         else
         { 
            RngLow[b]         = LL  ;
            RngHigh[b]        = LL + theBoxSize ;  
            LocationMax[b] = 0.0 ; 
            Location[b]    = 0.0 ;                                                        
            BoxMovedUp[b]  = false ;
            BoxMovedDn[b]  = true ; 
         } // if      
                 
         RngSize[b] = theBoxSize;
 
         
      } // if
           
   }   
      
// test for new box

   if( C > RngHigh[b])
   {
      RngHigh[b]     = C ;
      RngLow[b]      = RngHigh[b] - theBoxSize ;
      BoxMovedUp[b]  = true ;
      BoxMovedDn[b]  = false ;  
   }
   else
   if( C < RngLow[b])
   {
      RngLow[b]      = C ;
      RngHigh[b]     = RngLow[b] + theBoxSize ;
      BoxMovedUp[b]  = false ;
      BoxMovedDn[b]  = true ;           
   }  
     
// calc location in box

   if( RngSize[b] != 0.0 )
   {
   
      Location[b] = 100.0 * ( C - RngLow[b]) / ( RngSize[b]  ) ;

// https://docs.mql4.com/globals
// https://www.forexfactory.com/thread/146742-mt4-global-variables-my-new-best-friend
// https://github.com/iamideas/Mql-for-MT4/blob/master/GlobalVariable.h


      if(WriteGlobals)
      { 
         if(GlobalVariableSet( symbol+DoubleToStr(bBoxSize,digits),Location[b]) == 0) 
         {            
             int        err=GetLastError(); 
             DEBUGMSG = " error: " + err ;
             Print(TimeToStr(Time[0])+": "+symbol," Error failed with error(",err,")");
         }// if
      }// if
      
      
      sBoxSize = DoubleToStr(bBoxSize/10.0,1);
      
      if(BoxMovedUp[b] == false)
      {
      //   Color1         = Color[b];
      //   Color2         = Retrace_Color ;     
         Color1   = Color_Dn  ;
         Color[b] = Color_Dn ;
         sDirMsg  = "Down";
      }
      else
      {
      //   Color2         = Color[b];
      //   Color1         = Retrace_Color ;  
         Color1         = Color_Up   ;          
         Color[b]       = Color_Up ;
         sDirMsg     = "Up";   
         Location[b] = 100.0 - Location[b] ;
      }      
 /*     
      if(Show_Lines)
      {      
         drawLine(RngLow[b] ,"RL"+b, Color1 , Line_Style, sBoxSize+"-Low "+sDirMsg+" ", b    ) ;
         drawLine(RngHigh[b] ,"RH"+b, Color1 , Line_Style, sBoxSize+ "-High "+sDirMsg+" ", b    ) ;
      }
*/

      if( Location[b] > LocationMax[b] ) { LocationMax[b] = Location[b] ; }

      

    
   
   drawLine(RngLow[b] ,"RL"+b, Color1 , Line_Style, sBoxSize+" | "+sDirMsg+" ", b    ) ;
   drawLine(RngHigh[b] ,"RH"+b, Color1 , Line_Style, sBoxSize+ " | "+sDirMsg+" ", b    ) ;
           
  
   
              
     
/*
DEBUGMSG = DEBUGMSG +"b:"+ b + " LocationMax[b]= "+DoubleToStr(LocationMax[b],Digits) ;
DEBUGMSG = DEBUGMSG + " VALUE= "+DoubleToStr(VALUE,Digits) + "\n"   ;
   Comment(DEBUGMSG);
*/      
/*
      PRICEMAX    = RngHigh[b] ; 
      PRICEMIN    = C ; 
 //     STARTTIME   = MathMax(Time[nHH], Time[nLL]);
      STARTTIME   = Time[b+1] ;
      colorbox ("boxH"+b, STARTTIME, Time[0] , PRICEMAX, PRICEMIN, Color1) ;          

      PRICEMAX    = C ; 
      PRICEMIN    = RngLow[b] ; 
 //     STARTTIME   = MathMax(Time[nHH], Time[nLL]);
      STARTTIME   = Time[b+1] ;
      colorbox ("boxL"+b, STARTTIME, Time[0] , PRICEMAX, PRICEMIN, Color2) ;          
*/

      PRICEMAX    = RngHigh[b] ; 
      PRICEMIN    = RngLow[b] ; 
 //     STARTTIME   = MathMax(Time[nHH], Time[nLL]);
      STARTTIME   = Time[b+1] ;
      colorbox ("boxL"+b, STARTTIME, Time[b] , PRICEMAX, PRICEMIN, Color1, b) ;

/*
   Comment(
   "PRICEMAX= "+DoubleToStr(PRICEMAX,Digits) , "\n",
   "PRICEMIN= "+DoubleToStr(PRICEMIN,Digits) , "\n",
   "STARTTIME= "+TimeToStr(STARTTIME,TIME_MINUTES) , "\n",
   "");
*/    
   }// if   
   
   return;
}
  



//+-------------------------------------------------------------------------------------------+      
void colorbox(string name, double starttime, double endtime, double CBhigh, double CBlow, color col2, int dBar)
{
   string box = ShortName + name;

   double candleWidth=MathAbs(Time[1] - Time[2]);
   starttime = candleWidth * (6+dBar) + Time[0];  // 6 
   endtime  = candleWidth * (5+dBar) + Time[0];  // 7

  
   ObjectDelete(box);
   
   if (ObjectFind(box) != 0)
   {
      ObjectCreate(box,OBJ_RECTANGLE,0,0,0);
      ObjectSet(box,OBJPROP_TIME1,starttime);
      ObjectSet(box,OBJPROP_TIME2,endtime);
      ObjectSet(box,OBJPROP_PRICE1,CBhigh);
      ObjectSet(box,OBJPROP_PRICE2,CBlow);
      ObjectSet(box,OBJPROP_COLOR,col2);
      ObjectSet(box,OBJPROP_BACK,true);
   }
   else
   {      
      ObjectMove(box, 0, starttime,CBhigh);
      ObjectMove(box, 1, endtime, CBlow);
   } // if    
   
                    
}
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
void drawText( double lvl, string name, color Col, string text, int dBar) 
{ 

datetime StartTime, EndTime; 

   double candleWidth=MathAbs(Time[1] - Time[2]);
   StartTime = candleWidth * (6+dBar) + Time[0];   
   EndTime  = candleWidth * (0+dBar) + Time[0];  
   
   name = ShortName + name;

       if(ObjectFind(name) != 0)
      {
         ObjectCreate(name, OBJ_TEXT, 0, StartTime, lvl);
         ObjectSetText(name,text  , 8, "Terminal", Col);
      }
      else
      {
         ObjectMove(name, 0, StartTime, lvl);
      } // if 
}
//+------------------------------------------------------------------+
void drawLine(double lvl,  string name, color Col,int type,string text, int dBar)
{
   datetime StartTime, EndTime;     
   string   pipdist ;
   bool     RayRight ;
   int      theStyle ;

 //  StartTime = iTime(symbol,PERIOD_D1,0) ; 

   theStyle = Line_Style ;
   
   
//   EndTime  = Time[0] ;
   RayRight = true ;
 
 //  StartTime   = Time[dBar+1] ;
 
   double candleWidth=MathAbs(Time[1] - Time[2]);
   StartTime = candleWidth * (6+dBar) + Time[0];   
   EndTime  = candleWidth * (7+dBar) + Time[0];  
   
//   StartTime = Time[0] + (PERIOD_CURRENT * 60)*(dBar+1);  
 
   name = ShortName + name;
 
   ObjectDelete(name);
   ObjectCreate(name, OBJ_TREND, 0, StartTime, lvl,EndTime,lvl);
   ObjectSet(name, OBJPROP_STYLE, theStyle);    
   ObjectSet(name, OBJPROP_COLOR, Col);        
   ObjectSet(name,OBJPROP_WIDTH,Line_Width);
   ObjectSet(name,OBJPROP_BACK,false); 
   ObjectSet(name,OBJPROP_RAY,false); 
   
   name = ShortName + name+"vline";
 
   ObjectDelete(name);
//   ObjectCreate(name, OBJ_TREND, 0, Time[dBar+1], RngHigh[dBar],Time[dBar+1],RngLow[dBar]);
   ObjectCreate(name, OBJ_TREND, 0, EndTime, RngHigh[dBar],EndTime,RngLow[dBar]);
   ObjectSet(name, OBJPROP_STYLE, theStyle);    
   ObjectSet(name, OBJPROP_COLOR, clrDimGray);        
   ObjectSet(name,OBJPROP_WIDTH,Line_Width);
   ObjectSet(name,OBJPROP_BACK,false); 
   ObjectSet(name,OBJPROP_RAY,false); 

   name = ShortName + name+"vline2";
 
   ObjectDelete(name);
   ObjectCreate(name, OBJ_TREND, 0, EndTime, RngHigh[dBar],EndTime,RngLow[dBar]);
   ObjectSet(name, OBJPROP_STYLE, theStyle);    
   ObjectSet(name, OBJPROP_COLOR, clrDimGray);        
   ObjectSet(name,OBJPROP_WIDTH,Line_Width);
   ObjectSet(name,OBJPROP_BACK,false); 
   ObjectSet(name,OBJPROP_RAY,false); 
            
            
   if(Show_Level)
   {
            ObjectDelete(name+"X");
            ObjectCreate(name+"X", OBJ_HLINE, 0, 0, lvl );
            ObjectSet(name+"X", OBJPROP_STYLE, 5);    
            ObjectSet(name+"X", OBJPROP_COLOR, Col);        
   }
   
     //Determine the current chart scale (chart scale number should be 0-5) 
     

   if(Show_Labels)
   {         
     string Obj0002 = name+"linelbl" ;
     double lclose  ;
     
     int Chart_Scale  ,Bar_Width  ;      
     Chart_Scale = ChartScaleGet();
     
     //Set bar widths             
           if(Chart_Scale == 0) {Bar_Width = 100;}
     else {if(Chart_Scale == 1) {Bar_Width = 60;}      
     else {if(Chart_Scale == 2) {Bar_Width = 30;}
     else {if(Chart_Scale == 3) {Bar_Width = 15;}
     else {if(Chart_Scale == 4) {Bar_Width = 8;}
     else {Bar_Width = 4;} }}}}
 
     datetime LabelTime; 
     int LabelPeriod;
     
     if(Period() < PERIOD_MN1) { LabelPeriod = Period(); } else { LabelPeriod = PERIOD_MN1 + 10000 ; } 
     
     LabelTime = Time[0]+LabelPeriod*60*Bar_Width ; // Time[WindowFirstVisibleBar()/2]; // Time[0]+Period()*60*ShiftLabel ;   

         lclose  = iClose(symbol,PERIOD_D1,0) ;
//         pipdist = sDiff( lclose , lvl  )   ;   

      pipdist = DoubleToString(Location[dBar],0)+"%"; 
          
      ObjectDelete(Obj0002);
      
      if(ObjectFind(Obj0002) != 0)
      {
         ObjectCreate(Obj0002, OBJ_TEXT, 0, LabelTime, lvl);
         ObjectSetText(Obj0002,fFill(text+pipdist,22) , 8, "Terminal", Col);
      }
      else
      {
         ObjectMove(Obj0002, 0, LabelTime, lvl);
      } // if 
                 
   } // if     
   
   if(Show_Boxes)
   {  
     string dName = name+ "boxes" ;
     if (ObjectFind(dName) != 0)
      {
          ObjectCreate(dName,OBJ_ARROW,0,Time[0],lvl);
          ObjectSet(dName,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
          ObjectSet(dName,OBJPROP_COLOR,Col);  
      } 
      else
      {
         ObjectMove(dName,0,Time[0],lvl);
         ObjectSet(dName,OBJPROP_COLOR,Col);  
      } 
   } // if   
   
   if(Show_Side_Markers)
   {      
      ObjectDelete(name+"sm") ;
      ObjectCreate(name+"sm",OBJ_HLINE,0,0,lvl);
      ObjectSet(name+"sm",OBJPROP_COLOR,Col);
      ObjectSet(name+"sm",OBJPROP_HIDDEN,FALSE);
      ObjectSet(name+"sm",OBJPROP_STYLE,5);         
      ObjectSet(name+"sm",OBJPROP_BACK,false);  
   }        
           
}
//+-------------------------------------------------------------------------------------------+
//| Subroutine:  Get the chart scale number                                                   |
//+-------------------------------------------------------------------------------------------+
int ChartScaleGet()
{
  long result = -1;
  ChartGetInteger(0,CHART_SCALE,0,result);
  return((int)result);
}

//+------------------------------------------------------------------+

string fFill(string filled, int f ) 
{
   string FILLED ;
   
   FILLED = StringSubstr(filled + "                                         ",0,f) ;
   
   return(FILLED);
}

//+------------------------------------------------------------------+
string sDiff( double d1, double d2)
{   
   
   double d0 ;
   
   d0 = ( d1 - d2 ) / point ;

   return( DoubleToStr(d0,1) );
}

//+------------------------------------------------------------------+


/*  
  if (ObjectFind(sSHORTNAME) != 0)
      {
          ObjectCreate(sSHORTNAME,OBJ_TEXT,0,StartTime,RngHigh[numboxes-1]); 
          ObjectSetText(sSHORTNAME, sNum , myFontSize, myFont, clrDimGray );   
          ObjectSet(sSHORTNAME,OBJPROP_BACK,false) ;
      } 
      else
      {
         ObjectMove(sSHORTNAME,0,StartTime,RngHigh[numboxes-1]);
      }

*/


 

//+------------------------------------------------------------------+
  

//+------------------------------------------------------------------+
  
void DoShow( int u, color dsColor )
{

   ObjectCreate(lbl[u],23,0,Time[0],PRICE_CLOSE);

   ObjectSet(lbl[u],OBJPROP_XDISTANCE, x002+myChartX);
   ObjectSet(lbl[u],OBJPROP_YDISTANCE,n+myChartY);
   
/*   
   string Obj001 = lbl[u] + "val" ;
    
   ObjectCreate(Obj001,23,0,Time[0],PRICE_CLOSE);
   ObjectSet(Obj001, OBJPROP_CORNER, myCorner );
   ObjectSet(Obj001,OBJPROP_XDISTANCE, x003+myChartX);
   ObjectSet(Obj001,OBJPROP_YDISTANCE,n+myChartY);
   ObjectSetText(Obj001,"---",myFontSize,myFont,pColor);
*/
 
   n = n+20;
   
   return;

}

//+------------------------------------------------------------------+
string rtadjust( string rString )
{
 
 int sl = StringLen(rString) ;
 
 while(true)
 {
 
   if( sl == 6) { break ; } 
   if( sl == 5) { rString = " " + rString ; break ; } 
   if( sl == 4) { rString = "  " + rString ; break ; }    
   if( sl == 3) { rString = " " + rString ; break ; } 
   if( sl == 2) { rString = "  " + rString ; break ; } 
   if( sl == 1) { rString = "   " + rString ; break ; } 
    
   break ;
 }

   return(rString) ;
}   

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+


/*
Comment(
"ticks= ", ticks, "\n",
"XX= ", DoubleToStr(XX,Digits) , "\n",
"xBuffer[ticks]= ", DoubleToStr(xBuffer[ticks],Digits) , "\n",
"xBuffer[ticks-1]= ", DoubleToStr(xBuffer[ticks-1],Digits) , "\n",
"") ;

*/
 