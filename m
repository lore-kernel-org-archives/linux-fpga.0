Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C7E732E7
	for <linux-fpga@archiver.kernel.org>; Thu, 28 Sep 2023 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjI1QD0 (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 28 Sep 2023 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI1QDZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Sep 2023 12:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F40D6;
        Thu, 28 Sep 2023 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695917004; x=1727453004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2WJ2JHUZMGgvXYHvfCZXwdKMPR5M8xkDsvfLanYSBWw=;
  b=iHGXLIic3ZYAiRcya92TSOTrrxI3muWNJzpiDhR3aj+CeYt6j1AWhqXT
   JlOpnevWAOkDq8ICCcWal+3OqB02+sRqlGb9Q97lv2gnIXkdR0aNaXxMy
   BtKesaZO5EwycwxE7XiE4vTjk3hfKZG73YBVPcUiOWkxQ8FmQOQKwXLs4
   cB8YA/9xqGwFiaplN0zzo8alJymL/lkemhbiOLfz5HM4uzyydpO8zbv1r
   s532ooi1uXiCDw1LEFHBJ582SzG+yYiLDsXRD+jQV1oqA/Y0dgDAGJNp5
   HzAQEjKCQCEjosmM9JTbtmYPcD1kgSRK5GLKaBBf8Bg2UkyZHZX8VkY6D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="382008973"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="382008973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 09:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699329280"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="699329280"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2023 09:02:03 -0700
Date:   Fri, 29 Sep 2023 00:01:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH 1/4] fpga: add helpers for the FPGA KUnit test suites.
Message-ID: <ZRWjVkMYNosNvlt3@yilunxu-OptiPlex-7050>
References: <20230926163911.66114-1-marpagan@redhat.com>
 <20230926163911.66114-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926163911.66114-2-marpagan@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-09-26 at 18:39:08 +0200, Marco Pagani wrote:
> Add helpers to facilitate the registration of minimal platform drivers
> to support the parent platform devices used for testing.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-test-helpers.h
> 
> diff --git a/drivers/fpga/tests/fpga-test-helpers.h b/drivers/fpga/tests/fpga-test-helpers.h
> new file mode 100644
> index 000000000000..fcad3249be68
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-test-helpers.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit test for the FPGA Manager
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#ifndef FPGA_KUNIT_HELPERS_
> +#define FPGA_KUNIT_HELPERS_

How about _FPGA_KUNIT_HELPERS_H

Others LGTM for this series.

Thanks,
Yilun

> +
> +#define TEST_PDEV_NAME	"fpga-test-pdev"
> +
> +#define TEST_PLATFORM_DRIVER(__drv_name)			\
> +	__TEST_PLATFORM_DRIVER(__drv_name, TEST_PDEV_NAME)
> +/*
> + * Helper macro for defining a minimal platform driver that can
> + * be registered to support the parent platform devices used for
> + * testing.
> + */
> +#define __TEST_PLATFORM_DRIVER(__drv_name, __dev_name)		\
> +static struct platform_driver __drv_name = {			\
> +	.driver = {						\
> +		.name = __dev_name,				\
> +	},							\
> +}
> +
> +#endif	/* FPGA_KUNIT_HELPERS_ */
> -- 
> 2.41.0
> 
