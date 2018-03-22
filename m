Return-Path: <SRS0=45aN=GM=perches.com=joe@kernel.org>
Return-Path: <SRS0=45aN=GM=perches.com=joe@kernel.org>
Message-ID: <1521743410.7999.48.camel@perches.com>
Subject: Re: [PATCH 2/2] fpga: lattice machxo2: Add Lattice MachXO2 support
From: Joe Perches <joe@perches.com>
Date: Thu, 22 Mar 2018 11:30:10 -0700
In-Reply-To: <20180322172608.GA22179@harukaze>
References: <1521653726-24625-1-git-send-email-p.pisati@gmail.com>
	 <1521653726-24625-3-git-send-email-p.pisati@gmail.com>
	 <1521655492.7999.13.camel@perches.com> <20180322172608.GA22179@harukaze>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, 2018-03-22 at 18:26 +0100, Paolo Pisati wrote:
> > It's frequently nicer to use a static function
> > for these enum -> string conversions like:
> > 
> > static const char *get_err_string(unsigned long err)
> > {
> > 	switch (err) {
> > 	case ENOERR:	return "No Error";
> > 	case EID:	return "ID ERR";
> > 	case ECMD:	return "CMD ERR";
> > 	[...]
> > 	}
> > 	return "default switch case";
> > }
> 
> Ok - checkpatch complained when i put the "case ...: return ...;" on the same
> line as you did here, that is why i ended up with the ugly "case...: $string;
> break" all on different lines

checkpatch is brainless and stupid and if it
recommends stupid consistency over readability,
ignore it.
 
> > > +	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> > > +	       *status, test_bit(DONE, status), test_bit(ENAB, status),
> > > +	       test_bit(BUSY, status), test_bit(FAIL, status),
> > > +		   test_bit(DVER, status), ferr);
> > 
> > So instead of ferr, this could use
> > 	get_err_string(*status)
> > 
> > And please try to keep a consistent alignment for
> > indentation of multiple line statements
> 
> I tried, but then checkpatch complained again about the indentation of the above block
> and i literally had to guess...

I think it only complained about the
2nd line that starts *status because it
doesn't align with the open parenthesis
of pr_debug
