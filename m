Return-Path: <SRS0=Sh5S=AU=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=Sh5S=AU=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 19 Sep 2017 09:17:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] fpga: altera-cvp: remove DRIVER_ATTR() usage
Message-ID: <20170919071743.GA23085@kroah.com>
References: <20170918101736.GA30415@kroah.com>
 <20170918164225.GA31137@tyrael.ni.corp.natinst.com>
 <CANk1AXTRoOiqswPi-SzNG01vPRQuAKxsBt3hszyWw7BvPx-YdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTRoOiqswPi-SzNG01vPRQuAKxsBt3hszyWw7BvPx-YdQ@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Sep 18, 2017 at 03:40:13PM -0500, Alan Tull wrote:
> On Mon, Sep 18, 2017 at 11:42 AM, Moritz Fischer <mdf@kernel.org> wrote:
> > On Mon, Sep 18, 2017 at 12:17:36PM +0200, Greg Kroah-Hartman wrote:
> >> It's better to be explicit and use the DRIVER_ATTR_RW() macro when
> >> defining a driver's sysfs file.
> >>
> >> This is part of a series to drop DRIVER_ATTR() from the tree entirely.
> >>
> >> Cc: Alan Tull <atull@kernel.org>
> >> Cc: Moritz Fischer <mdf@kernel.org>
> >> Cc: linux-fpga@vger.kernel.org
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Alan Tull <atull@kernel.org>

Thanks to both of you for the review.

greg k-h
