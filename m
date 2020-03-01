Date: Sun, 1 Mar 2020 08:22:46 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv1 4/7] dt-bindings, firmware: add compatible value Intel
 Stratix10 service layer binding
Message-ID: <20200301162244.GC7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Feb 14, 2020 at 10:00:49AM -0600, richard.gong@linux.intel.com wrot=
e:
> From: Richard Gong <richard.gong@intel.com>
>=20
> A a compatible property value to Intel Stratix10 service layer binding
>=20
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-s=
vc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> index 1fa6606..6eff1af 100644
> --- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> +++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> @@ -23,7 +23,7 @@ Required properties:
>  The svc node has the following mandatory properties, must be located und=
er
>  the firmware node.
> =20
> -- compatible: "intel,stratix10-svc"
> +- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
>  - method: smc or hvc
>          smc - Secure Monitor Call
>          hvc - Hypervisor Call
> --=20
> 2.7.4
>=20
Applied to for-next,

Thanks
