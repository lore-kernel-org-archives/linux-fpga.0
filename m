Return-Path: <SRS0=kD2i=NF=oregano.at=puhm@kernel.org>
Return-Path: <SRS0=kD2i=NF=oregano.at=puhm@kernel.org>
From: Andreas Puhm <puhm@oregano.at>
Subject: AW: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Date: Thu, 25 Oct 2018 08:44:06 +0000
Message-ID: <1540457043890.27497@oregano.at>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
 <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
 <20181024095135.GA1382@archbook>,<alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
In-Reply-To: <alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
Content-Language: de-AT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>, Moritz Fischer <mdf@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>, Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Moritz, Matthew,=0A=
=0A=
>> Hi Anatolij, Andreas,=0A=
>>=0A=
>> On Tue, Oct 23, 2018 at 06:46:47PM +0000, Andreas Puhm wrote:=0A=
>>> Hi Anatolij,=0A=
>>>=0A=
>>>> The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of =
CVP=0A=
>>>> status can take up to 500ms. However it is not clear whether this dela=
y=0A=
>>>> might be required after peripheral image configuration and after PCIe=
=0A=
>>>> link activation. The diagram describing configuration sequence suggest=
s=0A=
>>>> that CVP_EN should be polled until it is asserted. I can imaging the=
=0A=
>>>> situation that this bit is still not asserted when the device is being=
=0A=
>>>> probed. Maybe we should better defer device probing if CVP_EN bit is=
=0A=
>>>> cleared? When deferred probing fails again and sufficient period for=
=0A=
>>>> CVP_EN bit assertion elapsed, then stop deferred probing and return=0A=
>>>> -ENODEV?=0A=
>>>>=0A=
>>>> Thanks,=0A=
>>>>=0A=
>>>> Anatolij=0A=
>>>=0A=
>>> Anatolij, thank you for your feedback.=0A=
>>>=0A=
>>> My rationale behind the patch is as follows:=0A=
>>>=0A=
>>> The CVP_EN is part of the Hard PCIe IP core configuration,=0A=
>>> and therefore, has a defined and static value right from "the start".=
=0A=
>>>=0A=
>>> Remark in [1, fig 12]=0A=
>>> " For high density devices such as Intel Cyclone 10 GX,=0A=
>>> it may be necessary to wait up to 500 ms for the CvP=0A=
>>> status register bit assertion."=0A=
>>> According to [2] the Cyclone 10 GX devices achieve proper operation=0A=
>>> within 100 ms (via the PCIe IP core and CvP).=0A=
>>>=0A=
>>> I think (and here the documentation is a bit lacking),=0A=
>>> that this remark is valid only for other bits of the status register,=
=0A=
>>> e.g., CVP_CONFIG_DONE or USERMODE.=0A=
>>> I also think, that the 500 ms delay is calculated from peripheral + cor=
e image programming=0A=
>>> and that the time for peripheral image programming is far lower than th=
at=0A=
>>> (i.e., low enough to allow PCI enumeration).=0A=
>>>=0A=
>>> But if this actually means that it can take up to 500 ms to program the=
 peripheral image,=0A=
>>> than such FPGAs would have different problems.=0A=
>>> I.e., missing the deadline for PCI enumeration.=0A=
>>> This would need a solution outside of the scope of the=0A=
>>> altera_cvp module (e.g., soft-reset to re-start enumeration with a stab=
le system).=0A=
>>>=0A=
>>> Bottom line:=0A=
>>> The CVP_EN should be deemed stable when altera_cvp is called,=0A=
>>> if not,=0A=
>>> the programming of the Intel/Altera FPGA and PCIe IP core has not been =
completed in time=0A=
>>> for the enumeration of the PCI device. Hence it would be questionable o=
r, more likely, would not=0A=
>>> have completed successfully in the first place, i.e., altera_cvp would =
not have been called.=0A=
>>=0A=
>> Yeah I think this makes sense. If your config space isn't up on boot you=
=0A=
>> would run into issues. I agree the docs are soemwhat vague here. Maybe M=
atthew or Alan can shoot=0A=
>> an email to their HW folks internally to clarify?=0A=
>=0A=
>My experience with cvp is with Arria10 and Stratix 10.  The PCIe Hard IP=
=0A=
>gets configured when the IOring gets configured at power on.  The idea is=
=0A=
>that the load of the IOring is very fast, much before the infamous 100ms=
=0A=
>PCIe timeout for link training.  When the Hard IP is configured, the=0A=
>CVP_EN is set or cleared according to how it was configured.  Yes, you=0A=
=0A=
So is it correct that the value of CVP_EN can be evaluated by the altera_cv=
p right in the first call of its probe function=0A=
(as would be the case with my proposed patch).=0A=
=0A=
If it is, I will fix the remaining issues with the patch and submit it.=0A=
=0A=
>will run into issues if config space is not up on boot.  The exact nature=
=0A=
>of the issues is dependent on the platform being used.=0A=
>=0A=
>For the record, if cvp is not being used then the initial full=0A=
>configuration of the FPGA can take much longer than just configuring the=
=0A=
>IOring.  In the worst case, if the initial FPGA image in flash is=0A=
>corrupted, it can take a while before the failover image gets configured=
=0A=
>into the fpga.  This might be the explanation for the 500 ms for Cyclone=
=0A=
>10 GX devices.  For an Arria10, the flash failover can take much longer=0A=
>than even the 500ms, which has been shown to have issues for many platform=
s.=0A=
>=0A=
>Thanks,=0A=
>Matthew=0A=
>=0A=
>>=0A=
>> Thanks,=0A=
>> Moritz=0A=
>>=0A=
=0A=
Thanks,=0A=
Andreas=
