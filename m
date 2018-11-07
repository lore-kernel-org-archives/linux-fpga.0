Return-Path: <SRS0=6hQ7=NS=denx.de=agust@kernel.org>
Return-Path: <SRS0=6hQ7=NS=denx.de=agust@kernel.org>
Date: Wed, 7 Nov 2018 23:11:36 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] fpga: altera-cvp: fix probing for multiple FPGAs on the
 bus
Message-ID: <20181107231136.4e9da738@crub>
In-Reply-To: <CANk1AXSAN1ywxR6AkP9EsodP73GY+CON76pTUCzMe8G-OHnkxQ@mail.gmail.com>
References: <20181106203512.4509-1-agust@denx.de>
	<CANk1AXS_FXFV3Q1zoorHc+fEMWtQzPfbgMEm=LzP5U0Qq_CAJg@mail.gmail.com>
	<20181107005604.693d3162@crub>
	<CANk1AXTXRT8fNQb18mUAi=N7DCKgRjYjbuTZiXPkpDDTMCKALA@mail.gmail.com>
	<CANk1AXSAN1ywxR6AkP9EsodP73GY+CON76pTUCzMe8G-OHnkxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alan Tull <atull@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Alan,

On Wed, 7 Nov 2018 10:05:21 -0600
Alan Tull atull@kernel.org wrote:
...
>> > >> +       if (!altera_cvp_cnt++) {
>> > >> +               ret = driver_create_file(&altera_cvp_driver.driver,
>> > >> +                                        &driver_attr_chkcfg);  
>
>Please consider whether moving this to the module init would solve
>your problem without having to add a counter.

This should work and it is a better idea, thanks.

Anatolij
