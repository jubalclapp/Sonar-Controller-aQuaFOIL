// power on & reset
logic [9:0] reset_count = 0;            // initialize reset_count
logic rst = 1;                          // initialize reset (t/f)
always_ff @(posedge clk)                // @ positive clock
    if (reset_count < 1000) begin
        reset_count <= reset_count + 1;
        rst <= 1;
        end
    else 
        rst <= 0;

// heartbeat
logic [25:0] heartbeat = 0;             // initialize
logic led = 0;
always_ff @(posedge clk) begin          // heartbeat loop
    heartbeat <= heartbeat + 1;
    led <= ~ heartbeat[24];
end

// pacing
logic [14:0] pace = 0;                  // initialize
logic send_now = 0;
always_ff @(posedge clk) begin          // pacing loop
    if (rst) begin                      // condition: system is reset
        pace <= 0;           
        send_now <= 0;
    end
    else if (pace == 26999) begin       // condition: 27k cycles have passed, send a message
        pace <= 0; 
        send_now <= 1;
    end
    else begin                          // condition: waiting for pace to reach 27k
        pace <= pace + 1;
        send_now <= 0;
    end
end