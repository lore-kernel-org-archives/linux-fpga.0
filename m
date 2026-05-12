Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313139A076;
	Tue, 12 May 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611746; cv=none; b=JNTcHthNCMT7gn27gi/LwMDIETsOHaW3dDzLL9IQOs0w5Jt2jSdUzeaVxP2fcZ+Xu2AUXw3Q95KSfgr6FjIpG+W038AnpErjplK9w1i3yVlHsTHrXrSwghyOn5WTnvUV12Mc2n9mddwU8Mliu4nZ0BmV4VJHyn4OSt8VQiZGm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611746; c=relaxed/simple;
	bh=IFHHh+ypxZXCZn0UJ7amOewF7rDeqiqicm+o7AXxP+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/w1/rwZqMRK3RX+u47GTMiw9K78AnkVBeOLji2a1pQ2FIW/gQk1s2Wcd+ZHnEHbB+oOq4PuNaj2+aVHg7+dcpOR8tdMKed6bW57kBFUyIFNfbED80G+rAkfpKqSKA9M5eOnRioHOFouPkToKs0RVAvPdVjUSLUHjVeUhr4fm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODlZ5+1v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODlZ5+1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778611745; x=1810147745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFHHh+ypxZXCZn0UJ7amOewF7rDeqiqicm+o7AXxP+k=;
  b=ODlZ5+1vAu7ZeIAyGrlhXexq1fCmWT0nwVOkuK8XoB+ehwwbc2vdX0p5
   7L+rBV5+sJSmQ15teYu3Z20NL2epYHH53sugukptZ6EdwcgEl8cK/zyAK
   MxIS+BWi11iwObKvSs5npb/vU0Q36Y54qTZ6r+Zw8Ht/cpX8YjxguphTn
   x5UW28NVYBTMAke5lQVfItcualxBzyGss5mM1SxOIri+xGrsGDTGx7pCA
   cVwPn9mONqop3uE2fW43iNS3zu9h2TZD+IGLN2sBL2CREZ5JGe8iq+toC
   aRG5KhGG86Sr0PQ4cqHX9FO1qUQLixs9ydL74NvUA+jnQ2L6mPou4D0Bw
   g==;
X-CSE-ConnectionGUID: tEs+fXgJRQGBOLoKDlLz/Q==
X-CSE-MsgGUID: 4dbK3M8oTsGGTWmMIVAMww==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78674345"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="78674345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:48:59 -0700
X-CSE-ConnectionGUID: bv0RfIDiSxuIqtGOxgCzBg==
X-CSE-MsgGUID: HO37BE3RRI2gdM6tw39b7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="268190672"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 May 2026 11:48:57 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMsA2-000000002dX-3nbN;
	Tue, 12 May 2026 18:48:54 +0000
Date: Wed, 13 May 2026 02:48:39 +0800
From: kernel test robot <lkp@intel.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-cvp: Extend wrapped HW credit counter in
 software
Message-ID: <202605130220.ZrvfCQQU-lkp@intel.com>
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
config: i386-buildonly-randconfig-006-20260512 (https://download.01.org/0day-ci/archive/20260513/202605130220.ZrvfCQQU-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130220.ZrvfCQQU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130220.ZrvfCQQU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/fpga/altera-cvp.c:242:13: error: no member named 'device_family_type' in 'struct altera_cvp_conf'
     242 |                 if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
         |                     ~~~~  ^
>> drivers/fpga/altera-cvp.c:242:35: error: use of undeclared identifier 'SOCFPGA_CVP_V2_AGILEX5'
     242 |                 if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
         |                                                 ^
>> drivers/fpga/altera-cvp.c:243:32: error: use of undeclared identifier 'VSE_CVP_AG5_TX_CREDITS'
     243 |                         vse_cvp_tx_credits_offset = VSE_CVP_AG5_TX_CREDITS;
         |                                                     ^
   3 errors generated.


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
