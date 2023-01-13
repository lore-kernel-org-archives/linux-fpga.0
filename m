Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ABCC54EBE
	for <linux-fpga@archiver.kernel.org>; Fri, 13 Jan 2023 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAMO6S (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjAMO5q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 13 Jan 2023 09:57:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320192342;
        Fri, 13 Jan 2023 06:44:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09B7662033;
        Fri, 13 Jan 2023 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BD8C433EF;
        Fri, 13 Jan 2023 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673621069;
        bh=JqO9Wp59UXUQK97O3r8cnH0Ybh0wDdsGyO/dONSSSdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhA564pOq5cDJr/PFP3o4W1BVTReajcinSRwW/3LPTdF6EPOCYE+McUpAVKFNwuwV
         EA3vOK/mT8vit84Z0ziSOXLLsJwQnbAMtrI9pkwYq24RkcDDNGfbyS0Y+1+Yq+sbKN
         w762LK9GXzLoWZdRhODwerN7pWoBLafY4sINpB+XU1YE0aKY6ayZ1YU5Un7tI2KaqF
         k9RfSANh0Y+2fq1UUq2NuLjk9CCxkiF8ycBqiFGRG4wPTG+cgwGlz2QqZ9jgP88RON
         8SeoFaWL1K533S1jMTasqQEtkCWsJe0zZEmZdKddLD6zgWB9v0O4JM+qGEl2SW+oRD
         sTQTiZQlSc1Xg==
Date:   Fri, 13 Jan 2023 14:44:22 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] mfd: intel-m10-bmc: Support multiple CSR
 register layouts
Message-ID: <Y8FuRtO0etJ0vl78@google.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-5-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 26 Dec 2022, Ilpo Järvinen wrote:

> There are different addresses for the MAX10 CSR registers. Introducing
> a new data structure m10bmc_csr_map for the register definition of
> MAX10 CSR.
> 
> Provide the csr_map for SPI.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 73 +++++++++++++++++--------
>  drivers/mfd/intel-m10-bmc-core.c        | 10 ++--
>  drivers/mfd/intel-m10-bmc-spi.c         | 24 ++++++++
>  include/linux/mfd/intel-m10-bmc.h       | 39 +++++++++++--
>  4 files changed, 113 insertions(+), 33 deletions(-)

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
