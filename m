Return-Path: <SRS0=+obP=JH=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=+obP=JH=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:43294
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932695AbeFUNOG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 21 Jun 2018 09:14:06 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: fpga: fpga_mgr_get() buggy ?
Date: Thu, 21 Jun 2018 15:13:41 +0200
Message-ID: <4617134.5euanDEBgJ@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

I believe that this patch

fpga: manager: change api, don't use drvdata
7085e2a94f7df5f419e3cfb2fe809ce6564e9629

is incomplete and buggy.

I completely agree that drvdata should not be used by the FPGA manager 
or any other subsystem like that.

What is buggy is the function fpga_mgr_get().
That patch has been done to allow multiple FPGA manager instances to 
be linked to the same device (PCI it says). But function 
fpga_mgr_get() will return only the first found: what about the 
others?

Then, all load kernel-doc comments says:

"This code assumes the caller got the mgr pointer from 
of_fpga_mgr_get() or fpga_mgr_get()"

but that function does not allow me to get, for instance, the second 
FPGA manager on my card.

Since, thanks to this patch I'm actually the creator of the 
fpga_manager structure,  I do not need to use fpga_mgr_get() to 
retrieve that data structure.
Despite this, I believe we still need to increment the module 
reference counter (which is done by fpga_mgr_get()).

We can fix this function by just replacing the argument from 'device' 
to 'fpga_manager' (the one returned by create() ). Alternatively, we 
can add an 'owner' field in "struct fpga_manager_ops" and 'get' it 
when we use it. Or again, just an 'owner' argument in the create() 
function. I'm proposing these alternatives because I'm not sure that 
this is correct:

	if (!try_module_get(dev->parent->driver->owner))

What if the device does not have a driver? Do we consider the 
following a valid use case?


probe(struct device *dev) {
  struct device *mydev;

  mydev->parent = dev;
  device_register(mydev);
  fpga_mrg_create(mydev, ....);
}


thanks :)



