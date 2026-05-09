Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D50A2571C7;
	Sat,  9 May 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334499; cv=none; b=pwjYS/RlPCG7ziQDHO2bxXA1kk4FPICIZqfW6gG8kzniqsaKf7n3MJhww9U2dH5C6LVtMd5rstTipJAwYRTuu2a9z95v/jHTFo17Vr3xvzel+Kmj6td8dQUFqwZgS6DYgGYpmJIymcf//kikPuHTTLsc1XTNV/u2lJq7oN3SIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334499; c=relaxed/simple;
	bh=soNz212u4CcfEPnTP+dW9qPZsQ9u0EEJad/ejiOqvv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB9Iy+GCjwtYjCUSjAtMu9c4jGu7zY9pvz/AEKA2+fOqBgdO+TNUY/AMTkgYw286W4ugnMr006FLmGmvXZfKR/rT98d3Y2rPvQFwYZVyALthMJFUTazMBiQXR6UzJIiAdaQhHuSTI6Y6lJM9FMltAms1oYfjnAHD8/Zk0g8011k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPo8hZJT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPo8hZJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778334497; x=1809870497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=soNz212u4CcfEPnTP+dW9qPZsQ9u0EEJad/ejiOqvv4=;
  b=SPo8hZJTsuR/NV+/keI1hnYohgLaDxyW+OD1jLruJtdaUI4odTrFO4ZN
   i71fAEmD0kfoyrOGkcuJUP7gZEMYdZ5ncjTNpFiSE++LinQrCU4FIlxWB
   9g3tgZW2/UgNnLke++SiX4HwKLEL3P6WHTYHzJcR30Z/SW4y4VosOVOjD
   8vVUMQ6LHcLOLvvNd6yY7/6YQ6xwPvNs5nvIMW2DQQbO9cU6WTGsIl0Yy
   gBItMEoH2Idn29S2lH3tt9B0wVRBijds4fq2Z1woIhvsraboqh5rOS/Dg
   zpEdIkP3HyNlffIgYudQHsHTRaJQBaucONTGgSvukC0C/eAp/RaDXetQl
   g==;
X-CSE-ConnectionGUID: bQBs8SKWTzaqdvMrXV8zgA==
X-CSE-MsgGUID: yGJnZriwTcGMmxHomZCitQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79231659"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79231659"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 06:48:17 -0700
X-CSE-ConnectionGUID: kyWiMhtHTlmOxQdy8eRI0g==
X-CSE-MsgGUID: SWwFQkSISw++Jv7OJI303A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="238827957"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 May 2026 06:48:15 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLi2O-0000000011p-2Tjf;
	Sat, 09 May 2026 13:48:12 +0000
Date: Sat, 9 May 2026 21:47:44 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 1/1] fpga: lattice-sysconfig-spi: simplify with
 spi_get_device_match_data()
Message-ID: <202605092148.6MdLTolJ-lkp@intel.com>
References: <20260508080650.1144588-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508080650.1144588-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc2 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/fpga-lattice-sysconfig-spi-simplify-with-spi_get_device_match_data/20260509-133025
base:   linus/master
patch link:    https://lore.kernel.org/r/20260508080650.1144588-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] fpga: lattice-sysconfig-spi: simplify with spi_get_device_match_data()
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20260509/202605092148.6MdLTolJ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260509/202605092148.6MdLTolJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605092148.6MdLTolJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/fpga/lattice-sysconfig-spi.c: In function 'sysconfig_spi_probe':
>> drivers/fpga/lattice-sysconfig-spi.c:96:51: error: passing argument 1 of 'spi_get_device_match_data' from incompatible pointer type [-Wincompatible-pointer-types]
      96 |         spi_max_speed = spi_get_device_match_data(dev);
         |                                                   ^~~
         |                                                   |
         |                                                   struct device *
   In file included from drivers/fpga/lattice-sysconfig-spi.c:7:
   include/linux/spi/spi.h:1757:52: note: expected 'const struct spi_device *' but argument is of type 'struct device *'
    1757 | spi_get_device_match_data(const struct spi_device *sdev);
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/spi_get_device_match_data +96 drivers/fpga/lattice-sysconfig-spi.c

    85	
    86	static int sysconfig_spi_probe(struct spi_device *spi)
    87	{
    88		struct device *dev = &spi->dev;
    89		struct sysconfig_priv *priv;
    90		const u32 *spi_max_speed;
    91	
    92		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
    93		if (!priv)
    94			return -ENOMEM;
    95	
  > 96		spi_max_speed = spi_get_device_match_data(dev);
    97		if (!spi_max_speed)
    98			return -EINVAL;
    99	
   100		if (spi->max_speed_hz > *spi_max_speed) {
   101			dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
   102				spi->max_speed_hz, *spi_max_speed);
   103			return -EINVAL;
   104		}
   105	
   106		priv->dev = dev;
   107		priv->command_transfer = sysconfig_spi_cmd_transfer;
   108		priv->bitstream_burst_write_init = sysconfig_spi_bitstream_burst_init;
   109		priv->bitstream_burst_write = sysconfig_spi_bitstream_burst_write;
   110		priv->bitstream_burst_write_complete = sysconfig_spi_bitstream_burst_complete;
   111	
   112		return sysconfig_probe(priv);
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
