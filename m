Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2AC07E96
	for <linux-fpga@archiver.kernel.org>; Wed,  7 Jul 2021 02:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D4761C9C
	for <linux-fpga@archiver.kernel.org>; Wed,  7 Jul 2021 02:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGGCLO (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:11:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:53335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhGGCLO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Jul 2021 22:11:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209182628"
X-IronPort-AV: E=Sophos;i="5.83,330,1616482800"; 
   d="scan'208";a="209182628"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 19:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,330,1616482800"; 
   d="scan'208";a="497468422"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2021 19:08:33 -0700
Date:   Wed, 7 Jul 2021 10:03:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] FPGA Manager address unused variable warnings
Message-ID: <20210707020309.GA12358@yilunxu-OptiPlex-7050>
References: <20210702035404.397853-1-mdf@kernel.org>
 <d0088161-ec7f-4ff4-d5c1-c0746ca17283@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0088161-ec7f-4ff4-d5c1-c0746ca17283@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 06, 2021 at 09:28:37AM -0700, Tom Rix wrote:
> 
> On 7/1/21 8:54 PM, Moritz Fischer wrote:
> > This patchset addresses a handful of warnings as result of_match_ids
> > being not properly wrapped in #ifdef CONFIG_OF.
> > 
> > Moritz Fischer (4):
> >    fpga: altera-freeze-bridge: Address warning about unused variable
> >    fpga: xiilnx-spi: Address warning about unused variable
> >    fpga: xilinx-pr-decoupler: Address warning about unused variable
> >    fpga: zynqmp-fpga: Address warning about unused variable
> > 
> >   drivers/fpga/altera-freeze-bridge.c | 2 ++
> >   drivers/fpga/xilinx-pr-decoupler.c  | 2 ++
> >   drivers/fpga/xilinx-spi.c           | 2 ++
> >   drivers/fpga/zynqmp-fpga.c          | 3 ++-
> >   4 files changed, 8 insertions(+), 1 deletion(-)
> 
> I am not seeing these warnings, but it is still worth doing.
> 
> I think a few more files need this change.
> 
> altera-ps-spi.c, dfl-n3000-nios.c, altera-hps2fpga.c, stratix10-soc.c,
> socfpga-a10.c, altera-fpga2sdram.c

dfl-n3000-nios is not using of_device_id, and doesn't need the change.

Thanks,
Yilun

> 
> Not needed for
> 
> altera-pr-ip-core-plat.c and ice40-spi.c
> 
> These have depends on OF in Kconfig.
> 
> Tom
