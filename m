Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
References: <1511816284-12145-1-git-send-email-atull@kernel.org> <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 29 Nov 2017 07:31:27 -0600
Message-ID: <CAL_JsqL5gYh_++1wDLMYjO7MXKOHpzr315FZ1tuN9o5tOe7TYA@mail.gmail.com>
Subject: Re: [RFC 0/2] of: Add whitelist
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Nov 29, 2017 at 3:20 AM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 11/27/17 15:58, Alan Tull wrote:
>> Here's a proposal for a whitelist to lock down the dynamic device tree.
>>
>> For an overlay to be accepted, all of its targets are required to be
>> on a target node whitelist.
>>
>> Currently the only way I have to get on the whitelist is calling a
>> function to add a node.  That works for fpga regions, but I think
>> other uses will need a way of having adding specific nodes from the
>> base device tree, such as by adding a property like 'allow-overlay;'
>> or 'allow-overlay = "okay";' If that is acceptable, I could use some
>> advice on where that particular code should go.
>>
>> Alan
>>
>> Alan Tull (2):
>>   of: overlay: add whitelist
>>   fpga: of region: add of-fpga-region to whitelist
>>
>>  drivers/fpga/of-fpga-region.c |  9 ++++++
>>  drivers/of/overlay.c          | 73 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of.h            | 12 +++++++
>>  3 files changed, 94 insertions(+)
>>
>
> The plan was to use connectors to restrict where an overlay could be applied.
> I would prefer not to have multiple methods for accomplishing the same thing
> unless there is a compelling reason to do so.

Connector nodes need a mechanism to enable themselves, too. I don't
think connector nodes are going to solve every usecase.

Rob
