Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D713859CC;
	Wed, 13 May 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670442; cv=none; b=soPvVz5iTlDBSNNoD0qTGvKfE3BgVHAEgpj109POBe7POw7+gNJKJDfJqKEM9i0ah/fElqpb7JA96pnWcQDbeFsYFmc2SGBEAaHUOhbh+iQJsrLvW81vVaJ85hJOPctMuyp+xphGv0Sku8iatJOTjukiMAhmm4hjJne8MxDHNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670442; c=relaxed/simple;
	bh=yIRvuRvWT5gNo1sGYcydz+yZq1dxrlXCn18QYFdR73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIg/2fi+95RQrtzvKG6PRTVO29vpg8xLPVYsBQi/ndK6MURha60yTz/SPwGysMTPf2XuYt/DOgnOtZNNHKjyD8WEwI2Ik0B3AUVUnUJHeUN2/cC89CLaVZIuh+hduCPBOp+aWUaGgqt8QtRaZar/7chVcO+kXfTpJsv2+cb6Ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6tuEeeX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6tuEeeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778670441; x=1810206441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yIRvuRvWT5gNo1sGYcydz+yZq1dxrlXCn18QYFdR73g=;
  b=b6tuEeeX+MtWcRQzfWFhzaAzNFy7GzLRZZwcm/41femkCgVG7/RUPfey
   8m/8Pa7B0jGknESIMfmrq0Ym1rgqO/pwPueMgJNGMFKJpOPI0Ml1JKkjO
   M9+ss0qM13zWGi+I26eDqmgw8HIohbRhs2V5rgLesITiFgAMoeUKmPGn6
   xfnQoGxb5PS+P5P9DsAujY2BU8ihyl61yu3olQ/mOikXv4l9WSK1/UW9C
   TL45SFmCUzl6IMOgGRssJ0ydvxggz4kUbIr1uIozXMtbOmEmcU6lju7Kz
   rUjTD/mHUHsWVeQao8DPQODBDK/J7a9z6Q+1RhlpGs8h3tek0L6cOsqoO
   g==;
X-CSE-ConnectionGUID: bPyc02b3QSKFW6KCXscVbA==
X-CSE-MsgGUID: D1oOzm0JSv+EY8MnrR19xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="89899249"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89899249"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:07:20 -0700
X-CSE-ConnectionGUID: sSpQQrjATeWoGEOZPXlbZg==
X-CSE-MsgGUID: pyG07AajQou6dmam89TDIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233783588"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2026 04:07:18 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN7Qq-000000003yF-0S8d;
	Wed, 13 May 2026 11:07:16 +0000
Date: Wed, 13 May 2026 19:07:09 +0800
From: kernel test robot <lkp@intel.com>
To: Mayur Kumar <kmayur809@gmail.com>, yilun.xu@intel.com, mdf@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: use kzalloc_obj over kzalloc with sizeof
Message-ID: <202605131802.mIyi1UXu-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20260513 (https://download.01.org/0day-ci/archive/20260513/202605131802.mIyi1UXu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131802.mIyi1UXu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131802.mIyi1UXu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/fpga/dfl-afu-dma-region.c:319:9: error: incompatible pointer types assigning to 'struct dfl_afu_dma_region *' from 'typeof (region) *' (aka 'struct dfl_afu_dma_region **'); dereference with * [-Werror,-Wincompatible-pointer-types]
     319 |         region = kzalloc_obj(region, GFP_KERNEL);
         |                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                  *(                             )
   1 error generated.


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
