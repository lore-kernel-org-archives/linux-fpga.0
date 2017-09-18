Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=atEN=AT=ettus.com=moritz.fischer@kernel.org>
Date: Mon, 18 Sep 2017 15:04:13 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [RFC] fpga: region: Move spinlock for bridge_list into region
Message-ID: <20170918220413.GB21015@tyrael.ni.corp.natinst.com>
References: <20170918203404.17502-1-mdf@kernel.org>
 <CANk1AXSGXfJ6Jicfw6ho3SJC6kQSye3z1kE8HJZZz9wq+X0e7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <CANk1AXSGXfJ6Jicfw6ho3SJC6kQSye3z1kE8HJZZz9wq+X0e7Q@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-ID: <linux-fpga@vger.kernel.org>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 04:00:47PM -0500, Alan Tull wrote:
> On Mon, Sep 18, 2017 at 3:34 PM, Moritz Fischer <mdf@kernel.org> wrote:
>=20
> Hi Moritz,
>=20
> > Instead of using a single (global) spinlock for all bridge lists use a
> > spinlock per list inside the containing fpga region.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >
> > Hi all,
> >
> > maybe I do misunderstand something fundamental here ;-) In that case,
> > please explain. In my understanding the current version works, because
> > it is more defensive, but is there a reason we need to make access to
> > any of the bridge lists exclusive?
>=20
> I think you are basically right here.  Moving the spinlock to the
> region is correct.  When you do your final version of this, could you
> just have it apply on top of this current patchset?  That will save me
> a lot of rebasing.

Yeah can resubmit on top of your current series if you prefer that.

Moritz
>=20
> Alan
>=20
> >
> > Cheers,
> > Moritz
> >
> > PS: Not fully happy with this patch, but wanted to figure out first if
> > this I'm wrong conceptually
> >
> > ---
> >  drivers/fpga/fpga-bridge.c | 5 ++---
> >  drivers/fpga/fpga-region.c | 6 ++++++
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> > index 9651aa56244a..b03ec59448e2 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -214,6 +214,8 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
> >   *
> >   * Get an exclusive reference to the bridge and and it to the list.
> >   *
> > + * Must be called with list lock held.
> > + *
> >   * Return 0 for success, error code from of_fpga_bridge_get() othewise.
> >   */
> >  int fpga_bridge_get_to_list(struct device_node *np,
> > @@ -221,15 +223,12 @@ int fpga_bridge_get_to_list(struct device_node *n=
p,
> >                             struct list_head *bridge_list)
> >  {
> >         struct fpga_bridge *bridge;
> > -       unsigned long flags;
> >
> >         bridge =3D of_fpga_bridge_get(np, info);
> >         if (IS_ERR(bridge))
> >                 return PTR_ERR(bridge);
> >
> > -       spin_lock_irqsave(&bridge_list_lock, flags);
> >         list_add(&bridge->node, bridge_list);
> > -       spin_unlock_irqrestore(&bridge_list_lock, flags);
> >
> >         return 0;
> >  }
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index 3b6b2f4182a1..c5c958e0e601 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -37,6 +37,7 @@ struct fpga_region {
> >         struct device dev;
> >         struct mutex mutex; /* for exclusive reference to region */
> >         struct list_head bridge_list;
> > +       spinlock_t bridge_list_lock; /* protects access to bridge list =
*/
> >         struct fpga_image_info *info;
> >  };
> >
> > @@ -180,11 +181,15 @@ static int fpga_region_get_bridges(struct fpga_re=
gion *region,
> >         struct device *dev =3D &region->dev;
> >         struct device_node *region_np =3D dev->of_node;
> >         struct device_node *br, *np, *parent_br =3D NULL;
> > +       unsigned long flags;
> >         int i, ret;
> >
> >         /* If parent is a bridge, add to list */
> > +       spin_lock_irqsave(&region->bridge_list_lock, flags);
> >         ret =3D fpga_bridge_get_to_list(region_np->parent, region->info,
> >                                       &region->bridge_list);
> > +       spin_unlock_irqrestore(&region->bridge_list_lock, flags);
> > +
> >         if (ret =3D=3D -EBUSY)
> >                 return ret;
> >
> > @@ -508,6 +513,7 @@ static int fpga_region_probe(struct platform_device=
 *pdev)
> >
> >         mutex_init(&region->mutex);
> >         INIT_LIST_HEAD(&region->bridge_list);
> > +       spin_lock_init(&region->bridge_list_lock);
> >
> >         device_initialize(&region->dev);
> >         region->dev.class =3D fpga_region_class;
> > --
> > 2.14.1
> >

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcxjJBP2M15CncZ7vkIQd6kWqi8FAlnAQtkACgkQvkIQd6kW
qi9/6QgA8H41rTRUqjcwPmY/IG5F/TquelC+tRmja0UaOmidIcslnIC9pQEXIbp0
1jOjCeZNdXqWWHRunWCF7Gf0qJkWjU1iBOZ5/juY+0S7xeneGgDdrvi5EzMeoINg
5NKI/dZpjIHlPzimNos5WzqVQTdiDRr99iYjpxt3OPMDZ6lpBEhxpQ1xj+WzLYjM
RdS5aufwcaBSrs808yqJJmhjnPvH9fLU04KK6xrfqbod8Vx2j48dyv22W95DjQXz
6EfBin5ICpPEp3VdP2zTjiYOg/fi/KIkiXzx3ipi1vIANQ5Zdagt3us99zDRe1Zh
rjrlKBoItb+lalulMvRDcBc4JljoKw==
=mC/f
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
