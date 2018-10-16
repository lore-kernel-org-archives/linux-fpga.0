Return-Path: <SRS0=Kx5u=M4=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=Kx5u=M4=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 00/18] of: overlay: validation checks, subsequent fixes
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Date: Tue, 16 Oct 2018 20:47:27 +1100
Message-ID: <87murekyts.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

frowand.list@gmail.com writes:

> From: Frank Rowand <frank.rowand@sony.com>
>
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
>
> The checks revealed bugs in existing code.  Fixed the bugs.
>
> While fixing bugs, noted other issues, which are fixed in
> separate patches.
>
> *****  Powerpc folks: I was not able to test the patches that
> *****  directly impact Powerpc systems that use dynamic
> *****  devicetree.  Please review that code carefully and
> *****  test.  The specific patches are: 03/16, 04/16, 07/16

Hi Frank,

Do you have this series in a git tree somewhere?

I tried applying it on top of linux-next but hit some conflicts which I
couldn't easily resolve.

cheers
