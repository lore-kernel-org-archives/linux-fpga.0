Return-Path: <SRS0=h6Hu=NC=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=h6Hu=NC=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbeJVWW4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Oct 2018 18:22:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id f17-v6so13352915wrs.12
        for <linux-fpga@vger.kernel.org>; Mon, 22 Oct 2018 07:04:12 -0700 (PDT)
Date: Mon, 22 Oct 2018 15:04:09 +0100
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181022140409.GA1883@archbook>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Andreas Puhm <puhm@oregano.at>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Andreas,

On Mon, Oct 22, 2018 at 01:15:34PM +0000, Andreas Puhm wrote:

Can you please send your patch using git-send-email?

[..]

> Subject: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled devices

How about:

fpga: altera-cvp: Fix registration for CvP incapable devices

The probe function needs to verify the CvP enable bit in order to
properly determine if FPGA Manager functionality can be safely
enabled.

> 
> The altera-cvp probe function now verifies, that the PCI device supports
> the CvP feature, before it registers the device.
> This is done by reading the CVP_EN bit,
> Bit 20 of the CVP_STATUS register (@ PCI Config Address 0x21C).
> 
> If this bit is '1' (CvP enabled), altera-cvp will register the device
> for further interaction.
> If this bit is '0' (CvP disabled), altera-cvp will not register the device.
> 

Could you add a Fixes <hash> ("Message") tag here, I believe we had this
issue since the very beginning, i.e

Fixes 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")

Something like ^^^^

Thanks,

Moritz
