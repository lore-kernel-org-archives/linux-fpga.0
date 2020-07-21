Return-Path: <SRS0=v5EL=BA=gmail.com=robherring2@kernel.org>
Return-Path: <SRS0=v5EL=BA=gmail.com=robherring2@kernel.org>
Date: Mon, 20 Jul 2020 19:50:27 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] fpga: region: Replace HTTP links with HTTPS ones
Message-ID: <20200721015027.GA3358506@bogus>
References: <20200713134008.34635-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713134008.34635-1-grandmaster@al2klimov.de>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, mdf@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Mon, 13 Jul 2020 15:40:08 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
