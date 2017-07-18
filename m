Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170718052228.GA10631@kroah.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
 <1498441938-14046-2-git-send-email-hao.wu@intel.com> <CANk1AXTDVVRG05H9kwZujFYGGS=AjQ2cdfrBm=bRNz9S7p6R6w@mail.gmail.com>
 <20170713042520.GC28569@hao-dev> <20170714235914.GA17169@eluebber-mac02.jf.intel.com>
 <CANk1AXTLhbczboA=wCYGUhnJyyYfvmUqUpk490sk34eh-MU5Ew@mail.gmail.com> <20170718052228.GA10631@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 18 Jul 2017 09:32:39 -0500
Message-ID: <CANk1AXRB4OzouKPRh2n-HfhrGGUUCh2w2BM8Zz81ZwCGU+8KCw@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] docs: fpga: add a document for Intel FPGA driver overview
Content-Type: text/plain; charset="UTF-8"
To: Greg KH <greg@kroah.com>
Cc: "Luebbers, Enno" <enno.luebbers@intel.com>, Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jul 18, 2017 at 12:22 AM, Greg KH <greg@kroah.com> wrote:
> On Mon, Jul 17, 2017 at 03:14:29PM -0500, Alan Tull wrote:
>> > Also, we're thinking that some operations require that you first "acquire
>> > ownership" of the respective device, which I believe maps more easily to
>> > open() and ioctls than sysfs.
>> >
>> > Thanks
>> > - Enno
>>
>> Yes, sysfs doesn't implement open/close so there's no clean way to
>> have one thing in userspace that owns the interface.  It's a shame.
>
> No, that was by design :)

Well that's good to know!  linux-api is copied on this patchset.  I'm
wondering if there is another mailing list that can weigh in on this
new ioctl that is being added to the kernel or if that's the one.

Alan Tull
