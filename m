Return-Path: <SRS0=1sRv=GT=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=1sRv=GT=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 29 Mar 2018 18:59:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] FPGA Manager Patches for 4.17
Message-ID: <20180329165945.GA8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Mar 29, 2018 at 08:36:52AM -0700, Moritz Fischer wrote:
> Hi Greg,
> 
> can you please take the following patches for 4.17.
> 
> Alan's changes are mostly refactoring in preparation for non-dt based
> FPGA regions.
> 
> Anatolij's changes fix a small issue with altera-ps-spi FPGAs,
> where the FPGA is being reset unnessesarily on driver load.
> 
> All patches have been reviewed on the list.
> 
> I'm sending the patches this time instead of Alan so I can get more
> familiar with the process.

Wow this is late.  If 4.16-final happens this Sunday, the most this
would possibly be in linux-next is for 1 day.  That's not ok.

If any of these are serious bug fixes, I'll consider them for 4.17-rc2,
so please send them after 4.17-rc1 is out.  And also send the new
features/cleanups then as well, as a separate series so I know to keep
them apart.

Next time please try to submit stuff sooner, there is no reason you
should not send them to me whenever they are ready, do not sit on them
at all if possible.

thanks,

greg k-h
