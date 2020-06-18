Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
References: <20200611211144.9421-1-luca@lucaceresoli.net> <20200611211144.9421-4-luca@lucaceresoli.net>
 <20200617223955.GA2967317@bogus> <b2c064c0-9a52-890d-b026-9cc1f4cab7d0@lucaceresoli.net>
In-Reply-To: <b2c064c0-9a52-890d-b026-9cc1f4cab7d0@lucaceresoli.net>
From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Jun 2020 12:07:32 -0600
Message-ID: <CAL_JsqLCYdRci2W3otAwz_rDKQeFXuOdO0ZAv4fUGNZoiZb6hg@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: fpga: xilinx-slave-serial: add optional
 INIT_B GPIO
Content-Type: text/plain; charset="UTF-8"
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Jun 17, 2020 at 11:47 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Rob, Moritz,
>
> On 18/06/20 00:39, Rob Herring wrote:
> > On Thu, Jun 11, 2020 at 11:11:43PM +0200, Luca Ceresoli wrote:
> >> The INIT_B is used by the 6 and 7 series to report the programming status,
> >> providing more control and information about programming errors.
> >>
> >> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> >> ---
> >>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> >> index 9f103f3872e8..a049082e1513 100644
> >> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> >> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> >> @@ -16,6 +16,10 @@ Required properties:
> >>  - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
> >>  - done-gpios: config status pin (referred to as DONE in the manual)
> >>
> >> +Optional properties:
> >> +- init_b-gpios: initialization status and configuration error pin
> >> +                (referred to as INIT_B in the manual)
> >
> > Don't use '_' in property names:
> >
> > init-b-gpios
>
> OK, will fix.
>
> Moritz, please don't apply this version of patches 4 and 5 if you still
> haven't done so.
>
> Now what about the existing prog_b-gpios property? Should we just leave
> it as is for backward compatibility, or is there a migration path to fix
> it as well?

Just leave it.

Rob
