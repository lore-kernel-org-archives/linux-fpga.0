Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 15 Apr 2020 19:25:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.7
Message-ID: <20200415172506.GB3661754@kroah.com>
References: <20200331035459.GA3472@epycbox.lan>
 <CAJYdmeP+wwLN7fc_6UgFAKOk5yR=OradHtH0MXVhR_TBQD7M5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYdmeP+wwLN7fc_6UgFAKOk5yR=OradHtH0MXVhR_TBQD7M5A@mail.gmail.com>
To: Moritz Fischer <moritz.fischer.private@gmail.com>
Cc: Moritz Fischer <moritzf@google.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Apr 15, 2020 at 09:05:50AM -0700, Moritz Fischer wrote:
> On Mon, Mar 30, 2020 at 8:55 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> >
> >   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-fixes-for-5.7
> >
> > for you to fetch changes up to 3c2760b78f90db874401d97e3c17829e2e36f400:
> >
> >   fpga: dfl: pci: fix return value of cci_pci_sriov_configure (2020-03-30 20:45:30 -0700)
> >
> > ----------------------------------------------------------------
> > FPGA Manager fixes for 5.7-rc1
> >
> > Here are two (late) fixes for 5.7-rc1 merge window.
> >
> > Xu's change addresses an issue with a wrong return value.
> >
> > Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on
> >
> > All patches have been reviewed on the mailing list, and have been in the
> > last few linux-next releases (as part of my for-next branch) without issues.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >
> > ----------------------------------------------------------------
> > Shubhrajyoti Datta (1):
> >       fpga: zynq: Remove clk_get error message for probe defer
> >
> > Xu Yilun (1):
> >       fpga: dfl: pci: fix return value of cci_pci_sriov_configure
> >
> >  drivers/fpga/dfl-pci.c   | 6 ++++--
> >  drivers/fpga/zynq-fpga.c | 3 ++-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Ping

I couldn't do anything until after -rc1 came out, and now I'm working on
catching up.  Don't worry, it's not lost...

greg k-h
