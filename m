Return-Path: <SRS0=rMVE=N3=denx.de=agust@kernel.org>
Return-Path: <SRS0=rMVE=N3=denx.de=agust@kernel.org>
Date: Fri, 16 Nov 2018 01:02:55 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3] fpga: mgr: altera-ps-spi: enable usage on non-dt
 platforms
Message-ID: <20181116010255.16091acf@crub>
In-Reply-To: <CANk1AXS5q4z-3fjdD822g5tqg7ToBtwoqamSMuSJ9ChEpm2_vQ@mail.gmail.com>
References: <20181101212231.9125-1-agust@denx.de>
	<CANk1AXS5q4z-3fjdD822g5tqg7ToBtwoqamSMuSJ9ChEpm2_vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Thu, 15 Nov 2018 16:24:21 -0600
Alan Tull atull@kernel.org wrote:
...
>Need to update the header to explain what has been added since v2
>(added spi ids and an array and code to map spi ids to data).

Done in v4.

...
>> +static const struct altera_ps_data *altera_ps_data_map[] = {  
>
>Please add a comment that array index is enum altera_ps_devtype or
>something like that.  Make it easy for future generations to do the
>right thing.  :)

Done in v4.

...
>> +static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
>> +{
>> +       const struct altera_ps_data *data;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(altera_ps_data_map); i++) {  
>
>At this point, id->driver_data == CYCLONE5 or ARRIA10 (more added in
>the future) so we don't need a loop to search the mapping array for a
>matching id.     Would something like the following work instead of
>this for loop?  I understand you wanted to do some checking, this
>accomplishes some checking but will exit NULL if someone extends the
>array wrongly.

Yes, this works.

>kernel_ulong_t devtype = id->driver_data;
>
>/* someone added a altera_ps_devtype without adding to the map array */
>if (devtype >= ARRAY_SIZE(altera_ps_data_map))
>   return NULL;
>
>data = altera_ps_data_map[devtype];
>if (!data || data->devtype != devtype)
>    return NULL;
>
>return data;

Okay, v4 uses this code.

Thanks,
Anatolij
