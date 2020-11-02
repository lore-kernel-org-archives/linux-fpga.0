Return-Path: <SRS0=LHrh=EI=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A502CC00A89
	for <linux-fpga@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6726C22453
	for <linux-fpga@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgKBOqP (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:46:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58696 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKBOqP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Nov 2020 09:46:15 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kZb5y-004pRV-Dp; Mon, 02 Nov 2020 15:46:06 +0100
Date:   Mon, 2 Nov 2020 15:46:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, mdf@kernel.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, netdev@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [RFC PATCH 1/6] docs: networking: add the document for DFL Ether
 Group driver
Message-ID: <20201102144606.GI1042051@lunn.ch>
References: <1603442745-13085-1-git-send-email-yilun.xu@intel.com>
 <1603442745-13085-2-git-send-email-yilun.xu@intel.com>
 <20201023153731.GC718124@lunn.ch>
 <20201026085246.GC25281@yilunxu-OptiPlex-7050>
 <20201026130001.GC836546@lunn.ch>
 <20201026173803.GA10743@yilunxu-OptiPlex-7050>
 <20201026191400.GO752111@lunn.ch>
 <20201102023809.GA10673@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102023809.GA10673@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> I did some investigation and now I have some details.
> The term 'PHY' described in Ether Group Spec should be the PCS + PMA, a figure
> below for one configuration:
> 
>  +------------------------+          +-----------------+
>  | Host Side Ether Group  |          |      XL710      |
>  |                        |          |                 |
>  | +--------------------+ |          |                 |
>  | | 40G Ether IP       | |          |                 |
>  | |                    | |          |                 |
>  | |       +---------+  | |  XLAUI   |                 |
>  | | MAC - |PCS - PMA|  | |----------| PMA - PCS - MAC |
>  | |       +---------+  | |          |                 |
>  +-+--------------------+-+          +-----------------+

Thanks, that makes a lot more sense.

	Andrew
