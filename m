Return-Path: <SRS0=2ORC=M4=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2ORC=M4=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPSsT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Oct 2018 14:48:19 -0400
Date: Tue, 16 Oct 2018 12:58:24 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Staging : Add RIFFA PCIe driver
Message-ID: <20181016105824.GA16641@kroah.com>
References: <SG2PR06MB31763736BF5D2F346D19C12EC1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB3176B20AA8DAB164A73568B7C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB317685E4238622AF0EB38684C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB31766B83E9967845C17E7B58C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
 <SG2PR06MB317677E129AECC23CF5705A3C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB317677E129AECC23CF5705A3C1FE0@SG2PR06MB3176.apcprd06.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Cheng Fei Phung <feiphung@hotmail.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

On Tue, Oct 16, 2018 at 10:54:28AM +0000, Cheng Fei Phung wrote:
> This patch adds RIFFA PCIe linux driver for https://github.com/promach/riffa/tree/full_duplex/driver/linux
> 
> TODO:
> 
> 1) this driver needs further speed optimization although it can now achieve defined PCIe speed grade
> 2) solve all the coding style errors from scripts/checkpatch.pl

Can you please wrap your lines at 72 columns like your editor wanted you
to?  :)

> 
> Signed-off-by: PHUNG CHENG FEI (feiphung@hotmail.com)

So close, you need to use '<' and '>' here, not '(' and ')'

> 
> ---
> Changes in v1:
> � - added full-duplex capability
> 
> �drivers/staging/riffa/Makefile������ |� 157 +++
> �drivers/staging/riffa/README.txt���� |�� 38 +
> �drivers/staging/riffa/circ_queue.c�� |� 188 +++
> �drivers/staging/riffa/circ_queue.h�� |�� 96 ++
> �drivers/staging/riffa/riffa.c������� |� 152 +++
> �drivers/staging/riffa/riffa.h������� |� 121 ++
> �drivers/staging/riffa/riffa_driver.c | 1633 ++++++++++++++++++++++++++
> �drivers/staging/riffa/riffa_driver.h |� 131 +++
> �8 files changed, 2516 insertions(+)
> �create mode 100644 drivers/staging/riffa/Makefile
> �create mode 100644 drivers/staging/riffa/README.txt
> �create mode 100644 drivers/staging/riffa/circ_queue.c
> �create mode 100644 drivers/staging/riffa/circ_queue.h
> �create mode 100644 drivers/staging/riffa/riffa.c
> �create mode 100644 drivers/staging/riffa/riffa.h
> �create mode 100644 drivers/staging/riffa/riffa_driver.c
> �create mode 100644 drivers/staging/riffa/riffa_driver.h

This does not actually add the driver to the kernel build process at
all.  How are you testing this?  You need to hook it up by adding a
Kconfig file and touching the drivers/staging/Kconfig and
drivers/staging/Makefile files to add your code to the build system.

As it is, this doesn't work at all :(

And none of your code has any tabs in it at all.  You should at least
fix that up first, otherwise the very first patch people are going to
be forced to send will be to replace all lines in all of these files
with that type of modification.  It is better if you do that first.

thanks,

greg k-h
