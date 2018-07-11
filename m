Return-Path: <SRS0=DVva=J3=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=DVva=J3=ettus.com=moritz.fischer@kernel.org>
Date: Wed, 11 Jul 2018 11:25:53 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: fpga: fpga_mgr_free usage
Message-ID: <20180711182553.GA5356@archbook>
References: <5553262.evi6GU8epL@pcbe13614>
 <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: federico.vaga@cern.ch, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Wed, Jul 11, 2018 at 10:59:01AM -0500, Alan Tull wrote:
> On Wed, Jul 11, 2018 at 7:38 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

[..]
> > This makes the usage consistent: the user creates and destroy its own
> > objects. This is also consistent with our other discussion where we
> > said, among the other things, that the module that uses the FPGA
> > manager can the owner of the fpga_manager data structure.
> 
> You're not the first to complain about this.  I think I'll err on the
> side of consistency and implement your option 2 here.

I agree, that seems like a good approach.

Cheers,

Moritz
