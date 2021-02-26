Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D8BC433DB
	for <linux-fpga@archiver.kernel.org>; Fri, 26 Feb 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BB164EDB
	for <linux-fpga@archiver.kernel.org>; Fri, 26 Feb 2021 06:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZGlk (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhBZGlj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 26 Feb 2021 01:41:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45194601FA;
        Fri, 26 Feb 2021 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614321659;
        bh=Paic+lKzSMeQ6CtUb4dplXqhyZZJH3hQU+cnvVbjFiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9wTy0xjc4UnFiJw2n7MKV7lX/TGgYca8QyGAifHYac95GpQg1whteZ+ClAGbBM1t
         svCOt9bhQgp+qqUlMg1siT6J9+pchLfIB0rBIzYGN8uI/6sU499U4MCtyxYVtTDwrA
         6VGoWbqlpxMv8W+YVOB6LkF0T+YjHkDdsCVYLcdc=
Date:   Fri, 26 Feb 2021 07:40:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v11 0/2] UIO support for dfl devices
Message-ID: <YDiX+Fl0AiQrdZJL@kroah.com>
References: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
 <9b5f6e54-7122-8cfb-39f8-a84599e081f1@redhat.com>
 <20210226012237.GA27194@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226012237.GA27194@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 26, 2021 at 09:22:37AM +0800, Xu Yilun wrote:
> On Mon, Feb 22, 2021 at 10:56:45AM -0800, Tom Rix wrote:
> > Yilun,
> > 
> > Is there anything outstanding or remaining to be done ?
> 
> Sorry for late reply. No, this is my lastest version now.
> 
> 
> Hi Greg:
> 
> Do you have some comments on this patchset?

It's the middle of the merge window, I can't accept anything right
now...

But this doesn't even look like it is in my "to review" queue anymore,
which means that there must have been a lot of discussion on it and
others asking for changes, so why not work on that right now while you
can and resubmit it when you have done that?

No need to ever wait on me for fixing things up.

greg k-h
