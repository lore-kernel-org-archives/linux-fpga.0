Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <152cb232-ea4d-292b-8b60-8bdc1732dc23@gmail.com>
References: <20180427012605.28981-1-mdf@kernel.org> <20180427012605.28981-3-mdf@kernel.org>
 <152cb232-ea4d-292b-8b60-8bdc1732dc23@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Fri, 27 Apr 2018 18:30:42 -0500
Message-ID: <CANk1AXTZhCA78eX9j5dg1VeNyg8G4+hsiSgG_CYpZObjJw+wfw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fpga: manager: change api, don't use drvdata
Content-Type: text/plain; charset="UTF-8"
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Apr 27, 2018 at 1:26 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 04/26/2018 06:26 PM, Moritz Fischer wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Change fpga_mgr_register to not set or use drvdata.  This supports
>> the case where a PCIe device has more than one manager.
>>
>> Add fpga_mgr_create/free functions.  Change fpga_mgr_register and
>> fpga_mgr_unregister functions to take the mgr struct as their only
>> parameter.
>>
>>   struct fpga_manager *fpga_mgr_create(struct device *dev,
>>                 const char *name,
>>                 const struct fpga_manager_ops *mops,
>>                 void *priv);
>>   void fpga_mgr_free(struct fpga_manager *mgr);
>>   int fpga_mgr_register(struct fpga_manager *mgr);
>>   void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>> Update the drivers that call fpga_mgr_register with the new API.
>
> Apologies for chiming in so late, this commit does not make it clear
> that fpga_mgr_unregister() now also free the 'mgr' argument by calling
> fpga_mgr_free(), this is kind of detail, but an API should make that
> clear IMHO.

If people follow the usage information, in
Documentation/fpga/fpga-mgr.txt, they'll do the right thing.  But I
can add a patch that clarifies the description of fpga_mgr_unregister
in fpga-mgr.c that it "unregisters and frees" the manager.

>
> Thanks
> --
> Florian
