Return-Path: <SRS0=LO+F=MI=zodiacaerospace.com=prvs=9807057bb5=eric.delage@kernel.org>
Return-Path: <SRS0=LO+F=MI=zodiacaerospace.com=prvs=9807057bb5=eric.delage@kernel.org>
In-Reply-To: <1537978342-17697-3-git-send-email-atull@kernel.org>
References: <1537978342-17697-1-git-send-email-atull@kernel.org> <1537978342-17697-3-git-send-email-atull@kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3 2/4] fpga: bridge: add devm_fpga_bridge_create
Message-ID: <OFE9B73D95.73C2CEF2-ONC1258314.005AEBC6-C1258314.005C6433@zodiacaerospace.com>
From: Eric.Delage@zodiacaerospace.com
Date: Wed, 26 Sep 2018 18:49:09 +0200
Content-Type: multipart/related; boundary="=_related 005C642FC1258314_="
To: Alan Tull <atull@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Federico Vaga <federico.vaga@cern.ch>, linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org, linux-fpga-owner@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
List-ID: <linux-fpga@vger.kernel.org>

Message en plusieurs parties au format MIME
--=_related 005C642FC1258314_=
Content-Type: multipart/alternative; boundary="=_alternative 005C642FC1258314_="


--=_alternative 005C642FC1258314_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Est-ce que je comprends bien qu'il ne s'agit que d'une carte de traitement =

FPGA sans possibilit=E9 de mettre une carte-fille type FMA (=E0 la REFLEX C=
ES=20
avec sa carte acc=E9l=E9ratrice FPGA) ?
4 XCKU115 pour les russes equiv. 2 cartes FPGA Xilinx avec des VU37P. Env. =

de d=E9veloppement SDAccel identique mais fait plut=F4t pour =EAtre utilis=
=E9 en=20
acc=E9l=E9rateur.
L'approche carte LB2P1/XCKU040-060 + carte FPGA est amha =E0 investiguer=20
s=E9rieusement.

Kind Regards,
Mit freundlichen Gr=FCssen,
Sinc=E8res Salutations,

ZODIAC DATA SYSTEMS
ZODIAC AEROSYSTEMS
Control Systems Division


Eric DELAGE
Head of the Monitoring Front-End Group, and
Technical Product Manager for IFoIP and RF2P(CIe) Solutions

Campus EffiScience - 5 Esplanade Anton Philips - 14460 Colombelles -=20
France
Tel: +33.2.31.29.49.45 - Fax: +33.2.31.80.65.49
eric.delage@zodiacaerospace.com
http://www.zodiacaerospace.com
http://www.linkedin.com/in/ericdelage




De :    Alan Tull <atull@kernel.org>
A :     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc :    Randy Dunlap <rdunlap@infradead.org>, Federico Vaga=20
<federico.vaga@cern.ch>, linux-kernel@vger.kernel.org,=20
linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull=20
<atull@kernel.org>
Date :  26/09/2018 18:13
Objet : [PATCH v3 2/4] fpga: bridge: add devm=5Ffpga=5Fbridge=5Fcreate
Envoy=E9 par :    linux-fpga-owner@vger.kernel.org



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
=20
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
+   :functions: devm=5Ffpga=5Fbridge=5Fcreate
+
+.. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga=5Fbridge=5Fcreate
=20
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
=20
-                br =3D fpga=5Fbridge=5Fcreate(dev, F2S=5FBRIDGE=5FNAME,
- &altera=5Ffpga2sdram=5Fbr=5Fops, priv);
+                br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, F2S=5FBRIDGE=5FN=
AME,
+ &altera=5Ffpga2sdram=5Fbr=5Fops, priv);
                 if (!br)
                                 return -ENOMEM;
=20
                 platform=5Fset=5Fdrvdata(pdev, br);
=20
                 ret =3D fpga=5Fbridge=5Fregister(br);
-                if (ret) {
-                                fpga=5Fbridge=5Ffree(br);
+                if (ret)
                                 return ret;
-                }
=20
                 dev=5Finfo(dev, "driver initialized with handoff %08x\n", =

priv->mask);
=20
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
-                int ret;
=20
                 if (!np)
                                 return -ENODEV;
@@ -245,20 +244,14 @@ static int altera=5Ffreeze=5Fbr=5Fprobe(struct=20
platform=5Fdevice *pdev)
=20
                 priv->base=5Faddr =3D base=5Faddr;
=20
-                br =3D fpga=5Fbridge=5Fcreate(dev, FREEZE=5FBRIDGE=5FNAME,
- &altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);
+                br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, FREEZE=5FBRIDGE=
=5FNAME,
+ &altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);
                 if (!br)
                                 return -ENOMEM;
=20
                 platform=5Fset=5Fdrvdata(pdev, br);
=20
-                ret =3D fpga=5Fbridge=5Fregister(br);
-                if (ret) {
-                                fpga=5Fbridge=5Ffree(br);
-                                return ret;
-                }
-
-                return 0;
+                return fpga=5Fbridge=5Fregister(br);
 }
=20
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
=20
-                br =3D fpga=5Fbridge=5Fcreate(dev, priv->name,=20
&altera=5Fhps2fpga=5Fbr=5Fops, priv);
+                br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, priv->name,
+ &altera=5Fhps2fpga=5Fbr=5Fops, priv);
                 if (!br) {
                                 ret =3D -ENOMEM;
                                 goto err;
@@ -190,12 +191,10 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct=20
platform=5Fdevice *pdev)
=20
                 ret =3D fpga=5Fbridge=5Fregister(br);
                 if (ret)
-                                goto err=5Ffree;
+                                goto err;
=20
                 return 0;
=20
-err=5Ffree:
-                fpga=5Fbridge=5Ffree(br);
 err:
                 clk=5Fdisable=5Funprepare(priv->clk);
=20
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 7cc041d..3ff9f3a 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -61,7 +61,6 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *pde=
v)
                 struct device *dev =3D &pdev->dev;
                 struct fme=5Fbr=5Fpriv *priv;
                 struct fpga=5Fbridge *br;
-                int ret;
=20
                 priv =3D devm=5Fkzalloc(dev, sizeof(*priv), GFP=5FKERNEL);
                 if (!priv)
@@ -69,18 +68,14 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *p=
dev)
=20
                 priv->pdata =3D dev=5Fget=5Fplatdata(dev);
=20
-                br =3D fpga=5Fbridge=5Fcreate(dev, "DFL FPGA FME Bridge",
- &fme=5Fbridge=5Fops, priv);
+                br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, "DFL FPGA FME Br=
idge",
+ &fme=5Fbridge=5Fops, priv);
                 if (!br)
                                 return -ENOMEM;
=20
                 platform=5Fset=5Fdrvdata(pdev, br);
=20
-                ret =3D fpga=5Fbridge=5Fregister(br);
-                if (ret)
-                                fpga=5Fbridge=5Ffree(br);
-
-                return ret;
+                return fpga=5Fbridge=5Fregister(br);
 }
=20
 static int fme=5Fbr=5Fremove(struct platform=5Fdevice *pdev)
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index c983dac..80bd8f1 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -324,6 +324,9 @@ ATTRIBUTE=5FGROUPS(fpga=5Fbridge);
  * @br=5Fops:             pointer to structure of fpga bridge ops
  * @priv:               FPGA bridge private data
  *
+ * The caller of this function is responsible for freeing the bridge with
+ * fpga=5Fbridge=5Ffree().  Using devm=5Ffpga=5Fbridge=5Fcreate() instead =
is=20
recommended.
+ *
  * Return: struct fpga=5Fbridge or NULL
  */
 struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct device *dev, const cha=
r=20
*name,
@@ -378,8 +381,8 @@ struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct dev=
ice=20
*dev, const char *name,
 EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Fcreate);
=20
 /**
- * fpga=5Fbridge=5Ffree - free a fpga bridge and its id
- * @bridge:             FPGA bridge struct created by fpga=5Fbridge=5Fcrea=
te
+ * fpga=5Fbridge=5Ffree - free a fpga bridge created by fpga=5Fbridge=5Fcr=
eate()
+ * @bridge:             FPGA bridge struct
  */
 void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *bridge)
 {
@@ -388,9 +391,56 @@ void fpga=5Fbridge=5Ffree(struct fpga=5Fbridge *bridge)
 }
 EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Ffree);
=20
+static void devm=5Ffpga=5Fbridge=5Frelease(struct device *dev, void *res)
+{
+                struct fpga=5Fbridge *bridge =3D *(struct fpga=5Fbridge **=
)res;
+
+                fpga=5Fbridge=5Ffree(bridge);
+}
+
 /**
- * fpga=5Fbridge=5Fregister - register a fpga bridge
- * @bridge:             FPGA bridge struct created by fpga=5Fbridge=5Fcrea=
te
+ * devm=5Ffpga=5Fbridge=5Fcreate - create and init a managed struct fpga=
=5Fbridge
+ * @dev:                FPGA bridge device from pdev
+ * @name:               FPGA bridge name
+ * @br=5Fops:             pointer to structure of fpga bridge ops
+ * @priv:               FPGA bridge private data
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
+                                                 const struct=20
fpga=5Fbridge=5Fops *br=5Fops, void *priv)
+{
+                struct fpga=5Fbridge **ptr, *bridge;
+
+                ptr =3D devres=5Falloc(devm=5Ffpga=5Fbridge=5Frelease,=20
sizeof(*ptr), GFP=5FKERNEL);
+                if (!ptr)
+                                return NULL;
+
+                bridge =3D fpga=5Fbridge=5Fcreate(dev, name, br=5Fops, pri=
v);
+                if (!bridge) {
+                                devres=5Ffree(ptr);
+                } else {
+                                *ptr =3D bridge;
+                                devres=5Fadd(dev, ptr);
+                }
+
+                return bridge;
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
=20
 /**
- * fpga=5Fbridge=5Funregister - unregister and free a fpga bridge
- * @bridge:             FPGA bridge struct created by fpga=5Fbridge=5Fcrea=
te
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
=20
 static void fpga=5Fbridge=5Fdev=5Frelease(struct device *dev)
 {
-                struct fpga=5Fbridge *bridge =3D to=5Ffpga=5Fbridge(dev);
-
-                fpga=5Fbridge=5Ffree(bridge);
 }
=20
 static int =5F=5Finit fpga=5Fbridge=5Fdev=5Finit(void)
diff --git a/drivers/fpga/xilinx-pr-decoupler.c=20
b/drivers/fpga/xilinx-pr-decoupler.c
index 07ba153..6410361 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -121,8 +121,8 @@ static int xlnx=5Fpr=5Fdecoupler=5Fprobe(struct=20
platform=5Fdevice *pdev)
=20
                 clk=5Fdisable(priv->clk);
=20
-                br =3D fpga=5Fbridge=5Fcreate(&pdev->dev, "Xilinx PR=20
Decoupler",
- &xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);
+                br =3D devm=5Ffpga=5Fbridge=5Fcreate(&pdev->dev, "Xilinx P=
R=20
Decoupler",
+ &xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);
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
=20
+struct fpga=5Fbridge
+*devm=5Ffpga=5Fbridge=5Fcreate(struct device *dev, const char *name,
+                                                 const struct=20
fpga=5Fbridge=5Fops *br=5Fops, void *priv);
+
 #endif /* =5FLINUX=5FFPGA=5FBRIDGE=5FH */
--=20
2.7.4



--=_alternative 005C642FC1258314_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Est-ce que je comprends bien qu'il ne s'=
agit
que d'une carte de traitement FPGA sans possibilit=E9 de mettre une carte-f=
ille
type FMA (=E0 la REFLEX CES avec sa carte acc=E9l=E9ratrice FPGA) ?</font>
<br><font size=3D2 face=3D"sans-serif">4 XCKU115 pour les russes equiv. 2 c=
artes
FPGA Xilinx avec des VU37P. Env. de d=E9veloppement SDAccel identique mais
fait plut=F4t pour =EAtre utilis=E9 en acc=E9l=E9rateur.</font>
<br><font size=3D2 face=3D"sans-serif">L'approche carte LB2P1/XCKU040-060 +
carte FPGA est amha =E0 investiguer s=E9rieusement.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Kind Regards,</font>
<br><font size=3D2 face=3D"sans-serif">Mit freundlichen Gr=FCssen,</font>
<br><font size=3D2 face=3D"sans-serif">Sinc=E8res Salutations,</font>
<br>
<table width=3D425 style=3D"border-collapse:collapse;">
<tr height=3D8>
<td width=3D289 style=3D"border-style:none none none none;border-color:#000=
000;border-width:0px 0px 0px 0px;padding:1px 1px;"><font size=3D1 color=3D#=
808080 face=3D"Arial"><b><u>ZODIAC
DATA SYSTEMS</u><br>
ZODIAC AEROSYSTEMS</b><br>
Control Systems Division</font>
<td width=3D132 style=3D"border-style:none none none none;border-color:#000=
000;border-width:0px 0px 0px 0px;padding:1px 1px;"><img align=3Dright src=
=3Dcid:=5F2=5F108B463C108B423C005C642CC1258314 alt=3Dlogo style=3D"border:0=
px solid;">
<tr height=3D8>
<td width=3D423 colspan=3D2 style=3D"border-style:none none none none;borde=
r-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"><font size=
=3D1 face=3D"Arial"><b><br>
Eric DELAGE</b><br>
Head of the Monitoring Front-End Group, and</font>
<br><font size=3D1 face=3D"Arial">Technical Product Manager for IFoIP and R=
F2P(CIe)
Solutions</font>
<tr height=3D8>
<td width=3D423 colspan=3D2 style=3D"border-style:none none none none;borde=
r-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"><font size=
=3D1 color=3D#808080 face=3D"Arial"><br>
Campus EffiScience - 5 Esplanade Anton Philips - 14460 Colombelles - France=
<br>
Tel: +33.2.31.29.49.45 - Fax: +33.2.31.80.65.49</font>
<br><a href=3Dmailto:Eric.DELAGE@ZodiacAerospace.Com><font size=3D1 color=
=3D#808080 face=3D"Arial">eric.delage@zodiacaerospace.com</font></a>
<br><a href=3D"http://www.zodiacaerospace.com&lt;br/&gt;http://WWW.ZDS-Fr.C=
om"><font size=3D1 color=3D#808080 face=3D"Arial">http://www.zodiacaerospac=
e.com</font></a>
<br><a href=3Dhttp://www.linkedin.com/in/ericdelage><font size=3D1 color=3D=
blue face=3D"Arial">http://www.linkedin.com/in/ericdelage</font></a></table>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">Moritz Fischer &lt;mdf@kern=
el.org&gt;,
Jonathan Corbet &lt;corbet@lwn.net&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc&nbsp;: &nbsp; &nb=
sp;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Randy Dunlap
&lt;rdunlap@infradead.org&gt;, Federico Vaga &lt;federico.vaga@cern.ch&gt;,
linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.ke=
rnel.org,
Alan Tull &lt;atull@kernel.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date : &nbsp; &nbsp;=
 &nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">26/09/2018 18:13</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Objet : &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">[PATCH v3 2/4]
fpga: bridge: add devm=5Ffpga=5Fbridge=5Fcreate</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Envoy=E9 par : &nbsp=
; &nbsp;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">linux-fpga-owner@vge=
r.kernel.org</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>Add devm=5Ffpga=5Fbridge=5Fcreate() which is the man=
aged<br>
version of fpga=5Fbridge=5Fcreate().<br>
<br>
Change current bridge drivers to use<br>
devm=5Ffpga=5Fbridge=5Fcreate().<br>
<br>
Signed-off-by: Alan Tull &lt;atull@kernel.org&gt;<br>
Suggested-by: Federico Vaga &lt;federico.vaga@cern.ch&gt;<br>
Acked-by: Moritz Fischer &lt;mdf@kernel.org&gt;<br>
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
 drivers/fpga/xilinx-pr-decoupler.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;| &nbsp;4 +-<br>
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
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*
Get f2s bridge configuration saved in handoff register */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;regmap=5Frea=
d(sysmgr,
SYSMGR=5FISWGRP=5FHANDOFF3, &amp;priv-&gt;mask);<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D fpga=5Fbridge=5Fcreate(dev, F2S=5FBRIDGE=5FNAME,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;altera=
=5Ffpga2sdram=5Fbr=5Fops,
priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, F2S=5FBRIDGE=5FNAME,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &amp;altera=5Ffpga2sdram=5Fbr=5Fops, priv);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!br)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return -ENOMEM;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;platform=5Fs=
et=5Fdrvdata(pdev,
br);<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret
=3D fpga=5Fbridge=5Fregister(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
if (ret) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpga=5Fbridge=
=5Ffree(br);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
if (ret)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return ret;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
}<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dev=5Finfo(d=
ev,
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
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
fpga=5Fbridge *br;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
resource *res;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;u32
status, revision;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
int ret;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!np)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return -ENODEV;<br>
@@ -245,20 +244,14 @@ static int altera=5Ffreeze=5Fbr=5Fprobe(struct platfo=
rm=5Fdevice
*pdev)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv-&gt;bas=
e=5Faddr
=3D base=5Faddr;<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D fpga=5Fbridge=5Fcreate(dev, FREEZE=5FBRIDGE=5FNAME,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;altera=
=5Ffreeze=5Fbr=5Fbr=5Fops,
priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, FREEZE=5FBRIDGE=5FNAME,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &amp;altera=5Ffreeze=5Fbr=5Fbr=5Fops, priv);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!br)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return -ENOMEM;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;platform=5Fs=
et=5Fdrvdata(pdev,
br);<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
ret =3D fpga=5Fbridge=5Fregister(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
if (ret) {<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpga=5Fbridge=
=5Ffree(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
ret;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
}<br>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return 0;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return fpga=5Fbridge=5Fregister(br);<br>
 }<br>
 <br>
 static int altera=5Ffreeze=5Fbr=5Fremove(struct platform=5Fdevice *pdev)<b=
r>
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.=
c<br>
index a974d3f..77b95f2 100644<br>
--- a/drivers/fpga/altera-hps2fpga.c<br>
+++ b/drivers/fpga/altera-hps2fpga.c<br>
@@ -180,7 +180,8 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct platform=
=5Fdevice
*pdev)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
}<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D fpga=5Fbridge=5Fcreate(dev, priv-&gt;name, &amp;altera=5Fhps2fpga=5F=
br=5Fops,
priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, priv-&gt;name,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &amp;altera=5Fhps2fpga=5Fbr=5Fops, priv);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!br) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
ret =3D -ENOMEM;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
goto err;<br>
@@ -190,12 +191,10 @@ static int alt=5Ffpga=5Fbridge=5Fprobe(struct platfor=
m=5Fdevice
*pdev)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret
=3D fpga=5Fbridge=5Fregister(br);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(ret)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto
err=5Ffree;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto
err;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
0;<br>
 <br>
-err=5Ffree:<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
fpga=5Fbridge=5Ffree(br);<br>
 err:<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;clk=5Fdisabl=
e=5Funprepare(priv-&gt;clk);<br>
 <br>
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c<br>
index 7cc041d..3ff9f3a 100644<br>
--- a/drivers/fpga/dfl-fme-br.c<br>
+++ b/drivers/fpga/dfl-fme-br.c<br>
@@ -61,7 +61,6 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *pde=
v)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
device *dev =3D &amp;pdev-&gt;dev;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
fme=5Fbr=5Fpriv *priv;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
fpga=5Fbridge *br;<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
int ret;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv
=3D devm=5Fkzalloc(dev, sizeof(*priv), GFP=5FKERNEL);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!priv)<br>
@@ -69,18 +68,14 @@ static int fme=5Fbr=5Fprobe(struct platform=5Fdevice *p=
dev)<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;priv-&gt;pda=
ta
=3D dev=5Fget=5Fplatdata(dev);<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D fpga=5Fbridge=5Fcreate(dev, &quot;DFL FPGA FME Bridge&quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;fme=5Fbr=
idge=5Fops,
priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D devm=5Ffpga=5Fbridge=5Fcreate(dev, &quot;DFL FPGA FME Bridge&quot;,<=
br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &amp;fme=5Fbridge=5Fops, priv);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!br)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return -ENOMEM;<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;platform=5Fs=
et=5Fdrvdata(pdev,
br);<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
ret =3D fpga=5Fbridge=5Fregister(br);<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
if (ret)<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpga=5Fbridge=
=5Ffree(br);<br>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return ret;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return fpga=5Fbridge=5Fregister(br);<br>
 }<br>
 <br>
 static int fme=5Fbr=5Fremove(struct platform=5Fdevice *pdev)<br>
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c<br>
index c983dac..80bd8f1 100644<br>
--- a/drivers/fpga/fpga-bridge.c<br>
+++ b/drivers/fpga/fpga-bridge.c<br>
@@ -324,6 +324,9 @@ ATTRIBUTE=5FGROUPS(fpga=5Fbridge);<br>
 &nbsp;* @br=5Fops: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; pointer to structure of fpga bridge ops<br>
 &nbsp;* @priv: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; FPGA bridge private data<br>
 &nbsp;*<br>
+ * The caller of this function is responsible for freeing the bridge with<=
br>
+ * fpga=5Fbridge=5Ffree(). &nbsp;Using devm=5Ffpga=5Fbridge=5Fcreate() ins=
tead is
recommended.<br>
+ *<br>
 &nbsp;* Return: struct fpga=5Fbridge or NULL<br>
 &nbsp;*/<br>
 struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct device *dev, const char
*name,<br>
@@ -378,8 +381,8 @@ struct fpga=5Fbridge *fpga=5Fbridge=5Fcreate(struct dev=
ice
*dev, const char *name,<br>
 EXPORT=5FSYMBOL=5FGPL(fpga=5Fbridge=5Fcreate);<br>
 <br>
 /**<br>
- * fpga=5Fbridge=5Ffree - free a fpga bridge and its id<br>
- * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge struct created by fpga=5Fbridge=5Fcreate<br>
+ * fpga=5Fbridge=5Ffree - free a fpga bridge created by fpga=5Fbridge=5Fcr=
eate()<br>
+ * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge struct<br>
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
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
struct fpga=5Fbridge *bridge =3D *(struct fpga=5Fbridge **)res;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
fpga=5Fbridge=5Ffree(bridge);<br>
+}<br>
+<br>
 /**<br>
- * fpga=5Fbridge=5Fregister - register a fpga bridge<br>
- * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge struct created by fpga=5Fbridge=5Fcreate<br>
+ * devm=5Ffpga=5Fbridge=5Fcreate - create and init a managed struct fpga=
=5Fbridge<br>
+ * @dev: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge device from pdev<br>
+ * @name: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge name<br>
+ * @br=5Fops: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
pointer to structure of fpga bridge ops<br>
+ * @priv: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge private data<br>
+ *<br>
+ * This function is intended for use in a FPGA bridge driver's probe funct=
ion.<br>
+ * After the bridge driver creates the struct with devm=5Ffpga=5Fbridge=5F=
create(),
it<br>
+ * should register the bridge with fpga=5Fbridge=5Fregister(). &nbsp;The b=
ridge
driver's<br>
+ * remove function should call fpga=5Fbridge=5Funregister(). &nbsp;The bri=
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
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;const struct fpga=5Fbridge=5Fops *br=5Fops, void *priv)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
struct fpga=5Fbridge **ptr, *bridge;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
ptr =3D devres=5Falloc(devm=5Ffpga=5Fbridge=5Frelease, sizeof(*ptr), GFP=5F=
KERNEL);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
if (!ptr)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
NULL;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
bridge =3D fpga=5Fbridge=5Fcreate(dev, name, br=5Fops, priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
if (!bridge) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;devres=5Ffree=
(ptr);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
} else {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*ptr
=3D bridge;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;devres=5Fadd(=
dev,
ptr);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
}<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
return bridge;<br>
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
- * @bridge: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
FPGA bridge struct created by fpga=5Fbridge=5Fcreate<br>
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
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
struct fpga=5Fbridge *bridge =3D to=5Ffpga=5Fbridge(dev);<br>
-<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
fpga=5Fbridge=5Ffree(bridge);<br>
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
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;clk=5Fdisabl=
e(priv-&gt;clk);<br>
 <br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D fpga=5Fbridge=5Fcreate(&amp;pdev-&gt;dev, &quot;Xilinx PR Decoupler&=
quot;,<br>
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;xlnx=5Fp=
r=5Fdecoupler=5Fbr=5Fops,
priv);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
br =3D devm=5Ffpga=5Fbridge=5Fcreate(&amp;pdev-&gt;dev, &quot;Xilinx PR Dec=
oupler&quot;,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &amp;xlnx=5Fpr=5Fdecoupler=5Fbr=5Fops, priv);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!br) {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
err =3D -ENOMEM;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
goto err=5Fclk;<br>
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
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;const struct fpga=5Fbridge=5Fops *br=5Fops, void *priv);<br>
+<br>
 #endif /* =5FLINUX=5FFPGA=5FBRIDGE=5FH */<br>
-- <br>
2.7.4<br>
<br>
</font></tt>
<br>
--=_alternative 005C642FC1258314_=--

--=_related 005C642FC1258314_=
Content-Type: image/jpeg
Content-ID: <_2_108B463C108B423C005C642CC1258314>
Content-Transfer-Encoding: base64

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
MztUZtpfS8R20uzkfS8nR7S//9k=
--=_related 005C642FC1258314_=--
