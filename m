Return-Path: <SRS0=kF30=BD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=kF30=BD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGXDEC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Jul 2020 23:04:02 -0400
Subject: Re: [PATCH v2 0/4] Modularization of DFL private feature drivers
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ff4653b-dcf0-e7d4-9d09-a30a9f857661@infradead.org>
Date: Thu, 23 Jul 2020 20:03:52 -0700
MIME-Version: 1.0
In-Reply-To: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, lgoncalv@redhat.com

On 7/23/20 7:09 PM, Xu Yilun wrote:
> This patchset makes it possible to develop independent driver modules
> for DFL private features. It also helps to leverage existing kernel
> drivers to enable some IP blocks in DFL.
> 
> Patch #1: An improvement of feature id definition. The feature id will be used
> 	  as the key field for dfl device/driver matching.
> Patch #2: Release the dfl mmio regions after enumeration, so that private
> 	  feature drivers could request mmio region in their own drivers.
> Patch #3: Introduce the dfl bus, then dfl devices could be supported by
> 	  independent dfl drivers.
> Patch #4: An example of the dfl driver for N3000 nios private feature.
> 

Hi,
What is "nios"?  Is that explained or described anywhere?

> 
> Main changes from v1:
> - Add the new Patch #1, to improve the feature id definition.
> - Change the dfl bus uevent format.
> - Change the dfl device's sysfs name format.
> - refactor dfl_dev_add()
> - Add the Patch #4 as an example of the dfl driver.
> - A lot of minor fixes for comments from Hao and Tom.

thanks.
-- 
~Randy
