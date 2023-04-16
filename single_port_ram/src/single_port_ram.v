module single_port_ram(
    input clk,         // Clock input
    input write_en,    // Write enable input
    input [3:0] address, // Address input
    input [3:0] write_data, // Data input for writing
    output reg [3:0] read_data // Data output for reading
);

reg [3:0] mem [0:255]; // 256-byte memory

always @(posedge clk) // On every rising edge of clock
begin
    if(write_en) // If write is enabled
        mem[address] <= write_data; // Write data to memory at specified address
    read_data <= mem[address]; // Read data from memory at specified address
end

endmodule