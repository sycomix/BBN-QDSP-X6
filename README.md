# BBN QDSP Firmware

Firmware to run a superconducting qubit measurement transceiver on the
[Innovative Integration X6-1000M
card](http://www.innovative-dsp.com/products.php?product=X6-1000M).

## Dependencies

* [verilog-axis](https://github.com/alexforencich/verilog-axis) - for AXI stream components
* [VHDL-Components](https://github.com/BBN-Q/VHDL-Components) - for complex multiplier; polyphase SSB and cross-clock synchronizer

## ISE Project Setup

Modify the ``scripts/create_project.tcl`` to set the project name and directory
and FPGA part parameters.  Then from the tcl console in ISE run:

```tcl
cd /path/to/scripts/folder
source create_project.tcl
create_project
regenerate_ip
```

Building the bitfile might fail the first time on Map with an error about
IODELAY placement.  ISE is messing up reading the constraints and ``Rerun All``
all seems to fix the issue.

## Version Tag Registers

ISE does not support pre synthesis hooks so you must manually source
`scripts/update_version_generics.tcl` to update the generics that will get
written to the version registers.

## Software Driver

The firmware works with a C-API driver [libx6](https://github.com/BBN-Q/libx6).

## License

The BBN written modules are licensed under the Apache open source
[license](http://github.com/BBN-Q/BBN-QDSP-X6/blob/github/LICENSE). Files in the
ii_mods directory are modified from original Innovative Integration code and
carry their own license. If your copy of the repository does not have the
ii_mods folder please contact BBN and if you have a valid Frameworks Logic
license we can share the modified files.
