module debounce(
	input logic clk,
	input logic pushbutton,
	output logic pulse_out);

	logic [11:0] count;   //12bit    why 12 bit is because we want a sufficiently enough debounce time, 
	                      //if bit is increased, more hardware, if decrease it then the debounce time is shorter
	logic new_press;
	logic stable;
	logic now_is_stable;

	always @(posedge clk) begin
		if (pushbutton == new_press) begin   //to check if current state of pushbutton is same as prev
			if (count == 4095)   //4.095 nano or 4095 micro      (2^12 -1)
				stable <= pushbutton;                  //count completes 4095 and is stable
			else                                       //is stable
				count <= count + 1;
		end
		
		else begin
			count <= 0;
			new_press <= pushbutton;
		end
   end


   always @(posedge clk) begin
         now_is_stable <= stable;
   end
 
   //Sends one shot pulse out if stable
   assign pulse_out = (now_is_stable == 0 & stable == 1);
   
endmodule