Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org> <948d6c0304eecaf916d21af5cfb0be21df80ed42.1528990947.git.mchehab+samsung@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Thu, 14 Jun 2018 11:39:20 -0500
Message-ID: <CANk1AXRnnYketpdvrsvN11hL6G9=WinzWHVM4k9VrGJZJ99pLQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] MAINTAINERS: get rid of non-existing Documentation/fpga
Content-Type: text/plain; charset="UTF-8"
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jun 14, 2018 at 11:09 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> This directory seems to have moved to a new place
> (Documentation/driver-api/fpga/), with is already at MAINTAINERS.
>
> So, get rid of the old location.

Wow, you caught that fast!  There's other documentation coming to this
directory soon.  IMO we might as well leave it.  We don't need to keep
adding and deleting this line from MAINTAINERS.

Also, why didn't you cc linux-fpga mailing list on this?  I guess you
ran get_maintainer.pl after adding this patch? :)

Alan

>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783ce44b3e7a..67641f5bb373 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5632,7 +5632,6 @@ L:        linux-fpga@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
>  Q:     http://patchwork.kernel.org/project/linux-fpga/list/
> -F:     Documentation/fpga/
>  F:     Documentation/driver-api/fpga/
>  F:     Documentation/devicetree/bindings/fpga/
>  F:     drivers/fpga/
> --
> 2.17.1
>
