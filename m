Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-7-atull@kernel.org>
 <20180906184338.GD20419@archbook>
In-Reply-To: <20180906184338.GD20419@archbook>
From: Alan Tull <atull@kernel.org>
Date: Thu, 6 Sep 2018 16:28:14 -0500
Message-ID: <CANk1AXQygEZYYrVVdWh5Z0M8ZLTEEH7E9CXxVBYx9JMgsNpm+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] fpga: bridge: fix obvious function documentation error
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Sep 6, 2018 at 1:43 PM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

>
> On Tue, Sep 04, 2018 at 04:22:35PM -0500, Alan Tull wrote:
> > fpga_bridge_dev_match() returns a FPGA bridge struct, not a
> > FPGA manager struct so s/manager/bridge/.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks!

Alan
