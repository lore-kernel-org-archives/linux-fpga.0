Return-Path: <SRS0=xDgO=2C=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=xDgO=2C=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANk1AXQ6Tf3MtHV2_iJ8cHxG71HYehQbZfcuKgK9124zCpS-nA@mail.gmail.com>
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
 <928f959d-fc36-ba5d-95ba-990dd1927489@xilinx.com> <CANk1AXQ6Tf3MtHV2_iJ8cHxG71HYehQbZfcuKgK9124zCpS-nA@mail.gmail.com>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Tue, 21 Feb 2017 12:26:17 -0600
Message-ID: <CANk1AXR3RK3na3h+EgPAcfjS2+4QRSqCZVKcJWHS=adcrpe=4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fpga: Add flag to indicate bitstream needs decrypting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Feb 21, 2017 at 10:35 AM, Alan Tull <delicious.quinoa@gmail.com>

Hi Greg,

Would it be helpful for us to resend patches for you to take with you
on cc?  Or is it enough that they are on lkml?

Thanks,
Alan Tull

wrote:
> On Tue, Feb 21, 2017 at 7:55 AM, Michal Simek <michal.simek@xilinx.com> w=
rote:
>> On 20.2.2017 21:55, mdf@kernel.org wrote:
>>> From: Moritz Fischer <mdf@kernel.org>
>>>
>>> Add a flag that is passed to the write_init() callback, indicating
>>> that the bitstream is encrypted.
>>>
>>> The low-level driver will deal with the flag, or return an error,
>>> if encrypted bitstreams are not supported.
>>>
>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>> Cc: Alan Tull <atull@kernel.org>
>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>> Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-fpga@vger.kernel.org
>>> ---
>>>
>>> Changes from v1:
>>> - Renamed flag from FPGA_MGR_DECRYPT_BITSTREAM->FPGA_MGR_ENCRYPTED_BITS=
TREAM
>>>
>>> ---
>>>  include/linux/fpga/fpga-mgr.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mg=
r.h
>>> index 57beb5d..e2ef94f 100644
>>> --- a/include/linux/fpga/fpga-mgr.h
>>> +++ b/include/linux/fpga/fpga-mgr.h
>>> @@ -70,6 +70,7 @@ enum fpga_mgr_states {
>>>   */
>>>  #define FPGA_MGR_PARTIAL_RECONFIG    BIT(0)
>>>  #define FPGA_MGR_EXTERNAL_CONFIG     BIT(1)
>>> +#define FPGA_MGR_ENCRYPTED_BITSTREAM BIT(2)
>>>
>>>  /**
>>>   * struct fpga_image_info - information specific to a FPGA image
>>>
>>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>
> Acked-by: Alan Tull <atull@kernel.org>
>
>>
>> Thanks,
>> Michal
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
