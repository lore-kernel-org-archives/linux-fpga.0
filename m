Return-Path: <SRS0=2nBX=LT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2nBX=LT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIETim (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Sep 2018 15:38:42 -0400
MIME-Version: 1.0
References: <20180904212237.3078-1-atull@kernel.org> <20180904212237.3078-2-atull@kernel.org>
 <CAAtXAHfzhmdZ6SnheZ-DXD14dde7Ccm66jEM=Q3UWDukKsyGBA@mail.gmail.com>
In-Reply-To: <CAAtXAHfzhmdZ6SnheZ-DXD14dde7Ccm66jEM=Q3UWDukKsyGBA@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 5 Sep 2018 10:07:29 -0500
Message-ID: <CANk1AXSttp7HmnoXnf0LYqEDrz0gDCYQxqJ1mmViqEeDqU=Ecg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] fpga: do not access region struct after fpga_region_unregister
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>

On Tue, Sep 4, 2018 at 6:41 PM Moritz Fischer <moritz.fischer@ettus.com> wrote:

Hi Moritz,

>
> Hi Alan,
>
> On Tue, Sep 4, 2018 at 2:22 PM, Alan Tull <atull@kernel.org> wrote:
> > A couple drivers were accessing the region struct after it had been
> > freed.  Save off the pointer to the mgr before the region struct gets
> > freed.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks!

Alan
