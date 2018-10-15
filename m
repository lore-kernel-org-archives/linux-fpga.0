Return-Path: <SRS0=NzGV=M3=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=NzGV=M3=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:40489 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbeJOJic (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Oct 2018 05:38:32 -0400
Message-ID: <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
From: Joe Perches <joe@perches.com>
Date: Sun, 14 Oct 2018 18:55:25 -0700
In-Reply-To: <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
         <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
         <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
         <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org

On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
> On 10/14/18 18:06, Joe Perches wrote:
> > On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
> > > From: Frank Rowand <frank.rowand@sony.com>
> > > 
> > > Add test case of two fragments updating the same property.  After
> > > adding the test case, the system hangs at end of boot, after
> > > after slub stack dumps from kfree() in crypto modprobe code.
[]
> > I think this is worse performance than before.
> > 
> > This now walks all entries when before it would
> > return -EINVAL directly when it found a match.
> 
> Yes, it is worse performance, but that is OK.
> 
> This is a check that is done when a devicetree overlay is applied.
> If an error occurs then that means that the overlay was incorrectly
> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> in this patch provides an example of how a bad overlay can be created.
> 
> Once an error was detected, the check could return immediately, or it
> could continue to give a complete list of detected errors.  I chose to
> give the complete list of detected errors.

Swell.  Please describe that in the commit message.
