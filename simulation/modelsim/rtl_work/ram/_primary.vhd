library verilog;
use verilog.vl_types.all;
entity ram is
    port(
        clk             : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        addr            : in     vl_logic_vector(15 downto 0);
        A1              : in     vl_logic;
        reset           : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        cpustate        : in     vl_logic_vector(1 downto 0);
        D               : in     vl_logic_vector(7 downto 0);
        data_out        : out    vl_logic_vector(7 downto 0);
        check_out       : out    vl_logic_vector(7 downto 0)
    );
end ram;
