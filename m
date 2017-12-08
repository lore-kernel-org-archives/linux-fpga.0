Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171207232728.GC17574@tyrael.ni.corp.natinst.com>
References: <1510779112-5517-1-git-send-email-atull@kernel.org>
 <1510779112-5517-6-git-send-email-atull@kernel.org> <20171207232728.GC17574@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Fri, 8 Dec 2017 11:30:22 -0600
Message-ID: <CANk1AXSCS2tyE=-kuJLzsUqatysVYqyi2iZahi5v_cWV1bOguw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fpga: region: return NOTIFY_STOP if overlay shoud
 be accepted
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Dec 7, 2017 at 5:27 PM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Nov 15, 2017 at 02:51:52PM -0600, Alan Tull wrote:
>> Recent changes to the Device Tree overlay notifier code have changed
>> how notifier return codes are interpreted, requiring a NOTIFY_STOP to
>> signal that the overlay should be accepted.  This commit makes the
>> appropriate change to the FPGA region's Device Tree overlay notifier.
>>
>> Fixes: 24789c5ce5a3 ("of: overlay: detect cases where device tree may become corrupt")
>> Signed-off-by: Alan Tull <atull@kernel.org>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>

Thanks!
Alan
