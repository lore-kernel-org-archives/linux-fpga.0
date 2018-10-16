Return-Path: <SRS0=2ORC=M4=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2ORC=M4=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeJPQRO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Oct 2018 12:17:14 -0400
Date: Tue, 16 Oct 2018 10:27:54 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Add RIFFA PCIe driver to staging tree
Message-ID: <20181016082754.GA11851@kroah.com>
References: <SG2PR06MB31763736BF5D2F346D19C12EC1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB3176B20AA8DAB164A73568B7C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB3176B20AA8DAB164A73568B7C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Cheng Fei Phung <feiphung@hotmail.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

On Tue, Oct 16, 2018 at 07:41:45AM +0000, Cheng Fei Phung wrote:
> Patch changelog content:
> 
> Add a PCIe linux driver called RIFFA to the linux staging tree. It has full duplex capability compared to the original RIFFA linux driver that you can easily find from https://github.com/KastnerRG/riffa/tree/master/driver/linux
> 
> For more context, please refer to https://github.com/promach/riffa/tree/full_duplex/driver/linux
> 
> 
> 
> phung@UbuntuHW15:~/linux$ cat patches/0001-Added-a-full-duplex-riffa-PCIe-linux-staging-driver..patch
> >From 7c3050c7e86017d85c75c640ea38376f505b2763 Mon Sep 17 00:00:00 2001
> From: promach <feiphung@hotmail.com>
> Date: Mon, 15 Oct 2018 18:28:16 +0800
> Subject: [PATCH] Added a full duplex riffa PCIe linux staging driver.
> �Signed-off-by: PHUNG CHENG FEI (feiphung@hotmail.com)
> 

This whole format is very odd.  Please look at how other patches are
posted to the list.  I need a proper changelog and signed-off-by line in
the correct place.

Also, no need to 'cat' the file here, just use git send-email to send
the patch correctly.

Because of this, all of your tabs got converted to spaces, so the patch
you sent here is corrupted.

Try sending it to yourself first, run the result of that email through
scripts/checkpatch.pl and apply it to the tree to verify that it really
does work.

Also, for staging drivers I need a TODO file that lists the remaining
tasks that are left to be done in order to get the driver out of the
staging portion of the kernel tree.

Look at the patch that was sent today that added a new driver to the
staging portion of the kernel as an example of how to do all of this
correctly.

thanks,

greg k-h
