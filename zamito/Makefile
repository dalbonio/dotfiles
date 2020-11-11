CPUC      = gcc
CFLAGS    = -O3 --std=c11 -m64 -w	 #     -Wunused-variable #-Wno-conversion-null -Wdelete-non-virtual-dtor
DEFS      =
INCLUDES  =
LIBDIR   = -L/usr/lib
LIBS     = -lm
LINK     =  $(LIBDIR) $(LIBS)
CPU_COMPILE_C  = $(CPUC) $(DEFS) $(INCLUDES) $(CFLAGS)
BIN_DIR     = bin
SCRIPTS_DIR = scripts
DATASET_DIR = dataset
SRC_DIR     = src

all:
	@echo "run \"make compile\" to compile the program for both sequential and parallel codes"
	@echo "run \"make run_omp\" to run the parallel program"
	@echo "run \"make run_seq\" to run the sequential program"
	@echo "run \"make new_dataset\" to get instructions about how a new dataset can be generated"

compile:
	@echo "compiling..."
	@$(CPU_COMPILE_C) -lm -fopenmp $(SRC_DIR)/main-gol.c  $(LINK) -o $(BIN_DIR)/gol_omp
	@$(CPU_COMPILE_C) -lm $(SRC_DIR)/main-gol-pragmaless.c  $(LINK) -o $(BIN_DIR)/gol_seq

new_dataset:
	@echo "1 - go to the folder \"dataset/\""
	@echo "2 - run \"julia gen_dataset.jl some_number\" to generate a new random dataset with some_number rows"
	@echo "obs.: if some_number is empty, the default value, 119746, will be used to generate a new random dataset with 119746 rows"

clean:
	@echo "removing executable programs:"
	rm $(BIN_DIR)/gol_omp
	rm $(BIN_DIR)/gol_seq

run_omp:
	@$(SCRIPTS_DIR)/exec_omp.sh

run_seq:
	@$(SCRIPTS_DIR)/exec_seq.sh