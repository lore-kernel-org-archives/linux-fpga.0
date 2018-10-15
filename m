Return-Path: <SRS0=NzGV=M3=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=NzGV=M3=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeJOSb5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Oct 2018 14:31:57 -0400
Date: Mon, 15 Oct 2018 12:47:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Add RIFFA PCIe driver to staging tree
Message-ID: <20181015104709.GA26218@kroah.com>
References: <CAF8QhUjTZB8YO-eBJM1TLfKfi91JR6cexAD_ApGn9KWs1VGEHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8QhUjTZB8YO-eBJM1TLfKfi91JR6cexAD_ApGn9KWs1VGEHg@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: fei phung <feiphung27@gmail.com>
Cc: linux-fpga@vger.kernel.org

On Mon, Oct 15, 2018 at 06:41:31PM +0800, fei phung wrote:
> Please the patch below or the email attachment
> 
> For reference, please see
> https://github.com/promach/riffa/tree/full_duplex/driver/linux
> 
> phung@UbuntuHW15:~/linux$ cat
> patches/0001-Added-a-full-duplex-riffa-PCIe-linux-staging-driver..patch
> >From 7c3050c7e86017d85c75c640ea38376f505b2763 Mon Sep 17 00:00:00 2001
> From: promach <feiphung@hotmail.com>
> Date: Mon, 15 Oct 2018 18:28:16 +0800
> Subject: [PATCH] Added a full duplex riffa PCIe linux staging driver.
>  Signed-off-by: PHUNG CHENG FEI (feiphung@hotmail.com)
> 
> ---
>  drivers/staging/riffa/Makefile       |  157 +++
>  drivers/staging/riffa/README.txt     |   38 +
>  drivers/staging/riffa/circ_queue.c   |  188 +++
>  drivers/staging/riffa/circ_queue.h   |   96 ++
>  drivers/staging/riffa/riffa.c        |  152 +++
>  drivers/staging/riffa/riffa.h        |  121 ++
>  drivers/staging/riffa/riffa_driver.c | 1633 ++++++++++++++++++++++++++
>  drivers/staging/riffa/riffa_driver.h |  131 +++
>  8 files changed, 2516 insertions(+)
>  create mode 100644 drivers/staging/riffa/Makefile
>  create mode 100644 drivers/staging/riffa/README.txt
>  create mode 100644 drivers/staging/riffa/circ_queue.c
>  create mode 100644 drivers/staging/riffa/circ_queue.h
>  create mode 100644 drivers/staging/riffa/riffa.c
>  create mode 100644 drivers/staging/riffa/riffa.h
>  create mode 100644 drivers/staging/riffa/riffa_driver.c
>  create mode 100644 drivers/staging/riffa/riffa_driver.h

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
