Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Nov 2018 13:24:31 -0600
Message-ID: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 5, 2018 at 9:26 AM <frowand.list@gmail.com> wrote:
>
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

I'm waiting for this to happen. Send me a pull req when it does or
when you give up waiting for a response.

Rob
