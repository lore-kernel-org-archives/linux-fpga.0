Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-11-git-send-email-hao.wu@intel.com> <20190402155018.GA1453@archbook>
In-Reply-To: <20190402155018.GA1453@archbook>
From: Alan Tull <atull@kernel.org>
Date: Thu, 11 Apr 2019 15:45:54 -0500
Message-ID: <CANk1AXRuA=hWOSxV-z9h3oz1VQVTVy8tYe2pgi4qN0fz9u2fyw@mail.gmail.com>
Subject: Re: [PATCH 10/17] fpga: dfl: afu: export __port_enable/disable function.
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>, Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Tue, Apr 2, 2019 at 10:50 AM Moritz Fischer <mdf@kernel.org> wrote:

Hi Hao,

>
> On Mon, Mar 25, 2019 at 11:07:37AM +0800, Wu Hao wrote:
> > As these two functions are used by other private features. e.g.
> > in error reporting private feature, it requires to check port status
> > and reset port for error clearing.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
