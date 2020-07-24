Return-Path: <SRS0=yLcN=BD=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=yLcN=BD=intel.com=yilun.xu@kernel.org>
Date: Fri, 24 Jul 2020 11:30:45 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v2 0/4] Modularization of DFL private feature drivers
Message-ID: <20200724033045.GA5726@yilunxu-OptiPlex-7050>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <7ff4653b-dcf0-e7d4-9d09-a30a9f857661@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff4653b-dcf0-e7d4-9d09-a30a9f857661@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jul 23, 2020 at 08:03:52PM -0700, Randy Dunlap wrote:
> On 7/23/20 7:09 PM, Xu Yilun wrote:
> > This patchset makes it possible to develop independent driver modules
> > for DFL private features. It also helps to leverage existing kernel
> > drivers to enable some IP blocks in DFL.
> > 
> > Patch #1: An improvement of feature id definition. The feature id will be used
> > 	  as the key field for dfl device/driver matching.
> > Patch #2: Release the dfl mmio regions after enumeration, so that private
> > 	  feature drivers could request mmio region in their own drivers.
> > Patch #3: Introduce the dfl bus, then dfl devices could be supported by
> > 	  independent dfl drivers.
> > Patch #4: An example of the dfl driver for N3000 nios private feature.
> > 
> 
> Hi,
> What is "nios"?  Is that explained or described anywhere?

It is the NIOS2 soft processor mostly used in the FPGA. I see the there
is an arch/nios2 folder in kernel.

On Intel PAC N3000 card, the embedded NIOS2 core in FPGA does some
Board initialization work (Mostly the configuration of ethernet retimer)
on reboot. And the dfl-n3000-nios private feature in DFL is actually the
handshake interfaces for host to communicate with the NIOS2 core, about 
what parameters to use, when the configuration is finished ...

Thanks,
Yilun

> 
> > 
> > Main changes from v1:
> > - Add the new Patch #1, to improve the feature id definition.
> > - Change the dfl bus uevent format.
> > - Change the dfl device's sysfs name format.
> > - refactor dfl_dev_add()
> > - Add the Patch #4 as an example of the dfl driver.
> > - A lot of minor fixes for comments from Hao and Tom.
> 
> thanks.
> -- 
> ~Randy
