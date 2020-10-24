Return-Path: <SRS0=bXk7=D7=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE54C2D0A3
	for <linux-fpga@archiver.kernel.org>; Sat, 24 Oct 2020 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892F222263
	for <linux-fpga@archiver.kernel.org>; Sat, 24 Oct 2020 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762415AbgJXQkA (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Sat, 24 Oct 2020 12:40:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42922 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762413AbgJXQkA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 24 Oct 2020 12:40:00 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kWMa6-003IGb-D0; Sat, 24 Oct 2020 18:39:50 +0200
Date:   Sat, 24 Oct 2020 18:39:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tom Rix <trix@redhat.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        mdf@kernel.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, netdev@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [RFC PATCH 4/6] ethernet: m10-retimer: add support for retimers
 on Intel MAX 10 BMC
Message-ID: <20201024163950.GJ745568@lunn.ch>
References: <1603442745-13085-1-git-send-email-yilun.xu@intel.com>
 <1603442745-13085-5-git-send-email-yilun.xu@intel.com>
 <dbc77c18-8076-bcfd-b4f7-03e62dc46a97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc77c18-8076-bcfd-b4f7-03e62dc46a97@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 24, 2020 at 08:03:51AM -0700, Tom Rix wrote:
> 
> On 10/23/20 1:45 AM, Xu Yilun wrote:
> > This driver supports the ethernet retimers (Parkvale) for the Intel PAC
> > (Programmable Acceleration Card) N3000, which is a FPGA based Smart NIC.
> 
> Parkvale is a code name, it would be better if the public name was used.
> 
> As this is a physical chip that could be used on other cards,
> 
> I think the generic parts should be split out of intel-m10-bmc-retimer.c
> 
> into a separate file, maybe retimer-c827.c

This driver is not really a driver for the Parkvale. That driver is
hidden away in the BMC. So we need to be a bit careful with the name,
leaving it available for when somebody writes a real Linux driver for
retimer.

	Andrew
