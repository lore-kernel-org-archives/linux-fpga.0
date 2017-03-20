Return-Path: <SRS0=g2Ne=25=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=g2Ne=25=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489781473-30772-1-git-send-email-mdf@kernel.org>
References: <1489781473-30772-1-git-send-email-mdf@kernel.org>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Mon, 20 Mar 2017 11:17:29 -0500
Message-ID: <CANk1AXRD4WVa4qrc4Mh64seu1ha+Kff=sGuZ7t98V1PnnBD9Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] doc: Add bindings document for Xilinx LogiCore PR Decoupler
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 17, 2017 at 3:11 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

Minor nits below.  Otherwise, looks good.

> This adds the binding documentation for the Xilinx LogiCORE PR
> Decoupler soft core.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org

Acked-by: Alan Tull <atull@kernel.org>

> ---
>
> Changes from v2:
> - Added refence to generic fpga-region bindings
> - Fixed up reg property in example
> - Added fallback to "xlnx,pr-decoupler" without version
>
> Changes from v1:
> - Added clock names & clock to example
> - Merged some of the description from Michal's version
>
> ---
>  .../bindings/fpga/xilinx-pr-decoupler.txt          | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-deco=
upler.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.t=
xt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> new file mode 100644
> index 0000000..16141bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -0,0 +1,35 @@
> +Xilinx LogiCORE Partial Reconfig Decoupler Softcore
> +
> +The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
> +decouplers / fpga bridges.
> +The controller can decouple/disable the bridges which prevents signal
> +changes from passing through the bridge.  The controller can also
> +couple / enable the bridges which allows traffic to pass through the
> +bridge normally.
> +
> +The Driver supports only MMIO handling. A PR region can have multiple
> +PR Decouples which can bhe handled independently or chaines via decouple=
/

s/PR Decoupler/PR Decouplers/
s/bhe/be/
s/chaines/chained/

> +decouple_status signals.
> +
> +Required properties:
> +- compatible           : Should contain "xlnx,pr-decoupler-1.00"
> +- regs                 : base address and size for decoupler module
> +- clocks               : input clock to IP
> +- clock-names          : should contain "aclk"
> +
> +Optional properties:
> +- bridge-enable                : 0 if driver should disable bridge at st=
artup
> +                         1 if driver should enable bridge at startup
> +                         Default is to leave bridge in current state.
> +
> +See Documentation/devicetree/bindings/fpga/fpga-region.txt for generic b=
indings.
> +
> +Example:
> +       fpga-bridge@100000450 {
> +               compatible =3D "xlnx,pr-decoupler-1.00",
> +                            "xlnx-pr-decoupler";
> +               regs =3D <0x10000045 0x10>;
> +               clocks =3D <&clkc 15>;
> +               clock-names =3D "aclk";
> +               bridge-enable =3D <0>;
> +       };
> --
> 2.7.4
>
