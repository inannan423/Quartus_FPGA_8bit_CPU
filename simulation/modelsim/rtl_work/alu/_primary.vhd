library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        alus            : in     vl_logic_vector(3 downto 0);
        ac              : in     vl_logic_vector(7 downto 0);
        \bus\           : in     vl_logic_vector(7 downto 0);
        dout            : out    vl_logic_vector(7 downto 0)
    );
end alu;
