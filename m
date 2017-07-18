Return-Path: <SRS0=oON0=6V=kroah.com=greg@kernel.org>
Return-Path: <SRS0=oON0=6V=kroah.com=greg@kernel.org>
Date: Tue, 18 Jul 2017 07:22:28 +0200
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 01/22] docs: fpga: add a document for Intel FPGA
 driver overview
Message-ID: <20170718052228.GA10631@kroah.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
 <1498441938-14046-2-git-send-email-hao.wu@intel.com>
 <CANk1AXTDVVRG05H9kwZujFYGGS=AjQ2cdfrBm=bRNz9S7p6R6w@mail.gmail.com>
 <20170713042520.GC28569@hao-dev>
 <20170714235914.GA17169@eluebber-mac02.jf.intel.com>
 <CANk1AXTLhbczboA=wCYGUhnJyyYfvmUqUpk490sk34eh-MU5Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTLhbczboA=wCYGUhnJyyYfvmUqUpk490sk34eh-MU5Ew@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: "Luebbers, Enno" <enno.luebbers@intel.com>, Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jul 17, 2017 at 03:14:29PM -0500, Alan Tull wrote:
> > Also, we're thinking that some operations require that you first "acquire
> > ownership" of the respective device, which I believe maps more easily to
> > open() and ioctls than sysfs.
> >
> > Thanks
> > - Enno
> 
> Yes, sysfs doesn't implement open/close so there's no clean way to
> have one thing in userspace that owns the interface.  It's a shame.

No, that was by design :)
