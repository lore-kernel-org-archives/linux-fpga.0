Return-Path: <SRS0=SrHn=NI=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=SrHn=NI=ettus.com=moritz.fischer@kernel.org>
Date: Sun, 28 Oct 2018 10:35:03 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181028173503.GA4358@archbook>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
 <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
 <20181024095135.GA1382@archbook>
 <alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
 <1540457043890.27497@oregano.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540457043890.27497@oregano.at>
To: Andreas Puhm <puhm@oregano.at>
Cc: "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>, Moritz Fischer <mdf@kernel.org>, Anatolij Gustschin <agust@denx.de>, Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Andreas,

On Thu, Oct 25, 2018 at 08:44:06AM +0000, Andreas Puhm wrote:

> >My experience with cvp is with Arria10 and Stratix 10.  The PCIe Hard IP
> >gets configured when the IOring gets configured at power on.  The idea is
> >that the load of the IOring is very fast, much before the infamous 100ms
> >PCIe timeout for link training.  When the Hard IP is configured, the
> >CVP_EN is set or cleared according to how it was configured.  Yes, you
> 
> So is it correct that the value of CVP_EN can be evaluated by the altera_cvp right in the first call of its probe function
> (as would be the case with my proposed patch).
> 
> If it is, I will fix the remaining issues with the patch and submit it.

Yes please, go ahead and fix up the remaining issues (+ send it using
git send-email)

Thanks,
Moritz
