Return-Path: <SRS0=E3xf=Q4=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=E3xf=Q4=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:21580 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUFcr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 21 Feb 2019 00:32:47 -0500
Date: Thu, 21 Feb 2019 13:17:34 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH] fpga: expand minor range when registering chrdev region
Message-ID: <20190221051734.GA19553@hao-dev>
References: <20190212062451.1354-1-cgxu519@gmx.com>
 <CAAtXAHck6a2LbWGb9Fu7+HP9Uz8oAhTOs9636AqD7P9SOSGi3A@mail.gmail.com>
 <3a1c6ac6-ecfe-f21c-ef4c-0af8ab8536eb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1c6ac6-ecfe-f21c-ef4c-0af8ab8536eb@gmx.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: cgxu519 <cgxu519@gmx.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org

On Tue, Feb 12, 2019 at 10:32:14PM +0800, cgxu519 wrote:
> On 2/12/19 6:54 PM, Moritz Fischer wrote:
> >Hi Chengguang,
> >
> >On Mon, Feb 11, 2019 at 10:25 PM Chengguang Xu <cgxu519@gmx.com> wrote:
> >>Actually, total amount of available minor number
> >>for a single major is MINORMARK + 1. So expand
> >Typo. MINORMASK?
> 
> Yeah, it's a typo, should be MINORMASK.
> 

Please fix this typo, and change the patch title to "fpga: dfl: ..."

with above fixings,

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao
