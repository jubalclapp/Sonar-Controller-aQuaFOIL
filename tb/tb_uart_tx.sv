`timescale 1ns/1ps
module tb_uart_tx;
logic clk = 0;
logic rst;
logic start;
logic busy;
logic serial_out;
logic [7:0] data;
uart_tx u_tx  (.clk(clk), .rst(rst), .data(data), .start(start), .busy(busy), .serial_out(serial_out));
always #18.52 clk = ~clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_uart_tx);
    rst = 1;
    start = 0;
    data = 8'h55;
    repeat (5) @(negedge clk);
    rst = 0;
    repeat (2) @(negedge clk);
    start = 1;
    @(negedge clk);
    start = 0;
    #100000;
    $finish;
end
endmodule