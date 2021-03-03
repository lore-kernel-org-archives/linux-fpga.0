Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F4C43381
	for <linux-fpga@archiver.kernel.org>; Wed,  3 Mar 2021 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E9E64ED7
	for <linux-fpga@archiver.kernel.org>; Wed,  3 Mar 2021 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhCCQaQ (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Wed, 3 Mar 2021 11:30:16 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:48364 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1355836AbhCCHBt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Mar 2021 02:01:49 -0500
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 02:01:49 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id A50018014646
        for <linux-fpga@vger.kernel.org>; Wed,  3 Mar 2021 06:50:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 33F8C100E7B42;
        Wed,  3 Mar 2021 06:49:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thumb56_150e8a6276c3
X-Filterd-Recvd-Size: 1626
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Mar 2021 06:49:44 +0000 (UTC)
Message-ID: <70f35c99165ac4dd1846ea2e30b9a1745c364903.camel@perches.com>
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
From:   Joe Perches <joe@perches.com>
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        robh@kernel.org
Date:   Tue, 02 Mar 2021 22:49:43 -0800
In-Reply-To: <YDLF2Bi3oEhP6A7Q@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
         <YDLF2Bi3oEhP6A7Q@archbook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, 2021-02-21 at 12:43 -0800, Moritz Fischer wrote:
> On Wed, Feb 17, 2021 at 10:40:01PM -0800, Lizhi Hou wrote:
> > This is V3 of patch series which adds management physical function driver for Xilinx
> > Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> > This driver is part of Xilinx Runtime (XRT) open source stack.
[]
> Please fix the indents all across this patchset. Doesn't checkpatch with
> --strict complain about this?

I glanced at a couple bits of these patches and didn't
notice any of what I consider poor indentation style.

What indent is wrong here?


