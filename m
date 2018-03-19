Return-Path: <SRS0=FZEQ=GJ=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=FZEQ=GJ=gmail.com=p.pisati@kernel.org>
Date: Mon, 19 Mar 2018 19:09:50 +0100
From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Message-ID: <20180319180950.GA15921@harukaze>
References: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
 <1521215669-23874-3-git-send-email-p.pisati@gmail.com>
 <20180316162654.bcr7d46om2tnhm7l@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316162654.bcr7d46om2tnhm7l@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 16, 2018 at 09:26:54AM -0700, Moritz Fischer wrote:
> >
> > +static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
> > +{
> > +	return FPGA_MGR_STATE_UNKNOWN;
> > +}
> 
> To understand this correctly: Further up you have a way to determine the
> state you're in, but then you only use that for debug printout, while
> here where you should provide the status you say FPGA_MGR_STATE_UNKNOWN?
> 
> Am I missing something here?

This is more of a generic function ('What's the state of the FPGA now?') while
dump_status_reg() is invoked after a specific SPI command is sent to the FPGA to
keep track of the status of the chip and check that it adhere to the state
machine.

I'll send a v7.
-- 
bye,
p.
