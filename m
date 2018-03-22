Return-Path: <SRS0=Su9g=GM=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=Su9g=GM=gmail.com=p.pisati@kernel.org>
Date: Thu, 22 Mar 2018 18:26:08 +0100
From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
Message-ID: <20180322172608.GA22179@harukaze>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
 <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
 <1521655492.7999.13.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521655492.7999.13.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Mar 21, 2018 at 11:04:52AM -0700, Joe Perches wrote:
> 
> static const u8 cmd[]
> here and everywhere else as all the tx_buf assignments 
> of cmd are to const void *

Ok
 
> Instead of multiple declarations of dump_status_reg
> it's frequently nicer to use a style like
> 
> static void debug_func(args...)
> {
> #ifdef DEBUG
> 	[code...]
> #endif
> }
> 
> so if function arguments ever need to be changed
> it's only required to be changed in one spot and
> not multiply compilation tested with and without
> the DEBUG definition

Ok
 
> It's frequently nicer to use a static function
> for these enum -> string conversions like:
> 
> static const char *get_err_string(unsigned long err)
> {
> 	switch (err) {
> 	case ENOERR:	return "No Error";
> 	case EID:	return "ID ERR";
> 	case ECMD:	return "CMD ERR";
> 	[...]
> 	}
> 	return "default switch case";
> }

Ok - checkpatch complained when i put the "case ...: return ...;" on the same
line as you did here, that is why i ended up with the ugly "case...: $string;
break" all on different lines
 
> > +	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> > +	       *status, test_bit(DONE, status), test_bit(ENAB, status),
> > +	       test_bit(BUSY, status), test_bit(FAIL, status),
> > +		   test_bit(DVER, status), ferr);
> 
> So instead of ferr, this could use
> 	get_err_string(*status)
> 
> And please try to keep a consistent alignment for
> indentation of multiple line statements

I tried, but then checkpatch complained again about the indentation of the above block
and i literally had to guess...

Anyhow, thanks, i'll send a v8 with all these style fixes.
-- 
bye,
p.
