Return-Path: <SRS0=DkGj=FH=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=DkGj=FH=intel.com=hao.wu@kernel.org>
Date: Tue, 13 Feb 2018 11:44:31 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3 11/21] fpga: dfl: fme: add header sub feature support
Message-ID: <20180213034431.GB10936@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-12-git-send-email-hao.wu@intel.com>
 <CANk1AXR2Q4M4c1TOQhR2J_Mz5MjwZWbR0JUXCR5jFVL_kZtcag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR2Q4M4c1TOQhR2J_Mz5MjwZWbR0JUXCR5jFVL_kZtcag@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Tim Whisonant <tim.whisonant@intel.com>, Enno Luebbers <enno.luebbers@intel.com>, Shiva Rao <shiva.rao@intel.com>, Christopher Rauer <christopher.rauer@intel.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 12, 2018 at 10:51:44AM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> > From: Kang Luwei <luwei.kang@intel.com>
> >
> > The header register set is always present for FPGA Management Engine (FME),
> > this patch implements init and uinit function for header sub feature and
> > introduce several read-only sysfs interfaces for the capability and status.
> >
> > Sysfs interfaces:
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/ports_num
> >   Read-only. Number of ports implemented
> >
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/bitstream_id
> >   Read-only. Blue Bitstream (static FPGA region) identifier number
> >
> > * /sys/class/fpga_region/<regionX>/<fpga-dfl-fme.x>/bitstream_metadata
> >   Read-only. Blue Bitstream (static FPGA region) meta data
> 
> Please document the meta data.  I don't see anywhere that describes it
> or how it differs from the bitstream_id.  So it could be useful to
> document it in this header a bit, and in the code, in the sysfs
> document, and in the Documentation/fpga so that people don't have to
> go hunting.

Hi Alan

Thanks a lot for the review.

The Blue Bitstream (static FPGA region) meta data contains information
like synthesis date and seed.

The Blue Bitstream (static FPGA region) id contains version information
like major, minor, patch number (e.g version 6.4.0)and etc.

I used bitstream_id a lot, but bitstream_metadata is useful in some cases
as well.

I will add more descriptions for them.

Thanks
Hao

> 
> We discussed elsewhere the static region bitstream_id verses the other
> interface_ids, so that's been discussed.
> 
> Besides that, this patch looks good and straightforward.
> 
> Thanks,
> Alan
> 
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Kang Luwei <luwei.kang@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ----
> > v2: add sysfs documentation
> > v3: rename driver to fpga-dfl-fme.
> >     improve sysfs doc and commit description.
> >     replace bitfield.
> > ---
> >  .../ABI/testing/sysfs-platform-fpga-dfl-fme        | 21 ++++++++
> >  drivers/fpga/dfl-fme-main.c                        | 60 ++++++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> > new file mode 100644
> > index 0000000..6b32799
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-fpga-dfl-fme
> > @@ -0,0 +1,21 @@
> > +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/ports_num
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. One DFL FPGA device may have more than 1
> > +               port/Accelerator Function Unit (AFU). It returns the
> > +               number of ports on the FPGA device when read it.
> > +
> > +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/bitstream_id
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> > +               identifier number.
> > +
> > +What:          /sys/bus/platform/devices/fpga-dfl-fme.0/bitstream_meta
> > +Date:          November 2017
> > +KernelVersion:  4.15
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns Blue Bitstream (static FPGA region)
> > +               meta data.
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index f7b5f7d..d17c66a 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -21,9 +21,68 @@
> >
> >  #include "fpga-dfl.h"
> >
> > +static ssize_t ports_num_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +       void __iomem *base;
> > +       u64 v;
> > +
> > +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> > +
> > +       v = readq(base + FME_HDR_CAP);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> > +                        (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
> > +}
> > +static DEVICE_ATTR_RO(ports_num);
> > +
> > +static ssize_t bitstream_id_show(struct device *dev,
> > +                                struct device_attribute *attr, char *buf)
> > +{
> > +       void __iomem *base;
> > +       u64 v;
> > +
> > +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> > +
> > +       v = readq(base + FME_HDR_BITSTREAM_ID);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> > +}
> > +static DEVICE_ATTR_RO(bitstream_id);
> > +
> > +static ssize_t bitstream_metadata_show(struct device *dev,
> > +                                      struct device_attribute *attr, char *buf)
> > +{
> > +       void __iomem *base;
> > +       u64 v;
> > +
> > +       base = get_feature_ioaddr_by_index(dev, FME_FEATURE_ID_HEADER);
> > +
> > +       v = readq(base + FME_HDR_BITSTREAM_MD);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
> > +}
> > +static DEVICE_ATTR_RO(bitstream_metadata);
> > +
> > +static const struct attribute *fme_hdr_attrs[] = {
> > +       &dev_attr_ports_num.attr,
> > +       &dev_attr_bitstream_id.attr,
> > +       &dev_attr_bitstream_metadata.attr,
> > +       NULL,
> > +};
> > +
> >  static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
> >  {
> > +       void __iomem *base = feature->ioaddr;
> > +       int ret;
> > +
> >         dev_dbg(&pdev->dev, "FME HDR Init.\n");
> > +       dev_dbg(&pdev->dev, "FME cap %llx.\n",
> > +               (unsigned long long)readq(base + FME_HDR_CAP));
> > +
> > +       ret = sysfs_create_files(&pdev->dev.kobj, fme_hdr_attrs);
> > +       if (ret)
> > +               return ret;
> >
> >         return 0;
> >  }
> > @@ -31,6 +90,7 @@ static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
> >  static void fme_hdr_uinit(struct platform_device *pdev, struct feature *feature)
> >  {
> >         dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> > +       sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
> >  }
> >
> >  static const struct feature_ops fme_hdr_ops = {
> > --
> > 1.8.3.1
> >
