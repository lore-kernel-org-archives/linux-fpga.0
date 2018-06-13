Return-Path: <SRS0=pjOi=I7=gmail.com=frowand.list@kernel.org>
Return-Path: <SRS0=pjOi=I7=gmail.com=frowand.list@kernel.org>
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
 <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b8c7cd9e-a841-a4b7-2366-6f08328b2b8f@gmail.com>
Date: Wed, 13 Jun 2018 14:47:27 -0700
MIME-Version: 1.0
In-Reply-To: <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On 06/13/18 07:42, Alan Tull wrote:
> On Tue, Jun 12, 2018 at 1:16 PM, Alan Tull <atull@kernel.org> wrote:
>> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>>
>> Hi Frank,
>>
>> I'm investigating a refcount use-after-free warning that happens after
>> overlays are applied, removed, reapplied a few (typically three) times
>> (see below).  This is new in v4.17, didn't happen in v4.16.  As I was
>> investigating I found that rebuilding the phandle_cache after overlays
>> are applied or removed seems to help.
> 
> I was probably wrong about this.  The more I look at the phandle_cache code,
> the more it looks looks good and straightforward.  Probably disabling
> phandle_cache is 'fixing' things through some weird side effect.  I'll
> keep investigating.  Sorry for the noise.

I suspect that you have found an issue, even if it is not the cause of
the refcount issue.  I noted in a reply to v4 of the patch:

  >> +static void of_populate_phandle_cache(void)
  >> +{
  >> +Â Â Â  unsigned long flags;
  >> +Â Â Â  u32 cache_entries;
  >> +Â Â Â  struct device_node *np;
  >> +Â Â Â  u32 phandles = 0;
  >> +
  >> +Â Â Â  raw_spin_lock_irqsave(&devtree_lock, flags);
  >> +
  >> +Â Â Â  kfree(phandle_cache);
  > 
  > I couldn't understood this. Everything else looks good to me.

  I will be adding a call to of_populate_phandle_cache() from the
  devicetree overlay code.  I put the kfree here so that the previous
  cache memory is freed when a new cache is created.
  
  Adding the call from the overlay code is not done in this
  series because I have a patch series modifying overlays and
  I do not want to create a conflict or ordering between that
  series and that patch.  The lack of the call from overlay
  code means that overlay code will gain some of the overhead
  reduction from this patch, but possibly not the entire reduction.

Sorry I'm not giving a link to the archive of this message - I have
a class I have to go to so I don't have enough time to find it.  The
email was

  Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
  of_find_node_by_phandle()
  Date: Fri, 16 Feb 2018 14:20:22 -0800
  Message-ID: <46d5fc76-33e3-d54a-26b8-e9bb8332924d@gmail.com>

Quickly looking at the current code, I don't see the overlay patch
that I mentioned.  I have to dig into what happened to that.

Leaving a phandle from an overlay in the phandle cache after the
overlay is removed would clearly be a bug.

-Frank
