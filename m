Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b8c7cd9e-a841-a4b7-2366-6f08328b2b8f@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com> <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
 <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com> <b8c7cd9e-a841-a4b7-2366-6f08328b2b8f@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 14 Jun 2018 15:59:16 -0500
Message-ID: <CANk1AXSvgHMWidmb+6k6paTdpj9HfSoyKoiMgLxH=8SoC-4qnw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Wed, Jun 13, 2018 at 4:47 PM, Frank Rowand <frowand.list@gmail.com> wrot=
e:
> On 06/13/18 07:42, Alan Tull wrote:
>> On Tue, Jun 12, 2018 at 1:16 PM, Alan Tull <atull@kernel.org> wrote:
>>> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>>>
>>> Hi Frank,
>>>
>>> I'm investigating a refcount use-after-free warning that happens after
>>> overlays are applied, removed, reapplied a few (typically three) times
>>> (see below).  This is new in v4.17, didn't happen in v4.16.  As I was
>>> investigating I found that rebuilding the phandle_cache after overlays
>>> are applied or removed seems to help.
>>
>> I was probably wrong about this.  The more I look at the phandle_cache c=
ode,
>> the more it looks looks good and straightforward.  Probably disabling
>> phandle_cache is 'fixing' things through some weird side effect.  I'll
>> keep investigating.  Sorry for the noise.
>
> I suspect that you have found an issue, even if it is not the cause of
> the refcount issue.  I noted in a reply to v4 of the patch:
>
>   >> +static void of_populate_phandle_cache(void)
>   >> +{
>   >> +=C3=82 =C3=82 =C3=82  unsigned long flags;
>   >> +=C3=82 =C3=82 =C3=82  u32 cache_entries;
>   >> +=C3=82 =C3=82 =C3=82  struct device_node *np;
>   >> +=C3=82 =C3=82 =C3=82  u32 phandles =3D 0;
>   >> +
>   >> +=C3=82 =C3=82 =C3=82  raw_spin_lock_irqsave(&devtree_lock, flags);
>   >> +
>   >> +=C3=82 =C3=82 =C3=82  kfree(phandle_cache);
>   >
>   > I couldn't understood this. Everything else looks good to me.
>
>   I will be adding a call to of_populate_phandle_cache() from the
>   devicetree overlay code.  I put the kfree here so that the previous
>   cache memory is freed when a new cache is created.
>
>   Adding the call from the overlay code is not done in this
>   series because I have a patch series modifying overlays and
>   I do not want to create a conflict or ordering between that
>   series and that patch.  The lack of the call from overlay
>   code means that overlay code will gain some of the overhead
>   reduction from this patch, but possibly not the entire reduction.
>
> Sorry I'm not giving a link to the archive of this message - I have
> a class I have to go to so I don't have enough time to find it.

I understand, that's cool.  I've found the email chain, thanks for
pointing me to it!

>  The
> email was
>
>   Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
>   of_find_node_by_phandle()
>   Date: Fri, 16 Feb 2018 14:20:22 -0800
>   Message-ID: <46d5fc76-33e3-d54a-26b8-e9bb8332924d@gmail.com>
>
> Quickly looking at the current code, I don't see the overlay patch
> that I mentioned.  I have to dig into what happened to that.
>
> Leaving a phandle from an overlay in the phandle cache after the
> overlay is removed would clearly be a bug.

Yes that's totally it, when I get a match of a phandle and the np
address is stale, then comes the kernel warning.

I added more debug code to print out the results of looking up dynamic
nodes only (nodes > the highest node added when the cache was
originally built).  Also I added debug code to also force the lookup
code to go back and look up dynamic nodes the slow, uncached way so I
could see if it got the correct np address.  I'm unloading and
reloading an overlay, so sometimes the new np (after the overlay was
removed and reapplied) is at the same address, but sometimes it isn't
and then I get the kernel warning.  Just for entertainment value, here
is my prints of the np from the cache and the correct np that' at a
different address.  The '88' is the phandle, after that is the np
address, then the np=3D<full_name>.  Note also the corruption in the
cached node's full_name

OF: of_find_node_by_phandle line 1108 found dynamic node in cache 88
ee518680 np=3D/soc/base_fpga_region/\300\252~\356ze_controller@0x100000450

OF: of_find_node_by_phandle line 1119 found the slow way: 88 eeaf2d00
np=3D/soc/base_fpga_region/freeze_controller@0x100000450

I'm just scratching my head and wondering: should we be zeroing out
some things in memory after an overlay is removed?  Then this bug
would led to a pointer that would have thrown an oops.

If it's useful for you, next week I can send a cleaned up version of
my patch that rebuilds the cache after overlays are applied or
removed.

Alan

>
> -Frank
