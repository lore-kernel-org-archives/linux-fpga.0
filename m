Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2020 12:56:18 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200210205618.GA1347752@kroah.com>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581306469-22629-3-git-send-email-hao.wu@intel.com>
To: Wu Hao <hao.wu@intel.com>
Cc: mdf@kernel.org, will@kernel.org, mark.rutland@arm.com, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com, Luwei Kang <luwei.kang@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> +What:		/sys/bus/event_source/devices/fmeX/format
> +Date:		February 2020
> +KernelVersion:  5.7
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Attribute group to describe the magic bits
> +		that go into perf_event_attr.config for a particular pmu.
> +		(See ABI/testing/sysfs-bus-event_source-devices-format).
> +
> +		Each attribute under this group defines a bit range of the
> +		perf_event_attr.config. All supported attributes are listed
> +		below.
> +
> +		  event  = "config:0-11"  - event ID
> +		  evtype = "config:12-15" - event type
> +		  portid = "config:16-23" - event source
> +
> +		For example,
> +
> +		  fab_mmio_read = "event=0x06,evtype=0x02,portid=0xff"

Are perf sysfs files always this bad "multiple values per file"?  Or is
that unique to this driver?  If not unique, do you have specific
examples in the kernel that currently do this today?


> +static struct attribute *fme_perf_events_attrs_empty[] = {
> +	NULL,

Huh?

> +};
> +
> +static struct attribute_group fme_perf_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_events_attrs_empty,

You create an empty directory?  Why?  What goes in here?

very odd...

greg k-h
