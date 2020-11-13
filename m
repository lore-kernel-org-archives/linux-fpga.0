Return-Path: <linux-fpga-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23381C55ABD
	for <linux-fpga@archiver.kernel.org>; Fri, 13 Nov 2020 20:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF9D22252
	for <linux-fpga@archiver.kernel.org>; Fri, 13 Nov 2020 20:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRU/AGSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKMUYq (ORCPT <rfc822;linux-fpga@archiver.kernel.org>);
        Fri, 13 Nov 2020 15:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMUYq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 13 Nov 2020 15:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605299084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26k5Ykpq8ko3cdeDg3z0O22hPlAwcLFHBPMuuARRqmQ=;
        b=bRU/AGSvsQfoyKAdAAO0tWpwx066psFImCR/HreSJ0MbXcwhBvLrQqUttHhHCfkzHySLsO
        49sPx560J0OuoPfSNmnBWCuAjML3QetE/y05JHrIUulIM63X2stxS9pFWRxcZ/cm8Dmk43
        ArIOTotI5SY7e7dT0wVWY9Sol6HA/cU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-qwN6AVmcMki6zrt5auMKJQ-1; Fri, 13 Nov 2020 15:24:42 -0500
X-MC-Unique: qwN6AVmcMki6zrt5auMKJQ-1
Received: by mail-qk1-f197.google.com with SMTP id 198so6592454qkj.7
        for <linux-fpga@vger.kernel.org>; Fri, 13 Nov 2020 12:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=26k5Ykpq8ko3cdeDg3z0O22hPlAwcLFHBPMuuARRqmQ=;
        b=GPaeRSOW+zo7wGjb9umbuGR/dRU599yc+yF02i02wDYQzW2FVUtxAZ85OoUpFSnKxR
         bQFE7ygcYR9jJgqNLVTnmS6VsROksFZPEKnGyLvLhHbBce1KZ6Z5GxRQa5efoyO1wIF1
         x4y2N7QYOvLf1Y54khFnQ3J/rZ6SukTsDxoSTo2AuXhGYZqLA2TT0fdC62y4yV8E/Jos
         sd6R4ZTqPfayyhe2Jn2ha07hrf/Y2sJton1QahKMWGseVasUC/CoVEl4Y3uFw1MhoJJf
         c4mS1CaR/l6h152iAceGZOHWX1Rha7w0Fy6BDhGUUt5OoPAt8uLviialgSnQyahD1Sz5
         pXBg==
X-Gm-Message-State: AOAM532zEWWsbK+yeX6y9PqA5EftgiIuUq7A5mnxq1A67aUnANssNXIw
        QuGcWi5YOOPfIH1axYtiWmu+WzC8sbxT3/USVTMNXhW0BKHijlEdT6fvS/uxRb6idAiWAs9AeJQ
        UQnsJJYqW5jcGRoXfcgyBAg==
X-Received: by 2002:a37:8203:: with SMTP id e3mr3674945qkd.322.1605299081793;
        Fri, 13 Nov 2020 12:24:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9VtR5u9OEAdfJGf71wRkZbn+TKbR8B8G43J5F/vkrkkVrmN6Bai+XBRI8YFkBi+3+1bBubg==
X-Received: by 2002:a37:8203:: with SMTP id e3mr3674913qkd.322.1605299081414;
        Fri, 13 Nov 2020 12:24:41 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l79sm7706734qke.1.2020.11.13.12.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:24:40 -0800 (PST)
Subject: Re: [PATCHv1 1/4] fpga: fpga-mgr: add
 FPGA_MGR_BITSTREM_AUTHENTICATION flag
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-2-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a71b7a9c-effa-ad01-4fde-3e1a1e517e2d@redhat.com>
Date:   Fri, 13 Nov 2020 12:24:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605204403-6663-2-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Add FPGA_MGR_BITSTREM_AUTHENTICATION flag for FPGA bitstream
> authentication.

Should improve this commit so explain what you mean authentication.

it could mean 'it wrote correctly' or 'it was signed correctly' or something else.

>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  include/linux/fpga/fpga-mgr.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 2bc3030..1d65814 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -67,12 +67,15 @@ enum fpga_mgr_states {
>   * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>   *
>   * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> + *
> + * %FPGA_MGR_BITSTREM_AUTHENTICATION: do FPGA bitstream authentication
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
>  #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
>  #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
>  #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
> +#define FPGA_MGR_BITSTREM_AUTHENTICATION BIT(5)

A whitespace issue, the new BIT(5) should align with the others, so add two spaces to the others.

Tom

>  
>  /**
>   * struct fpga_image_info - information specific to a FPGA image

