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
	@echo "run \"make run_omp iterations=some_number\" to run the parallel program with some_number iterations"
	@echo "run \"make run_seq iterations=some_number\" to run the sequential program with some_number iterations"
	@echo "run \"make new_dataset rows=some_number\" to generate a new random dataset with some_number rows\n(if you don't write \"rows=some_number\", the dataset will have 119746 rows)"

compile:
	@echo "compiling..."
	@$(CPU_COMPILE_C) -lm -fopenmp $(SRC_DIR)/main-gol.c  $(LINK) -o $(BIN_DIR)/gol_omp
	@$(CPU_COMPILE_C) -lm $(SRC_DIR)/main-gol-pragmaless.c  $(LINK) -o $(BIN_DIR)/gol_seq

new_dataset:
	@cd $(DATASET_DIR) && julia gen_dataset.jl $(rows)
	
clean:
	@echo "removing executable programs:"
	rm $(BIN_DIR)/gol_omp
	rm $(BIN_DIR)/gol_seq

run_omp:
	@$(SCRIPTS_DIR)/exec_omp.sh $(iterations)

run_seq:
	@$(SCRIPTS_DIR)/exec_seq.sh $(iterations)