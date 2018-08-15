Return-Path: <SRS0=HszP=K6=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=HszP=K6=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54720 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeHOFaa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Aug 2018 01:30:30 -0400
Subject: Re: [PATCH 8/8] docs: fpga: document programming fpgas using regions
References: <20180814191526.3247-1-atull@kernel.org>
 <20180814191526.3247-9-atull@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae18c3c0-6ba4-7e9f-9f94-0f8b7cdc8156@infradead.org>
Date: Tue, 14 Aug 2018 19:40:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180814191526.3247-9-atull@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org

On 08/14/2018 12:15 PM, Alan Tull wrote:
> Clarify the intention that interfaces and upper layers use
> regions rather than managers directly.
> 
> Rearrange API documentation to better group the API functions
> used to create FPGA mgr/bridge/regions and the API used for
> programming FPGAs.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  Documentation/driver-api/fpga/fpga-bridge.rst      |  38 ++-----
>  Documentation/driver-api/fpga/fpga-mgr.rst         | 117 ++-------------------
>  Documentation/driver-api/fpga/fpga-programming.rst | 103 ++++++++++++++++++
>  Documentation/driver-api/fpga/fpga-region.rst      |  92 ++++++++--------
>  Documentation/driver-api/fpga/index.rst            |   2 +
>  5 files changed, 166 insertions(+), 186 deletions(-)
>  create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst
> 

Hi,
A few comments below...


> diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
> new file mode 100644
> index 0000000..cc34d17
> --- /dev/null
> +++ b/Documentation/driver-api/fpga/fpga-programming.rst
> @@ -0,0 +1,103 @@
> +In-kernel API for FPGA Programming
> +==================================
> +
> +Overview
> +--------
> +
> +The in-kernel API for FPGA programming is a combination of APIs from
> +FPGA manager, bridge, and regions.  The actual function used to
> +trigger FPGA programming is :c:func:`fpga_region_program_fpga()`.
> +
> +:c:func:`fpga_region_program_fpga()` uses functionality supplied by
> +the FPGA manager and bridges.  It will:
> +
> + * lock the region's mutex
> + * lock the mutex of the region's FPGA manager
> + * build a list of FPGA bridges if a method has been specified to do so
> + * disable the bridges
> + * program the FPGA using info passed in :c:member:`fpga_region->info`.
> + * re-enable the bridges
> + * release the locks
> +
> +The struct fpga_image_info specifies what FPGA image to program.  It is allocated/freed by :c:func:`fpga_image_info_alloc()` and freed with :c:func:`fpga_image_info_free()`
> +
> +How to program an FPGA using a region
> +-------------------------------------
> +
> +When the FPGA region driver probed, it was given a pointer to a FPGA manager

                                                              to an FPGA

> +driver so it knows which manager to use.  The region also either has a list of
> +bridges to control during programming or it has a pointer to a function that
> +will generate that list.  Here's some sample code of what to do next::
> +
> +	#include <linux/fpga/fpga-mgr.h>
> +	#include <linux/fpga/fpga-region.h>
> +
> +	struct fpga_image_info *info;
> +	int ret;
> +
> +	/*
> +	 * First, alloc the struct with information about the FPGA image to
> +	 * program.
> +	 */
> +	info = fpga_image_info_alloc(dev);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* Set flags as needed, such as: */
> +	info->flags = FPGA_MGR_PARTIAL_RECONFIG;
> +
> +	/*
> +	 * Indicate where the FPGA image is. This is pseudo-code; you're
> +	 * going to use one of these three.
> +	 */
> +	if (image is in a scatter gather table) {
> +
> +		info->sgt = [your scatter gather table]
> +
> +	} else if (image is in a buffer) {
> +
> +		info->buf = [your image buffer]
> +		info->count = [image buffer size]
> +
> +	} else if (image is in a firmware file) {
> +
> +		info->firmware_name = devm_kstrdup(dev, firmware_name,
> +						   GFP_KERNEL);
> +
> +	}
> +
> +	/* Add info to region and do the programming */
> +	region->info = info;
> +	ret = fpga_region_program_fpga(region);
> +	if (ret)
> +		return ret;
> +

always deallocate and then do:
	if (ret)
		return ret;
?

> +	/* Deallocate the image info if you're done with it */
> +	fpga_image_info_free(info);
> +
> +	/* Now enumerate whatever hardware has appeared in the FPGA. */
> +
> +API for programming an FPGA
> +---------------------------
> +
> +* :c:func:`fpga_region_program_fpga` —  Program a FPGA
> +* :c:type:`fpga_image_info` —  Specifies what FPGA image to program
> +* :c:func:`fpga_image_info_alloc()` —  Allocate a FPGA image info struct
> +* :c:func:`fpga_image_info_free()` —  Free a FPGA image info struct
> +
> +.. kernel-doc:: drivers/fpga/fpga-region.c
> +   :functions: fpga_region_program_fpga
> +
> +FPGA Manager flags
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :doc: FPGA Manager flags
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :functions: fpga_image_info
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: fpga_image_info_alloc
> +
> +.. kernel-doc:: drivers/fpga/fpga-mgr.c
> +   :functions: fpga_image_info_free

[snip]

>  API to add a new FPGA region
>  ----------------------------
>  
> +* struct :c:type:`fpga_region` — The FPGA region struct
> +* :c:func:`devm_fpga_region_create` — Allocate and init a region struct
> +* :c:func:`fpga_region_register` —  Register a FPGA region

                                                an FPGA

> +* :c:func:`fpga_region_unregister` —  Unregister a FPGA region

                                                    an FPGA

> +
> +The FPGA region's probe function will need to get a reference to the FPGA
> +Manager it will be using to do the programming.  This usually would happen
> +during the region's probe function.
> +
> +* :c:func:`fpga_mgr_get` — Get a reference to a FPGA manager, raise ref count

                                                 an FPGA

> +* :c:func:`of_fpga_mgr_get` —  Get a reference to a FPGA manager, raise ref count,

                                                     an FPGA

> +  given a device node.
> +* :c:func:`fpga_mgr_put` — Put a FPGA manager

                                  an FPGA

> +
> +The FPGA region will need to specify which bridges to control while programming
> +the FPGA.  The region driver can build a list of bridges during probe time
> +(:c:member:`fpga_region->bridge_list`) or it can have a function that creates
> +the list of bridges to program just before programming
> +(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
> +following APIs to handle building or tearing down that list.
> +
> +* :c:func:`fpga_bridge_get_to_list` — Get a ref of a FPGA bridge, add it to a
> +  list
> +* :c:func:`of_fpga_bridge_get_to_list` — Get a ref of a FPGA bridge, add it to a
> +  list, given a device node
> +* :c:func:`fpga_bridges_put` — Given a list of bridges, put them
> +
>  .. kernel-doc:: include/linux/fpga/fpga-region.h
>     :functions: fpga_region
>  



-- 
~Randy
