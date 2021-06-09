Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C75C48BCD
	for <linux-fpga@archiver.kernel.org>; Wed,  9 Jun 2021 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92E6610F8
	for <linux-fpga@archiver.kernel.org>; Wed,  9 Jun 2021 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhFIOxg (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238255AbhFIOx3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 10:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6ADE6108E;
        Wed,  9 Jun 2021 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623250295;
        bh=RpHoluI8pTJmYD96yxbSmwNRfpnI7sPzIq66BPEzHic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6XvBkwRHOL+xT8BqLULeDZK2oVML/jSFl+yvvua7d18wx0ai1R8VhT5TqxPmAZyY
         dZmrYHoOgNYKJyqZ6tU3sNaQagd8YmUsuAx+I2Ub08xxMIPfjTLsxdpbUMyNF7bPyF
         A6nWssPIMC1cYGY2xzJVHVewqp/c/Sy93eAqkgtc=
Date:   Wed, 9 Jun 2021 16:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4]  fpga: reorganize to subdirs
Message-ID: <YMDVdGwo+3zaxEAv@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609142208.3085451-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The incoming xrt patchset has a toplevel subdir xrt/
> The current fpga/ uses a single dir with filename prefixes to subdivide owners
> For consistency, there should be only one way to organize the fpga/ dir.
> Because the subdir model scales better, refactor to use it.
> The discussion wrt xrt is here:
> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/

Why am I getting 2 copies of 0/4?

Please fix your email client...
