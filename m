Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a620530-2fac-480f-5c38-6b2b5257c9e9@gmail.com>
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
 <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com> <6a620530-2fac-480f-5c38-6b2b5257c9e9@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 30 Nov 2017 08:39:58 -0600
Message-ID: <CABGGisyiG3mV9s+ksgNFVgoOk=dJrFn4PGj6Ny-O7=o9kmpRTw@mail.gmail.com>
Subject: Re: [RFC 0/2] of: Add whitelist
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Nov 29, 2017 at 4:47 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 11/29/17 04:20, Frank Rowand wrote:
>> On 11/27/17 15:58, Alan Tull wrote:
>>> Here's a proposal for a whitelist to lock down the dynamic device tree.
>>>
>>> For an overlay to be accepted, all of its targets are required to be
>>> on a target node whitelist.
>>>
>>> Currently the only way I have to get on the whitelist is calling a
>>> function to add a node.  That works for fpga regions, but I think
>>> other uses will need a way of having adding specific nodes from the
>>> base device tree, such as by adding a property like 'allow-overlay;'
>>> or 'allow-overlay = "okay";' If that is acceptable, I could use some
>>> advice on where that particular code should go.
>>>
>>> Alan
>>>
>>> Alan Tull (2):
>>>   of: overlay: add whitelist
>>>   fpga: of region: add of-fpga-region to whitelist
>>>
>>>  drivers/fpga/of-fpga-region.c |  9 ++++++
>>>  drivers/of/overlay.c          | 73 +++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/of.h            | 12 +++++++
>>>  3 files changed, 94 insertions(+)
>>>
>>
>> The plan was to use connectors to restrict where an overlay could be applied.
>> I would prefer not to have multiple methods for accomplishing the same thing
>> unless there is a compelling reason to do so.
>
> Going back one level in my thinking, I don't think that having a driver mark
> a node as a location where an overlay fragment can be applied is serving a
> useful purpose.  Any driver, including any driver loaded as a module,
> could mark a node as ok.  I don't see how this is providing any meaningful
> restriction on where an overlay fragment can be applied.

It serves to separate the setting of which nodes overlays can be
applied to and the mechanism to apply them (checking permissions). The
former can't be centralized and the latter can be. For example,
something in the kernel enables overlays on a node or nodes, then the
overlay is applied with configfs interface and no board specific code
involved.

My concern is not whether any kernel component can enable applying of
overlays, but userspace. If it is a kernel component, then it is
explicit. And an OOT kernel module doesn't count because there's no
ABI guarantee there.

I agree that this patch series alone is not all that useful with only
in kernel users. It is only really interesting when we have a
userspace interface. However, an implementation with a flag bit is so
little code, I'm fine taking it now and not having to update all in
kernel users when adding a userspace interface.

Rob
