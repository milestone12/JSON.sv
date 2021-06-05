_JSON.sv_ is a SystemVerilog package that enables you to read, manipulate, and write JSON object trees.

# Usage
_JSON.sv_ uses the [FuseSoC](https://github.com/olofk/fusesoc) package manager to abstract from any HDL simulator you might want to use.

## FuseSoC library
After cloning the repository or downloading the `JSON.core` file you need to add it to a local FuseSoC library:
```bash
fusesoc library add <name> JSON.core
```

If you have decided to only donwload the `JSON.core` file you need to uncomment the lines that describe the file provider.

## Run the test bench
### Headless
```bash
fusesoc run FPGA_Garage:util:JSON
```

### With simulator GUI
```bash
fusesoc run --build FPGA_Garage:util:JSON
make -C build/FPGA_Garage_util_JSON_0/sim-<your simulator> run-gui
```

# Example code
The test program in `sv/json_test.sv` contains example calls for all the available API.
