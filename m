Return-Path: <SRS0=KMHB=G2=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=KMHB=G2=gmail.com=p.pisati@kernel.org>
Date: Thu, 5 Apr 2018 17:52:13 +0200
From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: [PATCH v10 2/2] fpga: lattice machxo2: Add Lattice MachXO2
 support
Message-ID: <20180405155213.GA19926@harukaze>
References: <1522782152-27300-1-git-send-email-p.pisati@gmail.com>
 <1522782152-27300-3-git-send-email-p.pisati@gmail.com>
 <CANk1AXTBNubsYm=psFRpL+q5oEckfyjdOfzmr-DOn69XCOCmbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXTBNubsYm=psFRpL+q5oEckfyjdOfzmr-DOn69XCOCmbw@mail.gmail.com>
To: Alan Tull <atull@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Thu, Apr 05, 2018 at 10:12:05AM -0500, Alan Tull wrote:
> On Tue, Apr 3, 2018 at 2:02 PM, Paolo Pisati <p.pisati@gmail.com> wrote:
> 
> Hi Paolo,
> 
> Looks good, except that I have to fix up the calls to
> fpga_mgr_register/unregister since my API changes didn't go in.  I've
> fixed those up and pushed to a branch on my kernel org git repo to let
> the robots do some testing.  I'll post (v11 with those fixes) after
> that is cleared.

Awesome Alan, thank you.
-- 
bye,
p.
