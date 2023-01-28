Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91424C27C76
	for <linux-fpga@archiver.kernel.org>; Sat, 28 Jan 2023 18:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjA1SUO (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sat, 28 Jan 2023 13:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjA1SUN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 Jan 2023 13:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD031241C1
        for <linux-fpga@vger.kernel.org>; Sat, 28 Jan 2023 10:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC21B808CF
        for <linux-fpga@vger.kernel.org>; Sat, 28 Jan 2023 18:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC63C433EF;
        Sat, 28 Jan 2023 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674930010;
        bh=Wm3qhUjW0LwsUbu+nve7scK0bo9lvMhdR5f9S9xv6oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnSXJiTWqgbLfmD5KbyvKRw8GYAE67yw7Y0iCCF/+t+VlWTeBn5RCB4mB1v6qIbzX
         LyWnbIVnXZDpp9BhrOISM6P3iPWmEgN6cCtaM9j2LFhR0sXWcEmuP4CiNq3eqPfEic
         1L78YegHom3QOs4hRykGSj58yJoam1/X+M4h6qA4=
Date:   Sat, 28 Jan 2023 19:20:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.2 final
Message-ID: <Y9VnVhmXT0uacq1J@kroah.com>
References: <Y9U0TASyMnHzbDtp@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9U0TASyMnHzbDtp@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jan 28, 2023 at 10:42:20PM +0800, Xu Yilun wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.2-final

Pulled and pushed out, thanks.

greg k-h
