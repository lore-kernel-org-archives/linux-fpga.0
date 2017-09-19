Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170919232424.2913-1-atull@kernel.org>
References: <20170919232424.2913-1-atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Tue, 19 Sep 2017 18:26:02 -0500
Message-ID: <CANk1AXTV9Dj1GkJNDE6SewCcJ69LXV_oQooHk86pr3fLM5FZmQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add backup maintainer
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Sep 19, 2017 at 6:24 PM, Alan Tull <atull@kernel.org> wrote:
> Add Moritz as a maintainer of the kernel FGPGA framework.

Argh!  I fixed this and then didn't do 'git format-patch' to
regenerate the patch!

Resending...

Alan
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b87c6989e82d..2d3d855ee6e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5441,7 +5441,7 @@ K:        fmc_d.*register
>
>  FPGA MANAGER FRAMEWORK
>  M:     Alan Tull <atull@kernel.org>
> -R:     Moritz Fischer <mdf@kernel.org>
> +M:     Moritz Fischer <mdf@kernel.org>
>  L:     linux-fpga@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
> --
> 2.11.0
>
