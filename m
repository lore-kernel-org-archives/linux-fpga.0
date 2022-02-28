Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACA3C433F5
	for <linux-fpga@archiver.kernel.org>; Mon, 28 Feb 2022 04:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiB1Euy (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 27 Feb 2022 23:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiB1Euy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 27 Feb 2022 23:50:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82950457
        for <linux-fpga@vger.kernel.org>; Sun, 27 Feb 2022 20:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D827560F81
        for <linux-fpga@vger.kernel.org>; Mon, 28 Feb 2022 04:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C32C340E7;
        Mon, 28 Feb 2022 04:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646023815;
        bh=JhVcsoiB3b1ENRdxAMIj50B8UetIW/zOpQlTX8ah9pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCCnIAtT/2jbKUr5bR9ooVepc9Dssei7rWR+gGRoXCNkAeeDJ4GwzDHmM6yjCZZUd
         3+hmII7lvegdHPlhHkJxJ+SjOKhDz4fKOQtgmwXd4VOkbGc5KuNxGI1jDq1I6un7H2
         MdtlOZ9txIOFC5/Pbmy3aGpdr4n9+jPa7PyE/n9Q=
Date:   Mon, 28 Feb 2022 05:50:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager change for 5.18-rc1
Message-ID: <YhxUgMvs2XabozMF@kroah.com>
References: <Yhv2DnIMuYrleRJK@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhv2DnIMuYrleRJK@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Feb 27, 2022 at 02:07:10PM -0800, Moritz Fischer wrote:
> The following changes since commit 21f0a239ecab4b6765269af78904512358beb802:
> 
>   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.18-rc1
> 
> for you to fetch changes up to 21f0a239ecab4b6765269af78904512358beb802:
> 
>   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)
> 
> ----------------------------------------------------------------
> FPGA Manager changes for 5.18-rc1
> 
> Christophe's patch is part of a larger effort of removing the use of the
> deprecated pci-dma-compat API.
> 
> All patches have been reviewed on the mailing list, and have been in the
> last few linux-next releases (as part of our for-next branch) without issues.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> 
> ----------------------------------------------------------------

No diffstat?
