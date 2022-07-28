Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C568C04A68
	for <linux-fpga@archiver.kernel.org>; Thu, 28 Jul 2022 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiG1TMi (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiG1TMe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Jul 2022 15:12:34 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66718691EB;
        Thu, 28 Jul 2022 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=FGPbbjbX4KDK76QvCX4o0ok2E32+6Ip3ULLXoY832p8=;
        b=JZ2/j3yOOKkow1aDcnks4F8J1DLOwd33yz/gaSgCbRATSIjRn3ZE+Fu3SQLDhzUY8VSACsn6zXQwq
         rOXCFCxENAEfwheB/O47YyRydzhgRPqmrNXhYaAD2kXyb5GHH1KagAAOzsu2IhwVUpiSxPLBSWryr8
         dyCPmOTWKXWPzofzwYcKJO3zb6egGdFOAeWs+bb+tSUzjERPTVC9GeSZLghyAGgxVJZxhzSYB8At6G
         Mq4ptZEJ5UIIqpnrY/lB8VvdbXMIyIwAosj87DOK7by4H6q5XkJ200P5GXC3ISdevscaTbKpWbzh7X
         D6qtemzvzbYAYNfbNuSeR5SeRV++9Ig==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.005760)], BW: [Enabled, t: (0.000013,0.000001)], RTDA: [Enabled, t: (0.070870), Hit: No, Details: v2.41.0; Id: 15.52k0je.1g933hend.4boe; mclb], total: 0(700)
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([85.93.58.13])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 28 Jul 2022 22:11:36 +0300
Date:   Thu, 28 Jul 2022 21:46:50 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: microchip-spi: add missing module author entry
Message-ID: <20220728184650.6wa5zwbrciatfsba@x260>
References: <20220728075012.3136914-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728075012.3136914-1-conor.dooley@microchip.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 28, 2022 at 08:50:13AM +0100, Conor Dooley wrote:
> Add the missing MODULE_AUTHOR entry for the Microchip spi-slave FPGA
> programming driver.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/fpga/microchip-spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index bd284c7b8dc9..7436976ea904 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -395,4 +395,5 @@ static struct spi_driver mpf_driver = {
>  module_spi_driver(mpf_driver);
>  
>  MODULE_DESCRIPTION("Microchip Polarfire SPI FPGA Manager");
> +MODULE_AUTHOR("Ivan Bornyakov <i.bornyakov@metrotek.ru>");
>  MODULE_LICENSE("GPL");
> -- 
> 2.36.1
> 

Acked-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Yet, I'm wondering in what situations MODULE_AUTHOR is needed? I've
submitted a couple of other drivers without it, should I fix them?

