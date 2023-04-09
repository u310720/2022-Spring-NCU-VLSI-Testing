LINK = iverilog
VERILOG = iverilog
VFLAGS = -g2012
TOPMODULE = DUT
TOPFILE = DUT.sv DUT_tb.sv

.PHONY: all
all:
	$(VERILOG) $(VFLAGS) -o $(TOPMODULE) $(TOPFILE)

clean:
	del *.vcd *.vvp $(TOPMODULE)