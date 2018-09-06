Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-6-atull@kernel.org>
In-Reply-To: <20180904212237.3078-6-atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Date: Thu, 6 Sep 2018 13:01:42 -0500
Message-ID: <CANk1AXTiHNV7ovn8nLsA9peCqeoa95Oytevijy1Eh2novAg=ZA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: fpga: fix freeze controller
 compatible in region doc
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Sep 4, 2018 at 4:22 PM Alan Tull <atull@kernel.org> wrote:

OK I left off the DT folk.  I'll resend this one patch separately.

Alan

>
> Documentation/devicetree/bindings/fpga/fpga-region.txt has an error
> regarding the freeze controller bridge, secifically:
>
>  compatible = "altr,freeze-bridge";
>
> The compatibility string should be "altr,freeze-bridge-controller"
> as set forth in altera-freeze-bridge.txt.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Reported-by: Dalon Westergreen <dalon.westergreen@intel.com>
> ---
> v2: no change in v2 of patchset
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
