Return-Path: <SRS0=jh/K=BE=redhat.com=trix@kernel.org>
Return-Path: <SRS0=jh/K=BE=redhat.com=trix@kernel.org>
Subject: Re: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
Date: Sat, 25 Jul 2020 06:29:53 -0700
MIME-Version: 1.0
In-Reply-To: <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com
List-ID: <linux-fpga@vger.kernel.org>

It would be good if the variable or element for the feature id had a consistent name.


> @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
>   * @id: unique dfl private feature id.
>   */
>  struct dfl_feature_id {
> -	u64 id;
> +	u16 id;
>  };

Is this structure needed ?

Here is how it could be changed to 

struct dfl_feature_driver {

-    const dfl_feature_id *

+    const u16 *id_table;

...

Tom


>  
>  /**
> @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
>   */
>  struct dfl_feature {
>  	struct platform_device *dev;
> -	u64 id;
> +	u16 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
>  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
>  
>  static inline
> -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>  	struct dfl_feature *feature;
> @@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
>  }
>  
>  static inline
> -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
>  
> @@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
>  	return NULL;
>  }
>  
> -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
> +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
>  {
>  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
>  }
