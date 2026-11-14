module uart_tx (input logic clk, input logic rst, input logic [7:0] data, input logic start, output logic busy, output logic serial_out);
    typedef enum  logic [1:0] {IDLE, START, DATA, STOP} state_t;
    state_t state;
    logic [7:0] shift = 0;
    logic [2:0] bit_index = 0;
    logic [7:0] clk_count = 0;
    parameter CLKS_PER_BIT = 234;
    always_ff @(posedge clk) begin
        if (rst)begin
            state <= IDLE;
            serial_out <= 1;
            busy <= 0;
        end 
        else
            case(state)
                IDLE: begin
                    serial_out <= 1;
                    if (start) begin
                        shift <= data;
                        clk_count <= 0;
                        busy <= 1;
                        state <= START;
                    end
                end
                START: begin
                    serial_out <= 0;
                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;
                        bit_index <= 0;
                        state <= DATA;
                    end
                    else
                        clk_count <= clk_count + 1;
                end
                DATA: begin 
                    serial_out <= shift[bit_index];
                    if (clk_count == CLKS_PER_BIT - 1) begin
                        clk_count <= 0;
                        if (bit_index == 7)
                            state <= STOP;
                        else
                            bit_index <= bit_index + 1;
                    end
                    else 
                        clk_count <= clk_count + 1;
                end
                STOP: begin
                    serial_out <= 1;
                    if (clk_count == CLKS_PER_BIT - 1) begin
                        busy <= 0;
                        state <= IDLE;
                    end
                    else
                        clk_count <= clk_count + 1;
                    end
            endcase
    end
endmodule