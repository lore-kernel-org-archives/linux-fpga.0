Return-Path: <SRS0=1sRv=GT=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=1sRv=GT=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 29 Mar 2018 19:01:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] fpga: region: don't use drvdata in common fpga code
Message-ID: <20180329170142.GB8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org>
 <20180329153658.11614-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329153658.11614-2-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 29, 2018 at 08:36:53AM -0700, Moritz Fischer wrote:
> From: Alan Tull <atull@kernel.org>
> 
> Part of patchset that changes the following fpga_*_register
> functions to not set drvdata:
> * fpga_region_register.
> * fpga_mgr_register
> * fpga_bridge_register

That's not what this specific patch does.  Please do not write generic
changelog text that is identical for 3 patches that does different
things in each one :(

thanks,

greg k-h
