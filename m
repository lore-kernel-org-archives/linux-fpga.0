Return-Path: <SRS0=CPnK=GT=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=CPnK=GT=gmail.com=p.pisati@kernel.org>
Date: Thu, 29 Mar 2018 16:33:58 +0200
From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Message-ID: <20180329143358.GA4556@harukaze>
References: <1521808032-29645-1-git-send-email-p.pisati@gmail.com>
 <1521808032-29645-3-git-send-email-p.pisati@gmail.com>
 <CANk1AXRAXQ8cURb+ObS5SpaBKQLdoFFB6nmLTnmA1gQowmoVbw@mail.gmail.com>
 <CANk1AXQyZdoxXnLTtwR0fkYjgdB36XABQSwdxk6eQoQJtLC80w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQyZdoxXnLTtwR0fkYjgdB36XABQSwdxk6eQoQJtLC80w@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Mar 28, 2018 at 03:03:42PM -0500, Alan Tull wrote:
> On Wed, Mar 28, 2018 at 11:26 AM, Alan Tull <atull@kernel.org> wrote:
> > On Fri, Mar 23, 2018 at 7:27 AM, Paolo Pisati <p.pisati@gmail.com> wrote:
> >
> > Hi Paolo,
> 
> One more thing.  The api for registering a FPGA manager is changing.
> It won't be hard to adapt.  I've pushed a branch that includes the
> patches that add this change.  Please rebase on top of that branch so
> your patch can go in on top of that.
> 
> My git repo is at:
> git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
> 
> The branch name is
> for-review-next-20180327-drvdata-v3

Ok, i'll fix all the issues you raised in the previous email, rebase on
this branch and resend.
-- 
bye,
p.
