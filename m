Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6706CC6FD1C
	for <linux-fpga@archiver.kernel.org>; Wed, 22 Mar 2023 14:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCVOvC (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 22 Mar 2023 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCVOu1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 22 Mar 2023 10:50:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA5565C74;
        Wed, 22 Mar 2023 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679496543; x=1711032543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8YNQRAicmSv6T0cU1eA62syh4TE+BY1vcLm2QfeLQDs=;
  b=bkf6S2dBctwDsEENusXDhCSCzyWiE0oj9ZRrMGcZH4cFNkyVq34js4pI
   C7daB9+AaJFv4wicXA6mE/FWAsfBUKY4eaz8AiQAyzHTup3diovF4n96g
   FG2rsKprM6V5Az+iUoEnMHPgJqd6YhyhzbqrYvCaSsKgRYhFAtzRxzymu
   tTGmx0daS1E9GS5cs5XFSPBvdM8sqAIaQvRezvQx5WuiQ9tjKId7tUkwy
   INTcSwWiGMW0Nf/jTdDL6h8Z2rtzsdxp2CtWIrNezjuP4U6wtZUcW14iT
   N5D+l2EJIEReyIgfygM4NXVp1kDH/nEo5scfvh6ypS/tsYullNg7Zevg8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327611173"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327611173"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792581061"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792581061"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:48:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pezlp-007Abe-2F;
        Wed, 22 Mar 2023 16:48:57 +0200
Date:   Wed, 22 Mar 2023 16:48:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-fpga@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        vinicius.gomes@intel.com, pierre-louis.bossart@linux.intel.com,
        marpagan@redhat.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, nico@fluxnic.net,
        Raghavendra Khadatare <raghavendrax.anand.khadatare@intel.com>
Subject: Re: [PATCH v2] ptp: add ToD device driver for Intel FPGA cards
Message-ID: <ZBsVWWe33FJgoj9A@smile.fi.intel.com>
References: <20230322143547.233250-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322143547.233250-1-tianfei.zhang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Mar 22, 2023 at 10:35:47AM -0400, Tianfei Zhang wrote:
> Adding a DFL (Device Feature List) device driver of ToD device for
> Intel FPGA cards.
> 
> The Intel FPGA Time of Day(ToD) IP within the FPGA DFL bus is exposed
> as PTP Hardware clock(PHC) device to the Linux PTP stack to synchronize
> the system clock to its ToD information using phc2sys utility of the
> Linux PTP stack. The DFL is a hardware List within FPGA, which defines
> a linked list of feature headers within the device MMIO space to provide
> an extensible way of adding subdevice features.

...

> +	dt->ptp_clock = ptp_clock_register(&dt->ptp_clock_ops, dev);
> +	if (IS_ERR_OR_NULL(dt->ptp_clock))
> +		return dev_err_probe(dt->dev, PTR_ERR_OR_ZERO(dt->ptp_clock),
> +				     "Unable to register PTP clock\n");
> +
> +	return 0;

Can be as simple as:

	ret = PTR_ERR_OR_ZERO(dt->ptp_clock);
	return dev_err_probe(dt->dev, ret, "Unable to register PTP clock\n");

-- 
With Best Regards,
Andy Shevchenko


