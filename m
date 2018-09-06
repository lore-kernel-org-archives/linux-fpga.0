Return-Path: <moritz.fischer@ettus.com>
Return-Path: <moritz.fischer@ettus.com>
Date: Thu, 6 Sep 2018 11:19:18 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 3/8] fpga: bridge: add devm_fpga_bridge_create
Message-ID: <20180906181918.GA20419@archbook>
References: <20180904212237.3078-1-atull@kernel.org>
 <20180904212237.3078-4-atull@kernel.org>
 <CAJYdmeO0RegP4q1tVow1U0=Zc42GEHMuqsHsvHvMqp89zZ6Wpw@mail.gmail.com>
 <CANk1AXQaSLziycCv4X50xufehu7AgV34pxydxs8H14uFREy4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQaSLziycCv4X50xufehu7AgV34pxydxs8H14uFREy4YQ@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <moritz.fischer.private@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Wed, Sep 05, 2018 at 10:38:53AM -0500, Alan Tull wrote:
> > > - * fpga_bridge_unregister - unregister and free a fpga bridge
> > > - * @bridge:    FPGA bridge struct created by fpga_bridge_create
> > > + * fpga_bridge_unregister - unregister a FPGA bridge
> > > + *
> > > + * @bridge: FPGA bridge struct
> > > + *
> > > + * This function is intended for use in a FPGA bridge driver's remove function.
> > > + * If the bridge was created with devm_fpga_bridge_create(), the bridge struct
> > > + * will be automatically freed.  If the bridge was created with
> > > + * fpga_bridge_create(), the caller is responsible for freeing the bridge with
> > > + * fpga_bridge_free().
> >
> > I find the formulation somewhat confusing, since it could be
> > interpreted as if you
> > used the devm_() functions you don't have to call unregister().
> 
> Yes I'm being too verbose and it's making things muddled.  How about
> if I take out the part that starts with "If bridge was created..."?
> That just leaves "This function is intended for use in a FPGA bridge
> driver's remove function."

Sounds good.

Moritz
