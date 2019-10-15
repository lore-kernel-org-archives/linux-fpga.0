Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfJODPI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Oct 2019 23:15:08 -0400
Date: Mon, 14 Oct 2019 20:15:04 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191015031504.GB32665@bombadil.infradead.org>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Tim.Bird@sony.com
Cc: jani.nikula@linux.intel.com, changbin.du@gmail.com, corbet@lwn.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

On Mon, Oct 14, 2019 at 08:48:48PM +0000, Tim.Bird@sony.com wrote:
> 
> 
> > -----Original Message-----
> > From: Jani Nikula on October 13, 2019 11:00 PM
> > On Sun, 13 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
> > > The 'functions' directive is not only for functions, but also works for
> > > structs/unions. So the name is misleading. This patch renames it to
> > > 'specific', so now we have export/internal/specific directives to limit
> > > the functions/types to be included in documentation. Meanwhile we
> > improved
> > > the warning message.
> > 
> > Agreed on "functions" being less than perfect. It directly exposes the
> > idiosyncrasies of scripts/kernel-doc. I'm not sure "specific" is any
> > better, though.
> 
> I strongly agree with this.  'specific' IMHO, has no semantic value and
> I'd rather just leave the only-sometimes-wrong 'functions' than convert
> to something that obscures the meaning always.
> 
> > 
> > Perhaps "symbols" would be more self-explanatory. Or, actually make
> > "functions" only work on functions, and add a separate keyword for other
> > stuff. *shrug*
> My preference would be to use 'symbols'.  I tried to come up with something
> but 'symbols' is better than anything I came up with.

structures aren't symbols though ... How about 'identifier'?
