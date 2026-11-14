// power on & reset
logic [9:0] reset_count = 0;            // initialize reset_count
logic [:0] rst = 1;                     // initialize reset (t/f)
always_ff @(posedge clk)                // @ positive clock
    if (reset_count < 1000) begin
        reset_count <= reset_count + 1;
        rst <= 1;
        end
    else 
        rst <= 0;