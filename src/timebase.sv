module timebase #(parameter SLOT_LENGTH = 3571) (input logic clk, input logic rst, output logic us_tick, output logic [31:0] timestamp_us, output logic sample_strobe, output logic slot_start);
    logic [4:0] counter;             // clock cycle counter
    logic [11:0] slot_counter;       // counter for the slot (0 tp 3570)

    always_ff @(posedge clk) begin 
        if (rst) begin                   // reset all globals
            counter <= 0;
            us_tick <= 0;
            timestamp_us <= 0;
            sample_strobe <= 0;
            slot_counter <= 0;
            slot_start <= 0;
        end 
        else begin                     
            counter <= counter + 1;
            sample_strobe <= 0;
            us_tick <= 0;
            slot_start <= 0;
            if (counter == 26) begin      // counter overflow handler
                counter <= 0;
            end
            else if (counter == 1) begin                           // every us, pulse us_tick, increment timestamp_us
                us_tick <= 1;                    
                timestamp_us <= timestamp_us + 1;
            end
            if (timestamp_us % 2 == 0 && counter == 1) begin       // pulse strobe every 2us
                sample_strobe <= 1;
                slot_counter <= slot_counter + 1;
                        if (slot_counter == SLOT_LENGTH - 1) begin
                    slot_counter <= 0;
                    slot_start <= 1;
                end
            end
        end
    end
endmodule