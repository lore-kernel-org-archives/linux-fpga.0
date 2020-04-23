Return-Path: <SRS0=et3w=6H=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=et3w=6H=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mx06lb.world4you.com ([81.19.149.116]:38508 "EHLO
        mx06lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgDWNfa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Apr 2020 09:35:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Apr 2020 15:09:10 +0200
From: Eric Schwarz <eas@sw-optimization.com>
Subject: Use DMA Test Kernel Module for FPGA Device
Message-ID: <3955779b6d28751c45ab5af01095ef88@sw-optimization.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

I think it is not possible to use the dmatest [1] kernel framework for 
testing a DMA engine located in an FPGA where the FPGA is connected to 
the host system over PCIe.
However, does any one have out-of-tree patches in order to do so for 
dmatest or knows a project which could be used for that case?

System setup:

                                          +-------+
                                          |  DDR  |
                                          +-------+
                                              |
                                              |
+--------------+                   +-------------------+
|              |                   | +------------+    |
|              |                   | | DMA Engine |    |
|              |      PCIe         | +------------+    |
|     CPU      +<----------------->+                   |
|              |                   |       FPGA        |
|              |                   |                   |
|              |                   |                   |
+--------------+                   +-------------------+


[1] 
https://www.kernel.org/doc/html/latest/driver-api/dmaengine/dmatest.html

Many thanks
Eric
