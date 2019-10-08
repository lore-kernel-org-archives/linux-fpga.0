Return-Path: <SRS0=mPPm=YB=gmail.com=groeck7@kernel.org>
Return-Path: <SRS0=mPPm=YB=gmail.com=groeck7@kernel.org>
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 8 Oct 2019 13:11:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] hwmon: Support ADI Fan Control IP
Message-ID: <20191008201129.GA14652@roeck-us.net>
References: <20190926103925.194973-1-nuno.sa@analog.com>
 <20190926103925.194973-3-nuno.sa@analog.com>
 <20191006153209.GA30372@roeck-us.net>
 <1125a1f831a76b27ccc050a0db4499e5c4abd76c.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125a1f831a76b27ccc050a0db4499e5c4abd76c.camel@analog.com>
To: "Sa, Nuno" <Nuno.Sa@analog.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Oct 08, 2019 at 03:59:49PM +0000, Sa, Nuno wrote:
[ ... ]
> > > +
> > > +	ctl->irq = platform_get_irq(pdev, 0);
> > > +	if (ctl->irq < 0) {
> > 
> > This can return -EPROBE_DEFER. On top of that, it already generates
> > an error
> > message, meaning another one here is unnecessary.
> 
> Why returning -EPROBE_DEFER? platform_get_irq() already seems to handle
> EPROBE_DEFER...
> 
... which is exactly why I am saying that you don't need another error
message, and that an unconditional error message is a bad idea.

Guenter
