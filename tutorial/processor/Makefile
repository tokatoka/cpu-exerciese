H3_CYGWIN_MODELSIM_PATH = /mnt/f/fpga/modelsim_ase/win32aloem

VLOG = $(H3_CYGWIN_MODELSIM_PATH)/vlog.exe
VLIB = $(H3_CYGWIN_MODELSIM_PATH)/vlib.exe
VSIM = $(H3_CYGWIN_MODELSIM_PATH)/vsim.exe -c
MODELSIM = $(H3_CYGWIN_MODELSIM_PATH)/modelsim.exe

PROJECT_WORK = ModelSim
LIBRARY_WORK = $(PROJECT_WORK)/$(LIBRARY_NAME)


# Library name and top-level module to be simulated
LIBRARY_NAME    = H3_Modules
TOPLEVEL_MODULE = H3_MainSim 

# Specify source files
SOURCES = \
	ALU.v \
	Branch.v \
	CPU.v \
	Decoder.v \
	DMem.v \
	IMem.v \
	ClockDivider.v \
	Main.v \
	IOCtrl.v \
	LEDDrv.v \
	MainSim.v \
	PC.v \
	RegFile.v \
	IFID.v \
	IDEX.v \
	EXMEM.v \
	MEMWB.v	\
	Types.v \
	InsnFeeder.v \
	Forward.v \
	ForwardMUX.v \
	Hazard.v \
	HazardMux.v

DEPS = \
	$(SOURCES) \

#	+incdir+../../Src 

OPTIONS = \
	-lint \
	-pedanticerrors \
	+librescan \
	-sv -nocovercells \
	-work $(LIBRARY_WORK) \
	#-incr \



all: $(DEPS) $(LIBRARY_WORK)
	$(VLOG) $(OPTIONS) $(SOURCES)


# vlib LIBRARY
clean:
	mkdir $(PROJECT_WORK) -p
	rm -f -r $(LIBRARY_WORK)
	( cd $(PROJECT_WORK); $(VLIB) $(LIBRARY_NAME); )

lib: clean

$(LIBRARY_WORK): Makefile
	make clean


# simulation
# vsim LIBRARY -do "run -all"
sim: 
	( cd $(PROJECT_WORK); $(VSIM) $(LIBRARY_NAME).$(TOPLEVEL_MODULE) -do "run -all"; )

# GUI simulation
sim-gui: 
	( cd $(PROJECT_WORK); $(MODELSIM) $(LIBRARY_NAME).$(TOPLEVEL_MODULE) ;  )




#	( cd $(WORK); $(VLOG) $(OPTIONS) $(DEPS); )


