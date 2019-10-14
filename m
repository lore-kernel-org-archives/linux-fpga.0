Return-Path: <SRS0=5PNB=YH=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=5PNB=YH=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:43474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730354AbfJNI6s (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Oct 2019 04:58:48 -0400
From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions' to 'specific'
In-Reply-To: <20191013055359.23312-1-changbin.du@gmail.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
Date: Mon, 14 Oct 2019 11:59:37 +0300
Message-ID: <875zkrd7nq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

On Sun, 13 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
> The 'functions' directive is not only for functions, but also works for
> structs/unions. So the name is misleading. This patch renames it to
> 'specific', so now we have export/internal/specific directives to limit
> the functions/types to be included in documentation. Meanwhile we improved
> the warning message.

Agreed on "functions" being less than perfect. It directly exposes the
idiosyncrasies of scripts/kernel-doc. I'm not sure "specific" is any
better, though.

Perhaps "symbols" would be more self-explanatory. Or, actually make
"functions" only work on functions, and add a separate keyword for other
stuff. *shrug*

Seems like the patch is way too big. I'd probably add "symbols" (or
whatever) as a synonym for "functions" for starters, and convert
documents piecemeal, and finally drop the old one.

The scripts/kernel-doc change should be a patch of its own.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
