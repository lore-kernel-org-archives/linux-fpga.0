Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170413200728.z6t2c7e6jobpstmb@rob-hp-laptop>
References: <1491757831-10510-1-git-send-email-mdf@kernel.org> <20170413200728.z6t2c7e6jobpstmb@rob-hp-laptop>
From: Alan Tull <atull@kernel.org>
Date: Thu, 13 Apr 2017 15:25:45 -0500
Message-ID: <CANk1AXQGXdAY_vz5GzujQL1ziqa5W23bGvkUPU2u5BaJKhBzrA@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: fpga: Add bindings document for Xilinx
 LogiCore PR Decoupler
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Apr 13, 2017 at 3:07 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Apr 09, 2017 at 10:10:31AM -0700, Moritz Fischer wrote:
>> This adds the binding documentation for the Xilinx LogiCORE PR
>> Decoupler soft core.
>>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Acked-by: Alan Tull <atull@kernel.org>
>> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> ---
>>
>> Changes from v4:
>> - Ssubject line
>> - Replaced 'or' by 'followed by' as suggested by Rob
>>
>> Changes from v3:
>> - Addressed Michal's comments
>> - Addressed Alan's Comments
>> - Added Alan's Acked-by
>>
>> Changes from v2:
>> - Added refence to generic fpga-region bindings
>> - Fixed up reg property in example
>> - Added fallback to "xlnx,pr-decoupler" without version
>>
>> Changes from v1:
>> - Added clock names & clock to example
>> - Merged some of the description from Michal's version
>>
>> ---
>>  .../bindings/fpga/xilinx-pr-decoupler.txt          | 36 +++++++++++++++=
+++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-dec=
oupler.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.=
txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>> new file mode 100644
>> index 0000000..b2c58fb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>> @@ -0,0 +1,36 @@
>> +Xilinx LogiCORE Partial Reconfig Decoupler Softcore
>> +
>> +The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
>> +decouplers / fpga bridges.
>> +The controller can decouple/disable the bridges which prevents signal
>> +changes from passing through the bridge.  The controller can also
>> +couple / enable the bridges which allows traffic to pass through the
>> +bridge normally.
>> +
>> +The Driver supports only MMIO handling. A PR region can have multiple
>> +PR Decouplers which can be handled independently or chained via decoupl=
e/
>> +decouple_status signals.
>> +
>> +Required properties:
>> +- compatible         : Should contain "xlnx,pr-decoupler-1.00" followed=
 by
>> +                          "xlnx,pr-decoupler"
>> +- regs                       : base address and size for decoupler modu=
le
>> +- clocks             : input clock to IP
>> +- clock-names                : should contain "aclk"
>> +
>> +Optional properties:
>> +- bridge-enable              : 0 if driver should disable bridge at sta=
rtup
>> +                       1 if driver should enable bridge at startup
>> +                       Default is to leave bridge in current state.
>
> Did this get into a common location? If so, then just "see .../?.txt" is
> enough of a description.

IIRC we went with this as is, with the intent of moving it to
a common location in a separate patch.  This binding shows
up in a a few bindings docs, so one patch could move it from all
of them at the same time.  That hasn't happened yet.

Alan

>
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
