Return-Path: <SRS0=uFsl=HQ=gmail.com=f.fainelli@kernel.org>
Return-Path: <SRS0=uFsl=HQ=gmail.com=f.fainelli@kernel.org>
Subject: Re: [PATCH 2/4] fpga: manager: change api, don't use drvdata
References: <20180427012605.28981-1-mdf@kernel.org>
 <20180427012605.28981-3-mdf@kernel.org>
 <152cb232-ea4d-292b-8b60-8bdc1732dc23@gmail.com>
 <CANk1AXTZhCA78eX9j5dg1VeNyg8G4+hsiSgG_CYpZObjJw+wfw@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8938518c-6e12-51f5-4747-8caab916fc3a@gmail.com>
Date: Fri, 27 Apr 2018 16:38:18 -0700
MIME-Version: 1.0
In-Reply-To: <CANk1AXTZhCA78eX9j5dg1VeNyg8G4+hsiSgG_CYpZObjJw+wfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-fpga@vger.kernel.org>

On 04/27/2018 04:30 PM, Alan Tull wrote:
> On Fri, Apr 27, 2018 at 1:26 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 04/26/2018 06:26 PM, Moritz Fischer wrote:
>>> From: Alan Tull <atull@kernel.org>
>>>
>>> Change fpga_mgr_register to not set or use drvdata.  This supports
>>> the case where a PCIe device has more than one manager.
>>>
>>> Add fpga_mgr_create/free functions.  Change fpga_mgr_register and
>>> fpga_mgr_unregister functions to take the mgr struct as their only
>>> parameter.
>>>
>>>   struct fpga_manager *fpga_mgr_create(struct device *dev,
>>>                 const char *name,
>>>                 const struct fpga_manager_ops *mops,
>>>                 void *priv);
>>>   void fpga_mgr_free(struct fpga_manager *mgr);
>>>   int fpga_mgr_register(struct fpga_manager *mgr);
>>>   void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>
>>> Update the drivers that call fpga_mgr_register with the new API.
>>
>> Apologies for chiming in so late, this commit does not make it clear
>> that fpga_mgr_unregister() now also free the 'mgr' argument by calling
>> fpga_mgr_free(), this is kind of detail, but an API should make that
>> clear IMHO.
> 
> If people follow the usage information, in
> Documentation/fpga/fpga-mgr.txt, they'll do the right thing.  But I
> can add a patch that clarifies the description of fpga_mgr_unregister
> in fpga-mgr.c that it "unregisters and frees" the manager.

Just mentioning that because not all APIs do this, take the network
devices: there is an unregister_netdev() and a free_netdev(). Either way
is fine with me as long as it is documented as such, I had to look at
the API implementation to figure out that, no, all the drivers were not
leaking their fpga_manager instance in their .remove() function :)
-- 
Florian
