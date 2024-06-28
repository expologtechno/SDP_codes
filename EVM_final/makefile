
DUMP_OPTS=DUMP_ON

DUT_FILE=""
SIM_OPTS=""
TOP_FILE=""

comp:
	vlog -coveropt 3 +cover -L $(QUESTA_HOME)/uvm-1.2 +define+$(DUMP_OPTS) $(TOP_FILE)

vsim_example:
	rm -rf $(LOG_DIR)/$(TEST_NAME)_$(SEED)
	rm -rf $(TEST_NAME)_$(SEED).ucdb
	mkdir $(LOG_DIR)/$(TEST_NAME)_$(SEED)
	vsim -c -debugDB -sv_seed $(SEED) -cvgperinstance -voptargs=+acc -coverage -voptargs="+cover=all" +UVM_VERBOSITY=UVM_MEDIUM +UVM_TESTNAME=$(TEST_NAME) -l $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).log -do "coverage save -onexit $(LOG_DIR)/$(TEST_NAME)_$(SEED)/$(TEST_NAME)_$(SEED).ucdb;do $(SIM_DIR)/wave.do; run -all; exit" work.top

sim: 
	vsim -c -debugDB $(SIM_OPTS) -do "do wave.do; run -all; exit" work.tb_top

sim_gui: 
	vsim -debugDB $(SIM_OPTS) -do "do wave.do; run -all; exit" work.tb_top

run: comp sim

run_gui: comp sim_gui

wave: 
	vsim -view vsim.wlf &


