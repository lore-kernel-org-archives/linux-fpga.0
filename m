Return-Path: <SRS0=xDgO=2C=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=xDgO=2C=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <29bc6189-479e-c063-ef35-4ba99c5a1d56@xilinx.com>
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
 <1487624123-13579-2-git-send-email-mdf@kernel.org> <29bc6189-479e-c063-ef35-4ba99c5a1d56@xilinx.com>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Tue, 21 Feb 2017 10:36:14 -0600
Message-ID: <CANk1AXQeJQHfGnBvpcP_+K92X=-DiC7LQF55cX0u7HKECaPYDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fpga: zynq: Add support for encrypted bitstreams
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Michal Simek <michal.simek@xilinx.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 21, 2017 at 7:55 AM, Michal Simek <michal.simek@xilinx.com> wro=
te:
> On 20.2.2017 21:55, mdf@kernel.org wrote:
>> From: Moritz Fischer <mdf@kernel.org>
>>
>> Add support for encrypted bitstreams. For this to work the system
>> must be booted in secure mode.
>>
>> In order for on-the-fly decryption to work, the PCAP clock rate
>> needs to be lowered via the PCAP_RATE_EN bit.
>>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> Cc: Alan Tull <atull@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fpga@vger.kernel.org
>> ---
>>
>> Changes from v1:
>> - Renamed flag from FPGA_MGR_DECRYPT_BITSTREAM->FPGA_MGR_ENCRYPTED_BITST=
REAM
>>
>> ---
>>  drivers/fpga/zynq-fpga.c | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 34cb981..70b15b3 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -72,6 +72,10 @@
>>  #define CTRL_PCAP_PR_MASK            BIT(27)
>>  /* Enable PCAP */
>>  #define CTRL_PCAP_MODE_MASK          BIT(26)
>> +/* Lower rate to allow decrypt on the fly */
>> +#define CTRL_PCAP_RATE_EN_MASK               BIT(25)
>> +/* System booted in secure mode */
>> +#define CTRL_SEC_EN_MASK             BIT(7)
>>
>>  /* Miscellaneous Control Register bit definitions */
>>  /* Internal PCAP loopback */
>> @@ -266,6 +270,17 @@ static int zynq_fpga_ops_write_init(struct fpga_man=
ager *mgr,
>>       if (err)
>>               return err;
>>
>> +     /* check if bitstream is encrypted & and system's still secure */
>> +     if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) {
>> +             ctrl =3D zynq_fpga_read(priv, CTRL_OFFSET);
>> +             if (!(ctrl & CTRL_SEC_EN_MASK)) {
>> +                     dev_err(&mgr->dev,
>> +                             "System not secure, can't use crypted bits=
treams\n");
>> +                     err =3D -EINVAL;
>> +                     goto out_err;
>> +             }
>> +     }
>> +
>>       /* don't globally reset PL if we're doing partial reconfig */
>>       if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
>>               if (!zynq_fpga_has_sync(buf, count)) {
>> @@ -337,12 +352,19 @@ static int zynq_fpga_ops_write_init(struct fpga_ma=
nager *mgr,
>>
>>       /* set configuration register with following options:
>>        * - enable PCAP interface
>> -      * - set throughput for maximum speed
>> +      * - set throughput for maximum speed (if bistream not crypted)
>>        * - set CPU in user mode
>>        */
>>       ctrl =3D zynq_fpga_read(priv, CTRL_OFFSET);
>> -     zynq_fpga_write(priv, CTRL_OFFSET,
>> -                     (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl));
>> +     if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
>> +             zynq_fpga_write(priv, CTRL_OFFSET,
>> +                             (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
>> +                              | CTRL_PCAP_RATE_EN_MASK | ctrl));
>> +     else
>> +             zynq_fpga_write(priv, CTRL_OFFSET,
>> +                             (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
>> +                              | ctrl));
>> +
>>
>>       /* We expect that the command queue is empty right now. */
>>       status =3D zynq_fpga_read(priv, STATUS_OFFSET);
>>
>
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Alan Tull <atull@kernel.org>

>
> Thanks,
> Michal
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
