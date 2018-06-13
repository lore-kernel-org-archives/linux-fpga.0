Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com> <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 13 Jun 2018 09:42:50 -0500
Message-ID: <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
Content-Type: text/plain; charset="UTF-8"
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Jun 12, 2018 at 1:16 PM, Alan Tull <atull@kernel.org> wrote:
> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>
> Hi Frank,
>
> I'm investigating a refcount use-after-free warning that happens after
> overlays are applied, removed, reapplied a few (typically three) times
> (see below).  This is new in v4.17, didn't happen in v4.16.  As I was
> investigating I found that rebuilding the phandle_cache after overlays
> are applied or removed seems to help.

I was probably wrong about this.  The more I look at the phandle_cache code,
the more it looks looks good and straightforward.  Probably disabling
phandle_cache is 'fixing' things through some weird side effect.  I'll
keep investigating.  Sorry for the noise.

Alan
