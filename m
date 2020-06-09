Return-Path: <SRS0=JyFA=7W=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=JyFA=7W=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728601AbgFIOp1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 10:45:27 -0400
Received: by mail-qt1-f198.google.com with SMTP id t24so18574311qtj.15
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 07:45:23 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt
 support
References: <20200609130208.27390-1-trix@redhat.com>
 <20200609130208.27390-2-trix@redhat.com> <20200609142007.GA831428@kroah.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
Date: Tue, 9 Jun 2020 07:45:18 -0700
MIME-Version: 1.0
In-Reply-To: <20200609142007.GA831428@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, linux-fpga@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org


> Why not use the ksft_* functions and frameworks to properly print out
> the test status and results so that tools can correctly parse it?
>
> It's generally bad-form to make up your own format.

I used the the drivers/dma-buf test a basis example.  Can you point me at a better example ?

T

> thanks,
>
> gre gk-h
>
