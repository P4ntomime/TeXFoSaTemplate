-- Libraries 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration (must be empty)
entity TestBench is 
end entity TestBench;

architecture RTL of TestBench is
	-- component declaration
	component comp_a
		port(
			inp        : in std_ulogic_vector(7 downto 0);
			clk, rst   : in std_logic;
			oup1, oup2 : out std_ulogic_vector(3 downto 0));
	end component comp_a;
	-- Internal signal declarations
	signal inp_tb           : std_ulogic_vector(7 downto 0);
	signal oup1_tb, oup2_tb : std_ulogic_vector(3 downto 0);
	signal clk_tb, rst_tb   : std_ulogic;
	
	-- Constant declarations
	constant test_frequency    : integer := 1e6; --1'000'000;
	constant test_period       : time := 1 sec / test_frequency;
	constant sample_before_clk : time := 1 ns;
begin
	-- Component instantiation
	dut : component comp_a 
		port map(
			inp => inp_tb,
			clk => clk_tb,
			rst => rst_tb,
			oup1 => oup1_tb,
			oup2 => oup2_tb);
	-- Clock generator
	clk_generator : process
	begin
		clk_tb <= '0'; wait for test_period / 2;
		clk_tb <= '1'; wait for test_period / 2;
	end process;
	-- reset generator: '1' for 8 cycles, then '0'
	reset_generator : rst_tb <= '1', '0' after 8*test_period;
	-- Generate all possible stimuli
	stimuli_generator : process
	begin
		inp_tb <= (others => '0');	-- default value
		wait until rst_tb = '0';
		wait until rising_edge(clk_tb);
	-- generate all possible stimuli for signal inp_tb
		for i in 0 to 2**8 - 1 loop
			inp_tb <= std_ulogic_vector(to_unsigned(i, 8));
			wait for test_period;
		end loop;
	end process;
	
	-- Check system response with asserts
	response_monitor : process
	begin
		wait until (rising_edge(clk_tb) and (rst_tb = '0'));
		for i in 0 to 2**8 - 1 loop
			wait for (test_period - sample_before_clk);
			assert (oup1_tb = oup1_expected) 
				report "mismatch at vector " & integer'image(i) 
				severity warning;
			assert (oup2_tb = oup2_expected) 
				report "mismatch at vector " & integer'image(i) 
				severity warning;
			wait for sample_before_clk;
		end loop;
	end process;
end architecture RTL;