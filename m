Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com> <20180307194745.657ewa6rtcta6eqm@rob-hp-laptop>
From: Alan Tull <atull@kernel.org>
Date: Wed, 7 Mar 2018 16:20:41 -0600
Message-ID: <CANk1AXS3gbLLy5fvyxcmeSBEaV2LZY9P=M3sOUHUceTgso5YkQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Content-Type: text/plain; charset="UTF-8"
To: Rob Herring <robh@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, catalin.marinas@arm.com, will.deacon@arm.com, Dinh Nguyen <dinguyen@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, Yves Vandervennet <yves.vandervennet@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Mar 7, 2018 at 1:47 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Mar 01, 2018 at 06:19:32PM -0600, richard.gong@linux.intel.com wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> ---
>> v2: this patch is added in patch set version 2
>> ---
>>  .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>> new file mode 100644
>> index 0000000..78de689
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>> @@ -0,0 +1,10 @@
>> +Intel Stratix10 SoC FPGA Manager
>> +
>> +Required properties:
>> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
>> +
>> +Example:
>> +
>> +     fpga_mgr: fpga-mgr@0 {
>> +             compatible = "intel,stratix10-soc-fpga-mgr";
>
> No reg or anything else? Is that because it all goes thru the service
> layer firmware?

Yes.

There will be a few more clients of the service layer: QSPI, Crypto
and warm reset.

> Just get the service layer driver to instantiate a
> device for this driver or get rid of the 2 layers if that's all the
> firmware interface does. DT is not a Linux driver instantiation
> mechanism.

Right, this should be describing hardware.

I could add this to the service layer binding:

firmware {
        svc {
                compatible = "intel,stratix10-svc";
                method = "smc";
                memory-region = <&service_reserved>;
                fpga-mgr {
                        compatible = "intel,stratix10-soc-fpga-mgr";
                };
        };
};

>
> And build your dts files with "W=1" because there's an error in this
> example.

Ouch.  Yes.

Warning (unit_address_vs_reg): Node /soc/fpga-mgr@0 has a unit name,
but no reg property

Thanks for the review,
Alan

>
> Rob
