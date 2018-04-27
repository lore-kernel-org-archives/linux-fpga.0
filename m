Return-Path: <SRS0=uFsl=HQ=gmail.com=f.fainelli@kernel.org>
Return-Path: <SRS0=uFsl=HQ=gmail.com=f.fainelli@kernel.org>
Subject: Re: [PATCH 2/4] fpga: manager: change api, don't use drvdata
References: <20180427012605.28981-1-mdf@kernel.org>
 <20180427012605.28981-3-mdf@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <152cb232-ea4d-292b-8b60-8bdc1732dc23@gmail.com>
Date: Fri, 27 Apr 2018 11:26:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180427012605.28981-3-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, linux-fpga@vger.kernel.org, atull@kernel.org, linux-doc@vger.kernel.org, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
List-ID: <linux-fpga@vger.kernel.org>

On 04/26/2018 06:26 PM, Moritz Fischer wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Change fpga_mgr_register to not set or use drvdata.  This supports
> the case where a PCIe device has more than one manager.
> 
> Add fpga_mgr_create/free functions.  Change fpga_mgr_register and
> fpga_mgr_unregister functions to take the mgr struct as their only
> parameter.
> 
>   struct fpga_manager *fpga_mgr_create(struct device *dev,
>                 const char *name,
>                 const struct fpga_manager_ops *mops,
>                 void *priv);
>   void fpga_mgr_free(struct fpga_manager *mgr);
>   int fpga_mgr_register(struct fpga_manager *mgr);
>   void fpga_mgr_unregister(struct fpga_manager *mgr);
> 
> Update the drivers that call fpga_mgr_register with the new API.

Apologies for chiming in so late, this commit does not make it clear
that fpga_mgr_unregister() now also free the 'mgr' argument by calling
fpga_mgr_free(), this is kind of detail, but an API should make that
clear IMHO.

Thanks
-- 
Florian
