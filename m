Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com> <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
In-Reply-To: <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 24 Oct 2018 14:57:31 -0500
Message-ID: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
Content-Type: text/plain; charset="UTF-8"
To: Alan Tull <atull@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Oct 22, 2018 at 4:25 PM Alan Tull <atull@kernel.org> wrote:
>
> On Thu, Oct 18, 2018 at 5:48 PM <frowand.list@gmail.com> wrote:
> >
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> > Add checks to (1) overlay apply process and (2) memory freeing
> > triggered by overlay release.  The checks are intended to detect
> > possible memory leaks and invalid overlays.
>
> I've tested v5, nothing new to report.

Does that mean everything broken or everything works great? In the
latter case, care to give a Tested-by.

Rob
