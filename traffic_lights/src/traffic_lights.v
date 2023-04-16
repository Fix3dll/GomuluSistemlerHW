module led (
    input sys_clk,
    input sys_rst_n,
    output reg [2:0] led // 110 R, 101 B, 011 G
);

reg [31:0] red_counter;
reg [31:0] yellow_counter;
reg [31:0] green_counter;

localparam RED = 3'b110;
localparam YELLOW = 3'b010;
localparam GREEN = 3'b011;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        red_counter <= 31'd0;
        yellow_counter <= 31'd0;
        green_counter <= 31'd0;
        led <= RED; // Tuşa basınca kırmızı yanan blok
    end
    else begin
        case (led)
            RED: begin
                if (red_counter < 31'd10000_0000) begin
                    red_counter <= red_counter + 1;
                end else begin
                    red_counter <= 31'd1;
                    led <= YELLOW;
                end
            end
            GREEN: begin
                if (green_counter < 31'd10000_0000) begin
                    green_counter <= green_counter + 1;
                end else begin
                    green_counter <= 31'd1;
                    led <= YELLOW;
                end
            end
            YELLOW: begin
                if (yellow_counter < 31'd2500_0000) begin
                    yellow_counter <= yellow_counter + 1;
                end else if (red_counter == 31'd1) begin // Eğer kırmızıdan geliyorsa sarı dan sonre yeşile geç
                    yellow_counter <= 31'd0;
                    red_counter <= 31'd0;
                    led <= GREEN;
                end else if (green_counter == 31'd1) begin // Eğer yeşil yanıyorsa sarıdan sonra kırmızıya geç
                    yellow_counter <= 31'd0;
                    green_counter <= 31'd0;
                    led <= RED;
                end
            end
        endcase
    end
end

endmodule