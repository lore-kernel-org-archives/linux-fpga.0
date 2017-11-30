Return-Path: <SRS0=jDSI=C4=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=jDSI=C4=gmail.com=frowand.list@kernel.org>
Subject: Re: [RFC 0/2] of: Add whitelist
From: Frank Rowand <frowand.list@gmail.com>
References: <1511816284-12145-1-git-send-email-atull@kernel.org>
 <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
Message-ID: <29ba2b39-7871-56fc-ce3f-acb0fc8bf602@gmail.com>
Date: Wed, 29 Nov 2017 19:58:38 -0500
MIME-Version: 1.0
In-Reply-To: <da4c9b29-eccc-6a67-291a-73a36c1598b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 11/29/17 04:20, Frank Rowand wrote:
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

Going back one level in my thinking, I don't think that having a driver mark
a node as a location where an overlay fragment can be applied is serving a
useful purpose.  Any driver, including any driver loaded as a module,
could mark a node as ok.  I don't see how this is providing any meaningful
restriction on where an overlay fragment can be applied.

-Frank
