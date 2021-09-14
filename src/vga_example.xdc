
#Autorzy: Jakub Bien, Tomasz Jurczyk, Bohdan Klymchuk


# Constraints for CLK
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.00 [get_ports clk]

# Constraints for VS and HS
set_property PACKAGE_PIN R19 [get_ports {vs}]
set_property IOSTANDARD LVCMOS33 [get_ports {vs}]
set_property PACKAGE_PIN P19 [get_ports {hs}]
set_property IOSTANDARD LVCMOS33 [get_ports {hs}]

# Constraints for RED
set_property PACKAGE_PIN G19 [get_ports {r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[0]}]
set_property PACKAGE_PIN H19 [get_ports {r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[1]}]
set_property PACKAGE_PIN J19 [get_ports {r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[2]}]
set_property PACKAGE_PIN N19 [get_ports {r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[3]}]

# Constraints for GRN
set_property PACKAGE_PIN J17 [get_ports {g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[0]}]
set_property PACKAGE_PIN H17 [get_ports {g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[1]}]
set_property PACKAGE_PIN G17 [get_ports {g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[2]}]
set_property PACKAGE_PIN D17 [get_ports {g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[3]}]

# Constraints for BLU
set_property PACKAGE_PIN N18 [get_ports {b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]
set_property PACKAGE_PIN L18 [get_ports {b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]
set_property PACKAGE_PIN K18 [get_ports {b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]
set_property PACKAGE_PIN J18 [get_ports {b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]

# Constraints for PCLK_MIRROR
set_property PACKAGE_PIN J1 [get_ports {pclk_mirror}]
set_property IOSTANDARD LVCMOS33 [get_ports {pclk_mirror}]

# Constraints for CFGBVS
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#Buttons
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN T18 [get_ports btnU]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnU]
set_property PACKAGE_PIN W19 [get_ports btnL]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnL]
set_property PACKAGE_PIN T17 [get_ports btnR]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnR]
set_property PACKAGE_PIN U17 [get_ports btnD]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnD]
	
##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports pad_D]
    set_property IOSTANDARD LVCMOS33 [get_ports pad_D]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports pad_R]
    set_property IOSTANDARD LVCMOS33 [get_ports pad_R]
##Sch name = JB3
#set_property PACKAGE_PIN B15 [get_ports pad_U]
#    set_property IOSTANDARD LVCMOS33 [get_ports pad_U]
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports pad_L]
    set_property IOSTANDARD LVCMOS33 [get_ports pad_L]
##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports pad_S]
    set_property IOSTANDARD LVCMOS33 [get_ports pad_S]
##Sch name = JB8
#set_property PACKAGE_PIN A17 [get_ports pad_a5]
#    set_property IOSTANDARD LVCMOS33 [get_ports pad_a5]
###Sch name = JB9
#set_property PACKAGE_PIN C15 [get_ports {pad_a_plug}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {pad_a_plug}]
###Sch name = JB10
#set_property PACKAGE_PIN C16 [get_ports {sound_a}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sound_a}]
