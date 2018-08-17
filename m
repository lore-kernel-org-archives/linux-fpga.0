Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180815220958.3606-1-atull@kernel.org> <1841468.1pWPcT6Du7@harkonnen>
 <20180816220034.GA4431@archbook> <2759044.uKe7sI2ItL@pcbe13614>
In-Reply-To: <2759044.uKe7sI2ItL@pcbe13614>
From: Alan Tull <atull@kernel.org>
Date: Fri, 17 Aug 2018 08:19:24 -0500
Message-ID: <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Content-Type: multipart/alternative; boundary="0000000000003a28710573a1695a"
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Dinh Nguyen <dinguyen@kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Alan Tull <atull@opensource.altera.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

--0000000000003a28710573a1695a
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 17, 2018, 2:00 AM Federico Vaga <federico.vaga@cern.ch> wrote:

> Hi Mortiz,
>
> I'm not 100% into the problem to understand all cases. I'm putting on the
> table the point of view, mainly, of an user. If you say there are problems
> here or there I believe you. At the beginning, you did not say that this
> interface may introduce problems (and I'm interested in those problems
> since I
> implemented one and we are using it), but that you fear that it becomes
> the
> default (usually, being a default is a good thing).
>
> Since you and Alan are working on this for a long time, you can read each
> other mind, but I need a more verbose email to understand ^_^'
>
> Of course the interface must be safe, I totally agree. In order to make me
> understand what are the issues, can you list some of them?


Before we repeat what the doc l posted says, could you look at it and
comment on what I'm not saying there?

https://lkml.org/lkml/2018/8/15/525

Alan

And expand your
> comment about  MMIO.
>
> (I just did a dummy backport, and implemented that interface. So, I repeat
> myself: I do not have enough experience with this framework to understand
> all
> consequences, but I'm interested to know what are the risks behind this
> interface)
>
> On Friday, August 17, 2018 12:00:34 AM CEST Moritz Fischer wrote:
> > Hi Federico,
> >
> > On Thu, Aug 16, 2018 at 11:21:32PM +0200, Federico Vaga wrote:
> > > Hi,
> > >
> > > On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:
> > > > On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer <mdf@kernel.org>
> wrote:
> > > > > Hi Alan,
> > > >
> > > > Hi Moritz,
> > > >
> > > > > comments inline. While I see how this is useful, I have the
> > > > > suspicion that from the moment this gets merged vendor kernels
> > > > > will just default to use this ...
> > > >
> > > > Yeah, I have that suspicion as well.  That's probably why I sat on
> > > > this and didn't upstream it for 2 years.  But on the other hand, I
> > > > keep hearing of lots of cases of people implementing this
> > > > independently anyway.  At least if it is debugfs, it makes it clear
> > > > that it's not intended for production use.
> > >
> > > I'm one of those guys who implemented this independently.
> >
> > We all have in one way or another ;) Most people on ARM run an out of
> tree
> > patch using devicetree overlays these days I hope rather than /dev/mem
> > and UIO ... or other vender solutions...
> >
> > > @Mortiz
> > > I do not see how this can be a bad thing (from what you wrote I guess
> you
> > > prefer another interface). Which interface to use depends on the use
> case.
> > > If you have this suspicion it's, I guess, because such interface it is
> > > extremely easy to use.
> >
> > What happens to a kernel driver doing MMIO with devices while you reload
> > the entire FPGA from userland?
> >
> > > @Alan
> > > DebugFS can be a first step, but I would go for a normal device in
> /dev at
> > > some point. I do not see why this should not be used in production
> >
> > I'm not against having a userland interface to reprogram the FPGA, the
> > Intel DFL code is a good example of a sensible one, doing so in a safe
> > manner.
> >
> > Ideally we'll get around to have a more generic interface, as we get
> > time to work on it.
> >
> > - Moritz
>
>
>
>
>

--0000000000003a28710573a1695a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, =
Aug 17, 2018, 2:00 AM Federico Vaga &lt;<a href=3D"mailto:federico.vaga@cer=
n.ch">federico.vaga@cern.ch</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Hi Mortiz,<br>
<br>
I&#39;m not 100% into the problem to understand all cases. I&#39;m putting =
on the <br>
table the point of view, mainly, of an user. If you say there are problems =
<br>
here or there I believe you. At the beginning, you did not say that this <b=
r>
interface may introduce problems (and I&#39;m interested in those problems =
since I <br>
implemented one and we are using it), but that you fear that it becomes the=
 <br>
default (usually, being a default is a good thing).<br>
<br>
Since you and Alan are working on this for a long time, you can read each <=
br>
other mind, but I need a more verbose email to understand ^_^&#39;<br>
<br>
Of course the interface must be safe, I totally agree. In order to make me =
<br>
understand what are the issues, can you list some of them?</blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">Before we repeat what=
 the doc l posted says, could you look at it and comment on what I&#39;m no=
t saying there?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><a href=
=3D"https://lkml.org/lkml/2018/8/15/525">https://lkml.org/lkml/2018/8/15/52=
5</a><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Alan</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"> And expand your <br>
comment about=C2=A0 MMIO.<br>
<br>
(I just did a dummy backport, and implemented that interface. So, I repeat =
<br>
myself: I do not have enough experience with this framework to understand a=
ll <br>
consequences, but I&#39;m interested to know what are the risks behind this=
 <br>
interface)<br>
<br>
On Friday, August 17, 2018 12:00:34 AM CEST Moritz Fischer wrote:<br>
&gt; Hi Federico,<br>
&gt; <br>
&gt; On Thu, Aug 16, 2018 at 11:21:32PM +0200, Federico Vaga wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt; <br>
&gt; &gt; On Thursday, August 16, 2018 10:04:51 PM CEST Alan Tull wrote:<br=
>
&gt; &gt; &gt; On Thu, Aug 16, 2018 at 1:59 PM, Moritz Fischer &lt;<a href=
=3D"mailto:mdf@kernel.org" target=3D"_blank" rel=3D"noreferrer">mdf@kernel.=
org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; Hi Alan,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Hi Moritz,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; comments inline. While I see how this is useful, I have=
 the<br>
&gt; &gt; &gt; &gt; suspicion that from the moment this gets merged vendor =
kernels<br>
&gt; &gt; &gt; &gt; will just default to use this ...<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Yeah, I have that suspicion as well.=C2=A0 That&#39;s probab=
ly why I sat on<br>
&gt; &gt; &gt; this and didn&#39;t upstream it for 2 years.=C2=A0 But on th=
e other hand, I<br>
&gt; &gt; &gt; keep hearing of lots of cases of people implementing this<br=
>
&gt; &gt; &gt; independently anyway.=C2=A0 At least if it is debugfs, it ma=
kes it clear<br>
&gt; &gt; &gt; that it&#39;s not intended for production use.<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m one of those guys who implemented this independently.<br>
&gt; <br>
&gt; We all have in one way or another ;) Most people on ARM run an out of =
tree<br>
&gt; patch using devicetree overlays these days I hope rather than /dev/mem=
<br>
&gt; and UIO ... or other vender solutions...<br>
&gt; <br>
&gt; &gt; @Mortiz<br>
&gt; &gt; I do not see how this can be a bad thing (from what you wrote I g=
uess you<br>
&gt; &gt; prefer another interface). Which interface to use depends on the =
use case.<br>
&gt; &gt; If you have this suspicion it&#39;s, I guess, because such interf=
ace it is<br>
&gt; &gt; extremely easy to use.<br>
&gt; <br>
&gt; What happens to a kernel driver doing MMIO with devices while you relo=
ad<br>
&gt; the entire FPGA from userland?<br>
&gt; <br>
&gt; &gt; @Alan<br>
&gt; &gt; DebugFS can be a first step, but I would go for a normal device i=
n /dev at<br>
&gt; &gt; some point. I do not see why this should not be used in productio=
n<br>
&gt; <br>
&gt; I&#39;m not against having a userland interface to reprogram the FPGA,=
 the<br>
&gt; Intel DFL code is a good example of a sensible one, doing so in a safe=
<br>
&gt; manner.<br>
&gt;<br>
&gt; Ideally we&#39;ll get around to have a more generic interface, as we g=
et<br>
&gt; time to work on it.<br>
&gt; <br>
&gt; - Moritz<br>
<br>
<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000003a28710573a1695a--
