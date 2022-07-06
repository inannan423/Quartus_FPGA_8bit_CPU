library verilog;
use verilog.vl_types.all;
entity ar is
    port(
        din             : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        arload          : in     vl_logic;
        arinc           : in     vl_logic;
        dout            : out    vl_logic_vector(15 downto 0)
    );
end ar;
