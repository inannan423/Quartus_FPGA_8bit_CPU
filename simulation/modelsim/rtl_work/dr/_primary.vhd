library verilog;
use verilog.vl_types.all;
entity dr is
    port(
        din             : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        drload          : in     vl_logic;
        dout            : out    vl_logic_vector(7 downto 0)
    );
end dr;
