Return-Path: <SRS0=F0XN=NQ=denx.de=agust@kernel.org>
Return-Path: <SRS0=F0XN=NQ=denx.de=agust@kernel.org>
Date: Mon, 5 Nov 2018 18:54:13 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] fpga: mgr: altera-ps-spi: enable usage on non-dt
 platforms
Message-ID: <20181105185413.6ee0ba0d@crub>
In-Reply-To: <CANk1AXQCQpi7nuvDSPGrp=zwvkhKpWha6_5T=7hYaZFpjsyuxw@mail.gmail.com>
References: <20181029141709.14749-1-agust@denx.de>
	<CANk1AXQCQpi7nuvDSPGrp=zwvkhKpWha6_5T=7hYaZFpjsyuxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Thu, 1 Nov 2018 14:37:02 -0500
Alan Tull atull@kernel.org wrote:
...
>>  static const struct spi_device_id altera_ps_spi_ids[] = {
>> -       {"cyclone-ps-spi", 0},
>> +       {"cyclone-ps-spi", (kernel_ulong_t)&c5_data},
>> +       {"fpga-passive-serial", (kernel_ulong_t)&c5_data},
>> +       {"fpga-arria10-passive-serial", (kernel_ulong_t)&a10_data},  
>
>I don't think this should be implemented as a pointer. This would be
>easy if driver_data were void* but it's a value that's not a pointer.
> I suggest using driver_data as a index to an array of pointers to the
>structs instead.

Thanks for review. I've sent v3 using array of pointers. It uses
the FPGA type in driver_data. It could be used as an index to the
array of pointers, but I'd prefer checking for this type explicitly,
so it will work even if the array is wrongly extended or reordered
by future changes.

Thanks,

Anatolij
