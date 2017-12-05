Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <edb604fa-4810-0de9-ce51-c90aa2442cb4@gmail.com>
References: <20171204191357.3211-1-atull@kernel.org> <edb604fa-4810-0de9-ce51-c90aa2442cb4@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 5 Dec 2017 11:07:00 -0600
Message-ID: <CANk1AXQ4HV9YAO_p1wrY66nnWY1n2WnR0JoCbAKU6RfrWqf9sQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] of: dynamic: restrict overlay by targets
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 4, 2017 at 7:14 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> Hi Alan,
>
> In the RFC thread "of: Add whitelist", I did not understand the use case and
> asked you some questions (30 Nov 2017 07:46:36 -0500), that you seem to have
> overlooked (or my mail server failed to deliver your answer to me).  Can you
> please answer that question so I can better understand this patch set is
> needed for.

Hi Frank,

Sorry I missed those, I've replied to the original questions now.

Alan

>
> Thanks,
>
> Frank
>
>
> On 12/04/17 14:13, Alan Tull wrote:
>> Restrict which nodes are valid targets for a DT overlay.
>>
>> Add a flag bit to struct device_node allowing nodes to be marked as
>> valid target for overlays.
>>
>> A driver that is always intended to handle DT overlays can
>> enable overlays by calling a function for its DT node.
>>
>> For individual nodes that need to be opened up for a specific use,
>> adding the property "overlay-allowed" enables overlays targeting
>> that node.  I'll need to document the DT property, not sure where
>> specifically.  New file bindings/overlay.txt?
>>
>> This patchset differs from the RFC:
>> * Added a flag bit and got rid of the whitelist
>> * Renamed the functions that enable a node
>> * Added a DT property
>>
>> Alan Tull (2):
>>   of: overlay: add flag enabling overlays and enable fpga-region
>>     overlays
>>   of: dynamic: add overlay-allowed DT property
>>
>>  drivers/fpga/of-fpga-region.c |  4 ++++
>>  drivers/of/base.c             |  4 ++--
>>  drivers/of/dynamic.c          |  3 +++
>>  drivers/of/fdt.c              |  3 +++
>>  drivers/of/of_private.h       |  2 ++
>>  drivers/of/overlay.c          | 26 ++++++++++++++++++++++++++
>>  include/linux/of.h            | 19 +++++++++++++++++++
>>  7 files changed, 59 insertions(+), 2 deletions(-)
>>
>
