Return-Path: <SRS0=Du5o=NX=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Du5o=NX=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx18lb.world4you.com ([81.19.149.128]:58504 "EHLO
        mx18lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeKLRwE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Nov 2018 12:52:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Nov 2018 08:59:58 +0100
From: Eric Schwarz <eas@sw-optimization.com>
Subject: Re: [PATCH 0/4] patches for FPGA
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
Message-ID: <3c40d1758b4ad0a71f826c5423ea4eeb@sw-optimization.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org

Hello Alan,

Am 07.11.2018 18:51, schrieb Alan Tull:

> Hi Greg,
> 
> Please take these four small fpga fixes patches.  They
> have been reviewed on the mailing list and apply
> cleanly on current linux-next and char-misc-testing.
> 
> Thanks,
> Alan
> 
> Anatolij Gustschin (1):
> fpga: altera-cvp: fix 'bad IO access' on x86_64
> 
> Andreas Puhm (1):
> fpga: altera-cvp: Fix registration for CvP incapable devices
> 
> Mike Looijmans (1):
> zynq-fpga: Only route PR via PCAP when required
> 
> YueHaibing (1):
> fpga: dfl: fme: remove set but not used variable 'priv'
> 
> drivers/fpga/altera-cvp.c | 15 +++++++++++++--
> drivers/fpga/dfl-fme-pr.c |  2 --
> drivers/fpga/zynq-fpga.c  |  4 ++++
> 3 files changed, 17 insertions(+), 4 deletions(-)

How is the backporting strategy for FPGA manager related bugfixes and 
drivers?

Best regards
Eric
