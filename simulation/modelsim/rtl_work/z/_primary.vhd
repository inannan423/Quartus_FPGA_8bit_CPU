library verilog;
use verilog.vl_types.all;
entity z is
    port(
        din             : in     vl_logic_vector(0 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        zload           : in     vl_logic;
        dout            : out    vl_logic_vector(0 downto 0)
    );
end z;
