library verilog;
use verilog.vl_types.all;
entity clk_div is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        symbol          : in     vl_logic_vector(31 downto 0);
        div_clk         : out    vl_logic
    );
end clk_div;
