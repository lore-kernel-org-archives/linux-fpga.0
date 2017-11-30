Return-Path: <SRS0=jDSI=C4=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=jDSI=C4=gmail.com=frowand.list@kernel.org>
Subject: Re: [RFC 0/2] of: Add whitelist
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
 <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
 <CAL_JsqL5gYh_++1wDLMYjO7MXKOHpzr315FZ1tuN9o5tOe7TYA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <157eebaf-89a9-a230-e56b-d98a8e1e26bf@gmail.com>
Date: Thu, 30 Nov 2017 07:18:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL5gYh_++1wDLMYjO7MXKOHpzr315FZ1tuN9o5tOe7TYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Moritz Fischer <mdf@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/29/17 08:31, Rob Herring wrote:
> On Wed, Nov 29, 2017 at 3:20 AM, Frank Rowand <frowand.list@gmail.com> wrote:
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
> Connector nodes need a mechanism to enable themselves, too. I don't
> think connector nodes are going to solve every usecase.
> 
> Rob
> 

The overlay code related to connectors does not exist yet, so my comment
is going to be theoretical.

I would expect the overlay code to check that the target of the overlay
fragment is a connector node, so there is no need to explicitly "enable"
applying an overlay to a connector node.

-Frank
