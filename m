Return-Path: <SRS0=OAol=A7=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=OAol=A7=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTIBB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 Jul 2020 04:01:01 -0400
Date: Mon, 20 Jul 2020 10:01:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200720080111.GA553171@kroah.com>
References: <20200717234408.GA4556@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717234408.GA4556@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, moritzf@google.com, linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 04:44:08PM -0700, Moritz Fischer wrote:
> The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:
> 
>   Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git fpga-late-fixes-for-5.8
> 
> for you to fetch changes up to 8614afd689df59d9ce019439389be20bd788a897:
> 
>   fpga: dfl: fix bug in port reset handshake (2020-07-13 22:11:17 -0700)
> 
> ----------------------------------------------------------------
> FPGA manager fixes for 5.8
> 
> Here are two (late) dfl fixes for the the 5.8 release.
> 
> Matthew's fix addresses an issue in the reset of a port.
> 
> Xu'x fix addresses a linter warning.

That's not a "real" issue, and should have waited until 5.9-rc1 as there
is no bug being fixed there at all.  I'll take it for now, but be more
careful in the future.

thanks,

greg k-h
