Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795888137;
	b=G1MYtWRjRJmS000PTIeE10XNfDydycY5h67xiM7xguXCpo+VMLBmVw3pgAbtrjCpEzQM
	 O1zWLSqO70PEI0oEfDQ9G4Y0nJsQv75H1eZ8T24ktbJkptWxL8YPxsYY12ojDynsXfv/j
	 l7YFMcYtphZtWyY/8xQsVBdx9QPQRKjoz1SisuSTpEKSjAdFzmkESeoOZThoPuepsnY8b
	 AKesENb7okZQGk9GhnnAaqcKzGoVBnCYLqlehIJGMJX7603b1t6fX7h5914B+7GL3H9mZ
	 nVbYjQh3CkgbkpjwHhPKDnfpalpu2A2iZIJ8wqbKFTnFjda9LvqZ5cMCn7FnXOpeLxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795888137;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=o1vyfluEhUJnbluF6GUcjMDTIyL0SaXusFUOnUCU43k=;
	b=OLDG7SLTQRXhkiIr1MLxiNiskiMRl/ig1FSMbxHAVmXrLEFSgL8MQesux29UBDKMP4Wp
	 RQyxXae13EZRngPtS9MrH7gSjmQx4E7Bhwjcjx45gwWBsnUAfAHsP8CjIq5sYv12Kskoi
	 qyDUcTunBSgJ1G+4y9+v5uFZ5Yj9ZeBXjxn+dUncaQlmYLmGMSX2JdmiHlZvi0DG0JeY4
	 ozjoBexUppb2pUAh1pHj/vXQoQdwYgAta2kKlq1ikFddF3lKBFklHcRK7s2zf40yEzP/h
	 QGjvBZV5Io3Ctsw7btbrBGQBrs1Jd8HncszZ2y88qnyH4vpPVFnOR3ZlelAMs1tlskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BuHCF07h;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1F606A332;
	Sat, 28 Nov 2026 17:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF1F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BuHCF07h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795888136; x=1827424136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mESh8w46MAHp0IedDV7lK4+2r5xhxNUiIwOX/N8u2Vs=;
  b=BuHCF07hO5cybxqkfAbeHou5uzBh3GuVmUhquavjISyCxrpmz11yaKS7
   nnaO9E0gv+PkdxRmc3B3OU/wrT3yC7D0PE7ln5sGK81dfh1/dXq26u8pb
   p/Wf+1nn1MLVEn1LHgJqdbA3/Lmv8tnb/gBlA21tkK5tw8kC8WjqRJqJ6
   F2YQlJazHzGjCFC0kbo20gFsyoTtR1CkFqi40Cw9OyFL+LY2zy+0Hmzum
   2GkIv1GujbFtn3RxWOUQz5B8gX2PPlyPrWRxsSwr83bmmbuCf8w9CgXU2
   PNrq+pzZ1HN/d9FC/SHXGmv+PDNrFePoL0oXLsuszqyA1T+zmYSskQeT7
   w==;
X-CSE-ConnectionGUID: bVXD666HTl6q0wHrEDVG3w==
X-CSE-MsgGUID: +0AeWuC7Qp+l8lKfvlXp8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11980"; a="4690109"
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="4690109"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2026 09:48:56 -0800
X-CSE-ConnectionGUID: eGJ+JD44TduKnNqVsc/8Hg==
X-CSE-MsgGUID: Ot2oZcS3RX6L9yKJyQB5pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="12726123"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa005.fm.intel.com with ESMTP; 28 Nov 2026 09:48:53 -0800
Date: Sun, 29 Nov 2026 01:38:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: release irq triggers when a feature device is
 removed
Message-ID: <awsRlTtDlPoQijA7@yilunxu-OptiPlex-7050>
References: <20261124145734.38683-1-ionut.nechita@windriver.com>
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124145734.38683-1-ionut.nechita@windriver.com>

On Tue, Nov 24, 2026 at 04:57:34PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> The eventfd triggers bound with the DFL_FPGA_*_SET_IRQ ioctls are only
> released in the release() handler of the feature device file, when the
> last user closes it. If the PCI device is removed while the file is
> still open with a trigger bound, for example by an FPGA image reload
> that removes and rescans the card, dfl-pci frees the MSI-X vectors
> while the handler is still requested:
> 
>   remove_proc_entry: removing non-empty directory 'irq/62', leaking at least 'fpga-irq[0](dfl-fme.0-4)'
>   WARNING: CPU: 24 PID: 19313 at fs/proc/generic.c:742 remove_proc_entry+0x199/0x1c0
>   Call Trace:
>    unregister_irq_proc
>    free_desc
>    irq_free_descs
>    msi_domain_free_irqs_all_locked
>    pci_free_irq_vectors
>    pci_device_remove
>    device_release_driver_internal
>    pci_stop_bus_device
>    pci_stop_and_remove_bus_device_locked
>    remove_store
> 
> The irqaction, its name and the eventfd reference are leaked, and the
> later release() calls free_irq() on an irq number that is no longer
> allocated to this device.
> 
> Release all triggers in dfl_fpga_dev_feature_uinit(), which runs on the
> remove path of both the FME and the port device before the parent
> frees the irq vectors. Do it after the sub-feature ops have been
> cleared, so that the ioctls no longer reach the sub-features. The

Why? I don't see dfl_fpga_dev_feature_uinit() sync with any ioctl.

> release() handler then finds no triggers left to free.

I don't think this method makes things clear. Now the problem is that
cdev operations don't sync with pci driver remove, so make them synced?

> 
> Fixes: 322b598be4d9 ("fpga: dfl: introduce interrupt trigger setting API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
> The warning above was hit on an Intel FPGA PAC N3000 when the card was
> removed for an image reload while /dev/dfl-fme.0 was held open with the
> FME error irq bound. The fix is build-tested (W=1) on next-20261123; it
> has not been runtime-tested on hardware yet.
> 
>  drivers/fpga/dfl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 6f5fa7b2f..70abbdc7e 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -503,6 +503,16 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
>  			feature->ops = NULL;
>  		}
>  	}
> +
> +	/*
> +	 * The device file may still be open with eventfd triggers bound.
> +	 * Release them now: the parent frees the irq vectors right after
> +	 * this device is removed, and release() may run much later.
> +	 */
> +	mutex_lock(&fdata->lock);
> +	dfl_fpga_dev_for_each_feature(fdata, feature)
> +		dfl_fpga_set_irq_triggers(feature, 0, feature->nr_irqs, NULL);
> +	mutex_unlock(&fdata->lock);
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
>  
> -- 
> 2.55.0
> 
> 
