Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9ADEB64D9
	for <linux-fpga@archiver.kernel.org>; Mon, 19 Jun 2023 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjFSNqh (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 19 Jun 2023 09:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFSNqe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 19 Jun 2023 09:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C952E63;
        Mon, 19 Jun 2023 06:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF7E60C74;
        Mon, 19 Jun 2023 13:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51FBC433C0;
        Mon, 19 Jun 2023 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687182392;
        bh=+ceSi0YnxMiyEVe/LA+ixdtXvBA3Y8U3mmhLi5z92ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cr1kPz5MF1Zyz2M6RBvxvni0OC7wn6KprtYy63bNqNcq6zYpgy76J357RuhkTqr3S
         WJBlPJcO/YG7hrr4OAq400MMIOQb2puV+IR30+iD+qTIABW1PCwtK/PjboV8GG7Yoi
         5cpdsioG24uKKtoDvPiAnYHVQ0w3RmGhp2/mQ4mY=
Date:   Mon, 19 Jun 2023 15:46:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     hao.wu@intel.com, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaron.j.grier@intel.com,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper
 macros
Message-ID: <2023061916-abacus-dipper-2238@gregkh>
References: <20230616224209.20991-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616224209.20991-1-peter.colberg@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 16, 2023 at 06:42:09PM -0400, Peter Colberg wrote:
> Replace all shifts by PAGE_SHIFT with PFN_DOWN() and PFN_PHYS() helper
> macros to convert between physical addresses and page frame numbers.

Is this a bugfix, or just a cleanup?

thanks,

greg k-h
