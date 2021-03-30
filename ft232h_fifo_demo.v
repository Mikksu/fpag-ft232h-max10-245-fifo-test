`default_nettype none

module top (
	
    // ftdi 245 fifo signals
    output reg  [7:0] data,           	// [7:0] = R5, L7, P4, L6, R3, M5, P3, M4 (GPIO0-7)
    input  wire rx_full,             	// P6 (GPIO8)
    input  wire tx_empty,            	// R7 (GPIO9)
    output reg  read_n,               	// P7 (GPIO10)
    output reg  write_n,              	// P8 (GPIO11)
    output reg  send_immediately_n,   	// P9 (GPIO12)
    input  wire clock_60mhz,          	// R9 (GPIO13)
    output reg  output_enable_n,      	// R11 (GPIO14)
	 output reg  pwrsav_n,					// P12 (GPIO15)
	
    // status leds
    output reg power_led_n,           	// M12
    output reg tx_active_led_n        	// N15
	
);

reg [7:0] counter;
	
always @(*) begin
	pwrsav_n <= 1;
end
	
always @(posedge clock_60mhz) begin
	
    power_led_n <= 0;
    output_enable_n <= 1;
    send_immediately_n <= 1;
	 
	
    if(!tx_empty) begin
        write_n <= 0;
        data <= counter;
        tx_active_led_n <= 0;
        counter <= counter + 1;
    end else begin
        write_n <= 1;
        read_n <= 1;
        tx_active_led_n <= 1;
    end
	
end

endmodule