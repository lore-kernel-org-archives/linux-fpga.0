Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171027140904.Horde.m5O1mdmtNKyY-jthC9ZZmz8@gator4166.hostgator.com>
References: <20171026230230.GA4904@embeddedor.com> <CANk1AXQX24U06SBuoBmw=UWeCdnu3OV4BW2ZRBW4t1KirZZ5DA@mail.gmail.com>
 <20171027140904.Horde.m5O1mdmtNKyY-jthC9ZZmz8@gator4166.hostgator.com>
From: Alan Tull <atull@kernel.org>
Date: Fri, 27 Oct 2017 14:49:55 -0500
Message-ID: <CANk1AXRzoh8ZsJmzoGJuOJZ=ioTyaMBtaT5y+63Ho26HUzJchA@mail.gmail.com>
Subject: Re: [PATCH] fpga: fpga-mgr: remove unnecessary code in __fpga_mgr_get
Content-Type: text/plain; charset="UTF-8"
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Oct 27, 2017 at 2:09 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Hi Alan,
>
> Quoting Alan Tull <atull@kernel.org>:
>
>> On Thu, Oct 26, 2017 at 6:02 PM, Gustavo A. R. Silva
>> <garsilva@embeddedor.com> wrote:
>>
>> Hi Gustavo,
>>
>> Thanks for pointing that out.  There's also a similar thing in
>> fpga-bridge.c that I need to fix.
>>
>
> Can you share with me what exactly are you trying to fix?
>
> If the issue is similar I might be able to help.

Same fix, but in of_fpga_bridge_get.  Checks the output of
to_fpga_bridge for NULL.

Thanks,
Alan

>
> Thanks
> --
> Gustavo A. R. Silva
>
>> Alan
>>
>>> Notice that mgr = to_fpga_manager(dev); expands to:
>>>
>>> mgr = container_of(dev, struct fpga_manager, dev);
>>>
>>> and container_of is never null, so this null check is
>>> unnecessary.
>>>
>>> Addresses-Coverity-ID: 1397916
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>>> ---
>>>  drivers/fpga/fpga-mgr.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>>> index 188ffef..33063ca 100644
>>> --- a/drivers/fpga/fpga-mgr.c
>>> +++ b/drivers/fpga/fpga-mgr.c
>>> @@ -367,8 +367,6 @@ static struct fpga_manager *__fpga_mgr_get(struct
>>> device *dev)
>>>         int ret = -ENODEV;
>>>
>>>         mgr = to_fpga_manager(dev);
>>> -       if (!mgr)
>>> -               goto err_dev;
>>>
>>>         /* Get exclusive use of fpga manager */
>>>         if (!mutex_trylock(&mgr->ref_mutex)) {
>>> --
>>> 2.7.4
