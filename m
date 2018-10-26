MIME-Version: 1.0
Date: Fri, 26 Oct 2018 10:04:21 -0700
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
	<20181023090119.GA2205@archbook>
	<1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
	<20181023110445.GA1371@archbook>
	<468b9b34-aa87-9abb-a913-0512a01e9a51@xilinx.com>
In-Reply-To: <468b9b34-aa87-9abb-a913-0512a01e9a51@xilinx.com>
Message-ID: <CAJYdmePrXcH=kYJFAD=dMWem0r6CpP_+P0NB6qGE-8TLT9rcRQ@mail.gmail.com>
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To: Michal Simek <michal.simek@xilinx.com>
Cc: mike.looijmans@topic.nl, linux-fpga@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Michal,

On Fri, Oct 26, 2018 at 12:54 AM Michal Simek <michal.simek@xilinx.com> wrote:

> > Ok, I had suspected you tested it and probably didn't run into issues,
> > but just wanted to make sure we think about it. If you don't mind, swap
> > it around as I suggested just to be safe.
> >
> > With that change feel free to add my Reviewed-by: Moritz Fischer
> > <mdf@kernel.org> in your v2.
>
> That clock can be used by something else that's why you didn't observe
> any issue. Anyway I have no problem with reverting that setting back
> that icap can be used.

Ok, thanks for clarification, that was what I assumed :)

> In general there should be synchronization mechanism for this. And also
> driver "feature" not to enable access from icap for security reason. But
> that's something what should be done in other patch.

Yeah I'll have to look at remote notifications for FPGA managers
soon-ish for another
project as discussed at ELCE. Part of that would be synchronization I guess :)

Umhh, based on the secure state read from CTRL_SEC_EN bit, or did you
think along the
lines of "xlnx,no-icap" property that your bootloader / dt would provide?

Cheers,

Moritz
