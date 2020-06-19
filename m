Date: Thu, 18 Jun 2020 18:39:35 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 2/2] fpga: Fix dead store in fpga-bridge.c
Message-ID: <20200619013933.GE3685@epycbox.lan>
References: <20200608125446.23311-1-trix@redhat.com>
 <20200608125446.23311-3-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125446.23311-3-trix@redhat.com>
To: trix@redhat.com
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jun 08, 2020 at 05:54:46AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Using clang's scan-build/view this issue was flagged
> a dead store issue in fpga-bridge.c
> 
> warning: Value stored to 'ret' is never read [deadcode.DeadStores]
>                   ret = id;
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 4bab9028940a..2deccacc3aa7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  				       void *priv)
>  {
>  	struct fpga_bridge *bridge;
> -	int id, ret = 0;
> +	int id, ret;
>  
>  	if (!name || !strlen(name)) {
>  		dev_err(dev, "Attempt to register with no name!\n");
> @@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret = id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>  
>  	mutex_init(&bridge->mutex);
>  	INIT_LIST_HEAD(&bridge->node);
> -- 
> 2.18.2
> 
Applied to for-next,

Thanks!
