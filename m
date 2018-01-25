Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180125190950.GA26170@tyrael.ni.corp.natinst.com>
References: <20180125153922.3119-1-atull@kernel.org> <20180125190950.GA26170@tyrael.ni.corp.natinst.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 25 Jan 2018 13:20:50 -0600
Message-ID: <CANk1AXSzAbofe3tMvgtjaBz7RFbO5+xfpi19FvW2M2sFV91aFQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: fpga-region: comment on fpga_region_program_fpga locking
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Jan 25, 2018 at 1:09 PM, Moritz Fischer <mdf@kernel.org> wrote:
> Hi Alan,
>
> looks good.
>

Thanks, Moritz!

> On Thu, Jan 25, 2018 at 09:39:22AM -0600, Alan Tull wrote:
>> Add a comment to the header of fpga_region_program_fpga()
>> regarding locking of the bridges.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/fpga-region.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index edab2a2..cb0603e 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -95,6 +95,11 @@ static void fpga_region_put(struct fpga_region *region)
>>   * fpga_region_program_fpga - program FPGA
>>   * @region: FPGA region
>>   * Program an FPGA using fpga image info (region->info).
>> + * If the region has a get_bridges function, the exclusive reference for the
>> + * bridges will be held if programming succeeds.  This is intended to prevent
>> + * reprogramming the region until the caller considers it safe to do so.
>> + * The caller will need to call fpga_bridges_put() before attempting to
>> + * reprogram the region.
>>   * Return 0 for success or negative error code.
>>   */
>>  int fpga_region_program_fpga(struct fpga_region *region)
>> --
>> 2.7.4
>>
>
> - Moritz
