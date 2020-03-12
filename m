Return-Path: <SRS0=PSro=45=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=PSro=45=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41800 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUif (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Mar 2020 16:38:35 -0400
Date: Thu, 12 Mar 2020 15:38:31 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] arch: nios2: rename 'altr,gpio-bank-width' ->
 'altr,ngpio'
Message-ID: <20200312203831.GA31683@bogus>
References: <20200306115450.3352-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306115450.3352-1-alexandru.ardelean@analog.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org, ley.foon.tan@intel.com, robh+dt@kernel.org, mdf@kernel.org

On Fri, 6 Mar 2020 13:54:49 +0200, Alexandru Ardelean wrote:
> There is no more 'altr,gpio-bank-width' in the 'altr,pio-1.0' driver.
> There is a 'altr,ngpio' which is  what the property wants to configure.
> 
> This change updates all occurrences of 'altr,gpio-bank-width' to
> 'altr,ngpio'.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
>  arch/nios2/boot/dts/10m50_devboard.dts                 | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
