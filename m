Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8C388885;
	Wed, 13 May 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667263; cv=none; b=qR/AeinFUXYP1ZuLlwGriL56d4gvHGc2r9aHG2uoEJ/8wdwlIp7kAnESbN7R/ak4cNPkaLPlbawadZYz/9jgn1hD1tFBKcvbmITmci0a8rGpQVk/AVI34TnN2aLs0THL+nr7jIrV4Yc9XX3+/UqoAkyaPVRKrAU6ZBqggvJUBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667263; c=relaxed/simple;
	bh=3HBbUw2VUe3eOJoNTb0vOVW3qGQ8wwSYVvdUqATMrwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKKpU+dS9PSDhGAqoOxru9WxV9k39JI+3KtAkqsxPXqWYGWaFBG95Z8nbsQL4jXRWWoitH1JtQnm15W9Ox64pSj/SLph4XEpIjd+buFcDxoGGb4aBXXp6g7oZG+L7BB0FdweGQQZsZWBaQRz2esd7DcQJxDB3RtcKG769qEYgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBQPK/na; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBQPK/na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778667259; x=1810203259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3HBbUw2VUe3eOJoNTb0vOVW3qGQ8wwSYVvdUqATMrwY=;
  b=KBQPK/naoX85n2hLaIRJmCDwhG7urQu7I4rPDOr8E5ncHC3yz6LRiidm
   BaM/C4X4S34ZdIHV+NfpRqGbulrmTyAyWICiBUsXg2y3sB6UJ+XW3Ir7n
   FepKFHBTBgG41w6dc1NjqdjTb5TTAql4RLAVgH5iKQE3z1FgHLib7Y28+
   eTKdVwOhdva5mAS1FYtn494yghWWbrIEowaQa7eyWZM91MBerobN4YebZ
   bB5UJ4YxhstWVGT1zqVAQ+HHMu6rUX80dAx4i+F5wdS2DxXjqb5camIUk
   ni9ONf/5+H8t1bTmYP0RHRNzN0kViopu/E7BGn1ntqPPd15QbwCOmbDW4
   w==;
X-CSE-ConnectionGUID: x1Cy0+a4TSy1CZV0owXNfA==
X-CSE-MsgGUID: iKzJMS8BRCCAVQwTMYOjxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79620781"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79620781"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:14:17 -0700
X-CSE-ConnectionGUID: OAOxY4jNSliEXYTGBBewPg==
X-CSE-MsgGUID: ntnq6umBR56fNj8+gRulRA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 May 2026 03:14:15 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN6bV-000000003uN-0nKu;
	Wed, 13 May 2026 10:14:13 +0000
Date: Wed, 13 May 2026 18:13:27 +0800
From: kernel test robot <lkp@intel.com>
To: Mayur Kumar <kmayur809@gmail.com>, yilun.xu@intel.com, mdf@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: use kzalloc_obj over kzalloc with sizeof
Message-ID: <202605131843.wVRKksBi-lkp@intel.com>
References: <20260511181240.223224-1-kmayur809@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511181240.223224-1-kmayur809@gmail.com>

Hi Mayur,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mayur-Kumar/fpga-dfl-afu-use-kzalloc_obj-over-kzalloc-with-sizeof/20260513-141558
base:   linus/master
patch link:    https://lore.kernel.org/r/20260511181240.223224-1-kmayur809%40gmail.com
patch subject: [PATCH] fpga: dfl: afu: use kzalloc_obj over kzalloc with sizeof
config: nios2-randconfig-002-20260513 (https://download.01.org/0day-ci/archive/20260513/202605131843.wVRKksBi-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131843.wVRKksBi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131843.wVRKksBi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/fpga/dfl-afu-dma-region.c: In function 'afu_dma_map_region':
>> drivers/fpga/dfl-afu-dma-region.c:319:9: error: assignment to 'struct dfl_afu_dma_region *' from incompatible pointer type 'struct dfl_afu_dma_region **' [-Werror=incompatible-pointer-types]
     region = kzalloc_obj(region, GFP_KERNEL);
            ^
   cc1: some warnings being treated as errors


vim +319 drivers/fpga/dfl-afu-dma-region.c

   289	
   290	/**
   291	 * afu_dma_map_region - map memory region for dma
   292	 * @fdata: feature dev data
   293	 * @user_addr: address of the memory region
   294	 * @length: size of the memory region
   295	 * @iova: pointer of iova address
   296	 *
   297	 * Map memory region defined by @user_addr and @length, and return dma address
   298	 * of the memory region via @iova.
   299	 * Return 0 for success, otherwise error code.
   300	 */
   301	int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
   302			       u64 user_addr, u64 length, u64 *iova)
   303	{
   304		struct device *dev = &fdata->dev->dev;
   305		struct dfl_afu_dma_region *region;
   306		int ret;
   307	
   308		/*
   309		 * Check Inputs, only accept page-aligned user memory region with
   310		 * valid length.
   311		 */
   312		if (!PAGE_ALIGNED(user_addr) || !PAGE_ALIGNED(length) || !length)
   313			return -EINVAL;
   314	
   315		/* Check overflow */
   316		if (user_addr + length < user_addr)
   317			return -EINVAL;
   318	
 > 319		region = kzalloc_obj(region, GFP_KERNEL);
   320		if (!region)
   321			return -ENOMEM;
   322	
   323		region->user_addr = user_addr;
   324		region->length = length;
   325	
   326		/* Pin the user memory region */
   327		ret = afu_dma_pin_pages(fdata, region);
   328		if (ret) {
   329			dev_err(dev, "failed to pin memory region\n");
   330			goto free_region;
   331		}
   332	
   333		/* Only accept continuous pages, return error else */
   334		if (!afu_dma_check_continuous_pages(region)) {
   335			dev_err(dev, "pages are not continuous\n");
   336			ret = -EINVAL;
   337			goto unpin_pages;
   338		}
   339	
   340		/* As pages are continuous then start to do DMA mapping */
   341		region->iova = dma_map_page(dfl_fpga_fdata_to_parent(fdata),
   342					    region->pages[0], 0,
   343					    region->length,
   344					    DMA_BIDIRECTIONAL);
   345		if (dma_mapping_error(dfl_fpga_fdata_to_parent(fdata), region->iova)) {
   346			dev_err(dev, "failed to map for dma\n");
   347			ret = -EFAULT;
   348			goto unpin_pages;
   349		}
   350	
   351		*iova = region->iova;
   352	
   353		mutex_lock(&fdata->lock);
   354		ret = afu_dma_region_add(fdata, region);
   355		mutex_unlock(&fdata->lock);
   356		if (ret) {
   357			dev_err(dev, "failed to add dma region\n");
   358			goto unmap_dma;
   359		}
   360	
   361		return 0;
   362	
   363	unmap_dma:
   364		dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
   365			       region->iova, region->length, DMA_BIDIRECTIONAL);
   366	unpin_pages:
   367		afu_dma_unpin_pages(fdata, region);
   368	free_region:
   369		kfree(region);
   370		return ret;
   371	}
   372	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
