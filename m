Return-Path: <SRS0=WO29=DB=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=WO29=DB=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH 0/2] of: dynamic: restrict overlay by targets
References: <20171204191357.3211-1-atull@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <edb604fa-4810-0de9-ce51-c90aa2442cb4@gmail.com>
Date: Mon, 4 Dec 2017 20:14:52 -0500
MIME-Version: 1.0
In-Reply-To: <20171204191357.3211-1-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

In the RFC thread "of: Add whitelist", I did not understand the use case and
asked you some questions (30 Nov 2017 07:46:36 -0500), that you seem to have
overlooked (or my mail server failed to deliver your answer to me).  Can you
please answer that question so I can better understand this patch set is
needed for.

Thanks,

Frank


On 12/04/17 14:13, Alan Tull wrote:
> Restrict which nodes are valid targets for a DT overlay.
> 
> Add a flag bit to struct device_node allowing nodes to be marked as
> valid target for overlays.
> 
> A driver that is always intended to handle DT overlays can
> enable overlays by calling a function for its DT node.
> 
> For individual nodes that need to be opened up for a specific use,
> adding the property "overlay-allowed" enables overlays targeting
> that node.  I'll need to document the DT property, not sure where
> specifically.  New file bindings/overlay.txt?
> 
> This patchset differs from the RFC:
> * Added a flag bit and got rid of the whitelist
> * Renamed the functions that enable a node
> * Added a DT property
> 
> Alan Tull (2):
>   of: overlay: add flag enabling overlays and enable fpga-region
>     overlays
>   of: dynamic: add overlay-allowed DT property
> 
>  drivers/fpga/of-fpga-region.c |  4 ++++
>  drivers/of/base.c             |  4 ++--
>  drivers/of/dynamic.c          |  3 +++
>  drivers/of/fdt.c              |  3 +++
>  drivers/of/of_private.h       |  2 ++
>  drivers/of/overlay.c          | 26 ++++++++++++++++++++++++++
>  include/linux/of.h            | 19 +++++++++++++++++++
>  7 files changed, 59 insertions(+), 2 deletions(-)
> 
