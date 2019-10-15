Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:36136 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfJOS12 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Oct 2019 14:27:28 -0400
Date: Tue, 15 Oct 2019 12:27:26 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Message-ID: <20191015122726.7e12f551@lwn.net>
In-Reply-To: <20191013055359.23312-1-changbin.du@gmail.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

On Sun, 13 Oct 2019 13:53:59 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The 'functions' directive is not only for functions, but also works for
> structs/unions. So the name is misleading. This patch renames it to
> 'specific', so now we have export/internal/specific directives to limit
> the functions/types to be included in documentation. Meanwhile we improved
> the warning message.

I agree with the others that "specific" doesn't really make things
better.  "Interfaces" maybe; otherwise we could go for something like
"filter" or "select".

Paint mine green :)

Whatever we end up with, I think it should be added as a synonym for
"functions".  Then the various selectors that are actually pulling out
docs for functions could be changed at leisure - or not at all.  I'd
rather not see a big patch changing everything at once.

Thanks,

jon
