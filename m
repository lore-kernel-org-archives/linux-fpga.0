Return-Path: <SRS0=rF6L=3N=xilinx.com=michal.simek@kernel.org>
Return-Path: <SRS0=rF6L=3N=xilinx.com=michal.simek@kernel.org>
Subject: Re: [PATCH 1/2] doc: Add bindings document for Xilinx LogiCore PR
 Decoupler
References: <20170324153321.4168-1-atull@kernel.org>
 <20170324153321.4168-2-atull@kernel.org>
 <20170330224429.yo42hgnr7nhm2ljv@rob-hp-laptop>
 <CAAtXAHe0qnu7Ub6sing4VUgFa-tkdvH767kNbZnu1S5THHS2oQ@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <efd9b44a-680b-e4fc-38bd-e126ef8b4094@xilinx.com>
Date: Wed, 5 Apr 2017 08:26:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAAtXAHe0qnu7Ub6sing4VUgFa-tkdvH767kNbZnu1S5THHS2oQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Moritz Fischer <moritz.fischer@ettus.com>, Rob Herring <robh@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Devicetree
List-ID: <linux-fpga@vger.kernel.org>

On 5.4.2017 01:36, Moritz Fischer wrote:
> On Thu, Mar 30, 2017 at 05:44:29PM -0500, Rob Herring wrote:
>> On Fri, Mar 24, 2017 at 10:33:20AM -0500, Alan Tull wrote:
>>> From: Moritz Fischer <mdf@kernel.org>
>>
>> Please use "dt-bindings: fpga: ..." for the subject.
>>
>>
>>>
>>> This adds the binding documentation for the Xilinx LogiCORE PR
>>> Decoupler soft core.
>>>
>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> Acked-by: Alan Tull <atull@kernel.org>
>>
>> I'm confused why you are sending these instead of Moritz? If it goes
>> through you, then it should have your S-o-B too.
> 
> Do you want me to resend this Alan (with Rob's suggestions)?
>>
>>> Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>> ---
>>>  .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 ++++++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>>> new file mode 100644
>>> index 000000000000..2c527ac30398
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>>> @@ -0,0 +1,35 @@
>>> +Xilinx LogiCORE Partial Reconfig Decoupler Softcore
>>> +
>>> +The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
>>> +decouplers / fpga bridges.
>>> +The controller can decouple/disable the bridges which prevents signal
>>> +changes from passing through the bridge.  The controller can also
>>> +couple / enable the bridges which allows traffic to pass through the
>>> +bridge normally.
>>> +
>>> +The Driver supports only MMIO handling. A PR region can have multiple
>>> +PR Decouplers which can be handled independently or chained via decouple/
>>> +decouple_status signals.
>>> +
>>> +Required properties:
>>> +- compatible : Should contain "xlnx,pr-decoupler-1.00" or "xlnx,pr-decoupler"
>>
>> I'd drop xlnx,pr-decoupler, but in any case, it should not be OR rather
>> "followed by". Plus the example has both.
> 
> Michal wanted to have both, so I put both. Personally I don't care. I
> think they have some downstream stuff that relied on it.

Agree with Rob with using "followed by" instead of or.

M
