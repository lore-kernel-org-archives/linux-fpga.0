Return-Path: <SRS0=vSF4=YW=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=vSF4=YW=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:42020 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJ2IAe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Oct 2019 04:00:34 -0400
Date: Tue, 29 Oct 2019 02:00:27 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191029020027.516a6bce@lwn.net>
In-Reply-To: <20191029003120.llve32crfw63ovpw@mail.google.com>
References: <20191020131717.28990-1-changbin.du@gmail.com>
        <20191024121940.1d6a64df@lwn.net>
        <87woctb9cj.fsf@intel.com>
        <20191025144802.uixg2crhw6h7gghq@mail.google.com>
        <87v9s99q9l.fsf@intel.com>
        <20191029003120.llve32crfw63ovpw@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Matthew Wilcox <willy@infradead.org>, Thomas Zimmermann <tzimmermann@suse.de>

On Tue, 29 Oct 2019 08:31:22 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> Here python is different from C. Both empty string and None are False in python.
> Note such condition is common in python.

Treating both as a False value is reasonably common.  Treating them
elsewhere in the same code block as separate values is less
so; that's the part I would prefer to avoid.

Thanks,

jon
