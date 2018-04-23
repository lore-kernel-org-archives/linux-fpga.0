Return-Path: <SRS0=7K8z=HM=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=7K8z=HM=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 23 Apr 2018 14:03:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 3/7] driver, misc: add Intel Stratix10 service layer
 driver
Message-ID: <20180423120300.GC7951@kroah.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522182014-7338-4-git-send-email-richard.gong@linux.intel.com>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Mar 27, 2018 at 03:20:10PM -0500, richard.gong@linux.intel.com wrote:
> +config INTEL_SERVICE

Naming is hard, but this is a _very_ generic name, don't you agree?

> +	tristate "Intel Service Layer"

As is this.  Can you make this a bit more specific to what hardware is
being controlled here?

> +++ b/drivers/misc/intel-service.c

Same for the file name, why not stratix10.c?

or intel_svc.c?  That makes it a _bit_ more generic.  Well, not really,
but it does hide the "genericness" a bit more, right?

> --- /dev/null
> +++ b/include/linux/intel-service-client.h
> @@ -0,0 +1,188 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2017-2018, Intel Corporation
> + */
> +
> +#ifndef __INTEL_SERVICE_CLIENT_H
> +#define __INTEL_SERVICE_CLIENT_H
> +
> +/*
> + * Service layer driver supports client names
> + *
> + * fpga: for FPGA configuration
> + * dummy: for integration/debug/trouble-shooting
> + */
> +#define SVC_CLIENT_FPGA		"fpga"
> +#define SVC_CLIENT_DUMMY	"dummy"
> +
> +/*
> + * Status of the sent command, in bit number
> + *
> + * SVC_COMMAND_STATUS_RECONFIG_REQUEST_OK:
> + * Secure firmware accepts the request of FPGA reconfiguration.
> + *
> + * SVC_STATUS_RECONFIG_BUFFER_SUBMITTED:
> + * Service client successfully submits FPGA configuration
> + * data buffer to secure firmware.
> + *
> + * SVC_COMMAND_STATUS_RECONFIG_BUFFER_DONE:
> + * Secure firmware completes data process, ready to accept the
> + * next WRITE transaction.
> + *
> + * SVC_COMMAND_STATUS_RECONFIG_COMPLETED:
> + * Secure firmware completes FPGA configuration successfully, FPGA should
> + * be in user mode.
> + *
> + * SVC_COMMAND_STATUS_RECONFIG_BUSY:
> + * FPGA configuration is still in process.
> + *
> + * SVC_COMMAND_STATUS_RECONFIG_ERROR:
> + * Error encountered during FPGA configuration.
> + */

You have an odd mix of kernel-doc formatting and non-kernel-doc
formatting in this file.  Pick one and stick with it :)

Also, if you use kernel-doc (as you should), please hook it up to the
kernel documentation build process to take advantage of it.

thanks,

greg k-h
