Return-Path: <SRS0=CLTL=IE=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=CLTL=IE=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 17 May 2018 09:04:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/14] fpga api changes and kernel-doc fixup
Message-ID: <20180517070407.GA13919@kroah.com>
References: <20180516235007.3951-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516235007.3951-1-atull@kernel.org>
To: Alan Tull <atull@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Wed, May 16, 2018 at 06:49:53PM -0500, Alan Tull wrote:
> I'm posting these all together because they are interdependent.
> 
> Patches 1-4 are a repost of v4 of the FPGA api change.
> 
> Patch 5 is a repost of adding SPDX to my fpga code
> 
> Patch 6-12 update the fpga kernel-doc documentation and move
> existing .txt fpga documentation to driver-api ReST documents.
> 
> Patch 13 is a minor documentation fix
> 
> Patch 14 updates MAINTAINERS for the new driver-api/fpga directory

Are these just for review, or do you feel they are good enough for me to
queue up for 4.18-rc1 now?

thanks,

greg k-h
