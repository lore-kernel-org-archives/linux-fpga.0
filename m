Return-Path: <moritz.fischer.private@gmail.com>
Date: Thu, 30 Mar 2017 10:17:01 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 00/16] Intel FPGA Device Drivers
Message-ID: <20170330171701.GA13590@tyrael.amer.corp.natinst.com>
References: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <1490875696-15145-1-git-send-email-hao.wu@intel.com>
To: Wu Hao <hao.wu@intel.com>
Cc: atull@kernel.org, moritz.fischer@ettus.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com
List-ID: <linux-fpga@vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 08:08:00PM +0800, Wu Hao wrote:
> Hi All,
>=20
> Here is a patch-series adding drivers for Intel FPGA devices.
>=20
> The Intel FPGA driver provides interfaces for userspace applications to
> configure, enumerate, open, and access FPGA accelerators on platforms
> equipped with Intel(R) FPGA solutions and enables system level management
> functions such as FPGA partial reconfiguration, power management and
> virtualization.
>=20
> This patch series only adds the basic functions for FPGA accelerators and
> partial reconfiguration. Patches for more functions, e.g power management
> and virtualization, will be submitted after this series gets reviewed.
>=20
> Patch 1: add a document for Intel FPGA driver overview, including the HW
> architecture, driver organization, device enumeration, virtualization and
> opens.
>=20
> Patch 2: introduce a fpga-dev class. It's used in below Intel FPGA PCIe
> device driver, to represent a FPGA device on the system, and all actual
> feature devices should be registered as child nodes of this container
> fpga-dev device.
>=20
> Patch 3-7: implement Intel FPGA PCIe device driver. It walks through the
> 'Device Feature List' in the PCI Bar, creates the container fpga-dev as
> parent and platform devices as children for the feature devices it found.
>=20
> Patch 8-11: implement Intel FPGA Management Engine (FME) driver. It's a
> platform driver matching with the FME platform device created by above
> PCIe driver. Sysfs and device file ioctls are exposed as user interfaces
> to allow partial reconfiguration to Accelerated Function Units (AFUs) from
> user space applications.
>=20
> Patch 12-16: implement Intel FPGA Accelerated Function Unit (AFU) driver.
> It's a platform driver matching with AFU platform device created by above
> PCIe driver. It provides user interfaces to expose the AFU MMIO region,
> map/unmap dma buffer, and control the port which AFU connects to.

This is exciting stuff. It will take some time to review, though. I marked
the patchset as 'In-Review' in patchwork.

Cheers,

Moritz


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY3T2LAAoJEL5CEHepFqov6OEIAJYJ5yzI6V3pTWRu+H73in3f
shFpSVJyq9hR5yRjs40MV81V1+LzzM5w04ecIt3+hhDytMMod06u5WzLtRKFy8pT
s6QqFz/TpVarM2XWwFvDop7VX2nwayk8s4tuEue7Kdp5MAFnBu9owGVHRJASq1Zz
qN4X0+8XfIMGtOoIdLWahd3AYhdJYiMdWyccPZrGfCDvw7B2WMurMG/Si6JFFMmi
h92AzxX6B7t9jZnPAR7u2+OL/SiXMJ+J1QkvZ0cy2jHMWoufDm54ZueOdskaIoHB
2SUG9xH3Xdmp97ysAUKyRIpxm8gh1hTbP2EXY5S1hf96OuZqqs6Wcu+Mm8a9xqs=
=vX8X
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
