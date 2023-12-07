library ieee;
use ieee.std_logic_1164.all;   

entity if_id is
    port (
		instruction_if_in   :in std_logic_vector(31 downto 0);
		PC_if_in			:in std_logic_vector(31 downto 0);
		
        clk					:in std_logic;
		rst					:in std_logic;
		enable				:in std_logic;
		
        instruction_id_out  :out std_logic_vector(31 downto 0);
		PC_id_out			:out std_logic_vector(31 downto 0) 
    );
end entity if_id;

architecture arch_if_id of if_id is		   
begin	
	process(clk)
	begin
		if rising_edge(clk) then 	
			if rst = '0' then
            			PC_id_out <=  X"00000000"; 
				instruction_id_out <= X"00000000"; 
        		else
				if enable = '1' then	
					--PC value is required in next stage
					PC_id_out <= PC_if_in;  								  
					-- output of instruction mem will be decoded in next state
					instruction_id_out<= instruction_if_in;
            			end if;
        		end if;		
		end if;
    end process;

end architecture arch_if_id;		   