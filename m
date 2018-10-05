Return-Path: <SRS0=Hrui=MR=gmail.com=groeck7@kernel.org>
Return-Path: <SRS0=Hrui=MR=gmail.com=groeck7@kernel.org>
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7fc4b9da-5fdf-11c9-e168-ccb2d960adea@roeck-us.net>
Date: Fri, 5 Oct 2018 06:26:22 -0700
MIME-Version: 1.0
In-Reply-To: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On 10/04/2018 09:12 PM, frowand.list@gmail.com wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

The same problem exists when of_parse_phandle_with_args() reports an error.

Guenter

> ---
>   drivers/of/unittest.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 6d80f474c8f2..b61a33f30a56 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -780,7 +780,7 @@ static void __init of_unittest_parse_interrupts(void)
>   	for (i = 0; i < 4; i++) {
>   		bool passed = true;
>   
> -		args.args_count = 0;
> +		memset(&args, 0, sizeof(args));
>   		rc = of_irq_parse_one(np, i, &args);
>   
>   		passed &= !rc;
> @@ -801,7 +801,7 @@ static void __init of_unittest_parse_interrupts(void)
>   	for (i = 0; i < 4; i++) {
>   		bool passed = true;
>   
> -		args.args_count = 0;
> +		memset(&args, 0, sizeof(args));
>   		rc = of_irq_parse_one(np, i, &args);
>   
>   		/* Test the values from tests-phandle.dtsi */
> @@ -854,6 +854,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
>   	for (i = 0; i < 7; i++) {
>   		bool passed = true;
>   
> +		memset(&args, 0, sizeof(args));
>   		rc = of_irq_parse_one(np, i, &args);
>   
>   		/* Test the values from tests-phandle.dtsi */
> 
