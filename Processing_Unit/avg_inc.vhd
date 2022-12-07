library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
 
entity avg_inc is
port ( clk,reset: in std_logic;
       i_index :in  std_logic_vector(14 downto 0);
       o_inc: out std_logic_vector(14 downto 0)
    );
end avg_inc;
 
architecture bhv of avg_inc is
 
	signal count :integer range 0 to 14999;
    signal out_cout :integer range 0 to 20;
    --signal sum   : integer;
    signal max  :std_logic_vector(14 downto 0);
 
begin
 
process(clk,reset)
begin
    if(reset='0') then
        o_inc <= (others => '0');
    elsif(rising_edge(clk)) then
        if(count = 0)then
            max <= i_index;
        end if;
        if (count = 14999) then
            count <= 0;
            out_cout <= out_cout + 1;
        elsif(out_cout = 20) then
            o_inc <=  max;
            out_cout <= 0;
            count <= 0;
           -- sum <= 0;
        elsif(i_index > max)then
            max <=i_index;
        else
            count <= count +1;
        end if;
    end if;

end process;
 
end bhv;