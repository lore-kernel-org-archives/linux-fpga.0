Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook> <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
 <20190403164742.GC5752@archbook> <CANk1AXSoF3bhiO=t-XJRLhBH20emWYaZ+2LCPtqJsKyh4b+9KQ@mail.gmail.com>
 <CANk1AXSJ31Q7X3J6NOsqVkQoJkjJz=xka0XiWvuYC36s1HiBuA@mail.gmail.com> <20190403200800.GE5752@archbook>
In-Reply-To: <20190403200800.GE5752@archbook>
From: Alan Tull <atull@kernel.org>
Date: Wed, 3 Apr 2019 16:57:59 -0500
Message-ID: <CANk1AXRtDJYAYS3WUvDhbhrN92pKFbsZYTbS8rXAJi78kAfbNA@mail.gmail.com>
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Richard Gong <richard.gong@linux.intel.com>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 3, 2019 at 3:08 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> On Wed, Apr 03, 2019 at 01:37:51PM -0500, Alan Tull wrote:
> > >
> > > it's state, not status for most fpga manager drivers.  It should
> > > return 'operating' if everything went well.
>
> Yeah, sorry :)
>
> > > It seems like there's a possible scenario where the FPGA starts up
> > > with the FPGA in 'operating' mode and the user messes up early enough
> > > that the state doesn't change.
>
> Huh, then we should fix that instead? :)
> > >
> > > >
> > > > Personally not in favor of extra messages, but if we do it we should
> > > > change the message to "Sucessfully programmed FPGA".
> > > >
> > > > I think making it a dbg message is a good trade-off ...
> >
> > dbg vs info... On the one hand, it is a usually a message the
> > developer wants to see so the developer would turn on debug messages.
> > But then again FPGA programming doesn't happen that often and it is a
> > kind of significant event since it is your hardware changing i.e. it
> > won't add a lot messages, but it is sort of an important one if it
> > happens.   If the system crashes after a FPGA reprogramming event, it
> > would be good to have this in the log by default.  I don't want to
> > argue too powerfully for adding extra messages though.  Is this a case
> > where info is worth it since fpga programming is significant?
>
> In the current setup, it doesn't happen often. Going forward people
> might have use-cases where this happens a lot more often.

Yes, then adding the message could become very spammy.

>
> I mean if y'all feel like this is required, sure, I still feel people
> shouldn't rely on dmesg output for functional verification :)

I agree with you that using sysfs to see what state the FPGA mgr ended
up in should be adequate most of the time.  We probably don't need
this.

>
> I don't wanna guarantee that this message is gonna be there always ...

Indeed...

Thanks,
Alan

>
> Cheers,
> Moritz
