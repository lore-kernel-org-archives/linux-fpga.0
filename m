Return-Path: <SRS0=j4g7=FQ=gmail.com=shubhrajyoti.datta@kernel.org>
Return-Path: <SRS0=j4g7=FQ=gmail.com=shubhrajyoti.datta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180221174440.GA17947@tyrael.ni.corp.natinst.com>
References: <1519188826-2047-1-git-send-email-shubhrajyoti.datta@gmail.com> <20180221174440.GA17947@tyrael.ni.corp.natinst.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Thu, 22 Feb 2018 15:17:04 +0530
Message-ID: <CAKfKVtFoF52S=6eoAdEfwm4-Puh1wnmsvxMY=M9G9S0_SHO1WA@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: fpga: Add reset bridge support
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, nofooter@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,

On Wed, Feb 21, 2018 at 11:14 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Feb 21, 2018 at 10:23:45AM +0530, shubhrajyoti.datta@gmail.com wrote:
>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> Add reset bridge support. Once this bridge is enabled.
>> The reset line(s) will be toggled. Generally it will be
>> called after the bitstream load to reset the PL.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> ---
>>  .../devicetree/bindings/fpga/xlnx,rst-bridge.txt   | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt b/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
>> new file mode 100644
>> index 0000000..6f1bfc2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
>> @@ -0,0 +1,22 @@
>> +Xilinx fpga reset bridge
>> +
>> +The Xilinx reset bridge toggles the reset line to the PL
>> +in Zynqmp Ultrascale plus.
>
> Out of curiosity do you have a reference in the TRM where this is
> explained?

https://www.xilinx.com/support/documentation/ip_documentation/zynq_ultra_ps_e/v2_0/pg201-zynq-ultrascale-plus-processing-system.pdf

section :Fabric Reset Enable
>> +
>> +
>> +Required properties:
>> +- compatible : Should contain "xlnx,rst-bridge"
>> +- reset              : reset phandles
>> +
>> +Optional properties:
>> +- bridge-enable              : 0 if driver should disable bridge at startup
>> +                       1 if driver should enable bridge at startup
>> +                       Default is to leave bridge in current state.
>> +
>> +See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic bindings.
>
> Since this would be the 5th? time of replicating this I sent out a patch
> [1] to consolidate this paragraph into a single file.
>
> Feel free to add this to your series and replace the above with
>
> See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
Will do

>
> Thanks
>
> Moritz
>
> [1] https://lkml.org/lkml/2018/2/21/1099
