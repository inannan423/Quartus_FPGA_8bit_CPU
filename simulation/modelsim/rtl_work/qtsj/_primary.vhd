library verilog;
use verilog.vl_types.all;
entity qtsj is
    port(
        clk_quick       : in     vl_logic;
        clk_slow        : in     vl_logic;
        clk_delay       : in     vl_logic;
        clr             : in     vl_logic;
        rst             : in     vl_logic;
        SW_choose       : in     vl_logic;
        A1              : in     vl_logic;
        cpustate        : in     vl_logic_vector(1 downto 0);
        clk_run         : out    vl_logic;
        clk_choose      : out    vl_logic
    );
end qtsj;
