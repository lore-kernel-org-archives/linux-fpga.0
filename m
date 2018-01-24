Return-Path: <SRS0=VREm=ET=gmail.com=shubhrajyoti.datta@kernel.org>
Return-Path: <SRS0=VREm=ET=gmail.com=shubhrajyoti.datta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKfKVtHL_b_Kj4DU=uy1ts2F8bAosqUo24CR8c6ADv3+a6cLSw@mail.gmail.com>
References: <1516771642-14551-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <CANk1AXQTDc+8ho=HtADAHd4BEPz3h4WOYgdxcBXDg_EWzB8FrA@mail.gmail.com> <CAKfKVtHL_b_Kj4DU=uy1ts2F8bAosqUo24CR8c6ADv3+a6cLSw@mail.gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Wed, 24 Jan 2018 22:18:54 +0530
Message-ID: <CAKfKVtFfBC11GRR8SrrUNgG8nSdtKYpeKDrFHv1eWLvqqTkaWQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: region: Release the bridge reference
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alan Tull <atull@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Jan 24, 2018 at 10:15 PM, Shubhrajyoti Datta
<shubhrajyoti.datta@gmail.com> wrote:
> Hi Alan,
>
> Thanks for your review.
>
> On Wed, Jan 24, 2018 at 10:04 PM, Alan Tull <atull@kernel.org> wrote:
>> On Tue, Jan 23, 2018 at 11:27 PM, Shubhrajyoti Datta
>> <shubhrajyoti.datta@xilinx.com> wrote:
>>
>>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>>> index d9ab7c7..58789b9 100644
>>> --- a/drivers/fpga/fpga-region.c
>>> +++ b/drivers/fpga/fpga-region.c
>>> @@ -273,6 +273,7 @@ static int fpga_region_program_fpga(struct fpga_reg=
ion *region,
>>>                 goto err_put_br;
>>>         }
>>>
>>> +       fpga_bridges_put(&region->bridge_list);
>>
>> Hi Shubhrajyoti,
>>
>> Please do not write to the Linux mailing lists with a
>> confidential/proprietary footer in your email.
>>
> My apologies will fix my mailer.
>
>> Thanks for your submission, but the code is already correct as-is.  We
>> want fpga_region_program_fpga to hold the reference to the bridges if
>> programming succeeds.  The idea is that the reference for the bridge
>> is exclusive, so if some module programs an FPGA region, that module
>> owns the region.  Nobody else can come and program it.  The function
>> header should make this clear and it doesn't, so that's the real
>> problem here.
>>
>> For example, in of-fpga-region.c, of_fpga_region_notify_post_remove
>> calls fpga_bridges_put when an overlay is removed.  But if someone
>> tries to program the region again (by applying another overlay without
>> first removing the first overlay), it will fail to get the bridges,
>> which is what we want.
>
> I was thinking that may be we should not allow the second overlay.

I was thinking that may be we should  allow the second overlay.

>
> I have 2 overlays.
> The first overlay adds the bridges values.
> the second overlay has the bit file and the firmware.
>
> May be I may be missing something.
>
>>
>> Alan
>>
>>>         fpga_mgr_put(mgr);
>>>         fpga_region_put(region);
>>>
>>> --
>>> 2.1.1
>>>
>>> This email and any attachments are intended for the sole use of the nam=
ed recipient(s) and contain(s) confidential information that may be proprie=
tary, privileged or copyrighted under applicable law. If you are not the in=
tended recipient, do not read, copy, or forward this email message or any a=
ttachments. Delete this email message and any attachments immediately.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
