library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        din             : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        pcload          : in     vl_logic;
        pcinc           : in     vl_logic;
        dout            : out    vl_logic_vector(15 downto 0)
    );
end pc;
