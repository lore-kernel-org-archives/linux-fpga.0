Return-Path: <SRS0=cVuE=CL=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=cVuE=CL=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 13 Nov 2017 10:31:47 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 2/3] fpga: manager: don't use drvdata in common fpga code
Message-ID: <20171113183147.GA28060@tyrael.ni.corp.natinst.com>
References: <1509482535-4921-1-git-send-email-atull@kernel.org>
 <1509482535-4921-3-git-send-email-atull@kernel.org>
 <20171031205924.p37uv6mfsmackhbj@us-sjc-wireless-10-16-34-58.amer.corp.natinst.com>
 <CANk1AXSpp=t71FmwRyX+gqY2r27JLzPKSg0e6yfMe35OsAv3Hw@mail.gmail.com>
 <20171101013428.GA21728@tyrael.ni.corp.natinst.com>
 <CANk1AXTLNFE5mBrNv0kBaOXJt0bT0QEbHh0BOSOg-ZHkanbxpA@mail.gmail.com>
 <CANk1AXSKQ1A66sTn3KMNN3G6bXm7aifp5yr90-bgWyTYSb=9ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <CANk1AXSKQ1A66sTn3KMNN3G6bXm7aifp5yr90-bgWyTYSb=9ww@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2017 at 11:51:59AM -0600, Alan Tull wrote:
> On Tue, Oct 31, 2017 at 9:22 PM, Alan Tull <atull@kernel.org> wrote:
>=20
> Any further comments on v5?  I'm getting ready to send v6.  If I do it
> today, most of these patches will have no changes (again), the only
> changes will be in the patches that move drvdata out of the common
> code.
>=20
> I've gone to a lot of trouble to break out functional patches to make
> them easy to review and to keep what I was trying to accomplish clear
> here.  I think this stuff is necessary going forward.  If this stuff
> doesn't have errors, let's move forward and make whatever changes we
> want to make on top of this.

Sounds good, haven't found anything else. Sorry for dropping the ball.
>=20
> > On Tue, Oct 31, 2017 at 8:34 PM, Moritz Fischer <mdf@kernel.org> wrote:
> >> On Tue, Oct 31, 2017 at 04:45:54PM -0500, Alan Tull wrote:
> >>> On Tue, Oct 31, 2017 at 3:59 PM, Moritz Fischer <mdf@kernel.org> wrot=
e:
> >>> > On Tue, Oct 31, 2017 at 08:42:14PM +0000, Alan Tull wrote:
> >>> >> Changes to the fpga manager code to not use drvdata in common
> >>> >> code.
> >>> >>
> >>> >> Change fpga_mgr_register to not set or use drvdata.
> >>> >>
> >>> >> Change the register/unregister function parameters to take the mgr
> >>> >> struct:
> >>> >> * int fpga_mgr_register(struct device *dev,
> >>> >>                         struct fpga_manager *mgr);
> >>> >> * void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>> >>
> >>> >> Change the drivers that call fpga_mgr_register to alloc the struct
> >>> >> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
> >>> >> ops, and priv.
> >>> >>
> >>> >> The rationale is that setting drvdata is fine for DT based devices
> >>> >> that will have one manager, bridge, or region per platform device.
> >>> >> However PCIe based devices may have multiple FPGA mgr/bridge/regio=
ns
> >>> >> under one pcie device.  Without these changes, the PCIe solution h=
as
> >>> >> to create an extra device for each child mgr/bridge/region to hold
> >>> >> drvdata.
> >>> >
> >>> > This looks very common, in fact several subsystems provide this two=
 step
> >>> > way of registering things.
> >>> >
> >>> > - Allocate fpga_mgr via fpga_mgr_alloc() where you pass in the size=
 of
> >>> >   the private data
> >>> > - Fill in some fields
> >>> > - fpga_mgr_register() where you pass in the fpga_mgr as suggested
> >>> >
> >>> > See for example the alloc_etherdev() for ethernet devices.
> >>> >
> >>>
> >>> Yes, I considered it when I was writing this.  I've seen it both ways.
> >>> In the case you mention, they've got reasons they absolutely needed to
> >>> do it that way.  alloc_etherdev() calls eventually to
> >>> alloc_netdev_mqs() which is about 100 lines of alloc'ing and
> >>> initializing a network device struct.
> >>
> >> Yeah, sure. I looked around some more. Other subsystems just alloc
> >> manually, seems fine with me.
> >>>
> >>> > The benefit of the API you proposed is that one could embed the fpg=
a_mgr
> >>> > struct inside of another struct and get to the container via
> >>> > container_of() I guess ...
> >>>
> >>> Yes, let's keep it simple for now, as that gives us greater
> >>> flexibility.  We can add alloc functions when it becomes clear that it
> >>> won't get in the way of someone's use.
> >>
> >> Agreed.
> >>>
> >>> Alan
> >>>
> >>> >
> >>> >>
> >>> >> Signed-off-by: Alan Tull <atull@kernel.org>
> >>> >> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
> >>> >> ---
> >>> >>  Documentation/fpga/fpga-mgr.txt  | 23 ++++++++++++++++-------
> >>> >>  drivers/fpga/altera-cvp.c        | 17 +++++++++++++----
> >>> >>  drivers/fpga/altera-pr-ip-core.c | 16 ++++++++++++++--
> >>> >>  drivers/fpga/altera-ps-spi.c     | 17 ++++++++++++++---
> >>> >>  drivers/fpga/fpga-mgr.c          | 28 +++++++---------------------
> >>> >>  drivers/fpga/ice40-spi.c         | 19 +++++++++++++++----
> >>> >>  drivers/fpga/socfpga-a10.c       | 15 ++++++++++++---
> >>> >>  drivers/fpga/socfpga.c           | 17 ++++++++++++++---
> >>> >>  drivers/fpga/ts73xx-fpga.c       | 17 ++++++++++++++---
> >>> >>  drivers/fpga/xilinx-spi.c        | 17 ++++++++++++++---
> >>> >>  drivers/fpga/zynq-fpga.c         | 15 ++++++++++++---
> >>> >>  include/linux/fpga/fpga-mgr.h    |  6 ++----
> >>> >>  12 files changed, 147 insertions(+), 60 deletions(-)
> >>> >>
> >>> >> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/=
fpga-mgr.txt
> >>> >> index cc6413e..7e5e5c8 100644
> >>> >> --- a/Documentation/fpga/fpga-mgr.txt
> >>> >> +++ b/Documentation/fpga/fpga-mgr.txt
> >>> >> @@ -67,11 +67,9 @@ fpga_mgr_unlock when done programming the FPGA.
> >>> >>  To register or unregister the low level FPGA-specific driver:
> >>> >>  -------------------------------------------------------------
> >>> >>
> >>> >> -     int fpga_mgr_register(struct device *dev, const char *name,
> >>> >> -                           const struct fpga_manager_ops *mops,
> >>> >> -                           void *priv);
> >>> >> +     int fpga_mgr_register(struct device *dev, struct fpga_manage=
r *mgr);
> >>
> >> At that point you could also just give the struct fpga_manager a
> >> ->parent or ->dev that you populate with &pdev->dev or &spi->dev etc i=
nstead of
> >> making it a separate parameter, this makes an odd mix of half and half=
 here.
> >
> > Yes, I'd have to call it parent as dev is taken.  I also noticed that
> > I forgot to edit the function parameter documentation in the c file.
> >
> >>> >>
> >>> >> -     void fpga_mgr_unregister(struct device *dev);
> >>> >> +     void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>> >>
> >>> >>  Use of these two functions is described below in "How To Support =
a new FPGA
> >>> >>  device."
> >>> >> @@ -148,8 +146,13 @@ static int socfpga_fpga_probe(struct platform=
_device *pdev)
> >>> >>  {
> >>> >>       struct device *dev =3D &pdev->dev;
> >>> >>       struct socfpga_fpga_priv *priv;
> >>> >> +     struct fpga_manager *mgr;
> >>> >>       int ret;
> >>> >>
> >>> >> +     mgr =3D devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
> >>> >> +     if (!mgr)
> >>> >> +             return -ENOMEM;
> >>> >> +
> >>> >>       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>> >>       if (!priv)
> >>> >>               return -ENOMEM;
> >>> >> @@ -157,13 +160,19 @@ static int socfpga_fpga_probe(struct platfor=
m_device *pdev)
> >>> >>       /* ... do ioremaps, get interrupts, etc. and save
> >>> >>          them in priv... */
> >>> >>
> >>> >> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> >>> >> -                              &socfpga_fpga_ops, priv);
> >>> >> +     mgr->name =3D "Altera SOCFPGA FPGA Manager";
> >>> >> +     mgr->mops =3D &socfpga_fpga_ops;
> >>> >> +     mgr->priv =3D priv;
> >> Like here: mgr->dev =3D &pdev->dev
> >
> > Yes, good catch.  By the way, I pushed these patches on a branch to
> > linux-fpga (branch name is review-v4.14-rc7-non-dt-support-v5.1).
> >
> > Thanks for reviewing,
> > Alan
> >
> >>
> >>> >> +     platform_set_drvdata(pdev, mgr);
> >>> >> +
> >>> >> +     return fpga_mgr_register(dev, mgr);
> >>> >>  }

Cheers,

Moritz

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEowQ4eJSlIZpNWnl2UVwKRFcJcNgFAloJ5Q8ACgkQUVwKRFcJ
cNhv2wgAqsdNdg0q80ncLtuMHH7nc4cw5uS0belzN+AG28yykxtxVf891G5m4jts
QEPeA97lMcBDPpTUgikbDsMUoRICqyjQVDJatbHPltqWckiJ8zZVmaq087EZO4JS
IdWxtXRVCGdqSaze9IB9axW0RgOEZDN17o3aRnRrOMslTM2fJuAQa1kIcmuTvT50
0VW8N3vxxVgxE4geSwCgurd3VWoWuN3HJF0CKLXj1sQY98cTBWQ1Cdyi+q2klWiL
sPKEXHh9js8A906UREhmqdU95ZWiVo+j7u3MMV5vJHzvISoT/jcS6vHDbmugbRj1
gAiYpzAdgpBrA9+EQInv4JcLxb1pfQ==
=vNKp
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
