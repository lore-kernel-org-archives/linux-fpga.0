Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180906180152.3620-1-atull@kernel.org> <20180906182359.GB20419@archbook>
In-Reply-To: <20180906182359.GB20419@archbook>
From: Alan Tull <atull@kernel.org>
Date: Thu, 6 Sep 2018 13:29:30 -0500
Message-ID: <CANk1AXT_U_Sdkvgjwf_2+ryNF7zCjreKZUnFzXt3ZtRWcWz2+w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: fpga: fix freeze controller compatible in
 region doc
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Sep 6, 2018 at 1:24 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Alan,
>
> looks like it's just the examples, right?

Yes, it's in the examples of use, not the actual freeze bridge
bindings doc that I'm correcting.

> So not sure someone
> would be affected by that, yet?

It's taken two years for anybody to notice and complain about it :) so
the effect has not been very terrible.  But it's good to correct it
since it's been noticed.

>
> On Thu, Sep 06, 2018 at 01:01:52PM -0500, Alan Tull wrote:
> > Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> > regarding the freeze controller bridge, secifically:
> >
> >  compatible = "altr,freeze-bridge";
> >
> > The compatibility string should be "altr,freeze-bridge-controller"
> > as set forth in altera-freeze-bridge.txt.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
>
> Acked-by: Moritz Fischer <mdf@kernel.org>
>
> Cheers,
>
> Moritz

Thanks Moritz!

Alan
