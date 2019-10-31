Return-Path: <SRS0=gdlX=YY=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=gdlX=YY=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52904 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJaNvK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 31 Oct 2019 09:51:10 -0400
Date: Thu, 31 Oct 2019 21:50:54 +0800
From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191031135052.tl63uzhdgcpcqwj5@mail.google.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
 <20191024121940.1d6a64df@lwn.net>
 <87woctb9cj.fsf@intel.com>
 <20191025144802.uixg2crhw6h7gghq@mail.google.com>
 <87v9s99q9l.fsf@intel.com>
 <20191029003120.llve32crfw63ovpw@mail.google.com>
 <20191029020027.516a6bce@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029020027.516a6bce@lwn.net>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Changbin Du <changbin.du@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, Thomas Zimmermann <tzimmermann@suse.de>

On Tue, Oct 29, 2019 at 02:00:27AM -0600, Jonathan Corbet wrote:
> On Tue, 29 Oct 2019 08:31:22 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Here python is different from C. Both empty string and None are False in python.
> > Note such condition is common in python.
> 
> Treating both as a False value is reasonably common.  Treating them
> elsewhere in the same code block as separate values is less
> so; that's the part I would prefer to avoid.
>
ok, please check update in v3.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
