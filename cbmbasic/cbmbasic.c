#include <stdio.h>
#include <string.h>
#include "../perfect6502.h"
#include "runtime.h"
#include "runtime_init.h"
#include <time.h>

int benchmark_mode = 0;


/*
See https://www.c64-wiki.com/wiki/C64-Commands

10 PRINT 200 * 25.4
20 PRINT 200 / 3.3333
30 END
RUN

*/

#define SHOW_AVG_SPEED      1

state_t *state;

int
main(int argc, char *argv[])
{
	int clk = 0;
	int show_status = 0;

	if (argc > 1 && strcmp(argv[1], "--benchmark") == 0)
		benchmark_mode = 1;
 
	void *state = initAndResetChip();

	/* set up memory for user program */
	if (init_monitor()) {
		return 1;
	}

#if SHOW_AVG_SPEED
    clock_t end_time;
    clock_t start_time = clock();
#endif

	/* emulate the 6502! */
	for (;;) {
		step(state);
		clk = !clk;
		if (clk)
			handle_monitor(state);

		if(show_status){
		    chipStatus(state);
		}
#if SHOW_AVG_SPEED
		if (!(cycle % 20000)) {
		    unsigned long speed, time;
		    end_time = clock();
		    time = (end_time - start_time);
		    time = time / CLOCKS_PER_SEC;
		    time = time?time:1;	// avoid div by zero
		    speed = cycle / time;
		    printf("cycle %lu, speed %lu steps per second\n", cycle, speed);
		}
#endif
	};
}
