Return-Path: <SRS0=Rhvk=DC=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=Rhvk=DC=gmail.com=frowand.list@kernel.org>
Subject: Re: [RFC 0/2] of: Add whitelist
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
 <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
 <6a620530-2fac-480f-5c38-6b2b5257c9e9@gmail.com>
 <CABGGisyiG3mV9s+ksgNFVgoOk=dJrFn4PGj6Ny-O7=o9kmpRTw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e3db9adc-477d-2358-ac52-8b78f6d38b58@gmail.com>
Date: Wed, 6 Dec 2017 06:44:32 -0500
MIME-Version: 1.0
In-Reply-To: <CABGGisyiG3mV9s+ksgNFVgoOk=dJrFn4PGj6Ny-O7=o9kmpRTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/30/17 09:39, Rob Herring wrote:
> On Wed, Nov 29, 2017 at 4:47 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 11/29/17 04:20, Frank Rowand wrote:
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
>> Going back one level in my thinking, I don't think that having a driver mark
>> a node as a location where an overlay fragment can be applied is serving a
>> useful purpose.  Any driver, including any driver loaded as a module,
>> could mark a node as ok.  I don't see how this is providing any meaningful
>> restriction on where an overlay fragment can be applied.
> 
> It serves to separate the setting of which nodes overlays can be
> applied to and the mechanism to apply them (checking permissions). The
> former can't be centralized

My expectation is that determining which nodes overlays can be applied
to can and _should_ be centralized, at least to begin with.  If we
loosen the restrictions on valid overlay application nodes then we
_might_ find that we have to provide additional non-centralized permission
granting.

I think that the core devicetree code is the place (for initial implementation)
that determining which nodes an overlay can be applied to.  My expectation
is that it will be implicitly obvious to the core devicetree code which
nodes are connector nodes.  Given that there have been several different
proposals for connector implementation, my expectation may be completely
wrong.  So I am sure I will revisit my expectations the actual
implementation of connectors arrives.

Since the architecture and implementation of connectors is still so
uncertain, I think it is premature to accept the changes proposed in
the patch set, and the next patch set that has been proposed in
response to the conversation in this thread.


> and the latter can be. For example,
> something in the kernel enables overlays on a node or nodes, then the
> overlay is applied with configfs interface and no board specific code
> involved.

I agree that the permission checking should not need to involve board
specific code.


> My concern is not whether any kernel component can enable applying of
> overlays, but userspace. If it is a kernel component, then it is
> explicit. And an OOT kernel module doesn't count because there's no
> ABI guarantee there.
> 
> I agree that this patch series alone is not all that useful with only
> in kernel users. It is only really interesting when we have a
> userspace interface. However, an implementation with a flag bit is so
> little code, I'm fine taking it now and not having to update all in
> kernel users when adding a userspace interface.

I think the concept of an API called by a driver, instead of the
devicetree core code determining which nodes an overlay can be
applied to is premature, since there is no direct need for it,
and given that it is little code it can easily be added when it
is needed, and we better understand how it will be used.

> 
> Rob
> 
