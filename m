MIME-Version: 1.0
In-Reply-To: <20180719134256.GA27234@hao-dev>
References: <1532006214-104930-1-git-send-email-weiyongjun1@huawei.com>
	<20180719134256.GA27234@hao-dev>
Date: Thu, 19 Jul 2018 08:19:07 -0700
Message-ID: <CAJYdmeP-yWcrhaqEw6bvyxMvtJdQ_7zKZDG4oMKszqWsdNP8AQ@mail.gmail.com>
Subject: Re: [PATCH -next] fpga: dfl: fme: fix return value check in in pr_mgmt_init()
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Content-Type: text/plain; charset="UTF-8"
To: Wu Hao <hao.wu@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Alan Tull <atull@kernel.org>, Kang Luwei <luwei.kang@intel.com>, linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jul 19, 2018 at 6:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> On Thu, Jul 19, 2018 at 01:16:54PM +0000, Wei Yongjun wrote:
>> In case of error, the function dfl_fme_create_region() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value check should
>> be replaced with IS_ERR().
>
> This is a valid issue, thanks a lot for the fixing.
>
> Hao
>
>>
>> Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/dfl-fme-pr.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
>> index fc9fd2d..0b84053 100644
>> --- a/drivers/fpga/dfl-fme-pr.c
>> +++ b/drivers/fpga/dfl-fme-pr.c
>> @@ -420,7 +420,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
>>               /* Create region for each port */
>>               fme_region = dfl_fme_create_region(pdata, mgr,
>>                                                  fme_br->br, i);
>> -             if (!fme_region) {
>> +             if (IS_ERR(fme_region)) {
>>                       ret = PTR_ERR(fme_region);
>>                       goto destroy_region;
>>               }
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,

Moritz
