Return-Path: <SRS0=YrXQ=N3=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=YrXQ=N3=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53500 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKSY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 16 Nov 2018 05:18:24 -0500
Date: Fri, 16 Nov 2018 01:08:17 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga: altera-cvp: output expected CvP
 VSE_PCIE_EXT_CAP_ID in error case
Message-ID: <20181116010817.155391d3@crub>
In-Reply-To: <CANk1AXRnahbsdbe7_XWvQudG_+Kr0exZgk2J4ay0sjM0b=bGBg@mail.gmail.com>
References: <20181106215838.5212-1-agust@denx.de>
        <CANk1AXRnahbsdbe7_XWvQudG_+Kr0exZgk2J4ay0sjM0b=bGBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>

Hi Alan,

On Thu, 15 Nov 2018 16:28:10 -0600
Alan Tull atull@kernel.org wrote:

>On Tue, Nov 6, 2018 at 3:58 PM Anatolij Gustschin <agust@denx.de> wrote:
>
>Hi Anatolij,
>
>>
>> Output VSE_PCIE_EXT_CAP_ID register address and expected register
>> value in error message to give more info when analyzing issues
>> with loaded periphery image.
>>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> ---
>>  drivers/fpga/altera-cvp.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index 381d0c42450f..08c0080092da 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -413,7 +413,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>          */
>>         pci_read_config_word(pdev, VSE_PCIE_EXT_CAP_ID, &val);
>>         if (val != VSE_PCIE_EXT_CAP_ID_VAL) {
>> -               dev_err(&pdev->dev, "Wrong EXT_CAP_ID value 0x%x\n", val);
>> +               dev_err(&pdev->dev,
>> +                       "Wrong VSE_PCIE_EXT_CAP_ID value 0x%04x at 0x%x, "
>> +                       "expected: 0x%04x\n",
>> +                       val, VSE_PCIE_EXT_CAP_ID, VSE_PCIE_EXT_CAP_ID_VAL);  
>
>This patch adds error print info which is printing out constants.
>Wouldn't the user just be able to look at the source and know what was
>expected?  I may be missing something here.

People dealing with different FPGAs asked me to add this, they didn't
want to lookup it in the code.

Thanks,
Anatolij
