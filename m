Return-Path: <SRS0=GOTt=UX=arm.com=suzuki.poulose@kernel.org>
Return-Path: <SRS0=GOTt=UX=arm.com=suzuki.poulose@kernel.org>
Subject: Re: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
 <325e46fd-a480-78ed-81fd-55e993fbc06f@axentia.se>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5cf1a8e2-bb1e-b6bc-32fe-93db0a6b5efd@arm.com>
Date: Mon, 24 Jun 2019 09:34:42 +0100
MIME-Version: 1.0
In-Reply-To: <325e46fd-a480-78ed-81fd-55e993fbc06f@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: peda@axentia.se, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, broonie@kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net, andrew@lunn.ch, lgirdwood@gmail.com, jslaby@suse.com
List-ID: <linux-fpga@vger.kernel.org>

Hi Peter,

On 22/06/2019 06:25, Peter Rosin wrote:
> On 2019-06-14 19:54, Suzuki K Poulose wrote:
>> Add a wrapper to class_find_device() to search for a device
>> by the of_node pointer, reusing the generic match function.
>> Also convert the existing users to make use of the new helper.
>>
>> Cc: Alan Tull <atull@kernel.org>
>> Cc: Moritz Fischer <mdf@kernel.org>
>> Cc: linux-fpga@vger.kernel.org
>> Cc: Peter Rosin <peda@axentia.se>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Jiri Slaby <jslaby@suse.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Reviewed-by: Peter Rosin <peda@axentia.se>
> 
> Whoooa! I reviewed only the drivers/mux/core.c changes when this was done
> in a series of much smaller patches. This tag makes it seem as if I have
> reviewed the whole thing, which I had not done when you added this tag out
> of the blue.

Apologies for the surprise. The patch was simply squashed with the change that
introduced the "helper" to better aid the reviewers, based on suggestions on the
list. I kept your tags, only because there were no changes, but some additional
context on the core driver.

> 
> Now, this stuff is trivial and by now I have looked at the other files
> and it all seems simple enough. So, you can keep the tag, but it is NOT
> ok to handle tags like you have done here.

Sure, I will keep that in mind.

Cheers
Suzuki
