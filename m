Return-Path: <SRS0=mpib=E4=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=mpib=E4=intel.com=hao.wu@kernel.org>
Date: Fri, 2 Feb 2018 17:08:22 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3 19/21] fpga: dfl: afu: add
 FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Message-ID: <20180202090822.GA17015@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-20-git-send-email-hao.wu@intel.com>
 <CANk1AXSfUfVbtbuREwG5Ck8TNZrqBg1fO5AuDDdFk-x=UjRTiw@mail.gmail.com>
 <20180201051625.GD10273@hao-dev>
 <20180201151309.q3jjx42y6ldcrhc6@insfl13.etec.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201151309.q3jjx42y6ldcrhc6@insfl13.etec.uni-karlsruhe.de>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Feb 01, 2018 at 04:13:09PM +0100, Moritz Fischer wrote:
> On Thu, Feb 01, 2018 at 01:16:25PM +0800, Wu Hao wrote:
> > On Wed, Jan 31, 2018 at 08:52:36AM -0600, Alan Tull wrote:
> > > On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> > > 
> > > Hi Hao,
> > > 
> > > I'm adding my "Acked-by' below.  When you post v4, please add it so
> > > that we can keep track of what got acked.
> > 
> > Sure, thanks a lot for the code review. :)
> > 
> > Hao
> > 
> > > 
> > > Thanks,
> > > Alan
> > > 
> > > > FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which
> > > > need to be supported by all feature devices drivers including FME and AFU.
> > > > This patch implements above 2 ioctls in FPGA Accelerated Function Unit
> > > > (AFU) driver.
> > > >
> > > > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > > > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > > > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > > > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > > > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Acked-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Looks good,

Thanks a lot for the code review. :)

Hao

> 
> Moritz
