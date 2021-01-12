Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E23C433DB
	for <linux-fpga@archiver.kernel.org>; Tue, 12 Jan 2021 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7626422E00
	for <linux-fpga@archiver.kernel.org>; Tue, 12 Jan 2021 09:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbhALJVo (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:21:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390542AbhALJVo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Jan 2021 04:21:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82EE922E00;
        Tue, 12 Jan 2021 09:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610443264;
        bh=2yUrUUeDJ7Sw3oM2+mdSjYMtTvA5NiE9SIFN3Y789VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lt5brxlkgyy0iGQPJ3mSTr502PzUwH1mR6CkM2U+N5DEtwggrdJvzUSc2DugTIt2r
         OCj/3QZJbEOu4GV7lCSo2rkTFT1qx2CgBjxKQYq+jWrpvuSYWIP2GBehUWqfnCXihX
         0wHfjPg0SmX4yX7nIwcD29cJdfNKhNMB3Yy+GVqY=
Date:   Tue, 12 Jan 2021 10:22:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.org, moritzf@google.com
Subject: Re: [GIT PULL] First set of FPGA Manager changes for 5.12-rc1
Message-ID: <X/1qRWITleqK8TuR@kroah.com>
References: <X/1Mb/9+Ln49Fdw8@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/1Mb/9+Ln49Fdw8@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 11:14:55PM -0800, Moritz Fischer wrote:
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-cleanup-for-5.12

Pulled and pushed out, thanks.

greg k-h
