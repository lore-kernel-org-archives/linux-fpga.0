Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170719161237.GA22403@tyrael.ni.corp.natinst.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-3-p.zabel@pengutronix.de> <20170719161237.GA22403@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 27 Jul 2017 13:49:14 -0500
Message-ID: <CANk1AXQzHoERm8pQESCM9DN_PaF5OJ+Zvrnr-uMVcgEc5DA9NA@mail.gmail.com>
Subject: Re: [PATCH 002/102] ARM: socfpga: explicitly request exclusive reset control
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Moritz Fischer <moritz.fischer@ettus.com>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Jul 19, 2017 at 11:12 AM, Moritz Fischer <mdf@kernel.org> wrote:
> On Wed, Jul 19, 2017 at 05:25:06PM +0200, Philipp Zabel wrote:
>> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
>> reset lines") started to transition the reset control request API calls
>> to explicitly state whether the driver needs exclusive or shared reset
>> control behavior. Convert all drivers requesting exclusive resets to the
>> explicit API call so the temporary transition helpers can be removed.
>>
>> No functional changes.
>>
>> Cc: Alan Tull <atull@kernel.org>
>> Cc: Moritz Fischer <moritz.fischer@ettus.com>
>> Cc: linux-fpga@vger.kernel.org
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-By: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
