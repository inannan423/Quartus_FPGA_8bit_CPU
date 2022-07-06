library verilog;
use verilog.vl_types.all;
entity CPU_Controller is
    port(
        SW1             : in     vl_logic;
        SW2             : in     vl_logic;
        CPU_state       : out    vl_logic_vector(1 downto 0)
    );
end CPU_Controller;
