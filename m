Date: Fri, 27 Sep 2019 08:01:16 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Message-ID: <20190927150114.GA2146@archbox>
References: <20190926103925.194973-1-nuno.sa@analog.com>
 <20190926103925.194973-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190926103925.194973-2-nuno.sa@analog.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi Nuno,

On Thu, Sep 26, 2019 at 12:39:23PM +0200, Nuno S� wrote:
> Add commom macros to "parse" ADI HDL cores version, in terms of
> major, minor and patch.
> 
> Signed-off-by: Nuno S� <nuno.sa@analog.com>
> ---
>  include/linux/fpga/adi-axi-common.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 7fc95d5c95bb..5bc5603e6bc8 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -16,4 +16,8 @@
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
>  
> +#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
> +#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
> +#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> +
>  #endif /* ADI_AXI_COMMON_H_ */
> -- 
> 2.23.0
> 

While implemented in an FPGA I'm not sure if this needs to go into
includelinux/fpga/.

I'd suggest to add this to the actual driver for now, and once you have
multiple users you can find a common location.

Cheers,
Moritz
