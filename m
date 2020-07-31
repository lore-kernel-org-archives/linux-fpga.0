Return-Path: <SRS0=jh9I=BK=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=jh9I=BK=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:13718 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbgGaHwB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 31 Jul 2020 03:52:01 -0400
Date: Fri, 31 Jul 2020 15:48:37 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200731074837.GE1781@yilunxu-OptiPlex-7050>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
 <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <316f86d4-7bba-f0c7-3dde-794df80d32e7@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tom Rix <trix@redhat.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, lgoncalv@redhat.com

On Sat, Jul 25, 2020 at 06:29:53AM -0700, Tom Rix wrote:
> It would be good if the variable or element for the feature id had a consistent name.
> 
> 
> > @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
> >   * @id: unique dfl private feature id.
> >   */
> >  struct dfl_feature_id {
> > -	u64 id;
> > +	u16 id;
> >  };
> 
> Is this structure needed ?
> 
> Here is how it could be changed to�
> 
> struct dfl_feature_driver {
> 
> -��� const dfl_feature_id *
> 
> +��� const u16 *id_table;

This structure is to represent an id type, which is used to match
fme/port owned features. It could be extended if some feature drivers
needs driver_data.

Actually I see some example of device_ids with similar structure, like:

  struct mips_cdmm_device_id {
  	__u8	type;
  };

  struct tee_client_device_id {
	uuid_t uuid;
  };


Thanks,
Yilun.

> 
> ...
> 
> Tom
> 
> 
> >  
> >  /**
> > @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
> >   */
> >  struct dfl_feature {
> >  	struct platform_device *dev;
> > -	u64 id;
> > +	u16 id;
> >  	int resource_index;
> >  	void __iomem *ioaddr;
> >  	struct dfl_feature_irq_ctx *irq_ctx;
> > @@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
> >  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
> >  
> >  static inline
> > -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> > +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> >  	struct dfl_feature *feature;
> > @@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> >  }
> >  
> >  static inline
> > -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> > +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
> >  {
> >  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
> >  
> > @@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> >  	return NULL;
> >  }
> >  
> > -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
> > +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
> >  {
> >  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
> >  }
