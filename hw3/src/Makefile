LINK = iverilog
VERILOG = iverilog
VFLAGS = -g2012
TOPMODULE = top
TOPFILE = top.v TPG.v CUT.v

.PHONY: all
all:
	$(VERILOG) $(VFLAGS) -o $(TOPMODULE) $(TOPFILE)

clean:
	del *.vcd *.vvp $(TOPMODULE)