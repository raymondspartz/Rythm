//+------------------------------------------------------------------+ 

#property strict
#property indicator_chart_window

//enum fonts set
enum fonts
{
font1,/*Aharoni*/ font2,/*Algerian*/ font3,/*Andalus*/ font4,/*Angsana New*/ font5,/*AngsanaUPC*/ font6,/*Aparajita*/ font7,/*Arabic Typesetting*/ font8,/*Arial*/ font9,/*Arial Black*/ 
font10,/*Arial Narrow*/ font11,/*Arial Unicode MS*/ font12,/*Baskenville Old Face*/ font13,/*Batang*/ font14,/*BatangChe*/ font15,/*Bauhaus 93*/ font16,/*Bell MT*/ font17,/*Berlin Sans FB*/ font18,/*Berlin Sans FB Demi*/ font19,/*Bernard MT Condensed*/ 
font20,/*Bodoni MT Poster Compressed*/ font21,/*Book Antiqua*/ font22,/*Bookman Old Style*/ font23,/*Bookshelf Symbol 7*/ font24,/*Britannic Bold*/ font25,/*Broadway*/ font26,/*Browallia New*/ font27,/*Browa|liaUPC*/ font28,/*Brush Script MT*/ font29,/*Calibri*/ 
font30,/*Calibri Light*/ font31,/*Californian FB*/ font32,/*Cambria*/ font33,/*Cambria Math*/ font34,/*Candara*/ font35,/*Centaur*/ font36,/*Century*/ font37,/*Century Gothic*/ font38,/*Chiller*/ font39,/*Colonna MT*/ 
font40,/*Comic Sans MS*/ font41,/*Consolas*/ font42,/*Constantia*/ font43,/*Cooper Black*/ font44,/*Corbel*/ font45,/*Cordia New*/ font46,/*CordiaUPC*/ font47,/*Courier*/ font48,/*Courier New*/ font49,/*DaunPenh*/ 
font50,/*David*/ font51,/*DFKai-SB*/ font52,/*DilleniaUPC*/ font53,/*DokChampa*/ font54,/*Dotum*/ font55,/*DotumChe*/ font56,/*Ebrima*/ font57,/*Estrangelo Edessa*/ font58,/*EucrosiaUPC*/ font59,/*Euphemia*/ 
font60,/*FangSong*/ font61,/*Fixedsys*/ font62,/*Footlight MT Light*/ font63,/*Franklin Gothic Medium*/ font64,/*FrankRuehl*/ font65,/*FreesiaUPC*/ font66,/*Freestyle Script*/ font67,/*Gabriola*/ font68,/*Garamond*/ font69,/*Gautami*/ 
font70,/*Georgia*/ font71,/*Gisha*/ font72,/*Gulim*/ font73,/*GulimChe*/ font74,/*Gungsuh*/ font75,/*GungsuhChe*/ font76,/*Haettenschweiler*/ font77,/*Harlow Solid Italic*/ font78,/*Harrington*/ font79,/*High Tower Text*/ 
font80,/*Impact*/ font81,/*Informal Roman*/ font82,/*IrisUPC*/ font83,/*Iskoola Pota*/ font84,/*JasmineUPC*/ font85,/*Jokerman*/ font86,/*Juice ITC*/ font87,/*KaiTi*/ font88,/*Kalinga*/ font89,/*Kartika*/ 
font90,/*Khmer UI*/ font91,/*KodchiangUPC*/ font92,/*Kokila*/ font93,/*Kristen ITC*/ font94,/*Kunstler Script*/ font95,/*Lao UI*/ font96,/*Latha*/ font97,/*Lato*/ font98,/*Lato Light*/ font99,/*Lato Semibold*/ 
font100,/*Leelawadee*/ font101,/*Levenim MT*/ font102,/*LilyUPC*/ font103,/*Lucida Bright*/ font104,/*Lucida Calligraphy*/ font105,/*Lucida Console*/ font106,/*Lucida Fax*/ font107,/*Lucida Handwriting*/ font108,/*Lucida Sans Unicode*/ font109,/*Magneto*/ 
font110,/*Malgun Gothic*/ font111,/*Mangal*/ font112,/*Marlett*/ font113,/*Matura MT Script Capitals*/ font114,/*Meiryo*/ font115,/*Meiryo UI*/ font116,/*Microsoft Himalaya*/ font117,/*Microsoft JhengHei*/ font118,/*Microsoft New Tai Lue*/ font119,/*Microsoft PhagsPa*/ 
font120,/*Microsoft Sans Serif*/ font121,/*Microsoft Tai Le*/ font122,/*Microsoft Uighur*/ font123,/*Microsoft YaHei*/ font124,/*Microsoft Yi Baiti*/ font125,/*MingLiU*/ font126,/*MingLiU_HKSCS*/ font127,/*MingLiU_HKSCS-ExtB*/ font128,/*MingLiU-ExtB*/ font129,/*Miriam*/ 
font130,/*Miriam Fixed*/ font131,/*Mistral*/ font132,/*Modern*/ font133,/*Modern No.20*/ font134,/*Mongolian Baiti*/ font135,/*Monotype Corsiva*/ font136,/*MoolBoran*/ font137,/*MS Gothic*/ font138,/*MS Mincho*/ font139,/*MS Outlook*/ 
font140,/*MS PGothic*/ font141,/*MS PMincho*/ font142,/*MS Reference Sans Serif*/ font143,/*MS Reference Specialty*/ font144,/*MS Sans Serifv*/ font145,/*MS Serif*/ font146,/*MS UI Gothic*/ font147,/*MT Extra*/ font148,/*MV Boli*/ font149,/*Narkisim*/ 
font150,/*Niagara Engraved*/ font151,/*Niagara Solid*/ font152,/*NSimSun*/ font153,/*Nyala*/ font154,/*Old English Text MT*/ font155,/*Onyx*/ font156,/*Palatino Linotype*/ font157,/*Parchment*/ font158,/*Plantagenet Cherokee*/ font159,/*Playbill*/ 
font160,/*PMingLiU*/ font161,/*PMingLiU-ExtB*/ font162,/*Poor Richard*/ font163,/*Raavi*/ font164,/*Ravie*/ font165,/*Rod*/ font166,/*Roman*/ font167,/*Sakkal Majalla*/ font168,/*Script*/ font169,/*Segoe Print*/ 
font170,/*Segoe Script*/ font171,/*Segoe UI*/ font172,/*Segoe UI Light*/ font173,/*Segoe UI Semibold*/ font174,/*Segoe UI Symbol*/ font175,/*Shonar Bangla*/ font176,/*Showcard Gothic*/ font177,/*Shruti*/ font178,/*SimHei*/ font179,/*Simplified Arabic*/ 
font180,/*Simplified Arabic Fixed*/ font181,/*SimSun*/ font182,/*SimSun-ExtB*/ font183,/*Small Fonts*/ font184,/*Snap ITC*/ font185,/*Stencil*/ font186,/*Sylfaen*/ font187,/*Symbol*/ font188,/*System*/ font189,/*Tahoma*/ 
font190,/*Tempus Sans ITC*/ font191,/*Terminal*/ font192,/*Times New Roman*/ font193,/*Traditional Arabic*/ font194,/*Trebuchet MS*/ font195,/*Tunga*/ font196,/*Utsaah*/ font197,/*Vani*/ font198,/*Verdana*/ font199,/*Vijaya*/ 
font200,/*Viner Hand ITC*/ font201,/*Vivaldi*/ font202,/*Vladimir Script*/ font203,/*Vrinda*/ font204,/*Webdings*/ font205,/*Wide Latin*/ font206,/*Wingdings*/ font207,/*Wingdings 2*/ font208,/*Wingdings 3*/ 
};
//fonts buf
string fonts_buf[208]=
{
"Aharoni","Algerian","Andalus","Angsana New","AngsanaUPC","Aparajita","Arabic Typesetting","Arial","Arial Black","Arial Narrow","Arial Unicode MS","Baskenville Old Face","Batang",
"BatangChe","Bauhaus 93","Bell MT","Berlin Sans FB","Berlin Sans FB Demi","Bernard MT Condensed","Bodoni MT Poster Compressed","Book Antiqua","Bookman Old Style","Bookshelf Symbol 7",
"Britannic Bold","Broadway","Browallia New","Browa|liaUPC","Brush Script MT","Calibri","Calibri Light","Californian FB","Cambria","Cambria Math","Candara","Centaur","Century","Century Gothic",
"Chiller","Colonna MT","Comic Sans MS","Consolas","Constantia","Cooper Black","Corbel","Cordia New","CordiaUPC","Courier","Courier New","DaunPenh","David","DFKai-SB","DilleniaUPC","DokChampa",
"Dotum","DotumChe","Ebrima","Estrangelo Edessa","EucrosiaUPC","Euphemia","FangSong","Fixedsys","Footlight MT Light","Franklin Gothic Medium","FrankRuehl","FreesiaUPC","Freestyle Script","Gabriola",
"Garamond","Gautami","Georgia","Gisha","Gulim","GulimChe","Gungsuh","GungsuhChe","Haettenschweiler","Harlow Solid Italic","Harrington","High Tower Text","Impact","Informal Roman","IrisUPC",
"Iskoola Pota","JasmineUPC","Jokerman","Juice ITC","KaiTi","Kalinga","Kartika","Khmer UI","KodchiangUPC","Kokila","Kristen ITC","Kunstler Script","Lao UI","Latha","Lato","Lato Light","Lato Semibold",
"Leelawadee","Levenim MT","LilyUPC","Lucida Bright","Lucida Calligraphy","Lucida Console","Lucida Fax","Lucida Handwriting","Lucida Sans Unicode","Magneto","Malgun Gothic","Mangal","Marlett",
"Matura MT Script Capitals","Meiryo","Meiryo UI","Microsoft Himalaya","Microsoft JhengHei","Microsoft New Tai Lue","Microsoft PhagsPa","Microsoft Sans Serif","Microsoft Tai Le","Microsoft Uighur",
"Microsoft YaHei","Microsoft Yi Baiti","MingLiU","MingLiU_HKSCS","MingLiU_HKSCS-ExtB","MingLiU-ExtB","Miriam","Miriam Fixed","Mistral","Modern","Modern No.20","Mongolian Baiti","Monotype Corsiva",
"MoolBoran","MS Gothic","MS Mincho","MS Outlook","MS PGothic","MS PMincho","MS Reference Sans Serif","MS Reference Specialty","MS Sans Serifv","MS Serif","MS UI Gothic","MT Extra","MV Boli","Narkisim",
"Niagara Engraved","Niagara Solid","NSimSun","Nyala","Old English Text MT","Onyx","Palatino Linotype","Parchment","Plantagenet Cherokee","Playbill","PMingLiU","PMingLiU-ExtB","Poor Richard","Raavi",
"Ravie","Rod","Roman","Sakkal Majalla","Script","Segoe Print","Segoe Script","Segoe UI","Segoe UI Light","Segoe UI Semibold","Segoe UI Symbol","Shonar Bangla","Showcard Gothic","Shruti","SimHei",
"Simplified Arabic","Simplified Arabic Fixed","SimSun","SimSun-ExtB","Small Fonts","Snap ITC","Stencil","Sylfaen","Symbol","System","Tahoma","Tempus Sans ITC","Terminal","Times New Roman",
"Traditional Arabic","Trebuchet MS","Tunga","Utsaah","Vani","Verdana","Vijaya","Viner Hand ITC","Vivaldi","Vladimir Script","Vrinda","Webdings","Wide Latin","Wingdings","Wingdings 2","Wingdings 3"
};

extern bool Sound_Alert=false;
extern bool Mail=false;
extern bool Push=false;

extern bool    QuickInit      = true ;
extern bool    UseSmallest    = true ;
  
extern color  Color_UP = C'156,239,231' ; 
extern color  Color_UP_Trade = clrTurquoise ; 
extern color  Color_DN = C'241,101,129' ; 
extern color  Color_DN_Trade = clrCrimson ; 

extern color Text_price_color = clrBlack;

extern color MaxMove_color = clrBlack;
extern color Alert_Message_color = clrMagenta;

extern double MinBoxMovePoints = 0.0 ;

extern double MaxTradeValue = 99.0 ;
extern double MinTradeValue = 82.0 ;

extern double MaxThreshold = 100.0 ;


double point ;
string symbol , TAG, ShortName, DEBUGMSG, TRADEMSG;  
int    digits,p,q,j,n ;
 
double RngHigh[100][100], RngLow[100][100], RngSize[100][100], C, theBoxSize, LocationMax[100][100];  
double Location[100][100], BoxSizePoints[100] ;
 
color  Color[100][100], BoxColor ; 
 
bool   BoxMovedUp[100][100], BoxMovedDn[100][100] ;  
bool   QuickInitDone ;
datetime TriggerTime ;

double   StartRngHigh[100][100], StartRngLow[100][100] ;
double   MODEBID;
string   sPrice;
int      bdigits;

double   LastTradePrice[100];
string   LastTradeTrigger[100], sDirection;
bool     LastTradeUp[100];
datetime LateTradeTime[100]; 


//=======================================================================

extern string ma_set = "///////////////////Main settings///////////////////";
extern string pairs = "ETHUSD";

extern int update_seconds = 1;
extern ENUM_BASE_CORNER corner = CORNER_RIGHT_UPPER;
extern bool redraw_objects = false;
extern bool draw_data = true;
extern int window = 0;

extern string rec_set = "///////////////////Rectangles settings///////////////////";
extern int Rectangle_width = 80;
extern int Rectangle_height = 50;
extern int Rectangle_X = 60;
extern int Rectangle_X_step = 80;
extern int Rectangle_Y = 100;
extern int Rectangle_Y_step = 50;
extern int Rectangle_main_plus = 50;
extern color Rectangle_main_color = C'230,230,230';
extern color Rectangle_color_up = clrDodgerBlue;
extern color Rectangle_color_medium = clrLightGray;
extern color Rectangle_color_down = clrPink;
extern color Rectangle_border_color = clrBlack;
extern fonts Text_symb_font = font174; // font9
extern int Text_symb_size = 10;
extern int Text_symb_shift_X = -10;
extern int Text_symb_shift_Y = 30;
extern int Text_symb2_shift_Y = 12;
extern color Text_symb_color = clrBlack;
extern fonts Text_numb_font = font174; // font9
extern int Text_numb_size = 10;
extern int Text_numb_shift_X = -15;
extern int Text_numb_shift_Y = -25;
extern color Text_numb_color = clrBlack;
extern int Text_numb_digits = 0;
extern fonts Text_TF_font = font174; // font9
extern int Text_TF_size = 12;
extern int Text_TF_shift_X = 60;
extern int Text_TF_shift_Y = -30;
extern color Text_TF_color = clrBlack;


// string TFs = "250-320-400-500-640-800";

//string TFs = "313-345-380-417-459-505-555-611-672-740-814";

string TFs = "1792-2000-2256-2528-2828-3200-3584-4000-4512-5056-5656-14336";




string identif="RYTHM";
string spliter = "-";
string pairs_b[];
double TFs_b[];
 int overall_rectangles;
 int one_line_rectangles;
string str_spl_tf[];

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
double   HH, LL, HH1, LL1, RNG, RNG1   ;   

//+------------------------------------------------------------------+

int OnInit()
{ 
    
  //update seconds or every tick
   if(update_seconds>0) EventSetTimer(update_seconds);
  
    //delete all
   delete_all_objects_f();
  
  //is it testing
   testing=IsTesting();
  
  //pairs and TFs cut to buffs
   pairs_to_buf_f();
     
   TFs_to_buf_f();
  
     
  //overall rectangles and rectangles in one line
   overall_rectangles=ArraySize(TFs_b)*ArraySize(pairs_b);
 

   one_line_rectangles=ArraySize(pairs_b);

 //different corners
   X_Y_set_f();
 
      //main reactangle
   create_Rectangle_main_f();
 
 //pairs to market watch
   add_symbols_market_watch_f();
 
   QuickInitDone = false ;

   
   
 //  Comment("INIT 99 ",TimeToString(TimeCurrent(),TIME_SECONDS));
   
   return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+

void DoCalcBox( int a, int b, double bBoxSize)
{  
   DEBUGMSG = " no error "  ;

   double   dpoint, theMoveSize;

   dpoint     = MarketInfo(pairs_b[a],MODE_POINT);
   
   theBoxSize = bBoxSize * dpoint ;
   
   theMoveSize = MinBoxMovePoints * dpoint ;
   
   if(theBoxSize == 0.0) { return; }
   
   RngSize[a][b]  = RngHigh[a][b] - RngLow[a][b] ;


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
         
// build first box     
  
         for(int w=0; w<6000; w++)
         {
            nHH =  iHighest(pairs_b[a], PERIOD_M1,MODE_HIGH,w+1,0);   
            HH  =  iHigh(pairs_b[a], PERIOD_M1,nHH);         
         
            nLL =  iLowest(pairs_b[a], PERIOD_M1,MODE_LOW,w+1,0);   
            LL  =  iLow(pairs_b[a], PERIOD_M1,nLL);  
         
            RNG = (HH-LL);
            if( RNG >= theBoxSize ) {break;}
         
         } // for

         minHHLL = MathMax(nHH,nLL);
         
         for(int w=0; w<6000; w++)
         {
            nHH1 =  iHighest(pairs_b[a], PERIOD_M1,MODE_HIGH,w+1,minHHLL);   
            HH1  =  iHigh(pairs_b[a], PERIOD_M1,nHH1);         
         
            nLL1 =  iLowest(pairs_b[a], PERIOD_M1,MODE_LOW,w+1,minHHLL);   
            LL1  =  iLow(pairs_b[a], PERIOD_M1,nLL1);  
            
            RNG1 = (HH1-LL1);
            if( RNG1 >= theBoxSize ) {break;}
            
         }  // for
  
            
     
         if(HH>HH1)
         {
            RngHigh[a][b]        = HH ;  
            RngLow[a][b]         = HH - theBoxSize ;
            BoxMovedUp[a][b]     = true ;
            BoxMovedDn[a][b]     = false ;   
            StartRngHigh[a][b]   = RngHigh[a][b] ;  
            StartRngLow[a][b]    = RngLow[a][b] ;                           
         }
         else
         { 
            RngLow[a][b]         = LL  ;
            RngHigh[a][b]        = LL + theBoxSize ; 
            BoxMovedUp[a][b]     = false ;
            BoxMovedDn[a][b]     = true ;      
            StartRngHigh[a][b]   = RngHigh[a][b] ;  
            StartRngLow[a][b]    = RngLow[a][b] ;                                                         
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
      StartRngHigh[a][b]= RngHigh[a][b] ;  
      StartRngLow[a][b] = RngLow[a][b] ;  
   }
   else
   if( C < RngLow[a][b] - theMoveSize)
   {
      RngLow[a][b]      = C ;
      RngHigh[a][b]     = RngLow[a][b] + theBoxSize ;
      BoxMovedUp[a][b]  = false ;
      BoxMovedDn[a][b]  = true ;
      LocationMax[a][b] = 0.0 ;            
      StartRngHigh[a][b]= RngHigh[a][b] ;  
      StartRngLow[a][b] = RngLow[a][b] ; 
   }  
     
// calc location in box

   BoxColor = clrNONE ;

   if( RngSize[a][b] != 0.0 )
   {
      Location[a][b] = 100.0 * ( C - RngLow[a][b]) / ( RngSize[a][b]  ) ;
      
      if(BoxMovedDn[a][b] == true) 
      {          
         if( Location[a][b] > LocationMax[a][b] ) { LocationMax[a][b] = Location[a][b] ; }
   
         if( LocationMax[a][b] > MaxThreshold ) { BoxColor = clrDimGray ; } 
         else
         {         
            if( Location[a][b] <= MaxTradeValue && Location[a][b] >= MinTradeValue)
            {
               BoxColor = Color_DN_Trade ; 
            }  
            else
            {
               BoxColor = Color_DN ;  
            }   // if   
         }   // if                 
      } // if
      else
      {
      if(BoxMovedUp[a][b] == true) 
      {  
         Location[a][b] = 100.0 - Location[a][b] ;
         
         if( Location[a][b] > LocationMax[a][b] ) { LocationMax[a][b] = Location[a][b] ; }

         if( LocationMax[a][b] > MaxThreshold ) { BoxColor = clrLightGray ; } 
         else
         {         
            if( Location[a][b] <= MaxTradeValue && Location[a][b] >= MinTradeValue)
            {
               BoxColor = Color_UP_Trade ; 
            }  
            else
            {
               BoxColor = Color_UP ;  
            }   // if             
         } // if   
      } // if  
    
      } // if
   }// if   
   
   return;
}
  
//+------------------------------------------------------------------+

void OnDeinit(const int reason)
{
   delete_all_objects_f();
   
   

}


//+------------------------------------------------------------------+

int OnCalculate(const int rates_total,const int prev_calculated,const datetime &time[],const double &open[],const double &high[],
                const double &low[],const double &close[],const long &tick_volume[],const long &volume[],const int &spread[])
  {
 
 
  
 
  if(update_seconds==0 || !first_chek || testing) 
  {
   All();
   first_chek=true;
  }
 
 
   return(rates_total);
  }

//+------------------------------------------------------------------+

 
void OnTimer()
{
   All();
}
 
//+------------------------------------------------------------------+

void All()
{
    //chart size
  if(main_chart_width_pix_!=int(ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0)) || main_chart_height_pix_!=int(ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0))) 
  {
     main_chart_width_pix_=int(ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0));
     main_chart_height_pix_=int(ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0));
     //delete_all_objects_f();
     X_Y_set_f();
     create_Rectangle_main_f();
  }
 
    //variables
   int st_X=Rectangle_X_real;
   int st_Y=Rectangle_Y_real;
   int tf_count=0;
   int pair_count=0;
   bool first_raw_chaked=false;
   string rectan_name;
   
   ////main
   for(int y=1;y<=overall_rectangles;y++)
   {
      //rectangles drawing
      rectan_name=identif+"rectan"+string(y);
      create_Rectangle_f(rectan_name,st_X,st_Y);
      
      //symbols drawing
      if(!first_raw_chaked)
      {
         /*
         create_label_f(y,st_X-Text_symb_shift_X,st_Y-Text_symb_shift_Y,symb_cut_f(pairs_b[pair_count],1),Text_symb_size,"SYMB",Text_symb_color,fonts_buf[Text_symb_font]);
         create_label_f(y,st_X-Text_symb_shift_X,st_Y-Text_symb2_shift_Y,symb_cut_f(pairs_b[pair_count],2),Text_symb_size,"SYMB2",Text_symb_color,fonts_buf[Text_symb_font]);
         */
         create_label_f(y,st_X-Text_symb_shift_X,st_Y-Text_symb_shift_Y,pairs_b[pair_count],Text_symb_size,"SYMB",Text_symb_color,fonts_buf[Text_symb_font]);
         
          
         bdigits     = int(MarketInfo(pairs_b[pair_count],MODE_DIGITS));
         MODEBID     = MarketInfo(pairs_b[pair_count],MODE_BID);
         sPrice      = DoubleToString(MODEBID,bdigits);
         
         create_label_f(y,st_X-Text_symb_shift_X,st_Y-Text_symb2_shift_Y,sPrice,Text_symb_size,"SYMB2",Text_price_color,fonts_buf[Text_symb_font]);
         
      }// if
   
      double data=0.0;
      //data
       
      
      C     = iClose(pairs_b[pair_count],PERIOD_M1,0);
      data  = data_get_f(pairs_b[pair_count],pair_count,tf_count,BoxSizePoints[tf_count]);

   
      //numb draw
      /*
      if(draw_data) create_label_f(y,st_X-Text_numb_shift_X,st_Y-Text_numb_shift_Y,DoubleToString(data,Text_numb_digits),Text_numb_size,"NUMB",Text_numb_color,fonts_buf[Text_numb_font]);
      */
      
      string msg;
      color mcolor;
      
      msg = DoubleToString(data,Text_numb_digits) + " | " + DoubleToString(LocationMax[pair_count][tf_count],Text_numb_digits) ;
      
    //  Comment( DoubleToString(LocationMax[pair_count][tf_count],Digits)  + " | " +  DoubleToString(MinTradeValue,Digits) ); 
      
      if( LocationMax[pair_count][tf_count] > MinTradeValue ) {  mcolor = MaxMove_color ; } else {  mcolor = Text_numb_color ; }
      
      if(draw_data) create_label_f(y,st_X-Text_numb_shift_X,st_Y-Text_numb_shift_Y,msg,Text_numb_size,"NUMB",mcolor,fonts_buf[Text_numb_font]);
     
      //rectangle color set 
      color_set_f(rectan_name,data,BoxColor); 

      //counters
      st_X+=Rectangle_X_step;
      pair_count++;
      
      
   //raw end
      if(y%one_line_rectangles==0)
      {
         if(!first_raw_chaked) first_raw_chaked=true;
         
         st_X=Rectangle_X_real;
         create_label_f(y,st_X-Text_TF_shift_X,st_Y-Text_TF_shift_Y,str_spl_tf[tf_count],Text_TF_size,"TF",Text_TF_color,fonts_buf[Text_TF_font]); //TF drawing
         st_Y+=Rectangle_Y_step;
         tf_count++;
         pair_count=0; 
      } // if
    
   } // for

   QuickInitDone = true ;

 
   DoCheck03("BUY 2-18-135 ",true,0,66.0,82.0,true,5,66.0,82.0,true,10,66.0,82.0) ;
   DoCheck03("BUY 3-18-135 ",true,1,66.0,82.0,true,5,66.0,82.0,true,10,66.0,82.0) ;  
   DoCheck03("BUY 5-18-135 ",true,2,66.0,82.0,true,5,66.0,82.0,true,10,66.0,82.0) ;  
   DoCheck03("BUY 8-18-135 ",true,3,66.0,82.0,true,5,66.0,82.0,true,10,66.0,82.0) ;   
 
   DoCheck03("SELL 2-18-135 ",false,1,66.0,82.0,false,5,66.0,82.0,false,10,66.0,82.0) ;
   DoCheck03("SELL 3-18-135 ",false,2,66.0,82.0,false,5,66.0,82.0,false,10,66.0,82.0) ;  
   DoCheck03("SELL 5-18-135 ",false,3,66.0,82.0,false,5,66.0,82.0,false,10,66.0,82.0) ;  
   DoCheck03("SELL 8-18-135 ",false,4,66.0,82.0,false,5,66.0,82.0,false,10,66.0,82.0) ;    
   
      
}
 
//+------------------------------------------------------------------+

void DoCheck03( string alertname, bool boxmove1, int Loc1, double min1, double max1, 
                                  bool boxmove2, int Loc2, double min2, double max2, 
                                  bool boxmove3, int Loc3, double min3, double max3 
)
{
     double   dclose ;
     int      ddigits ;
     
     string   alertvalues;
     
     for(int k=0;k<ArraySize(pairs_b );k++)
     {
/*
        for(int m=0;m<ArraySize(TFs_b) ;m++)
        {
 */         
 
          if(alertname == LastTradeTrigger[k]) 
          { 

Comment(pairs_b[k], " CONTINUE ",TimeToString(TimeCurrent(),TIME_SECONDS), alertname, " <", LastTradeTrigger[k], ">");
            continue ; 
          }
          
         RefreshRates();
         
         MODEBID  = MarketInfo(pairs_b[k],MODE_BID);
         ddigits  = int(MarketInfo(pairs_b[k],MODE_DIGITS));
         dclose   = iClose(pairs_b[k],PERIOD_CURRENT,0) ;
                         
          if( UseSmallest)
          {
             if(LocationMax[k][Loc3] < MaxThreshold && MODEBID < StartRngHigh[k][Loc3] && MODEBID > StartRngLow[k][Loc3] && 
                Location[k][Loc1] < max1 && Location[k][Loc1] > min1 && BoxMovedUp[k][Loc1] == boxmove1 &&
                Location[k][Loc2] < max2 && Location[k][Loc2] > min2 && BoxMovedUp[k][Loc2] == boxmove2 &&
                Location[k][Loc3] < max3 && Location[k][Loc3] > min3 && BoxMovedUp[k][Loc3] == boxmove3  
               )
             {
               alertvalues = DoubleToString(Location[k][Loc1],0 ) +"-"+DoubleToString(Location[k][Loc2],0 )+"-"+DoubleToString(Location[k][Loc3],0 ) ;
               
               if(LastTradeUp[k] != boxmove3) { sDirection = " DIRECTION CHANGE ";  } 
               else { sDirection = " SAME DIRECTION "; }
     
               LastTradePrice[k]    = MODEBID ;
               LastTradeTrigger[k]  = alertname ;
               LastTradeUp[k]       = BoxMovedUp[k][Loc3] ;
               LateTradeTime[k]     = Time[0] ; // ?? TimeCurrent() 
                          
               DoAlert( pairs_b[k] + " " + alertname + " " + DoubleToString(dclose,int(ddigits) ), alertvalues + sDirection ) ;
               
             }// if  
          }// if  
          else
          {
             if(  LocationMax[k][Loc3] < MaxThreshold && MODEBID < StartRngHigh[k][Loc3] && 
                  Location[k][Loc2] < max2 && Location[k][Loc2] > min2 && BoxMovedUp[k][Loc2] == boxmove2 &&
                  Location[k][Loc3] < max3 && Location[k][Loc3] > min3 && BoxMovedUp[k][Loc3] == boxmove3  
               )
             {               
               alertvalues =  DoubleToString(Location[k][Loc2],0 )+"-"+DoubleToString(Location[k][Loc3],0 ) ;
 
               if(LastTradeUp[k] != boxmove3) { sDirection = " DIRECTION CHANGE ";  } 
               else { sDirection = " SAME DIRECTION "; }

               LastTradePrice[k]    = MODEBID ;
               LastTradeTrigger[k]  = alertname ;
               LastTradeUp[k]       = BoxMovedUp[k][Loc3] ;
               LateTradeTime[k]     = Time[0] ; // ?? TimeCurrent() 
 
//Comment(pairs_b[k], " loop ",TimeToString(TimeCurrent(),TIME_SECONDS), alertname, " <", LastTradeTrigger[k], ">");
                         
               DoAlert( pairs_b[k] + " " + alertname + " " + DoubleToString(dclose,int(ddigits) ), alertvalues + sDirection ) ;

            
             }// if           
          } //if
/*
          m  =  m + 3;
        } // for m
*/        
     } // for k
  
  string debugmsg;
  
  debugmsg = TimeToString(TimeCurrent(),TIME_SECONDS) + "\n";
  
  for(int u=0;u<ArraySize(pairs_b );u++)
  {
      ddigits  = int(MarketInfo(pairs_b[u],MODE_DIGITS));
      debugmsg = debugmsg + pairs_b[u] + " " + LastTradeTrigger[u] + DoubleToString(LastTradePrice[u],5) + " " + TimeToString(LateTradeTime[u],TIME_SECONDS)  + "\n" ; 
  
  }
     
  Comment(debugmsg);
}

///////////////////////funcs

//+------------------------------------------------------------------+

double data_get_f(string myPair, int a, int b, double bBoxSize)
{
   double value=0;

   DoCalcBox(a, b, bBoxSize ); 

   value = Location[a][b];

   return(value);
}

//+------------------------------------------------------------------+

void color_set_f(string name,double data, color bColor)
{
   color col=clrNONE;
   
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bColor);

}

//+------------------------------------------------------------------+

void create_Rectangle_f(string name,int X,int Y)
{

   if(ObjectFind(name)==-1)
   {
      ObjectCreate(name,OBJ_RECTANGLE_LABEL,window,0,0);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,Rectangle_width);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,Rectangle_height);
      //
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,clrNONE);
      ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_RAISED); 
      ObjectSetInteger(0,name,OBJPROP_COLOR,Rectangle_border_color); 
      //
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_LEFT);
      ObjectSetInteger(0,name,OBJPROP_BACK,false);
      ObjectSetInteger(0,name,OBJPROP_ZORDER,false);
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,name,OBJPROP_SELECTED,false);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
   }
   
   ObjectSetInteger(0,name, OBJPROP_XDISTANCE,X);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE, Y);


}

//+------------------------------------------------------------------+

void create_label_f(int i,int X,int Y,string text,int Text_size,string name_add,color colo,string font)
{
      string name=identif+"label"+string(i)+name_add;
      
      if(ObjectFind(name)==-1)
      {
         ObjectCreate(name,OBJ_LABEL,window,0,0);
            //
      
            ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
            
            //
            ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_LEFT);
            ObjectSetInteger(0,name,OBJPROP_BACK,false);
            ObjectSetInteger(0,name,OBJPROP_ZORDER,false);
            ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
            ObjectSetInteger(0,name,OBJPROP_SELECTED,false);
            ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
      }
      
      ObjectSetInteger(0,name, OBJPROP_XDISTANCE,X);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE, Y);
      ObjectSetString(0,name,OBJPROP_TEXT,text);
      ObjectSetInteger(0,name,OBJPROP_COLOR, colo);
      ObjectSetString(0,name,OBJPROP_FONT, font);
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE, Text_size);
}

//+------------------------------------------------------------------+

void pairs_to_buf_f()
{
   string str_spl[];
   
   if(pairs == "") { pairs = Symbol() ; } // TRO
   
   int size=StringSplit(pairs,StringGetCharacter(spliter,0),str_spl);
   
   ArrayResize(pairs_b,size);
   ArrayResize(LastTradePrice,size);
   ArrayResize(LastTradeTrigger,size);
   ArrayResize(LastTradeUp,size);
   ArrayResize(LateTradeTime,size);
      
   for(int i=0;i<size;i++)
   {
      pairs_b[i]=str_spl[i];
   }

}

//+------------------------------------------------------------------+

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
   ArrayResize(StartRngHigh,size);
   ArrayResize(StartRngLow,size);

   for(int i=0;i<size;i++)
   {
   //   TFs_b[i]=String_to_TF(str_spl_tf[i]);
   
      TFs_b[i]= int(str_spl_tf[i]);
      
      BoxSizePoints[i] = StrToDouble(str_spl_tf[i]) ;
   }

}

//+------------------------------------------------------------------+

int String_to_TF(string tf)
{
   int TF=0;
   
   if(tf=="M1") TF=PERIOD_M1;
   if(tf=="M5") TF=PERIOD_M5;
   if(tf=="M15") TF=PERIOD_M15;
   if(tf=="M30") TF=PERIOD_M30;
   if(tf=="H1") TF=PERIOD_H1;
   if(tf=="H4") TF=PERIOD_H4;
   if(tf=="D1") TF=PERIOD_D1;
   if(tf=="W1") TF=PERIOD_W1;
   if(tf=="MN1") TF=PERIOD_MN1;
      
   return(TF);
}

//+------------------------------------------------------------------+

string symb_cut_f(string symb,short half)
{
   string cutted_symb=symb;
   
   if(half==1) cutted_symb=StringSubstr(symb,0,3);
   if(half==2) cutted_symb=StringSubstr(symb,3,3);
   
   
   return(cutted_symb);
}

//+------------------------------------------------------------------+

void X_Y_set_f()
{
   if(corner==CORNER_LEFT_UPPER) 
   {
       Rectangle_X_real=Rectangle_X;
       Rectangle_Y_real=Rectangle_Y;
   }
   else
   if(corner==CORNER_RIGHT_UPPER) 
   {
      int main_chart_width_pix=int(ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0));
      int size_all_X=ArraySize(pairs_b)*(Rectangle_X_step-1);
      Rectangle_X_real=main_chart_width_pix-Rectangle_X-size_all_X;
      Rectangle_Y_real=Rectangle_Y;
   }
   else
   if(corner==CORNER_LEFT_LOWER)
   {
      int main_chart_height_pix=int(ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0));
      int size_all_Y=ArraySize(TFs_b)*(Rectangle_Y_step-1);
      Rectangle_Y_real=main_chart_height_pix-Rectangle_Y-size_all_Y;
      Rectangle_X_real=Rectangle_X;
   }
   else
   if(corner==CORNER_RIGHT_LOWER) 
   {
      int main_chart_width_pix=int(ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0));
      int size_all_X=ArraySize(pairs_b)*(Rectangle_X_step-1);
      Rectangle_X_real=main_chart_width_pix-Rectangle_X-size_all_X;
      
      int main_chart_height_pix=int(ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0));
      int size_all_Y=ArraySize(TFs_b)*(Rectangle_Y_step-1);
      Rectangle_Y_real=main_chart_height_pix-Rectangle_Y-size_all_Y;
   }
   

}
 
//+------------------------------------------------------------------+

void delete_all_objects_f()
{
   string name_delete;
   for(int i=ObjectsTotal()-1;i>=0;i--)
   {
      name_delete=ObjectName(i);
      if(StringFind(name_delete,identif)!=-1) ObjectDelete(name_delete);
   }

}
 
//+------------------------------------------------------------------+

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

void create_Rectangle_main_f()
{
   string name=identif+"rectan"+string(-1);
   int X_dist_bet_rects=Rectangle_X_step-Rectangle_width;
   int Y_dist_bet_rects=Rectangle_Y_step-Rectangle_height;
   
   if(ObjectFind(0,name)==-1)
   {
      ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,window,0,0);
      //
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,name,OBJPROP_BGCOLOR,Rectangle_main_color);
      ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_RAISED); 
      ObjectSetInteger(0,name,OBJPROP_XSIZE,(Rectangle_width+X_dist_bet_rects)*ArraySize(pairs_b)+Text_TF_shift_X-X_dist_bet_rects+Rectangle_main_plus);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,(Rectangle_height+Y_dist_bet_rects)*ArraySize(TFs_b)+Text_symb_shift_Y-Y_dist_bet_rects+Rectangle_main_plus);
      //
      ObjectSetInteger(0,name,OBJPROP_BACK,false);
      ObjectSetInteger(0,name,OBJPROP_ZORDER,false);
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,name,OBJPROP_SELECTED,false);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,false);
   }

   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,Rectangle_X_real-Text_TF_shift_X-Rectangle_main_plus/2);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,Rectangle_Y_real-Text_symb_shift_Y-Rectangle_main_plus/2);

   create_label_f(0,Rectangle_X_real-60,Rectangle_Y_real-20,"RYTHM",Text_symb_size,"SYMB",clrBlack,fonts_buf[Text_symb_font]);

}

//+------------------------------------------------------------------+

void DoAlert(string tAlert, string tAlertValues )
{
   string MESSAGE;

   if( TriggerTime==TimeCurrent()) { return; }

   if(tAlert!="")
     {
 
       MESSAGE=  tAlert+" <"+tAlertValues+">"; 
      
      if(Sound_Alert) { Alert(MESSAGE); }
      if(Mail) { SendMail(MESSAGE,MESSAGE ); }
      if(Push) { SendNotification(MESSAGE); }

      TriggerTime =  TimeCurrent();
      MESSAGE     =  TimeToString(TimeCurrent(),TIME_SECONDS) + " " +MESSAGE;
      
      create_label_f(0,Rectangle_X_real,Rectangle_Y_real-60,MESSAGE,Text_numb_size,"Alert",Alert_Message_color,fonts_buf[Text_numb_font]);
      
      Print(MESSAGE);
      
     }
     
   return;
   
} 

 
//+------------------------------------------------------------------+  

//+------------------------------------------------------------------+
/*
     Comment(TimeToStr(TimeCurrent(),  TIME_MINUTES));


     for(int k=0;k<ArraySize(pairs_b );k++)
     {

     for(int m=0;m<tf_count;m++)
     {

       if(Location[k][0]   < MaxTradeValue && Location[k][0]   > MinTradeValue &&
          Location[k][m+TriggerSetSize] < MaxTradeValue && Location[k][m+TriggerSetSize] > MinTradeValue &&
          Location[k][m+2*TriggerSetSize] < MaxTradeValue && Location[k][m+2*TriggerSetSize] > MinTradeValue
         )
       {

         DoAlert( pairs_b[k] + " " + str_spl_tf[m] + " TRADE ALERT " + DoubleToString(Location[k][m],0) ) ;
       
       }// if  
         m  =  m + TriggerSetSize;
     } // for m
     } // for k

Comment(  "k=", k   ,   " m=", m   , "\n" , 

pairs_b[k], "\n" , 


"Location[ k][m ] " , DoubleToStr(Location[k ][m ] ,Digits)  , "\n" ,   
 
"") ; 
            
            

int com = 1 ;

Comment(  "com=", com   , "\n" , 

"TriggerSets=", TriggerSets   , "\n" , 
"TriggerArraySize=", TriggerArraySize   , "\n" , 
"TriggerSetSize=", TriggerSetSize   , "\n" , 

            "TRIGGERS[ com][0 ] " , DoubleToStr(TRIGGERS[com ][0 ] ,Digits)  , "\n" ,   
"TRIGGERS[ com][1 ] " , DoubleToStr(TRIGGERS[com ][1 ] ,Digits)  , "\n" ,  
"TRIGGERS[ com][2 ] " , DoubleToStr(TRIGGERS[ com][2] ,Digits)  , "\n" ,  
            
            "") ; 

    for(int k=0;k<pair_count;k++)
    {
      for(int m=0;m<tf_count;m++)
      {      
      
      for(int n=0;n<TriggerSets;n++)
      {
      
      
       if(Location[k][m] == TRIGGERS[n][0] && Location[k][m+1] == TRIGGERS[n][1] && Location[k][m+2] == TRIGGERS[n][2])
       {
         DoAlert( pairs_b[k] + " " + str_spl_tf[m]  ) ;
       
       }// if
  
       if(Location[k][m] == TRIGGERS[n][0] )
       {
         DoAlert( pairs_b[k] + " " + str_spl_tf[m]  ) ;
       
       }// if  
  
        
      }// for n
      m=m+TriggerSetSize;
      }// for m
    }// for k
*/
    
