Return-Path: <SRS0=JYT9=GF=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=JYT9=GF=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 15 Mar 2018 17:48:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 3/7] driver, misc: add Intel Stratix10 service layer
 driver
Message-ID: <20180315164836.GB4060@kroah.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519949975-13548-4-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 01, 2018 at 06:19:31PM -0600, richard.gong@linux.intel.com wrote:
> +EXPORT_SYMBOL_GPL(request_svc_channel_byname);

All of your global symbols should have the same prefix, not a verb.  So
this should be:
	svc_channel_request_by_name(), right?

> +EXPORT_SYMBOL_GPL(free_svc_channel);

svc_channel_free()?

> +EXPORT_SYMBOL_GPL(intel_svc_send);

Wait, why doesn't the first ones have "intel_svc" in them?

What is the difference here?

Should they all just have "intel_svc_" as the prefix?

Stick to one thing for all exported functions/variables please, it's the
only way we can attempt to keep our namespace "sane".

Also, why would a 'misc' driver be exporting things that something else
uses?  Why not just put this in the fpga directory next to the users of
this code?

thanks,

greg k-h
