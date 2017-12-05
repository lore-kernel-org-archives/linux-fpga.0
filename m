Return-Path: <SRS0=Wfb2=DB=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Wfb2=DB=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47418 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbdLEESA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 Dec 2017 23:18:00 -0500
Date: Tue, 5 Dec 2017 12:08:24 +0800
From: Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v3 03/21] fpga: mgr: add status for fpga-manager
Message-ID: <20171205040824.GD19730@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-4-git-send-email-hao.wu@intel.com>
 <CANk1AXSPQb3=bwaRQsysuiM5NiS6KpKRazP-WNLuus-C=UP6pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSPQb3=bwaRQsysuiM5NiS6KpKRazP-WNLuus-C=UP6pg@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>

On Mon, Dec 04, 2017 at 02:55:42PM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> mgr->status isn't used anywhere except in status_show.  So we don't
> need to add status to the fpga_manager struct.  Also don't need the
> inline function to update it.  Just read the status in status_show, if
> that ops exists.  If mops->status is NULL, return an error, as below.
> This will simplify things and make sure that status_show gets status
> that is not stale at all.

Hi Alan

You're right, this is much simpler. Will follow this to fix it in the
next version. Thanks!

Hao
