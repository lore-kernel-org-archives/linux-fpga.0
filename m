Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <1537978342-17697-1-git-send-email-atull@kernel.org>
 <1537978342-17697-3-git-send-email-atull@kernel.org> <OFE9B73D95.73C2CEF2-ONC1258314.005AEBC6-C1258314.005C6433@zodiacaerospace.com>
In-Reply-To: <OFE9B73D95.73C2CEF2-ONC1258314.005AEBC6-C1258314.005C6433@zodiacaerospace.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 26 Sep 2018 15:13:52 -0500
Message-ID: <CANk1AXTOqQQ5QycZiKpw=Rv8dY9njbah4bN-xb9Ty9UCONrKyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] fpga: bridge: add devm_fpga_bridge_create
Content-Type: multipart/mixed; boundary="000000000000a1a4c40576cbde04"
To: Eric.Delage@zodiacaerospace.com
Cc: Jonathan Corbet <corbet@lwn.net>, Federico Vaga <federico.vaga@cern.ch>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-fpga-owner@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
List-ID: <linux-fpga@vger.kernel.org>

--000000000000a1a4c40576cbde04
Content-Type: multipart/alternative; boundary="000000000000a1a4c30576cbde02"

--000000000000a1a4c30576cbde02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 12:21 PM <Eric.Delage@zodiacaerospace.com> wrote:

Hi Eric,

Est-ce que je comprends bien qu'il ne s'agit que d'une carte de traitement
> FPGA sans possibilit=C3=A9 de mettre une carte-fille type FMA (=C3=A0 la =
REFLEX CES
> avec sa carte acc=C3=A9l=C3=A9ratrice FPGA) ?
>

IIUC your question is about specific boards.  These changes I posted are
for a subsystem with support for various FPGA devices.  This is not code
that is specific to any one board.

We can have a better discussion if we could stick to English, please.

Alan


> 4 XCKU115 pour les russes equiv. 2 cartes FPGA Xilinx avec des VU37P. Env=
.
> de d=C3=A9veloppement SDAccel identique mais fait plut=C3=B4t pour =C3=AA=
tre utilis=C3=A9 en
> acc=C3=A9l=C3=A9rateur.
> L'approche carte LB2P1/XCKU040-060 + carte FPGA est amha =C3=A0 investigu=
er
> s=C3=A9rieusement.
>
> Kind Regards,
> Mit freundlichen Gr=C3=BCssen,
> Sinc=C3=A8res Salutations,
>
> *ZODIAC DATA SYSTEMS ZODIAC AEROSYSTEMS*
> Control Systems Division [image: logo]
>
> * Eric DELAGE*
> Head of the Monitoring Front-End Group, and
> Technical Product Manager for IFoIP and RF2P(CIe) Solutions
>
> Campus EffiScience - 5 Esplanade Anton Philips - 14460 Colombelles - Fran=
ce
> Tel: +33.2.31.29.49.45 - Fax: +33.2.31.80.65.49
> eric.delage@zodiacaerospace.com <Eric.DELAGE@ZodiacAerospace.Com>
> http://www.zodiacaerospace.com
> http://www.linkedin.com/in/ericdelage
>
>
>
>
> De :        Alan Tull <atull@kernel.org>
> A :        Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <
> corbet@lwn.net>
> Cc :        Randy Dunlap <rdunlap@infradead.org>, Federico Vaga <
> federico.vaga@cern.ch>, linux-kernel@vger.kernel.org,
> linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <
> atull@kernel.org>
> Date :        26/09/2018 18:13
> Objet :        [PATCH v3 2/4] fpga: bridge: add devm_fpga_bridge_create
> Envoy=C3=A9 par :        linux-fpga-owner@vger.kernel.org
> ------------------------------
>
>
>
> Add devm_fpga_bridge_create() which is the managed
> version of fpga_bridge_create().
>
> Change current bridge drivers to use
> devm_fpga_bridge_create().
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Suggested-by: Federico Vaga <federico.vaga@cern.ch>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: add suggested-by
> v3: remove some unclear documentation about fpga_bridge_unregister
>    add Acked-by
> ---
> Documentation/driver-api/fpga/fpga-bridge.rst |  3 ++
> drivers/fpga/altera-fpga2sdram.c              |  8 ++--
> drivers/fpga/altera-freeze-bridge.c           | 13 ++---
> drivers/fpga/altera-hps2fpga.c                |  7 ++-
> drivers/fpga/dfl-fme-br.c                     | 11 ++---
> drivers/fpga/fpga-bridge.c                    | 68
> +++++++++++++++++++++++----
> drivers/fpga/xilinx-pr-decoupler.c            |  4 +-
> include/linux/fpga/fpga-bridge.h              |  4 ++
> 8 files changed, 80 insertions(+), 38 deletions(-)
>
> diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst
> b/Documentation/driver-api/fpga/fpga-bridge.rst
> index 2c2aaca..ebbcbde 100644
> --- a/Documentation/driver-api/fpga/fpga-bridge.rst
> +++ b/Documentation/driver-api/fpga/fpga-bridge.rst
> @@ -11,6 +11,9 @@ API to implement a new FPGA bridge
>    :functions: fpga_bridge_ops
>
> .. kernel-doc:: drivers/fpga/fpga-bridge.c
> +   :functions: devm_fpga_bridge_create
> +
> +.. kernel-doc:: drivers/fpga/fpga-bridge.c
>    :functions: fpga_bridge_create
>
> .. kernel-doc:: drivers/fpga/fpga-bridge.c
> diff --git a/drivers/fpga/altera-fpga2sdram.c
> b/drivers/fpga/altera-fpga2sdram.c
> index 23660cc..a78e49c 100644
> --- a/drivers/fpga/altera-fpga2sdram.c
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -121,18 +121,16 @@ static int alt_fpga_bridge_probe(struct
> platform_device *pdev)
>                  /* Get f2s bridge configuration saved in handoff registe=
r
> */
>                  regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask)=
;
>
> -                 br =3D fpga_bridge_create(dev, F2S_BRIDGE_NAME,
> -
>  &altera_fpga2sdram_br_ops, priv);
> +                 br =3D devm_fpga_bridge_create(dev, F2S_BRIDGE_NAME,
> +
> &altera_fpga2sdram_br_ops, priv);
>                  if (!br)
>                                   return -ENOMEM;
>
>                  platform_set_drvdata(pdev, br);
>
>                  ret =3D fpga_bridge_register(br);
> -                 if (ret) {
> -                                  fpga_bridge_free(br);
> +                 if (ret)
>                                   return ret;
> -                 }
>
>                  dev_info(dev, "driver initialized with handoff %08x\n",
> priv->mask);
>
> diff --git a/drivers/fpga/altera-freeze-bridge.c
> b/drivers/fpga/altera-freeze-bridge.c
> index ffd586c..dd58c4a 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -213,7 +213,6 @@ static int altera_freeze_br_probe(struct
> platform_device *pdev)
>                  struct fpga_bridge *br;
>                  struct resource *res;
>                  u32 status, revision;
> -                 int ret;
>
>                  if (!np)
>                                   return -ENODEV;
> @@ -245,20 +244,14 @@ static int altera_freeze_br_probe(struct
> platform_device *pdev)
>
>                  priv->base_addr =3D base_addr;
>
> -                 br =3D fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
> -
>  &altera_freeze_br_br_ops, priv);
> +                 br =3D devm_fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
> +
> &altera_freeze_br_br_ops, priv);
>                  if (!br)
>                                   return -ENOMEM;
>
>                  platform_set_drvdata(pdev, br);
>
> -                 ret =3D fpga_bridge_register(br);
> -                 if (ret) {
> -                                  fpga_bridge_free(br);
> -                                  return ret;
> -                 }
> -
> -                 return 0;
> +                 return fpga_bridge_register(br);
> }
>
> static int altera_freeze_br_remove(struct platform_device *pdev)
> diff --git a/drivers/fpga/altera-hps2fpga.c
> b/drivers/fpga/altera-hps2fpga.c
> index a974d3f..77b95f2 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -180,7 +180,8 @@ static int alt_fpga_bridge_probe(struct
> platform_device *pdev)
>                                   }
>                  }
>
> -                 br =3D fpga_bridge_create(dev, priv->name,
> &altera_hps2fpga_br_ops, priv);
> +                 br =3D devm_fpga_bridge_create(dev, priv->name,
> +
> &altera_hps2fpga_br_ops, priv);
>                  if (!br) {
>                                   ret =3D -ENOMEM;
>                                   goto err;
> @@ -190,12 +191,10 @@ static int alt_fpga_bridge_probe(struct
> platform_device *pdev)
>
>                  ret =3D fpga_bridge_register(br);
>                  if (ret)
> -                                  goto err_free;
> +                                  goto err;
>
>                  return 0;
>
> -err_free:
> -                 fpga_bridge_free(br);
> err:
>                  clk_disable_unprepare(priv->clk);
>
> diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
> index 7cc041d..3ff9f3a 100644
> --- a/drivers/fpga/dfl-fme-br.c
> +++ b/drivers/fpga/dfl-fme-br.c
> @@ -61,7 +61,6 @@ static int fme_br_probe(struct platform_device *pdev)
>                  struct device *dev =3D &pdev->dev;
>                  struct fme_br_priv *priv;
>                  struct fpga_bridge *br;
> -                 int ret;
>
>                  priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>                  if (!priv)
> @@ -69,18 +68,14 @@ static int fme_br_probe(struct platform_device *pdev)
>
>                  priv->pdata =3D dev_get_platdata(dev);
>
> -                 br =3D fpga_bridge_create(dev, "DFL FPGA FME Bridge",
> -
>  &fme_bridge_ops, priv);
> +                 br =3D devm_fpga_bridge_create(dev, "DFL FPGA FME Bridg=
e",
> +
> &fme_bridge_ops, priv);
>                  if (!br)
>                                   return -ENOMEM;
>
>                  platform_set_drvdata(pdev, br);
>
> -                 ret =3D fpga_bridge_register(br);
> -                 if (ret)
> -                                  fpga_bridge_free(br);
> -
> -                 return ret;
> +                 return fpga_bridge_register(br);
> }
>
> static int fme_br_remove(struct platform_device *pdev)
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index c983dac..80bd8f1 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -324,6 +324,9 @@ ATTRIBUTE_GROUPS(fpga_bridge);
>  * @br_ops:                 pointer to structure of fpga bridge ops
>  * @priv:                 FPGA bridge private data
>  *
> + * The caller of this function is responsible for freeing the bridge wit=
h
> + * fpga_bridge_free().  Using devm_fpga_bridge_create() instead is
> recommended.
> + *
>  * Return: struct fpga_bridge or NULL
>  */
> struct fpga_bridge *fpga_bridge_create(struct device *dev, const char
> *name,
> @@ -378,8 +381,8 @@ struct fpga_bridge *fpga_bridge_create(struct device
> *dev, const char *name,
> EXPORT_SYMBOL_GPL(fpga_bridge_create);
>
> /**
> - * fpga_bridge_free - free a fpga bridge and its id
> - * @bridge:                 FPGA bridge struct created by
> fpga_bridge_create
> + * fpga_bridge_free - free a fpga bridge created by fpga_bridge_create()
> + * @bridge:                 FPGA bridge struct
>  */
> void fpga_bridge_free(struct fpga_bridge *bridge)
> {
> @@ -388,9 +391,56 @@ void fpga_bridge_free(struct fpga_bridge *bridge)
> }
> EXPORT_SYMBOL_GPL(fpga_bridge_free);
>
> +static void devm_fpga_bridge_release(struct device *dev, void *res)
> +{
> +                 struct fpga_bridge *bridge =3D *(struct fpga_bridge **)=
res;
> +
> +                 fpga_bridge_free(bridge);
> +}
> +
> /**
> - * fpga_bridge_register - register a fpga bridge
> - * @bridge:                 FPGA bridge struct created by
> fpga_bridge_create
> + * devm_fpga_bridge_create - create and init a managed struct fpga_bridg=
e
> + * @dev:                 FPGA bridge device from pdev
> + * @name:                 FPGA bridge name
> + * @br_ops:                 pointer to structure of fpga bridge ops
> + * @priv:                 FPGA bridge private data
> + *
> + * This function is intended for use in a FPGA bridge driver's probe
> function.
> + * After the bridge driver creates the struct with
> devm_fpga_bridge_create(), it
> + * should register the bridge with fpga_bridge_register().  The bridge
> driver's
> + * remove function should call fpga_bridge_unregister().  The bridge
> struct
> + * allocated with this function will be freed automatically on driver
> detach.
> + * This includes the case of a probe function returning error before
> calling
> + * fpga_bridge_register(), the struct will still get cleaned up.
> + *
> + *  Return: struct fpga_bridge or NULL
> + */
> +struct fpga_bridge
> +*devm_fpga_bridge_create(struct device *dev, const char *name,
> +                                                    const struct
> fpga_bridge_ops *br_ops, void *priv)
> +{
> +                 struct fpga_bridge **ptr, *bridge;
> +
> +                 ptr =3D devres_alloc(devm_fpga_bridge_release,
> sizeof(*ptr), GFP_KERNEL);
> +                 if (!ptr)
> +                                  return NULL;
> +
> +                 bridge =3D fpga_bridge_create(dev, name, br_ops, priv);
> +                 if (!bridge) {
> +                                  devres_free(ptr);
> +                 } else {
> +                                  *ptr =3D bridge;
> +                                  devres_add(dev, ptr);
> +                 }
> +
> +                 return bridge;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_bridge_create);
> +
> +/**
> + * fpga_bridge_register - register a FPGA bridge
> + *
> + * @bridge: FPGA bridge struct
>  *
>  * Return: 0 for success, error code otherwise.
>  */
> @@ -412,8 +462,11 @@ int fpga_bridge_register(struct fpga_bridge *bridge)
> EXPORT_SYMBOL_GPL(fpga_bridge_register);
>
> /**
> - * fpga_bridge_unregister - unregister and free a fpga bridge
> - * @bridge:                 FPGA bridge struct created by
> fpga_bridge_create
> + * fpga_bridge_unregister - unregister a FPGA bridge
> + *
> + * @bridge: FPGA bridge struct
> + *
> + * This function is intended for use in a FPGA bridge driver's remove
> function.
>  */
> void fpga_bridge_unregister(struct fpga_bridge *bridge)
> {
> @@ -430,9 +483,6 @@ EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
>
> static void fpga_bridge_dev_release(struct device *dev)
> {
> -                 struct fpga_bridge *bridge =3D to_fpga_bridge(dev);
> -
> -                 fpga_bridge_free(bridge);
> }
>
> static int __init fpga_bridge_dev_init(void)
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c
> b/drivers/fpga/xilinx-pr-decoupler.c
> index 07ba153..6410361 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -121,8 +121,8 @@ static int xlnx_pr_decoupler_probe(struct
> platform_device *pdev)
>
>                  clk_disable(priv->clk);
>
> -                 br =3D fpga_bridge_create(&pdev->dev, "Xilinx PR
> Decoupler",
> -
>  &xlnx_pr_decoupler_br_ops, priv);
> +                 br =3D devm_fpga_bridge_create(&pdev->dev, "Xilinx PR
> Decoupler",
> +
> &xlnx_pr_decoupler_br_ops, priv);
>                  if (!br) {
>                                   err =3D -ENOMEM;
>                                   goto err_clk;
> diff --git a/include/linux/fpga/fpga-bridge.h
> b/include/linux/fpga/fpga-bridge.h
> index ce550fc..817600a 100644
> --- a/include/linux/fpga/fpga-bridge.h
> +++ b/include/linux/fpga/fpga-bridge.h
> @@ -69,4 +69,8 @@ void fpga_bridge_free(struct fpga_bridge *br);
> int fpga_bridge_register(struct fpga_bridge *br);
> void fpga_bridge_unregister(struct fpga_bridge *br);
>
> +struct fpga_bridge
> +*devm_fpga_bridge_create(struct device *dev, const char *name,
> +                                                    const struct
> fpga_bridge_ops *br_ops, void *priv);
> +
> #endif /* _LINUX_FPGA_BRIDGE_H */
> --
> 2.7.4
>
>
>

--000000000000a1a4c30576cbde02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><span style=3D"font-family:Arial,Helvetica,sans-serif">On Wed,=
 Sep 26, 2018 at 12:21 PM &lt;<a href=3D"mailto:Eric.Delage@zodiacaerospace=
.com" target=3D"_blank">Eric.Delage@zodiacaerospace.com</a>&gt; wrote:</spa=
n><br></div><div class=3D"gmail_quote"><div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-family:monospace,monospace">Hi Eric,</div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><font size=3D"2" face=3D"sans-serif">E=
st-ce que je comprends bien qu&#39;il ne s&#39;agit
que d&#39;une carte de traitement FPGA sans possibilit=C3=A9 de mettre une =
carte-fille
type FMA (=C3=A0 la REFLEX CES avec sa carte acc=C3=A9l=C3=A9ratrice FPGA) =
?</font>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">IIUC your question is about specific board=
s.=C2=A0 These changes I posted are for a subsystem with support for variou=
s FPGA devices.=C2=A0 This is not code that is specific to any one board.</=
div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
<br></div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace">We can have a better discussion if we could stick to English, please.=
=C2=A0=C2=A0<br></div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">Alan</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><font size=3D"2" face=3D"sans-serif">4 XCKU115 pour les russe=
s equiv. 2 cartes
FPGA Xilinx avec des VU37P. Env. de d=C3=A9veloppement SDAccel identique ma=
is
fait plut=C3=B4t pour =C3=AAtre utilis=C3=A9 en acc=C3=A9l=C3=A9rateur.</fo=
nt>
<br><font size=3D"2" face=3D"sans-serif">L&#39;approche carte LB2P1/XCKU040=
-060 +
carte FPGA est amha =C3=A0 investiguer s=C3=A9rieusement.</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">Kind Regards,</font>
<br><font size=3D"2" face=3D"sans-serif">Mit freundlichen Gr=C3=BCssen,</fo=
nt>
<br><font size=3D"2" face=3D"sans-serif">Sinc=C3=A8res Salutations,</font>
<br>
<table width=3D"425" style=3D"border-collapse:collapse">
<tbody><tr height=3D"8">
<td width=3D"289" style=3D"border-style:none none none none;border-color:#0=
00000;border-width:0px 0px 0px 0px;padding:1px 1px"><font size=3D"1" color=
=3D"#808080" face=3D"Arial"><b><u>ZODIAC
DATA SYSTEMS</u><br>
ZODIAC AEROSYSTEMS</b><br>
Control Systems Division</font>
</td><td width=3D"132" style=3D"border-style:none none none none;border-col=
or:#000000;border-width:0px 0px 0px 0px;padding:1px 1px"><img align=3D"righ=
t" alt=3D"logo" style=3D"border:0px solid">
</td></tr><tr height=3D"8">
<td width=3D"423" colspan=3D"2" style=3D"border-style:none none none none;b=
order-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px"><font siz=
e=3D"1" face=3D"Arial"><b><br>
Eric DELAGE</b><br>
Head of the Monitoring Front-End Group, and</font>
<br><font size=3D"1" face=3D"Arial">Technical Product Manager for IFoIP and=
 RF2P(CIe)
Solutions</font>
</td></tr><tr height=3D"8">
<td width=3D"423" colspan=3D"2" style=3D"border-style:none none none none;b=
order-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px"><font siz=
e=3D"1" color=3D"#808080" face=3D"Arial"><br>
Campus EffiScience - 5 Esplanade Anton Philips - 14460 Colombelles - France=
<br>
Tel: +33.2.31.29.49.45 - Fax: +33.2.31.80.65.49</font>
<br><a href=3D"mailto:Eric.DELAGE@ZodiacAerospace.Com" target=3D"_blank"><f=
ont size=3D"1" color=3D"#808080" face=3D"Arial">eric.delage@zodiacaerospace=
.com</font></a>
<br><a><font size=3D"1" color=3D"#808080" face=3D"Arial">http://www.zodiaca=
erospace.com</font></a>
<br><a href=3D"http://www.linkedin.com/in/ericdelage" target=3D"_blank"><fo=
nt size=3D"1" color=3D"blue" face=3D"Arial">http://www.linkedin.com/in/eric=
delage</font></a></td></tr></tbody></table>
<br>
<br>
<br>
<br>
<br><font size=3D"1" color=3D"#5f5f5f" face=3D"sans-serif">De : =C2=A0 =C2=
=A0 =C2=A0
=C2=A0</font><font size=3D"1" face=3D"sans-serif">Alan Tull &lt;<a href=3D"=
mailto:atull@kernel.org" target=3D"_blank">atull@kernel.org</a>&gt;</font>
<br><font size=3D"1" color=3D"#5f5f5f" face=3D"sans-serif">A : =C2=A0 =C2=
=A0 =C2=A0
=C2=A0</font><font size=3D"1" face=3D"sans-serif">Moritz Fischer &lt;<a hre=
f=3D"mailto:mdf@kernel.org" target=3D"_blank">mdf@kernel.org</a>&gt;,
Jonathan Corbet &lt;<a href=3D"mailto:corbet@lwn.net" target=3D"_blank">cor=
bet@lwn.net</a>&gt;</font>
<br><font size=3D"1" color=3D"#5f5f5f" face=3D"sans-serif">Cc=C2=A0: =C2=A0=
 =C2=A0
=C2=A0 =C2=A0</font><font size=3D"1" face=3D"sans-serif">Randy Dunlap
&lt;<a href=3D"mailto:rdunlap@infradead.org" target=3D"_blank">rdunlap@infr=
adead.org</a>&gt;, Federico Vaga &lt;<a href=3D"mailto:federico.vaga@cern.c=
h" target=3D"_blank">federico.vaga@cern.ch</a>&gt;,
<a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank">linux-ker=
nel@vger.kernel.org</a>, <a href=3D"mailto:linux-fpga@vger.kernel.org" targ=
et=3D"_blank">linux-fpga@vger.kernel.org</a>, <a href=3D"mailto:linux-doc@v=
ger.kernel.org" target=3D"_blank">linux-doc@vger.kernel.org</a>,
Alan Tull &lt;<a href=3D"mailto:atull@kernel.org" target=3D"_blank">atull@k=
ernel.org</a>&gt;</font>
<br><font size=3D"1" color=3D"#5f5f5f" face=3D"sans-serif">Date : =C2=A0 =
=C2=A0 =C2=A0
=C2=A0</font><font size=3D"1" face=3D"sans-serif">26/09/2018 18:13</font>
<br><font size=3D"1" color=3D"#5f5f5f" face=3D"sans-serif">Objet : =C2=A0 =
=C2=A0
=C2=A0 =C2=A0</font><font size=3D"1" face=3D"sans-serif">[PATCH v3 2/4]
fpga: bridge: add devm_fpga_bridge_create</font>
<br><font size=3D"1" color=3D"#5f5f5f" face=3D"sans-serif">Envoy=C3=A9 par =
: =C2=A0 =C2=A0
=C2=A0 =C2=A0</font><font size=3D"1" face=3D"sans-serif"><a href=3D"mailto:=
linux-fpga-owner@vger.kernel.org" target=3D"_blank">linux-fpga-owner@vger.k=
ernel.org</a></font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D"2">Add devm_fpga_bridge_create() which is the managed=
<br>
version of fpga_bridge_create().<br>
<br>
Change current bridge drivers to use<br>
devm_fpga_bridge_create().<br>
<br>
Signed-off-by: Alan Tull &lt;<a href=3D"mailto:atull@kernel.org" target=3D"=
_blank">atull@kernel.org</a>&gt;<br>
Suggested-by: Federico Vaga &lt;<a href=3D"mailto:federico.vaga@cern.ch" ta=
rget=3D"_blank">federico.vaga@cern.ch</a>&gt;<br>
Acked-by: Moritz Fischer &lt;<a href=3D"mailto:mdf@kernel.org" target=3D"_b=
lank">mdf@kernel.org</a>&gt;<br>
---<br>
v2: add suggested-by<br>
v3: remove some unclear documentation about fpga_bridge_unregister<br>
 =C2=A0 =C2=A0add Acked-by<br>
---<br>
 Documentation/driver-api/fpga/fpga-bridge.rst | =C2=A03 ++<br>
 drivers/fpga/altera-fpga2sdram.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0| =C2=A08 ++--<br>
 drivers/fpga/altera-freeze-bridge.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
| 13 ++---<br>
 drivers/fpga/altera-hps2fpga.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0| =C2=A07 ++-<br>
 drivers/fpga/dfl-fme-br.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 | 11 ++---<br>
 drivers/fpga/fpga-bridge.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
=C2=A0 =C2=A0 =C2=A0| 68 +++++++++++++++++++++++----<br>
 drivers/fpga/xilinx-pr-decoupler.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0| =C2=A04 +-<br>
 include/linux/fpga/fpga-bridge.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0| =C2=A04 ++<br>
 8 files changed, 80 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/=
driver-api/fpga/fpga-bridge.rst<br>
index 2c2aaca..ebbcbde 100644<br>
--- a/Documentation/driver-api/fpga/fpga-bridge.rst<br>
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst<br>
@@ -11,6 +11,9 @@ API to implement a new FPGA bridge<br>
 =C2=A0 =C2=A0:functions: fpga_bridge_ops<br>
 <br>
 .. kernel-doc:: drivers/fpga/fpga-bridge.c<br>
+ =C2=A0 :functions: devm_fpga_bridge_create<br>
+<br>
+.. kernel-doc:: drivers/fpga/fpga-bridge.c<br>
 =C2=A0 =C2=A0:functions: fpga_bridge_create<br>
 <br>
 .. kernel-doc:: drivers/fpga/fpga-bridge.c<br>
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sd=
ram.c<br>
index 23660cc..a78e49c 100644<br>
--- a/drivers/fpga/altera-fpga2sdram.c<br>
+++ b/drivers/fpga/altera-fpga2sdram.c<br>
@@ -121,18 +121,16 @@ static int alt_fpga_bridge_probe(struct platform_devi=
ce
*pdev)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
Get f2s bridge configuration saved in handoff register */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regmap_read(=
sysmgr,
SYSMGR_ISWGRP_HANDOFF3, &amp;priv-&gt;mask);<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D fpga_bridge_create(dev, F2S_BRIDGE_NAME,<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;altera_f=
pga2sdram_br_ops,
priv);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D devm_fpga_bridge_create(dev, F2S_BRIDGE_NAME,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 &amp;altera_fpga2sdram_br_ops, priv);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!br)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return -ENOMEM;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set=
_drvdata(pdev,
br);<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret
=3D fpga_bridge_register(br);<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
if (ret) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fpga_bridge_f=
ree(br);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
if (ret)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return ret;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
}<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev=
,
&quot;driver initialized with handoff %08x\n&quot;, priv-&gt;mask);<br>
 <br>
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-free=
ze-bridge.c<br>
index ffd586c..dd58c4a 100644<br>
--- a/drivers/fpga/altera-freeze-bridge.c<br>
+++ b/drivers/fpga/altera-freeze-bridge.c<br>
@@ -213,7 +213,6 @@ static int altera_freeze_br_probe(struct platform_devic=
e
*pdev)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct
fpga_bridge *br;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct
resource *res;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32
status, revision;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
int ret;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!np)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return -ENODEV;<br>
@@ -245,20 +244,14 @@ static int altera_freeze_br_probe(struct platform_dev=
ice
*pdev)<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;bas=
e_addr
=3D base_addr;<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;altera_f=
reeze_br_br_ops,
priv);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D devm_fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 &amp;altera_freeze_br_br_ops, priv);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!br)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return -ENOMEM;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set=
_drvdata(pdev,
br);<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
ret =3D fpga_bridge_register(br);<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
if (ret) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fpga_bridge_f=
ree(br);<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
ret;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
}<br>
-<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return 0;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return fpga_bridge_register(br);<br>
 }<br>
 <br>
 static int altera_freeze_br_remove(struct platform_device *pdev)<br>
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.=
c<br>
index a974d3f..77b95f2 100644<br>
--- a/drivers/fpga/altera-hps2fpga.c<br>
+++ b/drivers/fpga/altera-hps2fpga.c<br>
@@ -180,7 +180,8 @@ static int alt_fpga_bridge_probe(struct platform_device
*pdev)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
}<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D fpga_bridge_create(dev, priv-&gt;name, &amp;altera_hps2fpga_br_ops,
priv);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D devm_fpga_bridge_create(dev, priv-&gt;name,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 &amp;altera_hps2fpga_br_ops, priv);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!br) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
ret =3D -ENOMEM;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
goto err;<br>
@@ -190,12 +191,10 @@ static int alt_fpga_bridge_probe(struct platform_devi=
ce
*pdev)<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret
=3D fpga_bridge_register(br);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(ret)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto
err_free;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto
err;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
0;<br>
 <br>
-err_free:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
fpga_bridge_free(br);<br>
 err:<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_=
unprepare(priv-&gt;clk);<br>
 <br>
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c<br>
index 7cc041d..3ff9f3a 100644<br>
--- a/drivers/fpga/dfl-fme-br.c<br>
+++ b/drivers/fpga/dfl-fme-br.c<br>
@@ -61,7 +61,6 @@ static int fme_br_probe(struct platform_device *pdev)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct
device *dev =3D &amp;pdev-&gt;dev;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct
fme_br_priv *priv;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct
fpga_bridge *br;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
int ret;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv
=3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!priv)<br>
@@ -69,18 +68,14 @@ static int fme_br_probe(struct platform_device *pdev)<b=
r>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;pda=
ta
=3D dev_get_platdata(dev);<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D fpga_bridge_create(dev, &quot;DFL FPGA FME Bridge&quot;,<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;fme_brid=
ge_ops,
priv);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D devm_fpga_bridge_create(dev, &quot;DFL FPGA FME Bridge&quot;,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 &amp;fme_bridge_ops, priv);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!br)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return -ENOMEM;<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set=
_drvdata(pdev,
br);<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
ret =3D fpga_bridge_register(br);<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
if (ret)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fpga_bridge_f=
ree(br);<br>
-<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return ret;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return fpga_bridge_register(br);<br>
 }<br>
 <br>
 static int fme_br_remove(struct platform_device *pdev)<br>
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c<br>
index c983dac..80bd8f1 100644<br>
--- a/drivers/fpga/fpga-bridge.c<br>
+++ b/drivers/fpga/fpga-bridge.c<br>
@@ -324,6 +324,9 @@ ATTRIBUTE_GROUPS(fpga_bridge);<br>
 =C2=A0* @br_ops: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 pointer to structure of fpga bridge ops<br>
 =C2=A0* @priv: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 FPGA bridge private data<br>
 =C2=A0*<br>
+ * The caller of this function is responsible for freeing the bridge with<=
br>
+ * fpga_bridge_free().=C2=A0 Using devm_fpga_bridge_create() instead is
recommended.<br>
+ *<br>
 =C2=A0* Return: struct fpga_bridge or NULL<br>
 =C2=A0*/<br>
 struct fpga_bridge *fpga_bridge_create(struct device *dev, const char
*name,<br>
@@ -378,8 +381,8 @@ struct fpga_bridge *fpga_bridge_create(struct device
*dev, const char *name,<br>
 EXPORT_SYMBOL_GPL(fpga_bridge_create);<br>
 <br>
 /**<br>
- * fpga_bridge_free - free a fpga bridge and its id<br>
- * @bridge: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge struct created by fpga_bridge_create<br>
+ * fpga_bridge_free - free a fpga bridge created by fpga_bridge_create()<b=
r>
+ * @bridge: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge struct<br>
 =C2=A0*/<br>
 void fpga_bridge_free(struct fpga_bridge *bridge)<br>
 {<br>
@@ -388,9 +391,56 @@ void fpga_bridge_free(struct fpga_bridge *bridge)<br>
 }<br>
 EXPORT_SYMBOL_GPL(fpga_bridge_free);<br>
 <br>
+static void devm_fpga_bridge_release(struct device *dev, void *res)<br>
+{<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
struct fpga_bridge *bridge =3D *(struct fpga_bridge **)res;<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
fpga_bridge_free(bridge);<br>
+}<br>
+<br>
 /**<br>
- * fpga_bridge_register - register a fpga bridge<br>
- * @bridge: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge struct created by fpga_bridge_create<br>
+ * devm_fpga_bridge_create - create and init a managed struct fpga_bridge<=
br>
+ * @dev: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge device from pdev<br>
+ * @name: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge name<br>
+ * @br_ops: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
pointer to structure of fpga bridge ops<br>
+ * @priv: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge private data<br>
+ *<br>
+ * This function is intended for use in a FPGA bridge driver&#39;s probe f=
unction.<br>
+ * After the bridge driver creates the struct with devm_fpga_bridge_create=
(),
it<br>
+ * should register the bridge with fpga_bridge_register().=C2=A0 The bridg=
e
driver&#39;s<br>
+ * remove function should call fpga_bridge_unregister().=C2=A0 The bridge
struct<br>
+ * allocated with this function will be freed automatically on driver
detach.<br>
+ * This includes the case of a probe function returning error before calli=
ng<br>
+ * fpga_bridge_register(), the struct will still get cleaned up.<br>
+ *<br>
+ * =C2=A0Return: struct fpga_bridge or NULL<br>
+ */<br>
+struct fpga_bridge<br>
+*devm_fpga_bridge_create(struct device *dev, const char *name,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0const struct fpga_bridge_ops *br_ops, void *priv)<br>
+{<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
struct fpga_bridge **ptr, *bridge;<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
ptr =3D devres_alloc(devm_fpga_bridge_release, sizeof(*ptr), GFP_KERNEL);<b=
r>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
if (!ptr)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
NULL;<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
bridge =3D fpga_bridge_create(dev, name, br_ops, priv);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
if (!bridge) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devres_free(p=
tr);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
} else {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*ptr
=3D bridge;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devres_add(de=
v,
ptr);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
}<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
return bridge;<br>
+}<br>
+EXPORT_SYMBOL_GPL(devm_fpga_bridge_create);<br>
+<br>
+/**<br>
+ * fpga_bridge_register - register a FPGA bridge<br>
+ *<br>
+ * @bridge: FPGA bridge struct<br>
 =C2=A0*<br>
 =C2=A0* Return: 0 for success, error code otherwise.<br>
 =C2=A0*/<br>
@@ -412,8 +462,11 @@ int fpga_bridge_register(struct fpga_bridge *bridge)<b=
r>
 EXPORT_SYMBOL_GPL(fpga_bridge_register);<br>
 <br>
 /**<br>
- * fpga_bridge_unregister - unregister and free a fpga bridge<br>
- * @bridge: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
FPGA bridge struct created by fpga_bridge_create<br>
+ * fpga_bridge_unregister - unregister a FPGA bridge<br>
+ *<br>
+ * @bridge: FPGA bridge struct<br>
+ *<br>
+ * This function is intended for use in a FPGA bridge driver&#39;s remove
function.<br>
 =C2=A0*/<br>
 void fpga_bridge_unregister(struct fpga_bridge *bridge)<br>
 {<br>
@@ -430,9 +483,6 @@ EXPORT_SYMBOL_GPL(fpga_bridge_unregister);<br>
 <br>
 static void fpga_bridge_dev_release(struct device *dev)<br>
 {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
struct fpga_bridge *bridge =3D to_fpga_bridge(dev);<br>
-<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
fpga_bridge_free(bridge);<br>
 }<br>
 <br>
 static int __init fpga_bridge_dev_init(void)<br>
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-de=
coupler.c<br>
index 07ba153..6410361 100644<br>
--- a/drivers/fpga/xilinx-pr-decoupler.c<br>
+++ b/drivers/fpga/xilinx-pr-decoupler.c<br>
@@ -121,8 +121,8 @@ static int xlnx_pr_decoupler_probe(struct platform_devi=
ce
*pdev)<br>
 <br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(=
priv-&gt;clk);<br>
 <br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D fpga_bridge_create(&amp;pdev-&gt;dev, &quot;Xilinx PR Decoupler&quot=
;,<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;xlnx_pr_=
decoupler_br_ops,
priv);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
br =3D devm_fpga_bridge_create(&amp;pdev-&gt;dev, &quot;Xilinx PR Decoupler=
&quot;,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 &amp;xlnx_pr_decoupler_br_ops, priv);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if
(!br) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
err =3D -ENOMEM;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
goto err_clk;<br>
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bri=
dge.h<br>
index ce550fc..817600a 100644<br>
--- a/include/linux/fpga/fpga-bridge.h<br>
+++ b/include/linux/fpga/fpga-bridge.h<br>
@@ -69,4 +69,8 @@ void fpga_bridge_free(struct fpga_bridge *br);<br>
 int fpga_bridge_register(struct fpga_bridge *br);<br>
 void fpga_bridge_unregister(struct fpga_bridge *br);<br>
 <br>
+struct fpga_bridge<br>
+*devm_fpga_bridge_create(struct device *dev, const char *name,<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0const struct fpga_bridge_ops *br_ops, void *priv);<br>
+<br>
 #endif /* _LINUX_FPGA_BRIDGE_H */<br>
-- <br>
2.7.4<br>
<br>
</font></tt>
<br></blockquote></div></div>

--000000000000a1a4c30576cbde02--

--000000000000a1a4c40576cbde04
Content-Type: image/jpeg; name=noname
Content-Disposition: attachment; filename=noname
Content-Transfer-Encoding: base64
Content-ID: <16617007935c204bfcc1>
X-Attachment-Id: 16617007935c204bfcc1

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
MztUZtpfS8R20uzkfS8nR7S//9k=
--000000000000a1a4c40576cbde04--
