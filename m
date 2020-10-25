Return-Path: <SRS0=KqJ9=EA=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7213FC4363A
	for <linux-fpga@archiver.kernel.org>; Sun, 25 Oct 2020 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D220936
	for <linux-fpga@archiver.kernel.org>; Sun, 25 Oct 2020 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416027AbgJYOr3 (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sun, 25 Oct 2020 10:47:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43508 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415756AbgJYOr3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 25 Oct 2020 10:47:29 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kWhIo-003RJA-Vi; Sun, 25 Oct 2020 15:47:22 +0100
Date:   Sun, 25 Oct 2020 15:47:22 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tom Rix <trix@redhat.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        mdf@kernel.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, netdev@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [RFC PATCH 5/6] ethernet: dfl-eth-group: add DFL eth group
 private feature driver
Message-ID: <20201025144722.GF792004@lunn.ch>
References: <1603442745-13085-1-git-send-email-yilun.xu@intel.com>
 <1603442745-13085-6-git-send-email-yilun.xu@intel.com>
 <326cf423-33ef-1fea-86c5-1b5245eadddf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326cf423-33ef-1fea-86c5-1b5245eadddf@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > +u64 read_mac_stats(struct eth_com *ecom, unsigned int addr)
> > +{
> > +	u32 data_l, data_h;
> > +
> > +	if (eth_com_read_reg(ecom, addr, &data_l) ||
> > +	    eth_com_read_reg(ecom, addr + 1, &data_h))
> > +		return 0xffffffffffffffffULL;

> return -1; ?

Since this is a u64 function, i expect you get a compiler
warning. Maybe only with W=1. It is better to use U64_MAX.

	 Andrew
