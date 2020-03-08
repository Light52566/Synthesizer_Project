set_property PACKAGE_PIN W5 [get_ports Clock]							
	set_property IOSTANDARD LVCMOS33 [get_ports Clock]
	create_clock -add -name sys_clock_pin -period 10.00 -waveform {0 5} [get_ports Clock]


##Mode Select
set_property PACKAGE_PIN R2 [get_ports {Mode[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Mode[0]}]
set_property PACKAGE_PIN T1 [get_ports {Mode[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Mode[1]}]
##W2 - Octave 4/5
set_property PACKAGE_PIN W2 [get_ports {Octave}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Octave}]

##Buttons
set_property PACKAGE_PIN T18 [get_ports {but}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {but}]
set_property PACKAGE_PIN U17 [get_ports {bdt}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {bdt}]

##R3 - C
set_property PACKAGE_PIN R3 [get_ports {N[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[0]}]
##T2 - Cs
set_property PACKAGE_PIN T2 [get_ports {N[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[1]}]
##T3 - D
set_property PACKAGE_PIN T3 [get_ports {N[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[2]}]
##V2 - Ds
set_property PACKAGE_PIN V2 [get_ports {N[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[3]}]
##W13 - E
set_property PACKAGE_PIN W13 [get_ports {N[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[4]}]
##W14 - F
set_property PACKAGE_PIN W14 [get_ports {N[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[5]}]
##V15 - Fs
set_property PACKAGE_PIN V15 [get_ports {N[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[6]}]
##W15 - G
set_property PACKAGE_PIN W15 [get_ports {N[7]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {N[7]}]
##W17 - Gs
set_property PACKAGE_PIN W17 [get_ports {N[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[8]}]
##W16 - A
set_property PACKAGE_PIN W16 [get_ports {N[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[9]}]
##V16 - As
set_property PACKAGE_PIN V16 [get_ports {N[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[10]}]
##V17 - B
set_property PACKAGE_PIN V17 [get_ports {N[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {N[11]}]


## JXAC4 - output
set_property PACKAGE_PIN N2 [get_ports {output}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {output}]
        
## 7segment
set_property PACKAGE_PIN W7 [get_ports {Display[6]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[6]}]
set_property PACKAGE_PIN W6 [get_ports {Display[5]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[5]}]
set_property PACKAGE_PIN U8 [get_ports {Display[4]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[4]}]
set_property PACKAGE_PIN V8 [get_ports {Display[3]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[3]}]
set_property PACKAGE_PIN U5 [get_ports {Display[2]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[2]}]
set_property PACKAGE_PIN V5 [get_ports {Display[1]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[1]}]
set_property PACKAGE_PIN U7 [get_ports {Display[0]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[0]}]
#set_property PACKAGE_PIN V7 [get_ports {Display[0]}]                
#    set_property IOSTANDARD LVCMOS33 [get_ports {Display[0]}]
set_property PACKAGE_PIN U2 [get_ports {Digit[0]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[0]}]
set_property PACKAGE_PIN U4 [get_ports {Digit[1]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[1]}]
set_property PACKAGE_PIN V4 [get_ports {Digit[2]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[2]}]
set_property PACKAGE_PIN W4 [get_ports {Digit[3]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[3]}]

##reset
set_property PACKAGE_PIN U18 [get_ports {Reset}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {Reset}]
 
