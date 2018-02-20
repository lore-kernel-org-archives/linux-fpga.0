Return-Path: <SRS0=ga9A=FO=gmail.com=shubhrajyoti.datta@kernel.org>
Return-Path: <SRS0=ga9A=FO=gmail.com=shubhrajyoti.datta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519116003-6967-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1519116003-6967-1-git-send-email-shubhrajyoti.datta@xilinx.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Tue, 20 Feb 2018 14:04:38 +0530
Message-ID: <CAKfKVtHhQBOFdrU-qT0ZEuFcuR5vh8rq5bt_qgjmWxGypj-Kzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: fpga: Add reset bridge support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi ,


On Tue, Feb 20, 2018 at 2:10 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@xilinx.com> wrote:
> Add reset bridge support. Once this bridge is enabled.
> The reset line(s) will be toggled. Generally it will be
> called after the bitstream load to reset the PL.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,rst-bridge.txt   | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,rst-bridg=
e.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt b=
/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
> new file mode 100644
> index 0000000..6f1bfc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,rst-bridge.txt
> @@ -0,0 +1,22 @@
> +Xilinx fpga reset bridge
> +
> +The Xilinx reset bridge toggles the reset line to the PL
> +in Zynqmp Ultrascale plus.
> +
> +
> +Required properties:
> +- compatible   : Should contain "xlnx,rst-bridge"
> +- reset                : reset phandles
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
> +fpga_rst_bridge: fpga_rst_bridge {
> +       compatible =3D "xlnx,rst-bridge";
> +       resets =3D <&rst 115>;
> +};
> --
> 2.1.1
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
Please ignore will resend.
