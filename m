Return-Path: <SRS0=+SIS=EJ=vger.kernel.org=linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E2C2D0A3
	for <linux-fpga@archiver.kernel.org>; Tue,  3 Nov 2020 07:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B37A223BD
	for <linux-fpga@archiver.kernel.org>; Tue,  3 Nov 2020 07:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604389336;
	bh=xUAAmwqjsB6YkrnTk4cWT7lghj/evr/qwh/eg5SuiMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pjm1EdncXqol3zBeLscmmUn9aO+zZ2pjxg8ME3GohsKrMl18fEmLcFe6yyIzgJoUp
	 +r9HAW4SaOtP/YSyVEEiz1qZ/ESW9wZFFUK7PgWYOiIbqFIaIKNcaYqBJZVaFPQMpQ
	 TCNqJeW22nH5z3wMBFoPUfXm9bav7M9u7p+2XEJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCHmQ (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Tue, 3 Nov 2020 02:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCHmQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 02:42:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 964212222B;
        Tue,  3 Nov 2020 07:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604389334;
        bh=xUAAmwqjsB6YkrnTk4cWT7lghj/evr/qwh/eg5SuiMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENJ7EMAUvS4YPAhES9YY0AspQ5x5cyO7Na/mvK+08g0k+rdFot/XSi7vZvg/5B/iA
         rNrifV8LkNrYo2PK14r2qZFSt5QlC63ac7affnVnKZf8aMfWV34OtTO5T9ObB7/9ck
         nBTiMtVELQ5NKImrtsH2krYE3O2Hj7sccc7EkkY8=
Date:   Tue, 3 Nov 2020 08:43:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 4/4] fpga: dfl: move dfl bus related APIs to
 include/linux/dfl.h
Message-ID: <20201103074307.GD2500572@kroah.com>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-5-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103072104.12361-5-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 02, 2020 at 11:21:04PM -0800, Moritz Fischer wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> Now the dfl drivers could be made as independent modules and put in
> different folders according to their functionalities. In order for
> scattered dfl device drivers to include dfl bus APIs, move the
> dfl bus APIs to a new header file in the public folder.
> 
> [mdf@kernel.org: Fixed up header guards to match filename]
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  MAINTAINERS         |  1 +
>  drivers/fpga/dfl.c  |  1 +
>  drivers/fpga/dfl.h  | 72 -------------------------------------
>  include/linux/dfl.h | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+), 72 deletions(-)
>  create mode 100644 include/linux/dfl.h

Why move this if there is no in-kernel users?

greg k-h
