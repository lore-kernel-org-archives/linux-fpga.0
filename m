Return-Path: <moritz.fischer.private@gmail.com>
Date: Fri, 24 Mar 2017 11:07:14 -0700
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Subject: Re: [PATCH v3 1/2] doc: Add bindings document for Xilinx LogiCore PR
 Decoupler
Message-ID: <20170324180714.GA4736@tyrael.amer.corp.natinst.com>
References: <1489781473-30772-1-git-send-email-mdf@kernel.org>
 <20170324145908.aiijqixf5xcnkksa@rob-hp-laptop>
 <20170324152318.GA13089@tyrael.amer.corp.natinst.com>
 <CANk1AXSHimnjsMsCJwbtwrkRppFCRxY7KQemFikgu+hqCTiO5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <CANk1AXSHimnjsMsCJwbtwrkRppFCRxY7KQemFikgu+hqCTiO5Q@mail.gmail.com>
To: Alan Tull <delicious.quinoa@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 12:25:25PM -0500, Alan Tull wrote:
> On Fri, Mar 24, 2017 at 10:23 AM, Moritz Fischer
> <moritz.fischer.private@gmail.com> wrote:
> > On Fri, Mar 24, 2017 at 09:59:08AM -0500, Rob Herring wrote:
> >> On Fri, Mar 17, 2017 at 01:11:12PM -0700, Moritz Fischer wrote:
> >> > This adds the binding documentation for the Xilinx LogiCORE PR
> >> > Decoupler soft core.
> >> >
> >> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >> > Cc: Michal Simek <michal.simek@xilinx.com>
> >> > Cc: S=F6ren Brinkmann <soren.brinkmann@xilinx.com>
> >> > Cc: linux-kernel@vger.kernel.org
> >> > Cc: devicetree@vger.kernel.org
> >> > ---
> >> >
> >> > Changes from v2:
> >> > - Added refence to generic fpga-region bindings
> >> > - Fixed up reg property in example
> >> > - Added fallback to "xlnx,pr-decoupler" without version
> >> >
> >> > Changes from v1:
> >> > - Added clock names & clock to example
> >> > - Merged some of the description from Michal's version
> >> >
> >> > ---
> >> >  .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 +++++++++++=
+++++++++++
> >> >  1 file changed, 35 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr=
-decoupler.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoup=
ler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> >> > new file mode 100644
> >> > index 0000000..16141bd
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> >> > @@ -0,0 +1,35 @@
> >> > +Xilinx LogiCORE Partial Reconfig Decoupler Softcore
> >> > +
> >> > +The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
> >> > +decouplers / fpga bridges.
> >> > +The controller can decouple/disable the bridges which prevents sign=
al
> >> > +changes from passing through the bridge.  The controller can also
> >> > +couple / enable the bridges which allows traffic to pass through the
> >> > +bridge normally.
> >> > +
> >> > +The Driver supports only MMIO handling. A PR region can have multip=
le
> >> > +PR Decouples which can bhe handled independently or chaines via dec=
ouple/
> >>
> >> s/chaines/chains/
> >
> > Fixed in v4.
> >
> >> > +decouple_status signals.
> >> > +
> >> > +Required properties:
> >> > +- compatible               : Should contain "xlnx,pr-decoupler-1.00"
> >> > +- regs                     : base address and size for decoupler mo=
dule
> >> > +- clocks           : input clock to IP
> >> > +- clock-names              : should contain "aclk"
> >> > +
> >> > +Optional properties:
> >> > +- bridge-enable            : 0 if driver should disable bridge at s=
tartup
> >> > +                     1 if driver should enable bridge at startup
> >> > +                     Default is to leave bridge in current state.
> >>
> >> This is common and should move into a common doc. Maybe fpga-region.txt
> >> works?
> >
> > Ok will add patch for that to v5 series.
>=20
> Arg, our emails criss-crossed.  I've already sent v4 to Greg.  I hope
> we don't need v5 for this one thing.  bridge-enable is common for the
> fpga bridges (altera-fpga2sdram-bridge.txt, altera-freeze-bridge.txt,
> altera-hps2fpga-bridge.txt, xilinx-pr-decoupler.txt).  Probably we
> need a new patch to move this common bridges binding from all the
> above to fpga-region.txt or create a new fpga-bridges.txt.  At first
> blush, I prefer the later.

Yeah, I'll just send a follow-up patch, it's not that it breaks anything
the way it is.

- Moritz

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1WBQAAoJEL5CEHepFqov1YoIAJ+JNJJMTQ2KHuEgT/IUvMLk
3tm8YmtavV0Q9G79nQfCSe2LSLuM4kiSMw5t0yCV5pVuwIuYpxdQeShl7BLf/kZ5
wl8+13fO431aF1vLPAYhI8Ti0FcFkI64bXVKzYsTUk8tsfEE73CNoNQsEks/5BX1
79jFyciQXCHHZjfftKGACz4R4P3fHmoEt6RcPNuowa7ciexNip2QIDNU4eEDni3A
V2QlJ5VdXFWn4Dt5OOXJcE6vlI31ANN7SI46xyl32GeboMg9yFHhpulfO8jctJO2
CH02frabhAtYgjOf7zZ2NRcg6DKNub737SBBwrNBTo+OvuY34p/BYDcrU1RviSk=
=L0by
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
