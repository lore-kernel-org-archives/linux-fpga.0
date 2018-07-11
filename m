Return-Path: <SRS0=Kptj=J3=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Kptj=J3=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:62082
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732385AbeGKMmw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:52 -0400
From: Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>
Subject: fpga: fpga_mgr_free usage
Date: Wed, 11 Jul 2018 14:38:29 +0200
Message-ID: <5553262.evi6GU8epL@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hi Alan,

I have another point that I would like to discuss. It is about the 
usage of 'fpga_mgr_free()' which does not look like consistent.

This function, according to the current implementation, can be used by 
an FPGA manager user and it is used by the FPGA manager itself on 
device release. This means that the user can only use this function if 
fpga_mgr_register() fails (to clean up), otherwise the user must NOT 
use this function, otherwise we most likely get an oops (NULL or 
invalid pointer). The example here is correct, this is what we should 
do:

https://www.kernel.org/doc/html/latest/driver-api/fpga/fpga-mgr.html

But I suggest to document it better or prevent this type of mistakes 
from happening. Following a couple of proposals

------
1.
Document it better. This is easy, in the fpga_mgr_free() kernel-doc 
comment we explain that the use of this function must be limited to 
clean up the memory on a registration failure. If an FPGA manager has 
been successfully registered then it will be freed by the framework 
itself.

But still, this does not prevent an oops from happening.
------
2.
Remove the fpga_mgr_free() from fpga_mgr_dev_release() and ask the 
user to free the manager when necessary.

This makes the usage consistent: the user creates and destroy its own 
objects. This is also consistent with our other discussion where we 
said, among the other things, that the module that uses the FPGA 
manager can the owner of the fpga_manager data structure.
------
3.
Not sure how, but perhaps we can be able to understand if we can 
safely continue to run fpga_mgr_free() or we should stop.
------


