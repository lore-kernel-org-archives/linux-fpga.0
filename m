Return-Path: <SRS0=yKvC=6A=redhat.com=trix@kernel.org>
Return-Path: <SRS0=yKvC=6A=redhat.com=trix@kernel.org>
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
Date: Thu, 16 Apr 2020 09:56:47 -0700
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bhu@redhat.com" <bhu@redhat.com>
List-ID: <linux-fpga@vger.kernel.org>

Please check the scope.

On linus/master, the result of this change looks like

static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
{
=A0=A0=A0 struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
=A0=A0=A0 struct dfl_fpga_cdev *cdev =3D drvdata->cdev;

=A0=A0=A0 if (!num_vfs) {
=A0=A0=A0 =A0=A0=A0 /*
=A0=A0=A0 =A0=A0=A0 =A0* disable SRIOV and then put released ports back to =
default
=A0=A0=A0 =A0=A0=A0 =A0* PF access mode.
=A0=A0=A0 =A0=A0=A0 =A0*/
=A0=A0=A0 =A0=A0=A0 pci_disable_sriov(pcidev);

=A0=A0=A0 =A0=A0=A0 dfl_fpga_cdev_config_ports_pf(cdev);

=A0=A0=A0 } else {
=A0=A0=A0 =A0=A0=A0 int ret; <--- defined here

=A0=A0=A0 =A0=A0=A0 /*
=A0=A0=A0 =A0=A0=A0 =A0* before enable SRIOV, put released ports into VF ac=
cess mode
=A0=A0=A0 =A0=A0=A0 =A0* first of all.
=A0=A0=A0 =A0=A0=A0 =A0*/
=A0=A0=A0 =A0=A0=A0 ret =3D dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
=A0=A0=A0 =A0=A0=A0 if (ret)
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return ret;

=A0=A0=A0 =A0=A0=A0 ret =3D pci_enable_sriov(pcidev, num_vfs);
=A0=A0=A0 =A0=A0=A0 if (ret)
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dfl_fpga_cdev_config_ports_pf(cdev);
=A0=A0=A0 }

=A0=A0=A0 return ret;=A0 <---- not in scope, not defined here
}

Tom
