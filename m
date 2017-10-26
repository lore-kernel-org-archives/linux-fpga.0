Return-Path: <SRS0=J2mi=BZ=huawei.com=majiuyue@kernel.org>
Return-Path: <SRS0=J2mi=BZ=huawei.com=majiuyue@kernel.org>
From: majiuyue <majiuyue@huawei.com>
Subject: RE: [PATCH v5 13/18] fpga: region: add register/unregister functions
Date: Thu, 26 Oct 2017 02:14:56 +0000
Message-ID: <1F870B2EBF7EE147840708BE00416263C63435@dggemi508-mbs.china.huawei.com>
References: <20171017212031.3770-1-atull@kernel.org>
 <20171017212031.3770-14-atull@kernel.org>
 <1F870B2EBF7EE147840708BE00416263C61FD3@dggemi508-mbs.china.huawei.com>
 <20171022094306.GA24055@tyrael.ni.corp.natinst.com>
In-Reply-To: <20171022094306.GA24055@tyrael.ni.corp.natinst.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz,

Sorry for the late reply, because I'm still trying to figure out the differ=
ences between a device-tree based system and a pcie base system.

In my mind, the main differences between them are:

  - In a of_* based system, the kernel will create platform_device objects =
for all of_node when system is boot up.
    Because these platform_device(s) are already there, a driver only need =
to match them and do the probe/register works.

  - But, for pcie based system, it is the driver's responsibility to discov=
er all the sub-features/sub-devices for a pci_dev.
    So the driver have the right to decide how to construct the device hier=
archy below the parent pci_dev.
    We (the fpga framework) should not make any restrictions/assumptions on=
 this, such as:
      * "fpga_mgr/region/bridge are stored in pdev->driver_data" --> the pc=
i driver may use it to store private data
      * "try_module_get(dev->parent->driver->owner)" --> the mgr/region/bri=
dge's parent driver may not exist, because they are registered by parent's =
parent driver.

So I'm not agree with your point:

>
>This step doesn't seem to crazy to me, because most likely you wanna be ab=
le to have region specific behavior on a per subdevice basis?
>

And surely, we are very glad to share our usecase to the fpga framework and=
 make it better :)


Thanks.

----
Jiuyue
