Return-Path: <SRS0=2ORC=M4=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2ORC=M4=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:45240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTo6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Oct 2018 15:44:58 -0400
Date: Tue, 16 Oct 2018 14:54:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Staging : Add RIFFA PCIe driver
Message-ID: <20181016115426.io5ejmshwlxt752x@mwanda>
References: <SG2PR06MB31763736BF5D2F346D19C12EC1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB3176B20AA8DAB164A73568B7C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB317685E4238622AF0EB38684C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB31766B83E9967845C17E7B58C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB317677E129AECC23CF5705A3C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB317677E129AECC23CF5705A3C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Cheng Fei Phung <feiphung@hotmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

Please make the subject be:

[PATCH] Staging: riffa: Add new RIFFA PCIe driver

On Tue, Oct 16, 2018 at 10:54:28AM +0000, Cheng Fei Phung wrote:
> This patch adds RIFFA PCIe linux driver for https://github.com/promach/riffa/tree/full_duplex/driver/linux

Line wrap the commit message at 75 characters or less.

> 
> TODO:
> 
> 1) this driver needs further speed optimization although it can now achieve defined PCIe speed grade
> 2) solve all the coding style errors from scripts/checkpatch.pl

Greg means that it needs a file named drivers/staging/riffa/TODO

> 
> Signed-off-by: PHUNG CHENG FEI (feiphung@hotmail.com)

Please use:

Signed-off-by: Cheng Fei Phung <feiphung@hotmail.com>

It's really unusual for any driver to not use the kernel build system
but to come with its own makefile like an out of tree driver...  I don't
care too much about that because this is staging and we will fix it, but
I had wanted to read the Kconfig entry but it's not there...

Anyway, this is a staging drive so we're not picky at all.

regards,
dan carpenter
