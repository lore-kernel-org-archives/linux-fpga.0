Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
MIME-Version: 1.0
References: <20181105171457.28150-1-agust@denx.de>
In-Reply-To: <20181105171457.28150-1-agust@denx.de>
From: Alan Tull <atull@kernel.org>
Date: Mon, 5 Nov 2018 15:08:03 -0600
Message-ID: <CANk1AXTTWMSsnjSgubnP6Mrt5GJ_edOL=cgix_rcrXs7t4-2CA@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: mgr: add notifier for manager
 register/unregister events
Content-Type: text/plain; charset="UTF-8"
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Nov 5, 2018 at 11:15 AM Anatolij Gustschin <agust@denx.de> wrote:

Hi Anatolij,

>
> Add API functions for registering and removing a notifier for FPGA
> manager register/unregister events. Notify when a new FPGA manager
> has been registered or when an existing manager is being removed.
> This will help configuration interface drivers to get the notion
> of low-level FPGA managers appearing or disappearing, when using
> hotpluggable FPGA configuration devices (e.g. via USB-FPP or
> USB-SPI adapters).

Are you going to be adding any code upstream that uses this API?

Alan
