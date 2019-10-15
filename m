Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=MvQI=YI=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:16623 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbfJONSp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Oct 2019 09:18:45 -0400
From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] kernel-doc: rename the kernel-doc directive 'functions' to 'specific'
In-Reply-To: <20191015115439.GE32665@bombadil.infradead.org>
References: <20191013055359.23312-1-changbin.du@gmail.com> <875zkrd7nq.fsf@intel.com> <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com> <7e7557b5-469f-3e63-6254-53dab2d7234a@suse.de> <20191015115439.GE32665@bombadil.infradead.org>
Date: Tue, 15 Oct 2019 16:19:36 +0300
Message-ID: <8736fub0yf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tim.Bird@sony.com, changbin.du@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Tue, 15 Oct 2019, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Oct 15, 2019 at 11:25:53AM +0200, Thomas Zimmermann wrote:
>> > My preference would be to use 'symbols'.  I tried to come up with something
>> > but 'symbols' is better than anything I came up with.
>> 
>> Maybe 'interfaces' or 'artifacts'. The term 'symbols' is just as
>> imprecise as 'functions'.
>
> I suggested 'identifier' because that's the term used in the C spec (6.2.1):
>
> : An identifier can denote an object; a function; a tag or a member
> : of a structure, union, or enumeration; a typedef name; a label name;
> : a macro name; or a macro parameter.
>
> We don't allow documenting all those things separately, but it does cover
> all the things we do allow to be individually documented.

Agreed.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
