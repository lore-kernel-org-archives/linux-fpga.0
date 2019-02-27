Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
From: Alan Tull <atull@kernel.org>
Date: Wed, 27 Feb 2019 15:39:42 -0600
Message-ID: <CANk1AXSxR7oW7yBTK8-BoTpVmE+mO0Dp4uMDD11b16dGgxyaFA@mail.gmail.com>
Subject: v5.0 Kernel Device Tree Overlay Changes
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, linux-fpga@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

=======================================
v5.0 Kernel Device Tree Overlay Changes
=======================================

This is getting out later than I hoped.  My intent is something brief
that will give a bit of guidance and context for FPGA users of DT
overlay under v5.0.

Summary
=======

Linux kernel changes [1] coming in v5.0 will affect the use of Device Tree (DT)
overlays. These changes introduce restrictions that may require users to adjust
their device tree overlays.  Fortunately the adjustments required are small.
However, even with adjustments users will experience new warnings.  These
restrictions and warnings are described below.  With continued upstream
improvements, the new warnings are expected to subside in the future.

Why these changes
-----------------

There are memory leaks that occur when overlays are removed due to the
way memory for DT properties is allocated and tracked. Frank Rowand
has undertaken the challenge of reworking the implementation to reduce
and eventually eliminate these leaks. This work is ongoing.

New restrictions
================

Overlays that change #address-cells or #size-cells of an existing node will be
rejected with an error message. This will mean that we must change how we map
FPGA bridges if they were mapped to a separate address space.

Device Tree Example
-------------------

The base device tree includes this region that will be targeted by an overlay:

        base_fpga_region: base-fpga-region {
                #address-cells = <1>;
                #size-cells = <1>;

                compatible = "fpga-region";
                fpga-mgr = <&fpga_mgr>;
        };

In the overlay (below), the hps2fpga and lwhps2fpga bridges are mapped using the
ranges property. The ranges property is described in [2] and consists of
triplets of (child-bus-address, parent-bus-address, length). The #address-cells
property specifies how many fields are in child-bus-address. By changing the
#address-cells from 1 to 2, the overlay adds a virtualized chip select to allow
mapping the address range of the two bridges to separate address spaces. This
makes the child-bus-address two fields so the first two numbers on each line are
actually the child-bus-address field. The first line of the ranges property maps
the hps2fpga bridge at parent address of 0xc0000000 to child address 0x0 at chip
select 0 for the nodes in the overlay. The next line maps the lwhps2fpga bridge
at parent address 0xff200000 to child address 0x0 at chip select 1. Note that
the parent addresses of both bridges are in the same address space and therefore
these chip selects are not needed.

        /dts-v1/;
        /plugin/;
        &base_fpga_region {
                ranges = <0x00000000 0x00000000 0xc0000000 0x00040000>,
                         <0x00000001 0x00000000 0xff200000 0x00001000>;
                #address-cells = <2>;
                #size-cells = <1>;
                freeze_controller_0: freeze_controller@0x100000450 {
                        compatible = "altr,freeze-bridge-controller";
                        reg = <0x00000001 0x00000450 0x00000010>;
                        ...

Attempting to apply the overlay will give the following error:

[ 57.326814] OF: overlay: ERROR: changing value of #address-cells is
not allowed in /soc/base_fpga_region
[ 57.336295] create_overlay: Failed to create overlay (err=-22)


Solution for the new restrictions
---------------------------------

Since overlays are no longer allowed to change #address-cells, the following
overlay leaves the #address-cells property set to a value of 1. The chip select
field has been dropped from the ranges and the reg properties. Both bridges are
mapped in the same address space and as such the addresses have been adjusted to
prevent overlap. The hps2fpga bridge is mapped to 0xc0000000 and the lwhps2fpga
bridge to 0x0. This achieves the same functionality without the error.

Note that these changes also will work on pre-v5.0 kernel branches.

        /dts-v1/;
        /plugin/;
        &base_fpga_region {
                ranges = <0xc0000000 0xc0000000 0x00040000>,
                         <0x00000000 0xff200000 0x00001000>;
                #address-cells = <1>;
                #size-cells = <1>;

                freeze_controller_0: freeze_controller@0x0450 {
                        compatible = "altr,freeze-bridge-controller";
                        reg = <0x00000450 0x00000010>;
                        ...

New warnings
============

Any properties that are added to an existing node will get a warning about
memory leaks. This warning will not prevent the overlay from being applied.  The
reason for the warning is due to lifespan of the memory that is allocated for
the properties being tied to the node they are in, not to the overlay. As
mentioned above, upstream development will continue, but for the time being,
users of DT overlays will get warnings about memory leaks.

Example warnings
----------------

Applying dtbo: socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb

[  304.796643] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /soc/base_fpga_region/ranges
[  304.807920] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /soc/base_fpga_region/external-fpga-config
[  304.819558] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /soc/base_fpga_region/clocks
[  304.829962] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /soc/base_fpga_region/clock-names
[  304.840919] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/clk_0
[  304.850467] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/ILC
[  304.859837] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/freeze_controller_0
[  304.870627] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/sysid_qsys_0
[  304.880789] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/led_pio
[  304.890510] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/button_pio
[  304.900488] OF: overlay: WARNING: memory leak will occur if overlay
removed, property: /__symbols__/dipsw_pio
[  304.913077] of-fpga-region soc:base_fpga_region:fpga_pr_region0:
FPGA Region probed
[  304.921320] altera_freeze_br ff200450.freeze_controller: fpga
bridge [freeze] registered


References
==========

[1] Git commit implementing these changes (from v5.0-rc1)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f75118800acf77f8ad6afec61ca1b2349ade371

[2] Link to device tree specification

https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf
