Return-Path: <SRS0=nFGk=DB=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=nFGk=DB=intel.com=hao.wu@kernel.org>
Date: Tue, 5 Dec 2017 11:36:11 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3 02/21] fpga: mgr: add region_id to fpga_image_info
Message-ID: <20171205033611.GB19730@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-3-git-send-email-hao.wu@intel.com>
 <20171129061107.w62q5tk5dplq2zmr@us-aus-ras-130-164-29-6.amer.corp.natinst.com>
 <CANk1AXTbrD3w=VEzXqTRfebgTYSRNGANthwN_PLVz8WWtxb7CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTbrD3w=VEzXqTRfebgTYSRNGANthwN_PLVz8WWtxb7CA@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Dec 04, 2017 at 02:26:14PM -0600, Alan Tull wrote:
> On Wed, Nov 29, 2017 at 12:11 AM, Moritz Fischer <mdf@kernel.org> wrote:
> > Hi Hao,
> >
> > On Mon, Nov 27, 2017 at 02:42:09PM +0800, Wu Hao wrote:
> >> This patch adds region_id to fpga_image_info data structure, it
> >> allows driver to pass region id information to fpga-mgr via
> >> fpga_image_info for fpga reconfiguration function.
> >>
> >> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> 
> Acked-by: Alan Tull <atull@kernel.org>

Hi Alan / Moritz

Thanks for the review. :)

Hao
