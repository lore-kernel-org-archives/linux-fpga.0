Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E582BEE49A3
	for <linux-fpga@archiver.kernel.org>; Tue, 22 Aug 2023 13:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjHVNxs (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjHVNxs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Aug 2023 09:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22018B
        for <linux-fpga@vger.kernel.org>; Tue, 22 Aug 2023 06:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C68A62166
        for <linux-fpga@vger.kernel.org>; Tue, 22 Aug 2023 13:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752DDC433C7;
        Tue, 22 Aug 2023 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692712425;
        bh=Inw6AzqT9PEt/Ycsrl/BqDr0Y5Q4N/1Ptqy1prcbdvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6euPUcA1EKEyLB+gzUgNBJsBFxbDkiZi/v1nSVDlbM0pxNReAlRfmIJ1VYcyrYub
         xLbzsFPaND+wR/7po8GXOyDfAzUHot/Mbhbb/6Ax8H7Jk/P7Im7moR37h2Y/mIzUTs
         z4O0LEs5HFqAvZuv3cK4vU6d3U+KRGfc1xPSh8aY=
Date:   Tue, 22 Aug 2023 15:53:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-rc1
Message-ID: <2023082210-retold-clear-3af4@gregkh>
References: <ZNn4p4zpwj3iCk4u@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNn4p4zpwj3iCk4u@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 14, 2023 at 05:49:27PM +0800, Xu Yilun wrote:
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-rc1

Pulled and pushed out, thanks.

greg k-h
