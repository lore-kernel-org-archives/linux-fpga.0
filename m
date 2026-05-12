Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07025B086;
	Tue, 12 May 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613004; cv=none; b=Rl5QZIvsVGW04LmSohj2mUsh0N+9Ssl1q+Nsm7WaGr07QsU+O56UU13JEayzJNXkdbO6uLem/t2IYa0WuqXxSynbyugibFrJLFFomzXrdqDSL9Yctv3XErRakdshcgDWQIzO2B3+ve88b5ezS7ePsGnfV/FZwuqyAjnK9bcvVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613004; c=relaxed/simple;
	bh=zUTaYGQD4wbN3rbTXzLUzoV7K2uAgMqMG61SDP/XTDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpplkU0TuzUbhdkW7k9drPhGGLP4DIdBBw1EE65CYu9hsOZ58JzBO98dBMdywVYkaa3GJa8CBzuCRTcOW117Tvf97fBgIjmMS5IXZLNMHsoqirzdxFY8AMJ519KjMx8bBz0CoKEQ7t8hqEP+HMT+akJP4tfZqI+lkVWyRnJSSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5jsa0TN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5jsa0TN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613002; x=1810149002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zUTaYGQD4wbN3rbTXzLUzoV7K2uAgMqMG61SDP/XTDw=;
  b=P5jsa0TNmBOc6Uc8VJy9IolCYCg5FKF9ptSFRb5phCm31eYvQOKxDVIU
   3mJaJC5O7cTagL+91uXS6oMPzSrVV2wuCsY3hiLhCoOlqlJ0iC28nzRmG
   85yunHvlFxCrcxYiZ1Gv6WskxYG2p+phoFRpBYxBck3nwKM/v/BjXXcLw
   CTcpkmM9z99Sz4dP5KFdYGz3FIolozuGQ2Yrd0e2J8KzlLW8gAtZ7VG7a
   5u5uCWAtvldhoDpmp3AvuZlmhEjaQTfNMCN6XC655R8tEl9qIpJh8Gdim
   uPnniiltdXyQlLN7Y5r52h6eRLmS36Un7ogp5ENLmAe6LEruJW19twagI
   g==;
X-CSE-ConnectionGUID: uGTocQCaR2qErVQJxftYVw==
X-CSE-MsgGUID: GnlRb8ajQxm2wTKKk9YrGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90994727"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90994727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:10:02 -0700
X-CSE-ConnectionGUID: tsHMwJIeRy6cXLEGBmStiw==
X-CSE-MsgGUID: vm3g/eu4RNSE3TD2aHY3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236874756"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 May 2026 12:09:59 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMsUO-000000002f9-0g39;
	Tue, 12 May 2026 19:09:56 +0000
Date: Wed, 13 May 2026 03:09:43 +0800
From: kernel test robot <lkp@intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Extend wrapped HW credit counter in
 software
Message-ID: <202605130328.AdvlQMiJ-lkp@intel.com>
References: <20260511053858.30921-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511053858.30921-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/muhammad-nazim-amirul-nazle-asmade-altera-com/fpga-altera-cvp-Extend-wrapped-HW-credit-counter-in-software/20260512-200019
base:   linus/master
patch link:    https://lore.kernel.org/r/20260511053858.30921-1-muhammad.nazim.amirul.nazle.asmade%40altera.com
patch subject: [PATCH] fpga: altera-cvp: Extend wrapped HW credit counter in software
config: x86_64-randconfig-r072-20260512 (https://download.01.org/0day-ci/archive/20260513/202605130328.AdvlQMiJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9065-ge9cc34fd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130328.AdvlQMiJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130328.AdvlQMiJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/fpga/altera-cvp.c: In function 'altera_cvp_v2_wait_for_credit':
>> drivers/fpga/altera-cvp.c:242:25: error: 'struct altera_cvp_conf' has no member named 'device_family_type'
     242 |                 if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
         |                         ^~
>> drivers/fpga/altera-cvp.c:242:49: error: 'SOCFPGA_CVP_V2_AGILEX5' undeclared (first use in this function)
     242 |                 if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/fpga/altera-cvp.c:242:49: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/fpga/altera-cvp.c:243:53: error: 'VSE_CVP_AG5_TX_CREDITS' undeclared (first use in this function); did you mean 'VSE_CVP_TX_CREDITS'?
     243 |                         vse_cvp_tx_credits_offset = VSE_CVP_AG5_TX_CREDITS;
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~
         |                                                     VSE_CVP_TX_CREDITS


vim +242 drivers/fpga/altera-cvp.c

   227	
   228	static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
   229						 u32 blocks)
   230	{
   231		u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
   232		struct altera_cvp_conf *conf = mgr->priv;
   233		int ret;
   234		u32 val;
   235		u32 credit_mask;
   236		u32 vse_cvp_tx_credits_offset = VSE_CVP_TX_CREDITS;
   237		u32 mod;
   238		u32 real_credit;
   239	
   240		do {
   241			/* READ DWORD is required for Agilex5 but READ BYTE is required for non-Agilex5 */
 > 242			if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
 > 243				vse_cvp_tx_credits_offset = VSE_CVP_AG5_TX_CREDITS;
   244				credit_mask = 0xFFF;
   245				ret = altera_read_config_dword(conf, vse_cvp_tx_credits_offset, &val);
   246			} else {
   247				/*
   248				 * For the byte config read path, val is zeroed before pci_read_config_byte
   249				 * so only the low byte is defined before masking.
   250				 */
   251				val = 0;
   252				credit_mask = 0xFF;
   253				ret = altera_read_config_byte(conf, vse_cvp_tx_credits_offset,
   254							      (u8 *)&val);
   255			}
   256	
   257	
   258			if (ret) {
   259				dev_err(&conf->pci_dev->dev,
   260					"Error reading CVP Credit Register\n");
   261				return ret;
   262			}
   263	
   264			val &= credit_mask;
   265			mod = credit_mask + 1;
   266	
   267			/*
   268			 * HW credit is n bits and wraps; extend it in software so we can
   269			 * compare to sent_packets directly. On a forward wrap the masked
   270			 * value jumps from high to low; require (last - val) > mod/2 so a
   271			 * small backward glitch is not counted as a wrap. More than one
   272			 * wrap between polls is not detected if the low bits repeat.
   273			 */
   274			if (conf->credit_ext_inited &&
   275			    val < conf->last_credit_hw &&
   276			    (conf->last_credit_hw - val) > (mod / 2))
   277				conf->overflow_counter++;
   278	
   279			conf->last_credit_hw = val;
   280			conf->credit_ext_inited = true;
   281	
   282			real_credit = conf->overflow_counter * mod + val;
   283	
   284			if (real_credit > conf->sent_packets)
   285				return 0;
   286			if (real_credit < conf->sent_packets) {
   287				dev_err(&conf->pci_dev->dev,
   288					"CVP credit behind sent count (real %u reg 0x%x sent %u)\n",
   289					real_credit, val, conf->sent_packets);
   290				return -EPROTO;
   291			}
   292	
   293			ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
   294			if (ret) {
   295				dev_err(&conf->pci_dev->dev,
   296					"CE Bit error credit reg[0x%x]:sent[0x%x]\n",
   297					val, conf->sent_packets);
   298				return -EAGAIN;
   299			}
   300	
   301			/* Limit the check credit byte traffic */
   302			usleep_range(V2_CHECK_CREDIT_US, V2_CHECK_CREDIT_US + 1);
   303		} while (timeout--);
   304	
   305		dev_err(&conf->pci_dev->dev, "Timeout waiting for credit\n");
   306		return -ETIMEDOUT;
   307	}
   308	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
