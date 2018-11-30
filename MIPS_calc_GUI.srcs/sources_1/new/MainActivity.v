`timescale 1ns / 1ps

module MainActivity(
   input CLK,					//clock signal
   input [4:0] button,
   input done,
   input [31:0] answer,
   output [11:0] COLOR_OUT,//bit patters for COLOR that goes to VGA port
   output HS,					//Horizontal Synch signal that goes into VGA port
   output VS,
   output reg [1:0] operation,					//Vertical Synch signal that goes into VGA port
   output reg [31:0] digit1,digit2,
   output reg enable
	);
	
//	reg [31:0] digit1, digit2;
	initial
	begin
	digit1 = 0;
	digit2 = 0;
	operation = 0;
	end
	reg DOWNCOUNTER = 0;		//need a downcounter to 25MHz
    reg DOWNCOUNTER2 = 0;		//need a downcounter to 50MHz
	parameter Size = 13'd6400;	//overall there are 6400 pixels
	parameter SizeXY = 7'd80;	//Gimp has 80x80 pixels
	
	//Downcounter to 25MHz		
	always @(posedge CLK)begin   
	    DOWNCOUNTER2 <= ~DOWNCOUNTER2;   //50 mhz
	end
	
	always @(posedge DOWNCOUNTER2)begin
			DOWNCOUNTER <= ~DOWNCOUNTER;	//Slow down the counter to 25MHz
	end
	
	reg [11:0] COLOR_IN;
	reg [11:0] COLOR_DATA1 [0:Size-1];
    reg [11:0] COLOR_DATA2 [0:Size-1];
    reg [11:0] COLOR_DATA3 [0:Size-1];
	reg [11:0] COLOR_DATA4 [0:Size-1];
	reg [11:0] COLOR_DATA5 [0:Size-1];
    reg [11:0] COLOR_DATA6 [0:Size-1];
    reg [11:0] COLOR_DATA7 [0:Size-1];
    reg [11:0] COLOR_DATA8 [0:Size-1];
    reg [11:0] COLOR_DATA9 [0:Size-1];
    reg [11:0] COLOR_DATA0 [0:Size-1];
    reg [11:0] COLOR_DATAplus [0:Size-1];
    reg [11:0] COLOR_DATAminus [0:Size-1];
    reg [11:0] COLOR_DATAdivide [0:Size-1];
    reg [11:0] COLOR_DATAmultiply [0:Size-1];
    reg [11:0] COLOR_DATAequal [0:Size-1];
    reg [1:0] cursorX,cursorY;
    reg [4:0] button_debounce = 0;
    reg state = 0;
    reg [1:0] state_next = 0;
    always @ (posedge CLK)
                    state<=state_next;  
                    
    always @ (posedge CLK)
    begin
        if(done)
        enable <= 0;
            if (button[0] && !button_debounce[0])
                cursorY <= cursorY-1;
            if (button[1]&& !button_debounce[1])
                cursorX <= cursorX-1;
                
                
            if (button[2] && !button_debounce[2])
                begin
                
                if(cursorX == 0 && cursorY == 0) //7
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 7;
                    if(state == 1)
                        digit2<= (digit2*10) + 7;
                    end
                
                else if(cursorX == 0 && cursorY == 1) //4       
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 4;
                    if(state == 1)
                        digit2<= (digit2*10) + 4;
                    end
                        
                else if(cursorX == 0 && cursorY == 2) //1     
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 1;
                    if(state == 1)
                        digit2<= (digit2*10) + 1;
                    end                          
                
                else if(cursorX == 1 && cursorY == 0) //8     
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 8;
                    if(state == 1)
                        digit2<= (digit2*10) + 8;
                    end          
                
                else if(cursorX == 1 && cursorY == 1) //5       
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 5;
                    if(state == 1)
                        digit2<= (digit2*10) + 5;
                    end
                        
                else if(cursorX == 1 && cursorY == 2) //2      
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 2;
                    if(state == 1)
                        digit2<= (digit2*10) + 2;
                    end
                         
                else if(cursorX == 1 && cursorY == 3) //0    
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 0;
                    if(state == 1)
                        digit2<= (digit2*10) + 0;
                    end
                           
                else if(cursorX == 2 && cursorY == 0) //9        
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 9;
                    if(state == 1)
                        digit2<= (digit2*10) + 9;
                    end
                      
                else if(cursorX == 2 && cursorY == 1) //6     
                    begin
                    if(state == 0)
                        digit1<= (digit1*10) + 6;
                    if(state == 1)
                        digit2<= (digit2*10) + 6;
                    end
                          
                else if(cursorX == 2 && cursorY == 2) //3   
                    begin
                    if(state == 0)
                        begin
                        digit1<= (digit1*10) + 3;                        //REMOVE THE STATE CHANGE
                        state_next <= 1;
                        end
                    if(state == 1)
                        digit2<= (digit2*10) + 3;
                    end
     //--------------------------------------begin operations-------------------------------------------//
                if(cursorX == 3 && cursorY == 0) // "/"
                        if(state == 0)
                            begin
                            operation <= 3; 
                            state_next <= 1;
                            end
                        
                if(cursorX == 3 && cursorY == 1) // *
                        if(state == 0)
                            begin
                            operation <= 2; 
                            state_next <= 1;
                            end
                if(cursorX == 3 && cursorY == 2) // -
                        if(state == 0)
                            begin
                            operation <= 1; 
                            state_next <= 1;
                            end
                if(cursorX == 3 && cursorY == 3) // +
                        if(state == 0)
                            begin
                            operation <= 0; 
                            state_next <= 1;
                            end
                            
                            
                if(cursorX == 2 && cursorY == 3) // =  
                        if(state == 1)
                            begin
                            enable<=1 ; 
                            state_next <= 0;
                            end            
             
                
            end    
        if(button[3]&& !button_debounce[3])
            cursorX <= cursorX+1;
        if(button[4]&& !button_debounce[4])
            cursorY <= cursorY+1;
       button_debounce <= button;
    end 
	wire [12:0] STATE0,STATE1,STATE2,STATE3,STATE4,STATE5,STATE6,STATE7,STATE8,STATE9,STATEplus,STATEminus,STATEdiv,STATEmul,STATEeq;
	wire TrigRefresh;			//Trigger gives a pulse when displayed refreshed
	wire [9:0] ADDRH;			//wire for getting Horizontal pixel value
	wire [8:0] ADDRV;			//wire for getting vertical pixel value
	
	//VGA Interface gets values of ADDRH & ADDRV and by puting COLOR_IN, gets valid output COLOR_OUT
	//Also gets a trigger, when the screen is refreshed
	VGAInterface VGA(
				.CLK(DOWNCOUNTER2),
			   .COLOR_IN (COLOR_IN),
				.COLOR_OUT(COLOR_OUT),
				.HS(HS),
				.VS(VS),
				.REFRESH(TrigRefresh),
				.ADDRH(ADDRH),
				.ADDRV(ADDRV),
				.DOWNCOUNTER(DOWNCOUNTER)
				);

			
		localparam col1 = 0; //7,4,1
        localparam col2 = 81; //8,5,2,0
        localparam col3 = 162; //9,6,3,=
        localparam col4 = 243; // /, *,-,+
        localparam row4 = 399;
        localparam row3 = 318;
        localparam row2 = 237;
        localparam row1 = 156;
       


	initial
	begin
	$readmemh ("0.list", COLOR_DATA0);
    $readmemh ("1.list", COLOR_DATA1);
    $readmemh ("2.list", COLOR_DATA2);
    $readmemh ("3.list", COLOR_DATA3);   
	$readmemh ("4.list", COLOR_DATA4);
	$readmemh ("5.list", COLOR_DATA5);
    $readmemh ("6.list", COLOR_DATA6);
    $readmemh ("7.list", COLOR_DATA7);   
    $readmemh ("8.list", COLOR_DATA8);
    $readmemh ("9.list", COLOR_DATA9);
        
    $readmemh ("+.list", COLOR_DATAplus);
    $readmemh ("-.list", COLOR_DATAminus);   
    $readmemh ("star.list", COLOR_DATAmultiply);
    $readmemh ("divide.list", COLOR_DATAdivide);
    $readmemh ("equal.list", COLOR_DATAequal);

	end
	assign STATE0 = (ADDRH-col2)*SizeXY+ADDRV-row4;
    assign STATE1 = (ADDRH-col1)*SizeXY+ADDRV-row3; // card 1 position
    assign STATE2 = (ADDRH-col2)*SizeXY+ADDRV-row3;
    assign STATE3 = (ADDRH-col3)*SizeXY+ADDRV-row3;
	assign STATE4 = (ADDRH-col1)*SizeXY+ADDRV-row2; //card 4 position
	assign STATE5 = (ADDRH-col2)*SizeXY+ADDRV-row2; 
    assign STATE6 = (ADDRH-col3)*SizeXY+ADDRV-row2;
    assign STATE7 = (ADDRH-col1)*SizeXY+ADDRV-row1;
    assign STATE8 = (ADDRH-col2)*SizeXY+ADDRV-row1; 
    assign STATE9 = (ADDRH-col3)*SizeXY+ADDRV-row1;
    
    assign STATEplus = (ADDRH-col4)*SizeXY+ADDRV-row4;
    assign STATEminus = (ADDRH-col4)*SizeXY+ADDRV-row3;
    assign STATEdiv = (ADDRH-col4)*SizeXY+ADDRV-row1;
    assign STATEmul = (ADDRH-col4)*SizeXY+ADDRV-row2;
    assign STATEeq =(ADDRH-col3)*SizeXY+ADDRV-row4;

	
	always @(posedge DOWNCOUNTER2) begin
	    if (ADDRH>=col2 && ADDRH<col2+SizeXY             //card 0 face down
        && ADDRV>=row4 && ADDRV<row4+SizeXY)
        
                if(cursorX == 1 && cursorY == 3)
                    if(state == 0)
                    COLOR_IN <= 12'hF00;
                    else
                    COLOR_IN <= 12'h00F;
                else
                COLOR_IN <= COLOR_DATA0[{STATE0}];	
	
		else if (ADDRH>=col1 && ADDRH<col1+SizeXY             //card 1 face down
			&& ADDRV>=row3 && ADDRV<row3+SizeXY)
			
                if(cursorX == 0 && cursorY == 2)
                    if(state == 0)
                    COLOR_IN <= 12'hF00;
                    else
                    COLOR_IN <= 12'h00F;
                else
				COLOR_IN <= COLOR_DATA1[{STATE1}];			


		else if (ADDRH>=col2 && ADDRH<col2+SizeXY        //card 2 face down
                 && ADDRV>=row3 && ADDRV<row3+SizeXY)
                 
                if(cursorX == 1 && cursorY == 2)
                    if(state == 0)
                    COLOR_IN <= 12'hF00;
                    else
                    COLOR_IN <= 12'h00F;
                 else
                 COLOR_IN <= COLOR_DATA2[{STATE2}];
			
				
		else if (ADDRH>=col3 && ADDRH<col3+SizeXY        //card 3 face down
                && ADDRV>=row3 && ADDRV<row3+SizeXY)
                
                if(cursorX == 2 && cursorY == 2)
                    if(state == 0)
                    COLOR_IN <= 12'hF00;
                    else
                    COLOR_IN <= 12'h00F;
                else
                  COLOR_IN <= COLOR_DATA3[{STATE3}];
			
						
				
		else if (ADDRH>=col1 && ADDRH<col1+SizeXY        //card 4 face down
                 && ADDRV>=row2 && ADDRV<row2+SizeXY)
                 
                 if(cursorX == 0 && cursorY == 1)
                    if(state == 0)
                     COLOR_IN <= 12'hF00;
                     else
                     COLOR_IN <= 12'h00F;
                 else
                 COLOR_IN <= COLOR_DATA4[{STATE4}];
                 
                 
		else if (ADDRH>=col2 && ADDRH<col2+SizeXY        //card 5 face down
                 && ADDRV>=row2 && ADDRV<row2+SizeXY)
                 
                 if(cursorX == 1 && cursorY == 1)
                    if(state == 0)
                     COLOR_IN <= 12'hF00;
                     else
                     COLOR_IN <= 12'h00F;
                 else
                 COLOR_IN <= COLOR_DATA5[{STATE5}];
                                          
                         
         else if (ADDRH>=col3 && ADDRH<col3+SizeXY        //card 6 face down
                  && ADDRV>=row2 && ADDRV<row2+SizeXY)
                  
                  if(cursorX == 2 && cursorY == 1)
                      if(state == 0)
                      COLOR_IN <= 12'hF00;
                      else
                      COLOR_IN <= 12'h00F;
                  else
                  COLOR_IN <= COLOR_DATA6[{STATE6}];

          
          else if (ADDRH>=col1 && ADDRH<col1+SizeXY             //card 7 face down
                  && ADDRV>=row1 && ADDRV<row1+SizeXY)
                  
                  if(cursorX == 0 && cursorY == 0)
                      if(state == 0)
                      COLOR_IN <= 12'hF00;
                      else
                      COLOR_IN <= 12'h00F;
                  else
                  COLOR_IN <= COLOR_DATA7[{STATE7}];            
  
  
          else if (ADDRH>=col2 && ADDRH<col2+SizeXY        //card 8 face down
                   && ADDRV>=row1 && ADDRV<row1+SizeXY)
                   
                   if(cursorX == 1 && cursorY == 0)
                       if(state == 0)
                       COLOR_IN <= 12'hF00;
                       else
                       COLOR_IN <= 12'h00F;
                   else
                   COLOR_IN <= COLOR_DATA8[{STATE8}];
              
                  
          else if (ADDRH>=col3 && ADDRH<col3+SizeXY        //card 9 face down
                  && ADDRV>=row1 && ADDRV<row1+SizeXY)
                  
                  if(cursorX == 2 && cursorY == 0)
                      if(state == 0)
                      COLOR_IN <= 12'hF00;
                      else
                      COLOR_IN <= 12'h00F;
                  else
                    COLOR_IN <= COLOR_DATA9[{STATE9}];
                                     
              else if (ADDRH>=col4 && ADDRH<col4+SizeXY        //card + face down
                       && ADDRV>=row4 && ADDRV<row4+SizeXY)
                       
                       if(cursorX == 3 && cursorY == 3)
                        if(state == 0)
                           COLOR_IN <= 12'hF00;
                        else
                           COLOR_IN <= 12'h00F;
                       else
                       COLOR_IN <= COLOR_DATAplus[{STATEplus}];
                       
                       
              else if (ADDRH>=col4 && ADDRH<col4+SizeXY        //card - face down
                       && ADDRV>=row3 && ADDRV<row3+SizeXY)
                       
                       if(cursorX == 3 && cursorY == 2)
                        if(state == 0)
                           COLOR_IN <= 12'hF00;
                           else
                           COLOR_IN <= 12'h00F;
                       else
                         COLOR_IN <= COLOR_DATAminus[{STATEminus}];
                                                
                               
              else if (ADDRH>=col4 && ADDRH<col4+SizeXY        //card / face down
                        && ADDRV>=row1 && ADDRV<row1+SizeXY)
                        
                        if(cursorX == 3 && cursorY == 0)
                            if(state == 0)
                                COLOR_IN <= 12'hF00;
                                else
                                COLOR_IN <= 12'h00F;
                        else
                        COLOR_IN <= COLOR_DATAdivide[{STATEdiv}];  
                                
                                        
               else if (ADDRH>=col4 && ADDRH<col4+SizeXY        //card * face down
                         && ADDRV>=row2 && ADDRV<row2+SizeXY)
                         
                       if(cursorX == 3 && cursorY == 1)
                            if(state == 0)
                               COLOR_IN <= 12'hF00;
                               else
                               COLOR_IN <= 12'h00F;
                         else
                         COLOR_IN <= COLOR_DATAmultiply[{STATEmul}];           
            
               else if (ADDRH>=col3 && ADDRH<col3+SizeXY        //card = face down
                       && ADDRV>=row4 && ADDRV<row4+SizeXY)
                       
                       if(cursorX == 2 && cursorY == 3)
                            if(state == 0)
                           COLOR_IN <= 12'hF00;
                           else
                           COLOR_IN <= 12'h00F;
                       else
                       COLOR_IN <= COLOR_DATAequal[{STATEeq}];
               else if (ANSWER_on)
                   COLOR_IN = ANSWER_rgb;
               else if (DIG1_on)
                   COLOR_IN = DIG1_rgb;
               else if (OPER_on)
                   COLOR_IN = OPER_rgb;
               else if (DIG2_on)
                   COLOR_IN = DIG2_rgb;
                    
		else
				COLOR_IN <= 12'hFFF;
	end
	
	
	
	
		    // constant and signal declaration
                // x, y coordinates (0,0) to (639,479)
                localparam MAX_X = 640;
                localparam MAX_Y = 480;
                wire refr_tick;
                //--------------------------------------------
                // ANSWER
                //--------------------------------------------
                // y should start at y=225
                // 18 + 6 + 18 + 6 + 18 + 6 + 18 + 6 + 18 = 114
                // x should start at 275
            
                localparam ANSWER_X_L = 100;
                localparam ANSWER_X_R = ANSWER_X_L + 90;
                localparam ANSWER_Y_T = 100;
                localparam ANSWER_Y_B = ANSWER_Y_T + 30;
            
                localparam DIG1_X_L = 400;
                localparam DIG1_X_R = DIG1_X_L + 42;
                localparam DIG1_Y_T = 100;
                localparam DIG1_Y_B = DIG1_Y_T + 30;
            
                localparam OPER_X_L = 400;
                localparam OPER_X_R = OPER_X_L + 18;
                localparam OPER_Y_T = 200;
                localparam OPER_Y_B = OPER_Y_T + 30;
            
                localparam DIG2_X_L = 400;
                localparam DIG2_X_R = DIG2_X_L + 42;
                localparam DIG2_Y_T = 300;
                localparam DIG2_Y_B = DIG2_Y_T + 30;
            
                wire [4:0] ANSWER_addr;
                wire [6:0] ANSWER_col;
                wire [113:0] ANSWER_data;
                wire ANSWER_bit;
            
                wire [4:0] DIG1_addr;
                wire [6:0] DIG1_col;
                wire [113:0] DIG1_data;
                wire DIG1_bit;
            
                wire [4:0] OPER_addr;
                wire [6:0] OPER_col;
                wire [113:0] OPER_data;
                wire OPER_bit;
            
                wire [4:0] DIG2_addr;
                wire [6:0] DIG2_col;
                wire [113:0] DIG2_data;
                wire DIG2_bit;
                
                wire [4:0] a_addr, d1_addr, d2_addr, op_addr;
                //--------------------------------------------
                // object output signals
                //--------------------------------------------
                wire ANSWER_on, DIG1_on, DIG2_on, OPER_on;
                wire [11:0] ANSWER_rgb, DIG1_rgb, DIG2_rgb, OPER_rgb;
                
                reg [11:0] background;
                //--------------------------------------------
                // digit selector
                //--------------------------------------------
                function [17:0] number_data;
                input [3:0] dig;
                input [4:0] number_addr;
                begin
                    case (dig)
                        0: 
                            case (number_addr)  //0
                                5'd0, 5'd1, 5'd28, 5'd29: number_data =   18'b001111111111111100;
                                5'd4, 5'd5, 5'd24, 5'd25: number_data =   18'b111111111111111111;
                                5'd8, 5'd9,  5'd12, 5'd13, 5'd16, 5'd17, 5'd20, 5'd21: number_data =   18'b111100000000001111;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        1: 
                            case (number_addr)  //1
                                5'd0, 5'd1: number_data =   18'b000000111111111100;
                                5'd4, 5'd5: number_data =   18'b000000111111111100;
                                5'd8, 5'd9: number_data =   18'b000000111111000000;
                                5'd12, 5'd13: number_data = 18'b000000111111000000;
                                5'd16, 5'd17: number_data = 18'b000000111111000000;
                                5'd20, 5'd21: number_data = 18'b000000111111000000;
                                5'd24, 5'd25: number_data = 18'b000000111111000000;
                                5'd28, 5'd29: number_data = 18'b000000111111000000;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        2: 
                            case (number_addr)  //2
                                5'd0, 5'd1: number_data =   18'b001111111111111100;
                                5'd4, 5'd5: number_data =   18'b111111111111111111;
                                5'd8, 5'd9: number_data =   18'b111111000000111111;
                                5'd12, 5'd13: number_data = 18'b001111111100000000;
                                5'd16, 5'd17: number_data = 18'b000000111111000000;
                                5'd20, 5'd21: number_data = 18'b000000001111111100;
                                5'd24, 5'd25: number_data = 18'b111111111111111111;
                                5'd28, 5'd29: number_data = 18'b111111111111111111;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        3: 
                            case (number_addr)  //3
                                5'd0, 5'd1: number_data =   18'b111111111111111111;
                                5'd4, 5'd5: number_data =   18'b111111111111111111;
                                5'd8, 5'd9: number_data =   18'b001111110000001111;
                                5'd12, 5'd13: number_data = 18'b000011111100000000;
                                5'd16, 5'd17: number_data = 18'b001111111111000000;
                                5'd20, 5'd21: number_data = 18'b111111000000001111;
                                5'd24, 5'd25: number_data = 18'b111111111111111111;
                                5'd28, 5'd29: number_data = 18'b001111111111111100;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        4: 
                            case (number_addr)  //4
                                5'd0, 5'd1: number_data =   18'b001111111100000000;
                                5'd4, 5'd5: number_data =   18'b001111001111110000;
                                5'd8, 5'd9: number_data =   18'b001111000011111100;
                                5'd12, 5'd13: number_data = 18'b001111000000111111;
                                5'd16, 5'd17: number_data = 18'b111111111111111111;
                                5'd20, 5'd21: number_data = 18'b001111110000000000;
                                5'd24, 5'd25: number_data = 18'b001111110000000000;
                                5'd28, 5'd29: number_data = 18'b111111111111000000;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        5: 
                            case (number_addr)  //5
                                5'd0, 5'd1, 5'd4, 5'd5, 5'd24, 5'd25: number_data =   18'b111111111111111111;
                                5'd8, 5'd9: number_data =   18'b000000000000111111;
                                5'd12, 5'd13: number_data = 18'b001111111111111111;
                                5'd16, 5'd17: number_data = 18'b111111000000000000;
                                5'd20, 5'd21: number_data = 18'b111111000000111111;
                                5'd28, 5'd29: number_data = 18'b001111111111111100;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        6: 
                            case (number_addr)  //6
                                5'd0, 5'd1: number_data =   18'b111111111111111100;
                                5'd4, 5'd5, 5'd16, 5'd17, 5'd24, 5'd25: number_data =   18'b111111111111111111;
                                5'd8, 5'd9: number_data =   18'b000000000000001111;
                                5'd12, 5'd13: number_data = 18'b001111111111111111;
                                5'd20, 5'd21: number_data = 18'b111100000000001111;
                                5'd28, 5'd29: number_data = 18'b001111111111111100;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        7: 
                            case (number_addr)  //7
                                5'd0, 5'd1: number_data =   18'b111111111111111111;
                                5'd4, 5'd5: number_data =   18'b011111111111111111;
                                5'd8, 5'd9: number_data =   18'b001111110000001111;
                                5'd12, 5'd13: number_data = 18'b000111111000000000;
                                5'd16, 5'd17: number_data = 18'b000011111100000000;
                                5'd20, 5'd21: number_data = 18'b000001111110000000;
                                5'd24, 5'd25: number_data = 18'b000000111111000000;
                                5'd28, 5'd29: number_data = 18'b000000011111100000;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        8: 
                            case (number_addr)  //8
                                5'd0, 5'd1, 5'd12, 5'd13, 5'd16, 5'd17, 5'd28, 5'd29: number_data =   18'b001111111111111100;
                                5'd4, 5'd5, 5'd24, 5'd25: number_data =   18'b111111111111111111;
                                5'd8, 5'd9, 5'd20, 5'd21: number_data =   18'b111111000000111111;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        9:
                            case (number_addr)  //9
                                5'd0, 5'd1: number_data =   18'b001111111111111100;
                                5'd4, 5'd5,  5'd12, 5'd13, 5'd24, 5'd25: number_data =   18'b111111111111111111;
                                5'd8, 5'd9: number_data =   18'b111100000000001111;
                                5'd16, 5'd17: number_data = 18'b111111111111111100;
                                5'd20, 5'd21: number_data = 18'b111100000000000000;
                                5'd28, 5'd29: number_data = 18'b001111111111111111;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        10: 
                            case (number_addr)  //+
                                5'd0, 5'd1: number_data =   18'b000000000000000000;
                                5'd4, 5'd5: number_data =   18'b000000111110000000;
                                5'd8, 5'd9: number_data =   18'b000000111110000000;
                                5'd12, 5'd13: number_data = 18'b001111111111111000;
                                5'd16, 5'd17: number_data = 18'b001111111111111000;
                                5'd20, 5'd21: number_data = 18'b000000111110000000;
                                5'd24, 5'd25: number_data = 18'b000000111110000000;
                                5'd28, 5'd29: number_data = 18'b000000000000000000;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        11: 
                            case (number_addr)  //-
                                5'd0, 5'd1: number_data =   18'b000000000000000000;
                                5'd4, 5'd5: number_data =   18'b000000000000000000;
                                5'd8, 5'd9: number_data =   18'b000000000000000000;
                                5'd12, 5'd13: number_data = 18'b001111111111111000;
                                5'd16, 5'd17: number_data = 18'b001111111111111000;
                                5'd20, 5'd21: number_data = 18'b000000000000000000;
                                5'd24, 5'd25: number_data = 18'b000000000000000000;
                                5'd28, 5'd29: number_data = 18'b000000000000000000;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        12: 
                            case (number_addr)  //x
                                5'd0, 5'd1: number_data =   18'b000000000000000000;
                                5'd4, 5'd5: number_data =   18'b111100000000001111;
                                5'd8, 5'd9: number_data =   18'b001111000000111100;
                                5'd12, 5'd13: number_data = 18'b000011110011110000;
                                5'd16, 5'd17: number_data = 18'b000000001100000000;
                                5'd20, 5'd21: number_data = 18'b000011110011110000;
                                5'd24, 5'd25: number_data = 18'b001111000000111100;
                                5'd28, 5'd29: number_data = 18'b111100000000001111;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        13: 
                            case (number_addr)  ///
                                5'd0, 5'd1: number_data =   18'b000000111100000000;
                                5'd4, 5'd5: number_data =   18'b000000111100000000;
                                5'd8, 5'd9: number_data =   18'b000000000000000000;
                                5'd12, 5'd13: number_data = 18'b001111111111111000;
                                5'd16, 5'd17: number_data = 18'b001111111111111000;
                                5'd20, 5'd21: number_data = 18'b000000000000000000;
                                5'd24, 5'd25: number_data = 18'b000000111100000000;
                                5'd28, 5'd29: number_data = 18'b000000111100000000;
                                default:      number_data = 18'b000000000000000000;
                            endcase
                        14:       number_data = 18'b000000000000000000;     // blank
                        default:  number_data = 18'b111111111111111111;     // block
                    endcase
                end
                endfunction
                
                // refr_tick: 1-clock tick asserted at start of v-sync
                //            i.e., when the screen is refreshed (60 Hz)
                assign refr_tick = (ADDRV==481) && (ADDRH==0);
                //--------------------------------------------
                // ANSWER
                //--------------------------------------------
                assign a_addr = ADDRV[4:0] - ANSWER_Y_T[4:0];
                
                assign d1_addr = ADDRV[4:0] - DIG1_Y_T[4:0];
            
                assign op_addr = ADDRV[4:0] - OPER_Y_T[4:0];
                
                assign d2_addr = ADDRV[4:0] - DIG2_Y_T[4:0];
                
                
//                wire [31:0] answer = 32'd9452;
                
                wire [3:0] answer_3, answer_2, answer_1, answer_0;
                
                assign answer_3 = answer / 1000;
                assign answer_2 = (answer % 1000) / 100; 
                assign answer_1 = (answer % 100) / 10;
                assign answer_0 = (answer % 10);
                
                
                wire [3:0] digit1_1, digit1_0;
                
                assign digit1_1 = (digit1 % 100) / 10;
                assign digit1_0 = (digit1 % 10);
                
                wire [3:0] digit2_1, digit2_0;
                                
                assign digit2_1 = (digit2 % 100) / 10;
                assign digit2_0 = (digit2 % 10);
                
                reg [3:0] oper;
                always @(posedge CLK) begin
                 if (operation == 2'd3)
                    oper = 4'd13;
                 else if (operation == 2'd2)
                    oper = 4'd12;
                 else if (operation == 2'd1)
                    oper = 4'd11;
                 else if (operation == 2'd0)
                    oper = 4'd10;
                end
                
                assign ANSWER_data = {number_data(answer_0, a_addr), 6'b0, number_data(answer_1, a_addr),  6'b0, 
                                       number_data(answer_2, a_addr), 6'b0, number_data(answer_3, a_addr)};
            
                assign DIG1_data = {number_data(digit1_0, d1_addr), 6'b0, number_data(digit1_1, d1_addr)};
            
                assign OPER_data = number_data(oper, op_addr);
            
                assign DIG2_data = {number_data(digit2_0, d2_addr), 6'b0, number_data(digit2_1, d2_addr)};                       
                
                assign ANSWER_addr = ADDRV[4:0] - ANSWER_Y_T[4:0];
                assign ANSWER_col = ADDRH[6:0] - ANSWER_X_L[6:0];
                assign ANSWER_bit = ANSWER_data[ANSWER_col];
            
                assign DIG1_addr = ADDRV[4:0] - DIG1_Y_T[4:0];
                assign DIG1_col = ADDRH[6:0] - DIG1_X_L[6:0];
                assign DIG1_bit = DIG1_data[DIG1_col];
            
                assign OPER_addr = ADDRV[4:0] - OPER_Y_T[4:0];
                assign OPER_col = ADDRH[6:0] - OPER_X_L[6:0];
                assign OPER_bit = OPER_data[OPER_col];
            
                assign DIG2_addr = ADDRV[4:0] - DIG2_Y_T[4:0];
                assign DIG2_col = ADDRH[6:0] - DIG2_X_L[6:0];
                assign DIG2_bit = DIG2_data[DIG2_col];
            
                assign ANSWER_on = ((ANSWER_Y_T<=ADDRV) && (ADDRV<=ANSWER_Y_B) &&
                                   (ANSWER_X_L<=ADDRH) && (ADDRH<=ANSWER_X_R)) & ANSWER_bit;
                assign ANSWER_rgb = 12'h00F;
            
                assign DIG1_on = ((DIG1_Y_T<=ADDRV) && (ADDRV<=DIG1_Y_B) &&
                                 (DIG1_X_L<=ADDRH) && (ADDRH<=DIG1_X_R)) & DIG1_bit;
                assign DIG1_rgb = 12'hF00;
            
                assign OPER_on = ((OPER_Y_T<=ADDRV) && (ADDRV<=OPER_Y_B) &&
                                 (OPER_X_L<=ADDRH) && (ADDRH<=OPER_X_R)) & OPER_bit;
                assign OPER_rgb = 12'h000;
            
                assign DIG2_on = ((DIG2_Y_T<=ADDRV) && (ADDRV<=DIG2_Y_B) &&
                                 (DIG2_X_L<=ADDRH) && (ADDRH<=DIG2_X_R)) & DIG2_bit;
                assign DIG2_rgb = 12'h0F0;
	
endmodule