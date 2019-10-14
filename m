Return-Path: <SRS0=5PNB=YH=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=5PNB=YH=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr760111.outbound.protection.outlook.com ([40.107.76.111]:23521
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387731AbfJNUtf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Oct 2019 16:49:35 -0400
From: <Tim.Bird@sony.com>
Subject: RE: [PATCH] kernel-doc: rename the kernel-doc directive 'functions'
 to 'specific'
Date: Mon, 14 Oct 2019 20:48:48 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977CAF09@USCULXMSG01.am.sony.com>
References: <20191013055359.23312-1-changbin.du@gmail.com>
 <875zkrd7nq.fsf@intel.com>
In-Reply-To: <875zkrd7nq.fsf@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: jani.nikula@linux.intel.com, changbin.du@gmail.com, corbet@lwn.net
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org



> -----Original Message-----
> From: Jani Nikula on October 13, 2019 11:00 PM
> On Sun, 13 Oct 2019, Changbin Du <changbin.du@gmail.com> wrote:
> > The 'functions' directive is not only for functions, but also works for
> > structs/unions. So the name is misleading. This patch renames it to
> > 'specific', so now we have export/internal/specific directives to limit
> > the functions/types to be included in documentation. Meanwhile we
> improved
> > the warning message.
>=20
> Agreed on "functions" being less than perfect. It directly exposes the
> idiosyncrasies of scripts/kernel-doc. I'm not sure "specific" is any
> better, though.

I strongly agree with this.  'specific' IMHO, has no semantic value and
I'd rather just leave the only-sometimes-wrong 'functions' than convert
to something that obscures the meaning always.

>=20
> Perhaps "symbols" would be more self-explanatory. Or, actually make
> "functions" only work on functions, and add a separate keyword for other
> stuff. *shrug*
My preference would be to use 'symbols'.  I tried to come up with something
but 'symbols' is better than anything I came up with.

>=20
> Seems like the patch is way too big. I'd probably add "symbols" (or
> whatever) as a synonym for "functions" for starters, and convert
> documents piecemeal, and finally drop the old one.
>=20
> The scripts/kernel-doc change should be a patch of its own.
Agreed on these two points as well.

Just adding my 2 cents.
 -- Tim
