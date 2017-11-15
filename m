Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171115154628.GA21681@tyrael.ni.corp.natinst.com>
References: <20171017212031.3770-1-atull@kernel.org> <20171017212031.3770-19-atull@kernel.org>
 <20171115154628.GA21681@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 15 Nov 2017 10:00:39 -0600
Message-ID: <CANk1AXTnryz_EQ-aNs0Ma4U+xCgBiqF228YJrMrWqEHDyH3d_w@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] fpga: add attribute groups
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Nov 15, 2017 at 9:46 AM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

Thanks!

Alan

> On Tue, Oct 17, 2017 at 04:20:31PM -0500, Alan Tull wrote:
>> Make it easy to add attributes to low level FPGA drivers the right
>> way.  Add attribute groups pointers to structures that are used when
>> registering a manager, bridge, or group.  When the low level driver
>> registers, set the device attribute group.  The attributes are
>> created in device_add.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
