Return-Path: <SRS0=uKU7=A3=redhat.com=trix@kernel.org>
Return-Path: <SRS0=uKU7=A3=redhat.com=trix@kernel.org>
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
Date: Thu, 16 Jul 2020 15:50:51 -0700
MIME-Version: 1.0
In-Reply-To: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com
List-ID: <linux-fpga@vger.kernel.org>

Generally i think this is a good approach.

However I do have concern.

The feature_id in dfl is magic number, similar to pci id but without a vendor id.

Is it possible to add something like a vendor id so different vendors would not have to be so careful to use a unique id ?

This touches some of the matching function of the bus ops.  Could there be a way for bus ops to be used so that there could be multiple matching function.  Maybe the one in 0002 as a default so users could override it ?

The use case I am worrying about is an OEM.  The OEM uses an unclaimed feature_id and supplies their own platform device device driver to match the feature_id.  But some later version of the kernel claims this feature_id and the OEM's driver no longer works and since the value comes from pci config space it is difficult to change.

So looking for something like

register_feature_matcher((*bus_match)(struct device *dev, struct device_driver *drv))

static int dfl_bus_match_default(struct device *dev, struct device_driver *drv)
{
    struct dfl_device *dfl_dev = to_dfl_dev(dev);
    struct dfl_driver *dfl_drv = to_dfl_drv(drv);
    const struct dfl_device_id *id_entry = dfl_drv->id_table;

    while (id_entry->feature_id) {
        if (dfl_match_one_device(id_entry, dfl_dev)) {
            dfl_dev->id_entry = id_entry;
            return 1;
        }
        id_entry++;
    }

    return 0;
}

register_feature_matcher(&dfl_bus_match_default)

static int dfl_bus_match(struct device *dev, struct device_driver *drv)
{

    struct dfl_device *dfl_dev = to_dfl_dev(dev);
    struct dfl_driver *dfl_drv = to_dfl_drv(drv);
    const struct dfl_device_id *id_entry = dfl_drv->id_table;

    while (id_entry->feature_id) {

        matcher = Loop over matchers()

        if (matcher(dev, drv)) {
            dfl_dev->id_entry = id_entry;
            return 1;
        }
        id_entry++;
    }

    return 0;
}

Or maybe use some of the unused bits in the dfl header to add a second vendor-like id and change existing matcher to look feature_id and vendor_like_id.

Tom

 

On 7/14/20 10:38 PM, Xu Yilun wrote:
> This patchset makes it possible to develop independent driver modules
> for DFL private features. It also helps to leverage existing kernel
> drivers to enable some IP blocks in DFL.
>
> Xu Yilun (2):
>   fpga: dfl: map feature mmio resources in their own feature drivers
>   fpga: dfl: create a dfl bus type to support DFL devices
>
>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>  drivers/fpga/dfl-pci.c                  |  21 +-
>  drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
>  drivers/fpga/dfl.h                      |  91 ++++++-
>  4 files changed, 492 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>
