Return-Path: <SRS0=NzGV=M3=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=NzGV=M3=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPE1j (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Oct 2018 00:27:39 -0400
MIME-Version: 1.0
References: <1537978342-17697-1-git-send-email-atull@kernel.org>
 <1537978342-17697-5-git-send-email-atull@kernel.org> <CAJYdmeNdBbJBVGjLkk03PpGERA2j=D__BVsb9_FBXwWFkMXR_Q@mail.gmail.com>
In-Reply-To: <CAJYdmeNdBbJBVGjLkk03PpGERA2j=D__BVsb9_FBXwWFkMXR_Q@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 15 Oct 2018 15:40:08 -0500
Message-ID: <CANk1AXQxX8_AMkJhSbuNgxb1972dRqv-6niqU3V63FzKE8=wtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] docs: fpga: document programming fpgas using regions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <moritz.fischer.private@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Federico Vaga <federico.vaga@cern.ch>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>

On Mon, Oct 15, 2018 at 3:11 PM Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 9:12 AM Alan Tull <atull@kernel.org> wrote:
> >
> > Clarify the intention that interfaces and upper layers use
> > regions rather than managers directly.
> >
> > Rearrange API documentation to better group the API functions
> > used to create FPGA mgr/bridge/regions and the API used for
> > programming FPGAs.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > Suggested-by: Federico Vaga <federico.vaga@cern.ch>
>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks Moritz!

Alan
