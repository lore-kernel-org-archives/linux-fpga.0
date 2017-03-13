Return-Path: <SRS0=mw+q=2W=gmail.com=delicious.quinoa@kernel.org>
Return-Path: <SRS0=mw+q=2W=gmail.com=delicious.quinoa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489178831-17934-1-git-send-email-mdf@kernel.org>
References: <1489178831-17934-1-git-send-email-mdf@kernel.org>
From: Alan Tull <delicious.quinoa@gmail.com>
Date: Mon, 13 Mar 2017 13:52:52 -0500
Message-ID: <CANk1AXQiSMGLCWJE-DqvDQz=6U85rkQTz6==OPPJqjGTGQULSQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: bridge: Replace open-coded list_for_each + list_entry
Content-Type: text/plain; charset=UTF-8
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, Mar 10, 2017 at 2:47 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

Thanks!

Alan

> Replaces open-coded list_for_each() + list_entry() with macro
> list_for_each_entry()
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Alan Tull <atull@kernel.org>
