Return-Path: <SRS0=jUA1=HN=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=jUA1=HN=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCHv3 3/7] driver, misc: add Intel Stratix10 service layer
 driver
Date: Tue, 24 Apr 2018 11:24:52 +0000
Message-ID: <9498165854b84321801d8186d3040b1e@AcuMS.aculab.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-4-git-send-email-richard.gong@linux.intel.com>
 <20180423120300.GC7951@kroah.com>
In-Reply-To: <20180423120300.GC7951@kroah.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: 'Greg KH' <gregkh@linuxfoundation.org>, "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "dinguyen@kernel.org" <dinguyen@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "atull@kernel.org" <atull@kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "yves.vandervennet@linux.intel.com" <yves.vandervennet@linux.intel.com>, "richard.gong@intel.com" <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Greg KH
> Sent: 23 April 2018 13:03
> On Tue, Mar 27, 2018 at 03:20:10PM -0500, richard.gong@linux.intel.com wr=
ote:
> > +config INTEL_SERVICE
>=20
> Naming is hard, but this is a _very_ generic name, don't you agree?
>=20
> > +	tristate "Intel Service Layer"
>=20
> As is this.  Can you make this a bit more specific to what hardware is
> being controlled here?
>=20
> > +++ b/drivers/misc/intel-service.c
>=20
> Same for the file name, why not stratix10.c?
>=20
> or intel_svc.c?  That makes it a _bit_ more generic.  Well, not really,
> but it does hide the "genericness" a bit more, right?

It'll all be even worse if (when) Intel decide to sell Altera to
someone else.

	David
