Return-Path: <SRS0=8Fhb=YJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=8Fhb=YJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfJPAKl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Oct 2019 20:10:41 -0400
Date: Wed, 16 Oct 2019 08:10:28 +0800
From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191016001026.wa4hvc2pgyij2b4c@mail.google.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <20191015122726.7e12f551@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015122726.7e12f551@lwn.net>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

On Tue, Oct 15, 2019 at 12:27:26PM -0600, Jonathan Corbet wrote:
> On Sun, 13 Oct 2019 13:53:59 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The 'functions' directive is not only for functions, but also works for
> > structs/unions. So the name is misleading. This patch renames it to
> > 'specific', so now we have export/internal/specific directives to limit
> > the functions/types to be included in documentation. Meanwhile we improved
> > the warning message.
> 
> I agree with the others that "specific" doesn't really make things
> better.  "Interfaces" maybe; otherwise we could go for something like
> "filter" or "select".
>
Jonathan, How about 'identifier' suggested by Matthew as it is mentioned in Then
C spec?

> Paint mine green :)
> 
> Whatever we end up with, I think it should be added as a synonym for
> "functions".  Then the various selectors that are actually pulling out
> docs for functions could be changed at leisure - or not at all.  I'd
> rather not see a big patch changing everything at once.
>
Sure, I'll make 'functions' deprecated and as an alias to our new directive name.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
