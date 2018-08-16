Return-Path: <SRS0=iILP=K7=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=iILP=K7=ettus.com=moritz.fischer@kernel.org>
Date: Thu, 16 Aug 2018 12:02:52 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 7/8] docs: fpga: document fpga manager flags
Message-ID: <20180816190252.GB3932@archbook>
References: <20180814191526.3247-1-atull@kernel.org>
 <20180814191526.3247-8-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814191526.3247-8-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Tue, Aug 14, 2018 at 02:15:25PM -0500, Alan Tull wrote:
> Add flags #defines to kerneldoc documentation in a
> useful place.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  Documentation/driver-api/fpga/fpga-mgr.rst |  5 +++++
>  include/linux/fpga/fpga-mgr.h              | 18 ++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
> index 431556d..db8885e 100644
> --- a/Documentation/driver-api/fpga/fpga-mgr.rst
> +++ b/Documentation/driver-api/fpga/fpga-mgr.rst
> @@ -183,6 +183,11 @@ API for implementing a new FPGA Manager driver
>  API for programming an FPGA
>  ---------------------------
>  
> +FPGA Manager flags
> +
> +.. kernel-doc:: include/linux/fpga/fpga-mgr.h
> +   :doc: FPGA Manager flags
> +
>  .. kernel-doc:: include/linux/fpga/fpga-mgr.h
>     :functions: fpga_image_info
>  
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 1ca02ce..777c502 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -53,12 +53,18 @@ enum fpga_mgr_states {
>  	FPGA_MGR_STATE_OPERATING,
>  };
>  
> -/*
> - * FPGA Manager flags
> - * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> - * FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> - * FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first

We are actually missing the ENCRYPTED flag here, can you add that while
we're at it? I must've forgotten to add that back then ... derp.

> - * FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> +/**
> + * DOC: FPGA Manager flags
> + *
> + * Flags used in the &fpga_image_info->flags field
> + *
> + * %FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> + *
> + * %FPGA_MGR_EXTERNAL_CONFIG: FPGA has been configured prior to Linux booting
> + *
> + * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
> + *
> + * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
> -- 
> 2.7.4
> 

Thanks,
Moritz
