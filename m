Return-Path: <SRS0=HJlN=KJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=HJlN=KJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYQsA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 25 Jul 2018 12:48:00 -0400
MIME-Version: 1.0
In-Reply-To: <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com> <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 25 Jul 2018 10:35:07 -0500
Message-ID: <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Nava kishore Manne <navam@xilinx.com>, Michal Simek <michals@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jul 25, 2018 at 4:12 AM, Appana Durga Kedareswara Rao
<appanad@xilinx.com> wrote:
> Hi Alan,
>
>         Thanks for the review...
>
> <Snip>
>> >
>> > <Snip>
>> >> > +static bool readback_type;
>> >> > +module_param(readback_type, bool, 0644);
>> >> > +MODULE_PARM_DESC(readback_type,
>> >> > +               "readback_type 0-configuration register read "
>> >> > +               "1- configuration data read (default: 0)");
>> >>
>> >> Not sure a module param is the best solution here.
>> >
>> > Need to provide flexibility to the user to switch between reading of FPGA
>> registers and configuration data.
>>
>> I suggested calling the attribute 'image' because I thought it would always be
>> a read back of the FPGA image information.  I don't think that a sysfs
>> attribute's function should change. :)
>
> In Zynq Case it supports two types of the readback (Configuration registers, Configuration data(fpga image))  which may not be the same case for other vendors.
> Since I need to support both the use cases I have differentiated them using module param in the zynq-fpga driver.
>
> As you said we shouldn't change the attribute's function, So in the zynq-fpga driver,
> I am planning to add another debugfs attribute for reading back of configuration registers as it is vendor specific readback type.
>  (Configuration registers                   ----  Usage:  /sys/kernel/debug/fpga/zynq-fpga/cfgreg_summary)

Is it called '...summary' because it is not all the registers?  Could
just be "cfg_regs"?

> (Configuration data(fpga image)    ----   Usage: /sys/kernel/debug/fpga/fpga0/image)
> Please let me know your thoughts for the same...
>
>>
>> > One other option is sysfs. Do you want me to implement sysfs path???
>> > Any other suggestions???
>>
>> You could implement another sysfs attribute for reading FPGA registers
>> with a separate ops callback.   Please clarify what it is doing (not
>> all FPGAs have this function) and what that will look like when the user reads
>> the from the sysfs
>
> AFAIK we shouldn't add another sysfs/debugfs attribute for vendor-specific readback type in the FPGA manager ops.
> Please correct me if my understanding is wrong.

You are not wrong :)

>
> Regards,
> Kedar.
>
>>
>> Alan
