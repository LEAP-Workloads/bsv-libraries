srcdir = ../src
debugdir = ../../Debug
testdir = ../test
commondir = ../../common
bramdir = ../../BRAM/
bdir = build/bdir
vdir = build/vdir
cdir = build/cdir
simdir = build/simdir

BSC = bsc

VER_OPTS =  +RTS -K100000000 --RTS -u -v -verilog -aggressive-conditions -vdir $(vdir) -bdir $(bdir) 
SIM_OPTS =  +RTS -K100000000 --RTS -u -v -sim -aggressive-conditions -show-schedule -vdir $(vdir) -bdir $(bdir) 
EXE_OPTS =  +RTS -K100000000 --RTS -simdir $(simdir) -sim 
C_OPTS = -c -fPIC

build: 
	mkdir -p build
	mkdir -p $(bdir)
	mkdir -p $(vdir)
	mkdir -p $(cdir)
	mkdir -p $(simdir)

FFT: build
	$(BSC) $(SIM_OPTS) -p +:$(testdir):$(srcdir):$(bdir):$(bramdir):$(debugdir) -g mkFFTTestBench $(srcdir)/FFTTestBench.bsv
	$(BSC) $(EXE_OPTS) -o FFT -p +:$(testdir):$(srcdir):$(bdir):$(bramdir):$(debugdir) -e mkFFTTestBench $(bdir)/mkFFTTestBench.ba $(srcdir)/fft.c > out.log

clean:
	rm -rf build

.PHONY: build