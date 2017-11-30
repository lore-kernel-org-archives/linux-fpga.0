Return-Path: <SRS0=jDSI=C4=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=jDSI=C4=gmail.com=frowand.list@kernel.org>
Subject: Re: [RFC 0/2] of: Add whitelist
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
 <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
 <CAL_JsqL5gYh_++1wDLMYjO7MXKOHpzr315FZ1tuN9o5tOe7TYA@mail.gmail.com>
 <CANk1AXTN=0L3L9O_7njF=hqJG=X88Q3jRvDW3UfBnZeEnUmhxA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <24161ebf-81be-bec7-9fe8-36279a8b5a8d@gmail.com>
Date: Thu, 30 Nov 2017 07:46:36 -0500
MIME-Version: 1.0
In-Reply-To: <CANk1AXTN=0L3L9O_7njF=hqJG=X88Q3jRvDW3UfBnZeEnUmhxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/29/17 11:11, Alan Tull wrote:
> On Wed, Nov 29, 2017 at 7:31 AM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Wed, Nov 29, 2017 at 3:20 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> On 11/27/17 15:58, Alan Tull wrote:
>>>> Here's a proposal for a whitelist to lock down the dynamic device tree.
>>>>
>>>> For an overlay to be accepted, all of its targets are required to be
>>>> on a target node whitelist.
>>>>
>>>> Currently the only way I have to get on the whitelist is calling a
>>>> function to add a node.  That works for fpga regions, but I think
>>>> other uses will need a way of having adding specific nodes from the
>>>> base device tree, such as by adding a property like 'allow-overlay;'
>>>> or 'allow-overlay = "okay";' If that is acceptable, I could use some
>>>> advice on where that particular code should go.
>>>>
>>>> Alan
>>>>
>>>> Alan Tull (2):
>>>>   of: overlay: add whitelist
>>>>   fpga: of region: add of-fpga-region to whitelist
>>>>
>>>>  drivers/fpga/of-fpga-region.c |  9 ++++++
>>>>  drivers/of/overlay.c          | 73 +++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/of.h            | 12 +++++++
>>>>  3 files changed, 94 insertions(+)
>>>>
>>>
>>> The plan was to use connectors to restrict where an overlay could be applied.
>>> I would prefer not to have multiple methods for accomplishing the same thing
>>> unless there is a compelling reason to do so.
>>
>> Connector nodes need a mechanism to enable themselves, too. I don't
>> think connector nodes are going to solve every usecase.
>>
>> Rob
> 
> The two methods I'm suggesting are intended to handle different cases.
>   There will exist some drivers that by their nature will want every
> instance to be enabled for overlays, such as fpga regions.  The other
> case is where drivers could support overlays but that's not the
> widespread use for them.  So no need to enable every instance of that
> driver for overlays.

I understand what the paragraph, to this point, means.  But I had to
read it several times to understand it because the way the concept is
phrased clashed with my mental model.

The device node is not an instance of a driver, which is why I was
getting confused.  (Yes, I do understand that the paragraph is talking
about multiple device nodes that are bound to the same driver, but
my mental model is tied to the device node, not to the driver.)

If each of the device nodes in question is a connector, then each of
the nodes will bind to a connector driver, based on the value of the
compatible property.  (This is of course a theoretical assumption on
my part since the connectors are not yet implemented.)

If the connector node is an fpga, or an fpga region (I may be getting
my terminology wrong here - please correct as needed) then an fpga
overlay could be applied to the node.

If I understand what you are saying, there will be some fpga connector
nodes for which the usage at a given moment might be programmed to
function in a manner that will not be described by an overlay, but
at a different moment in time may be programmed in a way that needs
to be described by an overlay.  So there may be some times that it
is valid to apply an overlay to the connector node and times that
it is not valid to apply an overlay to the connector node.

Is my understanding correct, or am I still confused?

-Frank

> In that case the DT property provides some
> granularity, only enabling overlays for specific instances of that
> driver, leaving the rest of the DT locked down.> 
> If we only want one method, I would choose having the DT property only
> and not exporting the functions.  Users would have to add the property
> for every FPGA region but that's not really painful.  This would have
> the benefit of still keeping the DT locked down unless someone
> specifically wanted to enable some regions for overlays for their
> particular use.
> 
> Alan
> 
