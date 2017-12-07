Return-Path: <SRS0=uIlv=DD=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=uIlv=DD=intel.com=hao.wu@kernel.org>
Date: Thu, 7 Dec 2017 11:47:49 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3 08/21] fpga: add Intel FPGA DFL PCIe device
Message-ID: <20171207034749.GA23924@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-9-git-send-email-hao.wu@intel.com>
 <f5ae8e5edf88420e89cfbe754407b92e@AcuMS.aculab.com>
 <20171128031519.GA25705@hao-dev>
 <CANk1AXRBEcz5_j+v0oTAXfH10hrPbHGabdR8Pqt07exYxYgfCw@mail.gmail.com>
 <20171205033330.GA19730@hao-dev>
 <391be54799604c1fb3d7b80c7ad6d111@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391be54799604c1fb3d7b80c7ad6d111@AcuMS.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Alan Tull <atull@kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "luwei.kang@intel.com" <luwei.kang@intel.com>, "yi.z.zhang@intel.com" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Dec 06, 2017 at 09:34:14AM +0000, David Laight wrote:
> From: Wu Hao
> > Sent: 05 December 2017 03:34
> ...
> > > I don't see anything Intel specific here.  This could all be named dfl-*
> > 
> > The maybe some device specific things, e.g Intel FPGA devices supported by this
> > driver always have FME DFL at the beginning on the BAR0 for PF device.
> 
> Since when has that been a method for specifying what the card does?
> You need to allocate a PCI-id for your DFL accelerator.

This driver only supports Intel FPGA devices (see PCI Device Ids table
in this patch) as mentioned above now, per my current understanding, if
other vendors follow the same hardware design on using DFL for their PCIe
based devices, then it's possible for them to fully reuse this code,
otherwise they need to develop new drivers for their own designs or extend
this driver in some ways (it depends on actual hardware implementation).

Thanks
Hao

> 
> 	David
