OBJS 	  += perfect6502.o
OBJS 	  += netlist_sim.o
CBM_OBJS  += cbmbasic/cbmbasic.o
CBM_OBJS  += cbmbasic/runtime.o
CBM_OBJS  += cbmbasic/runtime_init.o
CBM_OBJS  += cbmbasic/plugin.o
CBM_OBJS  += cbmbasic/console.o
CBM_OBJS  += cbmbasic/emu.o
CBM_TARGET = cbmbasic/cbmbasic

MEAS_OBJS  += measure.o
MEAS_TARGET = measure

APPLE_OBJS += apple1basic/apple1basic.o
APPLE_TARGET = apple1basic/apple1basic

ALL_OBJS  = $(OBJS) $(CBM_OBJS) $(MEAS_OBJS) $(APPLE_OBJS)
TARGETS   = $(CBM_TARGET) $(MEAS_TARGET) $(APPLE_TARGET)

CFLAGS	+= -std=gnu18
CFLAGS	+= -Werror
CFLAGS	+= -Wall
CFLAGS  += -Wmismatched-dealloc
CFLAGS  += -Wfree-nonheap-object
#CFLAGS  += -m32
CFLAGS	+= -O3
CFLAGS	+= -g
CC 	= gcc

all: $(TARGETS)

$(CBM_TARGET):	$(OBJS) $(CBM_OBJS)
	$(CC) $(CFLAGS) -o $(CBM_TARGET) $(OBJS) $(CBM_OBJS)

$(MEAS_TARGET):	$(OBJS) $(MEAS_OBJS)
	$(CC) $(CFLAGS) -o $(MEAS_TARGET) $(OBJS) $(MEAS_OBJS)

$(APPLE_TARGET): $(OBJS) $(APPLE_OBJS)
	$(CC) $(CFLAGS) -o $(APPLE_TARGET) $(OBJS) $(APPLE_OBJS)

benchmark: cbmbasic
	./cbmbasic/cbmbasic --benchmark

clean:
	rm -f $(ALL_OBJS) $(TARGETS)

