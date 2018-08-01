Return-Path: <SRS0=dfNq=KQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=dfNq=KQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389498AbeHAQgd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 1 Aug 2018 12:36:33 -0400
MIME-Version: 1.0
In-Reply-To: <MWHPR0201MB3481D2A338A004B2FB17CA61C22D0@MWHPR0201MB3481.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com> <20180801100457.25614-2-nava.manne@xilinx.com>
 <MWHPR0201MB34811402926886136673CE68C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
 <CANk1AXQ-qrEKAm9zEs8sVaFNGGFkjCr+npTKUNDXz_bnpL=DQw@mail.gmail.com> <MWHPR0201MB3481D2A338A004B2FB17CA61C22D0@MWHPR0201MB3481.namprd02.prod.outlook.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 1 Aug 2018 09:49:46 -0500
Message-ID: <CANk1AXQci08TOVq7TeXXGfMWi8C8o4AGYDJK2Dr-mVgZPqU8bQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Nava kishore Manne <navam@xilinx.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>, "atull@opensource.altera.com" <atull@opensource.altera.com>, "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Appana Durga Kedareswara Rao <appanad@xilinx.com>, "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>

On Wed, Aug 1, 2018 at 12:49 AM, Nava kishore Manne <navam@xilinx.com> wrote:
> Hi Alan Tull,
>
> Thanks for the quick response.
> Please find my Comments inline...
>
>> -----Original Message-----
>> From: Alan Tull [mailto:atull@kernel.org]
>> Sent: Tuesday, July 31, 2018 8:52 PM
>> To: Nava kishore Manne <navam@xilinx.com>
>> Cc: robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
>> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
>> atull@opensource.altera.com; moritz.fischer@ettus.com;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; chinnikishore369@gmail.com; linux-
>> fpga@vger.kernel.org
>> Subject: Re: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
>> Xilinx zynqmp
>>
>> On Tue, Jul 31, 2018 at 8:08 AM, Nava kishore Manne <navam@xilinx.com>
>> wrote:
>> >
>> > +Alan Tull,
>>
>> + linux-fpga mailing list
>>
>> Hi Nava,
>>
>> Thanks for submitting.
>>
>> This should be on the linux-fpga mailing list.  The
>> linux/scripts/get_maintainer.pl script would tell you that.
>>
> I have Created this Patch On Master Branch there get_maintainer.pl Doesn't have linux-fpga mailing list.

The linux-fpga mailing list has been in MAINTAINERS since v4.9.

> https://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git/
> Please suggest a branch So will create a patch on top of it.

I understand now.  linux-fpga/master is v4.9ish.  I haven't updated
the master branch it since I cloned the repo, it doesn't have any
special FPGA development patches, it's just what Linus's master branch
was when I cloned.  I don't think you can count on any kernel.org's
master branch to be up to date with Linus other than Linus.  Probably
because it would be a waste of traffic on kernel.org and you can have
multiple remotes on your local git repo with Linus being the one that
contains the one true master branch.

Right now, Linus's master branch has the latest FPGA API, so it would
be a good one to develop on.

Generally speaking, sometimes there will be some API changes for FPGA
that are only on linux-next/master.  I spend most of my time
developing on linux-next/master.  Occasionally that's broken but most
of the time that works for me.  Or you could use a Linus release tag
from linus' repo.  Or Linus' master branch.  When submitting, if your
patches apply cleanly on linux-next/master, that is helpful and good.

Alan
