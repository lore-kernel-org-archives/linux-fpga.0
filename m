Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com> <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 5 Oct 2018 09:53:08 -0500
Message-ID: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling of_irq_parse_one()
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Callers of of_irq_parse_one() blindly use the pointer args.np
> without checking whether of_irq_parse_one() had an error and
> thus did not set the value of args.np.  Initialize args to
> zero so that using the format "%pOF" to show the value of
> args.np will show "(null)" when of_irq_parse_one() has an
> error and does not set args.np instead of trying to
> dereference a random value.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does this need to be part of this series?

Rob
