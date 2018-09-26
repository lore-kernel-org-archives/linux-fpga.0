Return-Path: <SRS0=LO+F=MI=zodiacaerospace.com=prvs=9807057bb5=eric.delage@kernel.org>
Return-Path: <SRS0=LO+F=MI=zodiacaerospace.com=prvs=9807057bb5=eric.delage@kernel.org>
In-Reply-To: <CANk1AXTOqQQ5QycZiKpw=Rv8dY9njbah4bN-xb9Ty9UCONrKyw@mail.gmail.com>
References: <1537978342-17697-1-git-send-email-atull@kernel.org> <1537978342-17697-3-git-send-email-atull@kernel.org> <OFE9B73D95.73C2CEF2-ONC1258314.005AEBC6-C1258314.005C6433@zodiacaerospace.com> <CANk1AXTOqQQ5QycZiKpw=Rv8dY9njbah4bN-xb9Ty9UCONrKyw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/4] fpga: bridge: add devm_fpga_bridge_create
Message-ID: <OFCCA34A06.F9AA3030-ONC1258314.007071B6-C1258314.0070C1A5@zodiacaerospace.com>
From: Eric.Delage@zodiacaerospace.com
Date: Wed, 26 Sep 2018 22:31:36 +0200
Content-Type: multipart/alternative; boundary="=_alternative 0070C1A5C1258314_="
To: Alan Tull <atull@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Federico Vaga <federico.vaga@cern.ch>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-fpga@vger.kernel.org, linux-fpga-owner@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
List-ID: <linux-fpga@vger.kernel.org>

Message en plusieurs parties au format MIME
--=_alternative 0070C1A5C1258314_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

The mail was not intended for the mailing list otherwise I would have=20
asked in english. I made a mistake... next time I won't do several things=20
at once.
Anyway it's the opportunity for me to tell you I find it a pity that=20
Intel/Xilinx can't agree on a common driver for their respective OpenCL=20
approach.
Do you think there is a chance in the near future to have a kind of=20
convergence?

Eric




De :    Alan Tull <atull@kernel.org>
A :     Eric.Delage@zodiacaerospace.com
Cc :    Jonathan Corbet <corbet@lwn.net>, Federico Vaga=20
<federico.vaga@cern.ch>, Linux Doc Mailing List=20
<linux-doc@vger.kernel.org>, linux-fpga@vger.kernel.org,=20
linux-fpga-owner@vger.kernel.org, linux-kernel=20
<linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, Randy=20
Dunlap <rdunlap@infradead.org>
Date :  26/09/2018 22:14
Objet : Re: [PATCH v3 2/4] fpga: bridge: add devm=5Ffpga=5Fbridge=5Fcreate



On Wed, Sep 26, 2018 at 12:21 PM <Eric.Delage@zodiacaerospace.com> wrote:

Hi Eric,

Est-ce que je comprends bien qu'il ne s'agit que d'une carte de traitement =

FPGA sans possibilit=E9 de mettre une carte-fille type FMA (=E0 la REFLEX C=
ES=20
avec sa carte acc=E9l=E9ratrice FPGA) ?=20

IIUC your question is about specific boards.  These changes I posted are=20
for a subsystem with support for various FPGA devices.  This is not code=20
that is specific to any one board.

We can have a better discussion if we could stick to English, please. =20

Alan
=20
4 XCKU115 pour les russes equiv. 2 cartes FPGA Xilinx avec des VU37P. Env. =

de d=E9veloppement SDAccel identique mais fait plut=F4t pour =EAtre utilis=
=E9 en=20
acc=E9l=E9rateur.=20
L'approche carte LB2P1/XCKU040-060 + carte FPGA est amha =E0 investiguer=20
s=E9rieusement.=20

Kind Regards,=20
Mit freundlichen Gr=FCssen,=20
Sinc=E8res Salutations,=20
ZODIAC DATA SYSTEMS
ZODIAC AEROSYSTEMS
Control Systems Division=20


Eric DELAGE
Head of the Monitoring Front-End Group, and=20
Technical Product Manager for IFoIP and RF2P(CIe) Solutions=20

Campus EffiScience - 5 Esplanade Anton Philips - 14460 Colombelles -=20
France
Tel: +33.2.31.29.49.45 - Fax: +33.2.31.80.65.49=20
eric.delage@zodiacaerospace.com=20
http://www.zodiacaerospace.com=20
http://www.linkedin.com/in/ericdelage





De :        Alan Tull <atull@kernel.org>=20
A :        Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <
corbet@lwn.net>=20
Cc :        Randy Dunlap <rdunlap@infradead.org>, Federico Vaga <
federico.vaga@cern.ch>, linux-kernel@vger.kernel.org,=20
linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <
atull@kernel.org>=20
Date :        26/09/2018 18:13=20
Objet :        [PATCH v3 2/4] fpga: bridge: add devm=5Ffpga=5Fbridge=5Fcrea=
te=20
Envoy=E9 par :        linux-fpga-owner@vger.kernel.org=20



Add devm=5Ffpga=5Fbridge=5Fcreate() which is the managed
version of fpga=5Fbridge=5Fcreate().

Change current bridge drivers to use
devm=5Ffpga=5Fbridge=5Fcreate().

Signed-off-by: Alan Tull <atull@kernel.org>
Suggested-by: Federico Vaga <federico.vaga@cern.ch>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: add suggested-by
v3: remove some unclear documentation about fpga=5Fbridge=5Funregister
   add Acked-by
---
Documentation/driver-api/fpga/fpga-bridge.rst |  3 ++
drivers/fpga/altera-fpga2sdram.c              |  8 ++--
drivers/fpga/altera-freeze-bridge.c           | 13 ++---
drivers/fpga/altera-hps2fpga.c                |  7 ++-
drivers/fpga/dfl-fme-br.c                     | 11 ++---
drivers/fpga/fpga-bridge.c                    | 68=20
+++++++++++++++++++++++----
drivers/fpga/xilinx-pr-decoupler.c            |  4 +-
include/linux/fpga/fpga-bridge.h              |  4 ++
8 files changed, 80 insertions(+), 38 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst=20
b/Documentation/driver-api/fpga/fpga-bridge.rst
index 2c2aaca..ebbcbde 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -11,6 +11,9 @@ API to implement a new FPGA bridge
   :functions: fpga=5Fbridge=5Fops

.. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: devm=5Ffpga=5Fbridge=5Fcreate
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
   :functions: fpga=5Fbridge=5Fcreate

.. kernel-doc:: drivers/fpga/fpga-bridge.c
diff --git a/drivers/fpga/altera-fpga2sdram.c=20
b/drivers/fpga/altera-fpga2sdram.c
index 23660cc..a78e49c 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -121,18 +121,16 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct=20
platform=5Fdevice *pdev)
                 /* Get f2s bridge configuration saved in handoff register =

*/
                 regmap=5Fread(sysmgr, SYSMGR=5FISWGRP=5FHANDOFF3, &priv->m=
ask);

-                 br =3D fpga=5Fbridge=5Fcreate(dev, F2S=5FBRIDGE=5FNAME,
-                                                                  =20
 &altera=5Ffpga2sdram=5Fbr=5Fops, priv);
+                 br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, F2S=5FBRIDGE=5F=
NAME,
+                                                                        =20
&altera=5Ffpga2sdram=5Fbr=5Fops, priv);
                 if (!br)
                                  return -ENOMEM;

                 platform=5Fset=5Fdrvdata(pdev, br);

                 ret =3D fpga=5Fbridge=5Fregister(br);
-                 if (ret) {
-                                  fpga=5Fbridge=5Ffree(br);
+                 if (ret)
                                  return ret;
-                 }

                 dev=5Finfo(dev, "driver initialized with handoff %08x\n", =

priv->mask);

diff --git a/drivers/fpga/altera-freeze-bridge.c=20
b/drivers/fpga/altera-freeze-bridge.c
index ffd586c..dd58c4a 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -213,7 +213,6 @@ static int altera=5Ffreeze=5Fbr=5Fprobe(struct=20
platform=5Fdevice *pdev)
                 struct fpga=5Fbridge *br;
                 struct resource *res;
                 u32 status, revision;
-                 int ret;

                 if (!np)
                                  return -ENODEV;
@@ -245,20 +244,14 @@ static int altera=5Ffreeze=5Fbr=5Fprobe(struct=20
platform=5Fdevice *pdev)

                 priv->base=5Faddr =3D base=5Faddr;

-                 br =3D fpga=5Fbridge=5Fcreate(dev, FREEZE=5FBRIDGE=5FNAME,
-                                                                  =20
 &altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);
+                 br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, FREEZE=5FBRIDGE=
=5FNAME,
+                                                                        =20
&altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);
                 if (!br)
                                  return -ENOMEM;

                 platform=5Fset=5Fdrvdata(pdev, br);

-                 ret =3D fpga=5Fbridge=5Fregister(br);
-                 if (ret) {
-                                  fpga=5Fbridge=5Ffree(br);
-                                  return ret;
-                 }
-
-                 return 0;
+                 return fpga=5Fbridge=5Fregister(br);
}

static int altera=5Ffreeze=5Fbr=5Fremove(struct platform=5Fdevice *pdev)
diff --git a/drivers/fpga/altera-hps2fpga.c=20
b/drivers/fpga/altera-hps2fpga.c
index a974d3f..77b95f2 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -180,7 +180,8 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct=20
platform=5Fdevice *pdev)
                                  }
                 }

-                 br =3D fpga=5Fbridge=5Fcreate(dev, priv->name,=20
&altera=5Fhps2fpga=5Fbr=5Fops, priv);
+                 br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, priv->name,
+                                                                        =20
&altera=5Fhps2fpga=5Fbr=5Fops, priv);
                 if (!br) {
                                  ret =3D -ENOMEM;
                                  goto err;
@@ -190,12 +191,10 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct=20
platform=5Fdevice *pdev)

                 ret =3D fpga=5Fbridge=5Fregister(br);
                 if (ret)
-                                  goto err=5Ffree;
+                                  goto err;

                 return 0;

-err=5Ffree:
-                 fpga=5Fbridge=5Ffree(br);
err:
                 clk=5Fdisable=5Funprepare(priv->clk);

diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 7cc041d..3ff9f3a 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -61,7 +61,6 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *pde=
v)
                 struct device *dev =3D &pdev->dev;
                 struct fme=5Fbr=5Fpriv *priv;
                 struct fpga=5Fbridge *br;
-                 int ret;

                 priv =3D devm=5Fkzalloc(dev, sizeof(*priv), GFP=5FKERNEL);
                 if (!priv)
@@ -69,18 +68,14 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *p=
dev)

                 priv->pdata =3D dev=5Fget=5Fplatdata(dev);

-                 br =3D fpga=5Fbridge=5Fcreate(dev, "DFL FPGA FME Bridge",
-                                                                  =20
 &fme=5Fbridge=5Fops, priv);
+                 br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, "DFL FPGA FME B=
ridge",
+                                                                        =20
&fme=5Fbridge=5Fops, priv);
                 if (!br)
                                  return -ENOMEM;

                 platform=5Fset=5Fdrvdata(pdev, br);

-                 ret =3D fpga=5Fbridge=5Fregister(br);
-                 if (ret)
-                                  fpga=5Fbridge=5Ffree(br);
-
-                 return ret;
+                 return fpga=5Fbridge=5Fregister(br);
}

static int fme=5Fbr=5Fremove(struct platform=5Fdevice *pdev)
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index c983dac..80bd8f1 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -324,6 +324,9 @@ ATTRIBUTE=5FGROUPS(fpga=5Fbridge);
 * @br=5Fops:                 pointer to structure of fpga bridge ops
 * @priv:                 FPGA bridge private data
 *
+ * The caller of this function is responsible for freeing the bridge with
+ * fpga=5Fbridge=5Ffree().  Using devm=5Ffpga=5Fbridge=5Fcreate() instead =
is=20
recommended.
+ *
 * Return: struct fpga=5Fbridge or NULL
 */
struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct device *dev, const char=
=20
*name,
@@ -378,8 +381,8 @@ struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct dev=
ice=20
*dev, const char *name,
EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Fcreate);

/**
- * fpga=5Fbridge=5Ffree - free a fpga bridge and its id
- * @bridge:                 FPGA bridge struct created by=20
fpga=5Fbridge=5Fcreate
+ * fpga=5Fbridge=5Ffree - free a fpga bridge created by fpga=5Fbridge=5Fcr=
eate()
+ * @bridge:                 FPGA bridge struct
 */
void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *bridge)
{
@@ -388,9 +391,56 @@ void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *bridge)
}
EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Ffree);

+static void devm=5Ffpga=5Fbridge=5Frelease(struct device *dev, void *res)
+{
+                 struct fpga=5Fbridge *bridge =3D *(struct fpga=5Fbridge=20
**)res;
+
+                 fpga=5Fbridge=5Ffree(bridge);
+}
+
/**
- * fpga=5Fbridge=5Fregister - register a fpga bridge
- * @bridge:                 FPGA bridge struct created by=20
fpga=5Fbridge=5Fcreate
+ * devm=5Ffpga=5Fbridge=5Fcreate - create and init a managed struct fpga=
=5Fbridge
+ * @dev:                 FPGA bridge device from pdev
+ * @name:                 FPGA bridge name
+ * @br=5Fops:                 pointer to structure of fpga bridge ops
+ * @priv:                 FPGA bridge private data
+ *
+ * This function is intended for use in a FPGA bridge driver's probe=20
function.
+ * After the bridge driver creates the struct with=20
devm=5Ffpga=5Fbridge=5Fcreate(), it
+ * should register the bridge with fpga=5Fbridge=5Fregister().  The bridge=
=20
driver's
+ * remove function should call fpga=5Fbridge=5Funregister().  The bridge=20
struct
+ * allocated with this function will be freed automatically on driver=20
detach.
+ * This includes the case of a probe function returning error before=20
calling
+ * fpga=5Fbridge=5Fregister(), the struct will still get cleaned up.
+ *
+ *  Return: struct fpga=5Fbridge or NULL
+ */
+struct fpga=5Fbridge
+*devm=5Ffpga=5Fbridge=5Fcreate(struct device *dev, const char *name,
+                                                    const struct=20
fpga=5Fbridge=5Fops *br=5Fops, void *priv)
+{
+                 struct fpga=5Fbridge **ptr, *bridge;
+
+                 ptr =3D devres=5Falloc(devm=5Ffpga=5Fbridge=5Frelease,=20
sizeof(*ptr), GFP=5FKERNEL);
+                 if (!ptr)
+                                  return NULL;
+
+                 bridge =3D fpga=5Fbridge=5Fcreate(dev, name, br=5Fops, pr=
iv);
+                 if (!bridge) {
+                                  devres=5Ffree(ptr);
+                 } else {
+                                  *ptr =3D bridge;
+                                  devres=5Fadd(dev, ptr);
+                 }
+
+                 return bridge;
+}
+EXPORT=5FSYMBOL=5FGPL(devm=5Ffpga=5Fbridge=5Fcreate);
+
+/**
+ * fpga=5Fbridge=5Fregister - register a FPGA bridge
+ *
+ * @bridge: FPGA bridge struct
 *
 * Return: 0 for success, error code otherwise.
 */
@@ -412,8 +462,11 @@ int fpga=5Fbridge=5Fregister(struct fpga=5Fbridge *bri=
dge)
EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Fregister);

/**
- * fpga=5Fbridge=5Funregister - unregister and free a fpga bridge
- * @bridge:                 FPGA bridge struct created by=20
fpga=5Fbridge=5Fcreate
+ * fpga=5Fbridge=5Funregister - unregister a FPGA bridge
+ *
+ * @bridge: FPGA bridge struct
+ *
+ * This function is intended for use in a FPGA bridge driver's remove=20
function.
 */
void fpga=5Fbridge=5Funregister(struct fpga=5Fbridge *bridge)
{
@@ -430,9 +483,6 @@ EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Funregister);

static void fpga=5Fbridge=5Fdev=5Frelease(struct device *dev)
{
-                 struct fpga=5Fbridge *bridge =3D to=5Ffpga=5Fbridge(dev);
-
-                 fpga=5Fbridge=5Ffree(bridge);
}

static int =5F=5Finit fpga=5Fbridge=5Fdev=5Finit(void)
diff --git a/drivers/fpga/xilinx-pr-decoupler.c=20
b/drivers/fpga/xilinx-pr-decoupler.c
index 07ba153..6410361 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -121,8 +121,8 @@ static int xlnx=5Fpr=5Fdecoupler=5Fprobe(struct=20
platform=5Fdevice *pdev)

                 clk=5Fdisable(priv->clk);

-                 br =3D fpga=5Fbridge=5Fcreate(&pdev->dev, "Xilinx PR=20
Decoupler",
-                                                                  =20
 &xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);
+                 br =3D devm=5Ffpga=5Fbridge=5Fcreate(&pdev->dev, "Xilinx =
PR=20
Decoupler",
+                                                                        =20
&xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);
                 if (!br) {
                                  err =3D -ENOMEM;
                                  goto err=5Fclk;
diff --git a/include/linux/fpga/fpga-bridge.h=20
b/include/linux/fpga/fpga-bridge.h
index ce550fc..817600a 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -69,4 +69,8 @@ void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *br);
int fpga=5Fbridge=5Fregister(struct fpga=5Fbridge *br);
void fpga=5Fbridge=5Funregister(struct fpga=5Fbridge *br);

+struct fpga=5Fbridge
+*devm=5Ffpga=5Fbridge=5Fcreate(struct device *dev, const char *name,
+                                                    const struct=20
fpga=5Fbridge=5Fops *br=5Fops, void *priv);
+
#endif /* =5FLINUX=5FFPGA=5FBRIDGE=5FH */
--=20
2.7.4

[pi=E8ce jointe "noname" supprim=E9e par Eric=20
Delage/BRETTEVILLE/ZDF/BTECH/ZODIAC]=20

--=_alternative 0070C1A5C1258314_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi Alan,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">The mail was not intended for the ma=
iling
list otherwise I would have asked in english. I made a mistake... next
time I won't do several things at once.</font>
<br><font size=3D2 face=3D"sans-serif">Anyway it's the opportunity for me to
tell you I find it a pity that Intel/Xilinx can't agree on a common driver
for their respective OpenCL approach.</font>
<br><font size=3D2 face=3D"sans-serif">Do you think there is a chance in the
near future to have a kind of convergence?</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Eric</font>
<br>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">De : &nbsp; &nbsp; &=
nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Alan Tull &lt;atull@kernel.=
org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">A : &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Eric.Delage@zodiacaerospace=
.com</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc&nbsp;: &nbsp; &nb=
sp;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Jonathan Corbet
&lt;corbet@lwn.net&gt;, Federico Vaga &lt;federico.vaga@cern.ch&gt;, Linux
Doc Mailing List &lt;linux-doc@vger.kernel.org&gt;, linux-fpga@vger.kernel.=
org,
linux-fpga-owner@vger.kernel.org, linux-kernel &lt;linux-kernel@vger.kernel=
.org&gt;,
Moritz Fischer &lt;mdf@kernel.org&gt;, Randy Dunlap &lt;rdunlap@infradead.o=
rg&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date : &nbsp; &nbsp;=
 &nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">26/09/2018 22:14</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Objet : &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [PATCH v3
2/4] fpga: bridge: add devm=5Ffpga=5Fbridge=5Fcreate</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D3 face=3D"Arial">On Wed, Sep 26, 2018 at 12:21 PM &lt;</fo=
nt><a href=3Dmailto:Eric.Delage@zodiacaerospace.com target=3D=5Fblank><font=
 size=3D3 color=3Dblue face=3D"Arial"><u>Eric.Delage@zodiacaerospace.com</u=
></font></a><font size=3D3 face=3D"Arial">&gt;
wrote:</font>
<br>
<br><tt><font size=3D3>Hi Eric,</font></tt>
<br>
<br><font size=3D2 face=3D"sans-serif">Est-ce que je comprends bien qu'il ne
s'agit que d'une carte de traitement FPGA sans possibilit=E9 de mettre une
carte-fille type FMA (=E0 la REFLEX CES avec sa carte acc=E9l=E9ratrice FPG=
A)
?</font><font size=3D3> </font>
<br>
<br><tt><font size=3D3>IIUC your question is about specific boards.&nbsp;
These changes I posted are for a subsystem with support for various FPGA
devices.&nbsp; This is not code that is specific to any one board.</font></=
tt>
<br>
<br><tt><font size=3D3>We can have a better discussion if we could stick
to English, please.&nbsp;&nbsp;</font></tt>
<br>
<br><tt><font size=3D3>Alan</font></tt>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D2 face=3D"sans-serif">4 XCKU115 pour les russes equiv. 2 c=
artes
FPGA Xilinx avec des VU37P. Env. de d=E9veloppement SDAccel identique mais
fait plut=F4t pour =EAtre utilis=E9 en acc=E9l=E9rateur.</font><font size=
=3D3> </font><font size=3D2 face=3D"sans-serif"><br>
L'approche carte LB2P1/XCKU040-060 + carte FPGA est amha =E0 investiguer
s=E9rieusement.</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
Kind Regards,</font><font size=3D3> </font><font size=3D2 face=3D"sans-seri=
f"><br>
Mit freundlichen Gr=FCssen,</font><font size=3D3> </font><font size=3D2 fac=
e=3D"sans-serif"><br>
Sinc=E8res Salutations,</font><font size=3D3> </font>
<table width=3D425 style=3D"border-collapse:collapse;">
<tr height=3D8>
<td width=3D289 style=3D"border-style:none none none none;border-color:#000=
000;border-width:0px 0px 0px 0px;padding:1px 1px;"><font size=3D1 color=3D#=
808080 face=3D"Arial"><b><u>ZODIAC
DATA SYSTEMS</u><br>
ZODIAC AEROSYSTEMS</b><br>
Control Systems Division</font><font size=3D3> </font>
<td width=3D132 style=3D"border-style:none none none none;border-color:#000=
000;border-width:0px 0px 0px 0px;padding:1px 1px;">
<tr height=3D8>
<td width=3D423 colspan=3D2 style=3D"border-style:none none none none;borde=
r-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"><font size=
=3D1 face=3D"Arial"><b><br>
Eric DELAGE</b><br>
Head of the Monitoring Front-End Group, and</font><font size=3D3> </font><f=
ont size=3D1 face=3D"Arial"><br>
Technical Product Manager for IFoIP and RF2P(CIe) Solutions</font><font siz=
e=3D3>
</font>
<tr height=3D8>
<td width=3D423 colspan=3D2 style=3D"border-style:none none none none;borde=
r-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"><font size=
=3D1 color=3D#808080 face=3D"Arial"><br>
Campus EffiScience - 5 Esplanade Anton Philips - 14460 Colombelles - France=
<br>
Tel: +33.2.31.29.49.45 - Fax: +33.2.31.80.65.49</font><font size=3D3> </fon=
t><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3Dmailto:Eric.DELAGE@ZodiacAerospace.Com target=3D=5Fbla=
nk><font size=3D1 color=3D#808080 face=3D"Arial"><u>eric.delage@zodiacaeros=
pace.com</u></font></a><font size=3D3>
</font><font size=3D1 color=3D#808080 face=3D"Arial"><br>
</font><a href=3Dhttp://www.zodiacaerospace.com/><font size=3D1 color=3D#80=
8080 face=3D"Arial">http://www.zodiacaerospace.com</font></a><font size=3D3>
</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A=
=5F=5Fwww.linkedin.com=5Fin=5Fericdelage&amp;d=3DDwMFaQ&amp;c=3DuGI7=5Fx3Gc=
0YOJ1Z5IL8CqsjX2-KkH7gFBXSNm7B0tus&amp;r=3DT-mDIZHaKRLvFTdjv-vde1xmWJa4Y89=
=5F=5FaL-pXSANq0&amp;m=3D5GaN4nz4atcDckyf=5Fhh9GwSkaJ-15zAYrnQ=5FP6kZb2s&am=
p;s=3DVJ=5F8u=5FLxkqZBnQQ4=5FV=5F-wIfleAH8REWv1wqcE43NH=5FA&amp;e=3D" targe=
t=3D=5Fblank><font size=3D1 color=3Dblue face=3D"Arial"><u>http://www.linke=
din.com/in/ericdelage</u></font></a></table>
<br><font size=3D3><br>
<br>
<br>
<br>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
De : &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">A=
lan
Tull &lt;</font><a href=3Dmailto:atull@kernel.org target=3D=5Fblank><font s=
ize=3D1 color=3Dblue face=3D"sans-serif"><u>atull@kernel.org</u></font></a>=
<font size=3D1 face=3D"sans-serif">&gt;</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
A : &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Mo=
ritz
Fischer &lt;</font><a href=3Dmailto:mdf@kernel.org target=3D=5Fblank><font =
size=3D1 color=3Dblue face=3D"sans-serif"><u>mdf@kernel.org</u></font></a><=
font size=3D1 face=3D"sans-serif">&gt;,
Jonathan Corbet &lt;</font><a href=3Dmailto:corbet@lwn.net target=3D=5Fblan=
k><font size=3D1 color=3Dblue face=3D"sans-serif"><u>corbet@lwn.net</u></fo=
nt></a><font size=3D1 face=3D"sans-serif">&gt;</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
Cc&nbsp;: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-ser=
if">Randy
Dunlap &lt;</font><a href=3Dmailto:rdunlap@infradead.org target=3D=5Fblank>=
<font size=3D1 color=3Dblue face=3D"sans-serif"><u>rdunlap@infradead.org</u=
></font></a><font size=3D1 face=3D"sans-serif">&gt;,
Federico Vaga &lt;</font><a href=3Dmailto:federico.vaga@cern.ch target=3D=
=5Fblank><font size=3D1 color=3Dblue face=3D"sans-serif"><u>federico.vaga@c=
ern.ch</u></font></a><font size=3D1 face=3D"sans-serif">&gt;,
</font><a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D=5Fblank><f=
ont size=3D1 color=3Dblue face=3D"sans-serif"><u>linux-kernel@vger.kernel.o=
rg</u></font></a><font size=3D1 face=3D"sans-serif">,
</font><a href=3D"mailto:linux-fpga@vger.kernel.org" target=3D=5Fblank><fon=
t size=3D1 color=3Dblue face=3D"sans-serif"><u>linux-fpga@vger.kernel.org</=
u></font></a><font size=3D1 face=3D"sans-serif">,
</font><a href=3D"mailto:linux-doc@vger.kernel.org" target=3D=5Fblank><font=
 size=3D1 color=3Dblue face=3D"sans-serif"><u>linux-doc@vger.kernel.org</u>=
</font></a><font size=3D1 face=3D"sans-serif">,
Alan Tull &lt;</font><a href=3Dmailto:atull@kernel.org target=3D=5Fblank><f=
ont size=3D1 color=3Dblue face=3D"sans-serif"><u>atull@kernel.org</u></font=
></a><font size=3D1 face=3D"sans-serif">&gt;</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
Date : &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif"=
>26/09/2018
18:13</font><font size=3D3> </font><font size=3D1 color=3D#5f5f5f face=3D"s=
ans-serif"><br>
Objet : &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif=
">[PATCH
v3 2/4] fpga: bridge: add devm=5Ffpga=5Fbridge=5Fcreate</font><font size=3D=
3> </font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
Envoy=E9 par : &nbsp; &nbsp; &nbsp; &nbsp;</font><a href=3D"mailto:linux-fp=
ga-owner@vger.kernel.org" target=3D=5Fblank><font size=3D1 color=3Dblue fac=
e=3D"sans-serif"><u>linux-fpga-owner@vger.kernel.org</u></font></a><font si=
ze=3D3>
<br>
</font>
<hr noshade><font size=3D3><br>
<br>
</font><tt><font size=3D2><br>
Add devm=5Ffpga=5Fbridge=5Fcreate() which is the managed<br>
version of fpga=5Fbridge=5Fcreate().<br>
<br>
Change current bridge drivers to use<br>
devm=5Ffpga=5Fbridge=5Fcreate().<br>
<br>
Signed-off-by: Alan Tull &lt;</font></tt><a href=3Dmailto:atull@kernel.org =
target=3D=5Fblank><tt><font size=3D2 color=3Dblue><u>atull@kernel.org</u></=
font></tt></a><tt><font size=3D2>&gt;<br>
Suggested-by: Federico Vaga &lt;</font></tt><a href=3Dmailto:federico.vaga@=
cern.ch target=3D=5Fblank><tt><font size=3D2 color=3Dblue><u>federico.vaga@=
cern.ch</u></font></tt></a><tt><font size=3D2>&gt;<br>
Acked-by: Moritz Fischer &lt;</font></tt><a href=3Dmailto:mdf@kernel.org ta=
rget=3D=5Fblank><tt><font size=3D2 color=3Dblue><u>mdf@kernel.org</u></font=
></tt></a><tt><font size=3D2>&gt;<br>
---<br>
v2: add suggested-by<br>
v3: remove some unclear documentation about fpga=5Fbridge=5Funregister<br>
&nbsp; &nbsp;add Acked-by<br>
---<br>
Documentation/driver-api/fpga/fpga-bridge.rst | &nbsp;3 ++<br>
drivers/fpga/altera-fpga2sdram.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;| &nbsp;8 ++--<br>
drivers/fpga/altera-freeze-bridge.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
| 13 ++---<br>
drivers/fpga/altera-hps2fpga.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;| &nbsp;7 ++-<br>
drivers/fpga/dfl-fme-br.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; | 11 ++---<br>
drivers/fpga/fpga-bridge.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;| 68 +++++++++++++++++++++++----<br>
drivers/fpga/xilinx-pr-decoupler.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;|
&nbsp;4 +-<br>
include/linux/fpga/fpga-bridge.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;| &nbsp;4 ++<br>
8 files changed, 80 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/=
driver-api/fpga/fpga-bridge.rst<br>
index 2c2aaca..ebbcbde 100644<br>
--- a/Documentation/driver-api/fpga/fpga-bridge.rst<br>
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst<br>
@@ -11,6 +11,9 @@ API to implement a new FPGA bridge<br>
&nbsp; &nbsp;:functions: fpga=5Fbridge=5Fops<br>
<br>
.. kernel-doc:: drivers/fpga/fpga-bridge.c<br>
+ &nbsp; :functions: devm=5Ffpga=5Fbridge=5Fcreate<br>
+<br>
+.. kernel-doc:: drivers/fpga/fpga-bridge.c<br>
&nbsp; &nbsp;:functions: fpga=5Fbridge=5Fcreate<br>
<br>
.. kernel-doc:: drivers/fpga/fpga-bridge.c<br>
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sd=
ram.c<br>
index 23660cc..a78e49c 100644<br>
--- a/drivers/fpga/altera-fpga2sdram.c<br>
+++ b/drivers/fpga/altera-fpga2sdram.c<br>
@@ -121,18 +121,16 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct platfor=
m=5Fdevice
*pdev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Get f2s
bridge configuration saved in handoff register */<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;regmap=5Fread=
(sysmgr,
SYSMGR=5FISWGRP=5FHANDOFF3, &amp;priv-&gt;mask);<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D fpga=5Fbri=
dge=5Fcreate(dev,
F2S=5FBRIDGE=5FNAME,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&amp;altera=5Ffpga2sdram=5Fbr=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D devm=5Ffpg=
a=5Fbridge=5Fcreate(dev,
F2S=5FBRIDGE=5FNAME,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &amp;altera=5Ffpga2sdram=5Fbr=5Fops, priv);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!br)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;platform=5Fse=
t=5Fdrvdata(pdev,
br);<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D fpga=
=5Fbridge=5Fregister(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpga=5Fbridge=5Ffree(br);<b=
r>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dev=5Finfo(de=
v,
&quot;driver initialized with handoff %08x\n&quot;, priv-&gt;mask);<br>
<br>
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-free=
ze-bridge.c<br>
index ffd586c..dd58c4a 100644<br>
--- a/drivers/fpga/altera-freeze-bridge.c<br>
+++ b/drivers/fpga/altera-freeze-bridge.c<br>
@@ -213,7 +213,6 @@ static int altera=5Ffreeze=5Fbr=5Fprobe(struct platform=
=5Fdevice
*pdev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct fpga=
=5Fbridge
*br;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct resour=
ce
*res;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;u32 status,
revision;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int ret;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!np)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENODEV;<br>
@@ -245,20 +244,14 @@ static int altera=5Ffreeze=5Fbr=5Fprobe(struct platfo=
rm=5Fdevice
*pdev)<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv-&gt;base=
=5Faddr
=3D base=5Faddr;<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D fpga=5Fbri=
dge=5Fcreate(dev,
FREEZE=5FBRIDGE=5FNAME,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&amp;altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D devm=5Ffpg=
a=5Fbridge=5Fcreate(dev,
FREEZE=5FBRIDGE=5FNAME,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &amp;altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!br)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;platform=5Fse=
t=5Fdrvdata(pdev,
br);<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D fpga=5Fbr=
idge=5Fregister(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpga=5Fbridge=5Ffree(br);<b=
r>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return fpga=5Fbri=
dge=5Fregister(br);<br>
}<br>
<br>
static int altera=5Ffreeze=5Fbr=5Fremove(struct platform=5Fdevice *pdev)<br>
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.=
c<br>
index a974d3f..77b95f2 100644<br>
--- a/drivers/fpga/altera-hps2fpga.c<br>
+++ b/drivers/fpga/altera-hps2fpga.c<br>
@@ -180,7 +180,8 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct platform=
=5Fdevice
*pdev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D fpga=5Fbri=
dge=5Fcreate(dev,
priv-&gt;name, &amp;altera=5Fhps2fpga=5Fbr=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D devm=5Ffpg=
a=5Fbridge=5Fcreate(dev,
priv-&gt;name,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &amp;altera=5Fhps2fpga=5Fbr=5Fops, priv);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!br)
{<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D -ENOMEM;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err;<br>
@@ -190,12 +191,10 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct platfor=
m=5Fdevice
*pdev)<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret =3D fpga=
=5Fbridge=5Fregister(br);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto err=5Ffree;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto err;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
<br>
-err=5Ffree:<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fpga=5Fbridge=5Ff=
ree(br);<br>
err:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;clk=5Fdisable=
=5Funprepare(priv-&gt;clk);<br>
<br>
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c<br>
index 7cc041d..3ff9f3a 100644<br>
--- a/drivers/fpga/dfl-fme-br.c<br>
+++ b/drivers/fpga/dfl-fme-br.c<br>
@@ -61,7 +61,6 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *pde=
v)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct device
*dev =3D &amp;pdev-&gt;dev;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct fme=5F=
br=5Fpriv
*priv;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct fpga=
=5Fbridge
*br;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int ret;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv =3D devm=
=5Fkzalloc(dev,
sizeof(*priv), GFP=5FKERNEL);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!priv)<br>
@@ -69,18 +68,14 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *p=
dev)<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv-&gt;pdata
=3D dev=5Fget=5Fplatdata(dev);<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D fpga=5Fbri=
dge=5Fcreate(dev,
&quot;DFL FPGA FME Bridge&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&amp;fme=5Fbridge=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D devm=5Ffpg=
a=5Fbridge=5Fcreate(dev,
&quot;DFL FPGA FME Bridge&quot;,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &amp;fme=5Fbridge=5Fops, priv);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!br)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;platform=5Fse=
t=5Fdrvdata(pdev,
br);<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D fpga=5Fbr=
idge=5Fregister(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpga=5Fbridge=5Ffree(br);<b=
r>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return fpga=5Fbri=
dge=5Fregister(br);<br>
}<br>
<br>
static int fme=5Fbr=5Fremove(struct platform=5Fdevice *pdev)<br>
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c<br>
index c983dac..80bd8f1 100644<br>
--- a/drivers/fpga/fpga-bridge.c<br>
+++ b/drivers/fpga/fpga-bridge.c<br>
@@ -324,6 +324,9 @@ ATTRIBUTE=5FGROUPS(fpga=5Fbridge);<br>
&nbsp;* @br=5Fops: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
pointer to structure of fpga bridge ops<br>
&nbsp;* @priv: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge private data<br>
&nbsp;*<br>
+ * The caller of this function is responsible for freeing the bridge with<=
br>
+ * fpga=5Fbridge=5Ffree().&nbsp; Using devm=5Ffpga=5Fbridge=5Fcreate() ins=
tead is
recommended.<br>
+ *<br>
&nbsp;* Return: struct fpga=5Fbridge or NULL<br>
&nbsp;*/<br>
struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct device *dev, const char=
 *name,<br>
@@ -378,8 +381,8 @@ struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct dev=
ice
*dev, const char *name,<br>
EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Fcreate);<br>
<br>
/**<br>
- * fpga=5Fbridge=5Ffree - free a fpga bridge and its id<br>
- * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge struct created by fpga=5Fbridge=5Fcreate<br>
+ * fpga=5Fbridge=5Ffree - free a fpga bridge created by fpga=5Fbridge=5Fcr=
eate()<br>
+ * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge struct<br>
&nbsp;*/<br>
void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *bridge)<br>
{<br>
@@ -388,9 +391,56 @@ void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *bridge=
)<br>
}<br>
EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Ffree);<br>
<br>
+static void devm=5Ffpga=5Fbridge=5Frelease(struct device *dev, void *res)<=
br>
+{<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct fpga=5Fbri=
dge
*bridge =3D *(struct fpga=5Fbridge **)res;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fpga=5Fbridge=5Ff=
ree(bridge);<br>
+}<br>
+<br>
/**<br>
- * fpga=5Fbridge=5Fregister - register a fpga bridge<br>
- * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge struct created by fpga=5Fbridge=5Fcreate<br>
+ * devm=5Ffpga=5Fbridge=5Fcreate - create and init a managed struct fpga=
=5Fbridge<br>
+ * @dev: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge device from pdev<br>
+ * @name: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge name<br>
+ * @br=5Fops: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; poin=
ter
to structure of fpga bridge ops<br>
+ * @priv: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge private data<br>
+ *<br>
+ * This function is intended for use in a FPGA bridge driver's probe funct=
ion.<br>
+ * After the bridge driver creates the struct with devm=5Ffpga=5Fbridge=5F=
create(),
it<br>
+ * should register the bridge with fpga=5Fbridge=5Fregister().&nbsp; The b=
ridge
driver's<br>
+ * remove function should call fpga=5Fbridge=5Funregister().&nbsp; The bri=
dge
struct<br>
+ * allocated with this function will be freed automatically on driver
detach.<br>
+ * This includes the case of a probe function returning error before calli=
ng<br>
+ * fpga=5Fbridge=5Fregister(), the struct will still get cleaned up.<br>
+ *<br>
+ * &nbsp;Return: struct fpga=5Fbridge or NULL<br>
+ */<br>
+struct fpga=5Fbridge<br>
+*devm=5Ffpga=5Fbridge=5Fcreate(struct device *dev, const char *name,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;const struct fpga=5Fbridge=5Fops *br=5Fop=
s,
void *priv)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct fpga=5Fbri=
dge
**ptr, *bridge;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ptr =3D devres=5F=
alloc(devm=5Ffpga=5Fbridge=5Frelease,
sizeof(*ptr), GFP=5FKERNEL);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!ptr)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return NULL;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bridge =3D fpga=
=5Fbridge=5Fcreate(dev,
name, br=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!bridge)
{<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;devres=5Ffree(ptr);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*ptr =3D bridge;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;devres=5Fadd(dev, ptr);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return bridge;<br>
+}<br>
+EXPORT=5FSYMBOL=5FGPL(devm=5Ffpga=5Fbridge=5Fcreate);<br>
+<br>
+/**<br>
+ * fpga=5Fbridge=5Fregister - register a FPGA bridge<br>
+ *<br>
+ * @bridge: FPGA bridge struct<br>
&nbsp;*<br>
&nbsp;* Return: 0 for success, error code otherwise.<br>
&nbsp;*/<br>
@@ -412,8 +462,11 @@ int fpga=5Fbridge=5Fregister(struct fpga=5Fbridge *bri=
dge)<br>
EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Fregister);<br>
<br>
/**<br>
- * fpga=5Fbridge=5Funregister - unregister and free a fpga bridge<br>
- * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FPGA
bridge struct created by fpga=5Fbridge=5Fcreate<br>
+ * fpga=5Fbridge=5Funregister - unregister a FPGA bridge<br>
+ *<br>
+ * @bridge: FPGA bridge struct<br>
+ *<br>
+ * This function is intended for use in a FPGA bridge driver's remove
function.<br>
&nbsp;*/<br>
void fpga=5Fbridge=5Funregister(struct fpga=5Fbridge *bridge)<br>
{<br>
@@ -430,9 +483,6 @@ EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Funregister);<br>
<br>
static void fpga=5Fbridge=5Fdev=5Frelease(struct device *dev)<br>
{<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct fpga=5Fbri=
dge
*bridge =3D to=5Ffpga=5Fbridge(dev);<br>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fpga=5Fbridge=5Ff=
ree(bridge);<br>
}<br>
<br>
static int =5F=5Finit fpga=5Fbridge=5Fdev=5Finit(void)<br>
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-de=
coupler.c<br>
index 07ba153..6410361 100644<br>
--- a/drivers/fpga/xilinx-pr-decoupler.c<br>
+++ b/drivers/fpga/xilinx-pr-decoupler.c<br>
@@ -121,8 +121,8 @@ static int xlnx=5Fpr=5Fdecoupler=5Fprobe(struct platfor=
m=5Fdevice
*pdev)<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;clk=5Fdisable=
(priv-&gt;clk);<br>
<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D fpga=5Fbri=
dge=5Fcreate(&amp;pdev-&gt;dev,
&quot;Xilinx PR Decoupler&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;&amp;xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; br =3D devm=5Ffpg=
a=5Fbridge=5Fcreate(&amp;pdev-&gt;dev,
&quot;Xilinx PR Decoupler&quot;,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &amp;xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!br)
{<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; err =3D -ENOMEM;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto err=5Fclk;<br>
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bri=
dge.h<br>
index ce550fc..817600a 100644<br>
--- a/include/linux/fpga/fpga-bridge.h<br>
+++ b/include/linux/fpga/fpga-bridge.h<br>
@@ -69,4 +69,8 @@ void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *br);<br>
int fpga=5Fbridge=5Fregister(struct fpga=5Fbridge *br);<br>
void fpga=5Fbridge=5Funregister(struct fpga=5Fbridge *br);<br>
<br>
+struct fpga=5Fbridge<br>
+*devm=5Ffpga=5Fbridge=5Fcreate(struct device *dev, const char *name,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;const struct fpga=5Fbridge=5Fops *br=5Fop=
s,
void *priv);<br>
+<br>
#endif /* =5FLINUX=5FFPGA=5FBRIDGE=5FH */<br>
-- <br>
2.7.4<br>
</font></tt><font size=3D3><br>
[pi=E8ce jointe &quot;noname&quot; supprim=E9e par Eric Delage/BRETTEVILLE/=
ZDF/BTECH/ZODIAC]
</font>
<br>
--=_alternative 0070C1A5C1258314_=--
